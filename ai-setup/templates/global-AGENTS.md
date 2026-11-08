# Global agent guide

Rules for every repo, for any AI agent (Claude Code, Codex, Cursor, ...).
The repo's own AGENTS.md adds project rules and wins where the two differ.

## How I work
- Keep answers concise. Explain what you'll change before changing it.
- Before a command that could overwrite or delete data (`rm`, `mv`, `ln -sf`, `>`), say so first and use the safe form (back up, no force flags).

## Every session
- Read the repo's AGENTS.md and `memory/` (progress.md, decision.md) first.
- Before ending: update your task's section in `memory/progress.md`; log choices in `memory/decision.md`.

## Safety
- Never commit secrets, keys or tokens. Never log them.
- Never bypass git hooks (`--no-verify`, `LEFTHOOK=0`).
- Ask before deleting files, force-pushing, rewriting history or deploying.

## Quality
- Tests first for new behaviour; run the repo's tests and analyzer before saying done.
- Stay inside the task: no drive-by refactors.
