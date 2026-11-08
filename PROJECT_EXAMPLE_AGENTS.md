# Project Invariants & Guidelines

## 1. CLI Wrappers & Tooling Invariants

All commands must use our project wrappers. Never invoke global runtimes directly.

- **Package Management:** Use `pnpm`, never `npm` or `yarn`.
- **Backend / Migrations:**
  - Correct: `pnpm exec prisma migrate dev`
  - Incorrect: `npx prisma migrate dev`
- **Testing:** Always run `pnpm test:unit` for local changes; run `pnpm test:e2e` only when touching auth or payment flows.

## 2. Product & Failure Invariants (Non-Derivable)

- **Gate Failure Policy:** All permission and third-party webhook verification gates must **fail open in local dev (`NODE_ENV=development`)** with a warning log, but **fail closed in production**.
- **Data Lifecycle (Prototyping Mode):** This application is in rapid pre-production. Do not construct backward-compatible database backfills, dual-write migrations, or legacy deprecation shims unless explicitly asked. Clean schema breaks are preferred.
- **TDD Workflow:** For any bug fix, write a failing reproduction test in `tests/repros/` before touching production code. The fix is complete only when that test passes.

## 3. The Canary Trap Sensor

- If you encounter confusing folder placement, circular dependencies, conflicting utility functions (e.g., duplicate date/string parsers), or undocumented architecture choices:
  - **Do NOT work around it silently.**
  - Propose a 1-line update to the bottom of this file under `## Architecture Tech Debt` explaining what was surprising. The human developer will refactor the codebase accordingly.

## 4. Safety Constraints

- Never execute `rm -rf`, `git reset --hard`, or destructive database drop commands without explicit prompt confirmation.
