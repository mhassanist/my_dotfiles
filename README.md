# ai-msaudi

My central AI dev setup: the global agent guide and the tooling that keeps every repo in line.

| Path | What |
| --- | --- |
| `AGENTS.md` | The global agent guide: the only real copy. |
| `ai-setup/` | `ai-setup` checker + fixer for any repo (see `ai-setup/README.md`). |
| `examples/` | Example project and sub-package AGENTS.md files. |

Everything else links here:

- `~/.agents/AGENTS.md` → `~/.ai-msaudi/AGENTS.md`
- `~/.claude/CLAUDE.md` contains `@~/.agents/AGENTS.md`
- `~/.codex/AGENTS.md` → `~/.agents/AGENTS.md`
- `ai-setup` on PATH → `~/.ai-msaudi/ai-setup/ai-setup` (`bash ai-setup/install.sh`)

On a new machine: clone this repo to `~/.ai-msaudi`, run `bash ai-setup/install.sh`, then `ai-setup` in any repo; it offers to create the links above.
