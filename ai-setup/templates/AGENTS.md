# Project name

What this project is, in one or two sentences.

## Build and test

```sh
# the exact commands agents should run
```

## Memory: read first, update last

Project state lives in `memory/`, in the repo. Any agent or engineer can pick up from it.

- **Start of a session:** read `memory/*`.
- **End of a session (or before a push):** update your task's section in `progress.md`: status, next step, blockers.
- **When you choose between options:** add an entry to `decision.md` (append only, never rewrite old entries).
- **A fact that stays true** (a convention, a gotcha) goes in this file or the app's `AGENTS.md`, not in `memory/`.
- Commit `memory/` with the code it describes.

