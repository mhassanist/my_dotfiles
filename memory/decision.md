# Decisions

Append only. One entry per choice: date, decision, why, alternatives considered.

## 2026-11-08: Keep ai-setup small
- Decision: one script with two commands (`link`, repo setup). No settings sync, no auto-installs, tools only warned about.
- Why: the links.conf / settings-sync version got hard to maintain.
- Dropped: links.conf, Claude settings/agents sync, Cubit and CI checks, deny rules, history scan, re-check loop.

## 2026-11-08: Memory rules live in the global guide
- Decision: the Memory section is in `~/.ai-msaudi/AGENTS.md` once; repos only need `memory/progress.md` and `memory/decision.md`.
- Why: the rules are the same in every repo; one copy to edit.
- Exception: shared repos (e.g. Blink) keep their own Memory section, since teammates don't have this global guide.
- Rejected: moving the global guide to `global/AGENTS.md` so this repo could have its own guide.

## 2026-11-08: Agent links refreshed on every push
- Decision: each repo's lefthook pre-push runs `ai-setup link --quiet` (skipped if ai-setup isn't installed).

## 2026-11-08: gitleaks mobile rules
- Decision: Flutter repos get `.gitleaks.toml` with rules for keystores, signing passwords, Apple keys and service accounts; Firebase client config is allowlisted (public by design).
