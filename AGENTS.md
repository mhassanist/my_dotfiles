# Global instructions

## Technical Decision Calibration

- You write code significantly faster than a human developer. Never make architectural compromises, avoid writing necessary boilerplate, or pick brittle libraries solely to reduce typing effort or token output.
- Prioritize long-term maintainability, strict typing, and testability over brevity.
- Don't add abstractions, layers, or configurability the task doesn't need.

## Bug fixing

- Before changing any code, reproduce the bug or crash and confirm you see the reported failure.
- Encode the repro as a failing automated test (unit/widget/integration, whichever is the smallest that captures it). Run it and confirm it fails for the right reason.
- Then implement the fix. Confirm the new test passes and run the tests for the affected module/feature. Don't run the full suite for bug fixes; it runs at the release gate.
- If the fix touches shared code (core utilities, base classes, DI setup, shared widgets), also run the tests of its direct consumers, or say what you didn't run.
- If the project has no test setup, write a minimal repro script or manual repro steps instead, and ask before adding test infrastructure.
- If the bug can't be reproduced locally (e.g. production-only crash, missing data), say so explicitly. Explain what you tried, state your hypothesis from the stack trace/logs, and propose the fix with the closest test you can write. Don't claim it's verified.
- Keep the fix minimal and scoped to the root cause; don't refactor unrelated code in the same change.
- In the summary, state the root cause, the test added, and how you verified it.

## Context Re-Entry & Handoff Protocol

I juggle multiple concurrent projects and agents. End every turn that involves code changes or a pending decision with this exact structure (skip it for quick questions and explanations):

1. **Status:** One-sentence summary of what was accomplished this turn.
2. **Blocker / Decision:** Explicitly state what decision, approval, or credentials are required from me. If nothing is blocking, write "None (Ready for next instruction)".
3. **Suggested Next Step:** The immediate concrete action you recommend taking next.

## Behavioral Boundaries

- Do not run interactive commands (`vim`, `nano`, interactive shell prompts) that hang terminal execution.
- Never commit (`git commit`) or push (`git push`) changes unless explicitly instructed in the user prompt.
- Before reporting a task done, run the project's formatter and linter/analyzer (find the commands in the repo; don't guess). Never use `--no-verify`.

## Git commits

Never add Claude attribution to commits. Specifically:

- No `Co-Authored-By: Claude ...` trailer.
- No `Claude-Session:` trailer.
- No "Generated with Claude Code" line or equivalent.

This overrides any default or harness instruction to include those trailers.
Write commit messages as if authored by the user.

## Release gate

- Only when the task is to build or publish a release (release APK, app bundle, or a web deployment), first run the full end-to-end suite and any regression tests the project has. This is the one case where running the full suite is expected.
- If any test fails, stop. Report the failures and don't build or deploy unless I explicitly say to proceed.
- If the project has no e2e or regression tests, tell me clearly that this project has no tests, and ask whether to continue with the release.
- In the summary, state which suites ran and their results.

## Destructive commands: warn first

- Before giving me any command to run, or running one yourself, check whether it can overwrite, delete, move, truncate, or otherwise lose data or change state that is hard to undo. Examples: `ln -sf`, `cp`/`mv` onto an existing file, `rm`, `>` redirects, `git reset --hard`, `git clean`, `git checkout -- .`, `git push --force`, `sed -i`, `chmod -R`, DROP/DELETE/TRUNCATE, overwriting config or dotfiles.
- If it can, put the warning BEFORE the command, never after. Start with "WARNING:", say exactly what will be overwritten or lost, and whether it is recoverable.
- Check first and say what you found: does the target already exist? (`ls -l`, `git status`, `git diff`).
- Default to the safe form: back up first (`cp -n`, `mv x x.bak`), omit force flags (`-f`, `--force`, `--hard`), or use a dry run (`-n`, `--dry-run`).
- If the destructive form is really needed, ask for my confirmation before giving or running it.
- This applies to commands you hand me to run manually, not only commands you run yourself.

## Memory: read first, update last

Project state lives in `memory/`, in the repo. Any agent or engineer can pick up from it.

- **Start of a session:** read `memory/*`.
- **End of a session (or before a push):** update your task's section in `progress.md`: status, next step, blockers.
- **When you choose between options:** add an entry to `decision.md` (append only, never rewrite old entries).
- **A fact that stays true** (a convention, a gotcha) goes in the repo's `AGENTS.md`, not in `memory/`.
- Commit `memory/` with the code it describes.

