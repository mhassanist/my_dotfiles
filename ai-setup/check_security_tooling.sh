#!/usr/bin/env bash
# Checks installed security tooling against the rules in security_tools.conf.
# Usage: bash tools/check_security_tooling.sh [path/to/conf]
# Exit 0 = all applicable required rules pass (WARN lines do not fail).
# Exit 1 = a required rule failed. Exit 2 = config not found.
# Run from the repo root: project settings and has: checks are relative to the current folder.
# Read-only: it never installs or changes anything.

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONF="${1:-$DIR/security_tools.conf}"
SETTINGS=("$HOME/.claude/settings.json" ".claude/settings.json" ".claude/settings.local.json")

[ -f "$CONF" ] || { echo "ERROR: config not found: $CONF" >&2; exit 2; }

trim() {
  local s="$*"
  s="${s#"${s%%[![:space:]]*}"}"
  s="${s%"${s##*[![:space:]]}"}"
  printf '%s' "$s"
}

have_tool() {
  local t="$1" name f pat
  case "$t" in
    plugin:*)
      # Enabled only: "<name>@<marketplace>": true. A disabled (false) entry doesn't count.
      name="${t#plugin:}"
      for f in "${SETTINGS[@]}"; do
        case "$name" in
          *@*) pat="\"${name}\"" ;;            # plugin:name@marketplace
          *)   pat="\"${name}@[^\"]*\"" ;;     # plugin:name, any marketplace
        esac
        [ -f "$f" ] && grep -qE "${pat}[[:space:]]*:[[:space:]]*true" "$f" && return 0
      done
      return 1 ;;
    *) command -v "$t" >/dev/null 2>&1 ;;
  esac
}

applies() {
  local when="$1" g
  local -a globs
  [ "$when" = "always" ] && return 0
  case "$when" in
    has:*)
      read -ra globs <<< "${when#has:}"
      for g in "${globs[@]}"; do
        find . -maxdepth 3 \
          \( -name node_modules -o -name .git -o -name build -o -name .dart_tool -o -name venv -o -name .venv \) -prune \
          -o -name "$g" -print 2>/dev/null | grep -q . && return 0
      done
      return 1 ;;
    *) echo "ERROR: unknown WHEN value: $when" >&2; return 1 ;;
  esac
}

fail=0
warned=0
while IFS='|' read -r type mode tools when || [ -n "$type" ]; do
  type="$(trim "$type")"
  [ -z "$type" ] && continue
  case "$type" in \#*) continue ;; esac
  mode="$(trim "$mode")"; tools="$(trim "$tools")"; when="$(trim "$when")"

  if ! applies "$when"; then
    printf 'SKIP  %-12s not applicable here (%s)\n' "$type" "$when"
    continue
  fi

  read -ra list <<< "$tools"
  found=(); missing=()
  for t in "${list[@]}"; do
    if have_tool "$t"; then found+=("$t"); else missing+=("$t"); fi
  done

  case "$mode" in
    all)
      if [ "${#missing[@]}" -eq 0 ]; then
        printf 'PASS  %-12s have all: %s\n' "$type" "${found[*]}"
      else
        printf 'FAIL  %-12s missing required: %s\n' "$type" "${missing[*]}"; fail=1
      fi ;;
    any)
      if [ "${#found[@]}" -gt 0 ]; then
        printf 'PASS  %-12s have: %s\n' "$type" "${found[*]}"
      else
        printf 'FAIL  %-12s need at least one of: %s\n' "$type" "${missing[*]}"; fail=1
      fi ;;
    want)
      if [ "${#missing[@]}" -eq 0 ]; then
        printf 'PASS  %-12s have all: %s\n' "$type" "${found[*]}"
      else
        printf 'WARN  %-12s recommended but missing: %s\n' "$type" "${missing[*]}"; warned=$((warned+1))
      fi ;;
    *)
      echo "ERROR: unknown MODE '$mode' for rule '$type'" >&2; fail=1 ;;
  esac
done < "$CONF"

echo
if [ "$fail" -eq 0 ]; then
  if [ "$warned" -gt 0 ]; then
    echo "Security tooling check: OK ($warned recommended tool group(s) missing)"
  else
    echo "Security tooling check: OK"
  fi
else
  echo "Security tooling check: FAILED. Install the missing tools or edit $(basename "$CONF")."
fi
exit "$fail"
