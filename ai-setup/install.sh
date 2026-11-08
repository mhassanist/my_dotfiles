#!/usr/bin/env bash
# Puts `ai-setup` on your PATH by linking it into a bin folder already on your PATH.
# Never overwrites: if something named ai-setup is already there, it stops.
set -uo pipefail
dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
src="$dir/ai-setup"
chmod +x "$src" "$dir/check_security_tooling.sh"
for d in "$HOME/.local/bin" /opt/homebrew/bin /usr/local/bin; do
  case ":$PATH:" in *":$d:"*) ;; *) continue ;; esac
  [ -d "$d" ] && [ -w "$d" ] || continue
  dest="$d/ai-setup"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then echo "= already linked: $dest"; exit 0; fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then echo "! $dest already exists and isn't this script; left alone." >&2; exit 1; fi
  ln -s "$src" "$dest" && echo "+ linked $dest -> $src" && echo "Next: ai-setup machine"
  exit $?
done
echo "No writable folder on your PATH found. Add this line to ~/.zshrc instead:"
echo "  export PATH=\"$dir:\$PATH\""
exit 1
