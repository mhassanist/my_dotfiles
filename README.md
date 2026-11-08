# ai-msaudi

My AI dev setup in one place. Edit here only.

| Path | What |
| --- | --- |
| `AGENTS.md` | The global agent guide. Every installed agent's global file links to it. |
| `tools.conf` | Tools a coding project needs (required / recommended). Checked, never installed. |
| `templates/` | What `ai-setup` adds to a repo: AGENTS.md + memory, lefthook, gitleaks, analysis_options. |
| `examples/` | Example project and sub-package AGENTS.md files. |
| `ai-setup/` | The `ai-setup` script and `install.sh`. |

## Use

```bash
bash ~/.ai-msaudi/ai-setup/install.sh   # once per machine: puts ai-setup on PATH
ai-setup link                           # point every agent's global guide at AGENTS.md
cd <repo> && ai-setup                   # set up / check a code repo (asks before each change)
ai-setup --check                        # report only
```

- **Agent links:** `~/.agents/AGENTS.md`, `~/.claude/CLAUDE.md`, `~/.claude-blink/CLAUDE.md`,
  `~/.codex/AGENTS.md`, `~/.gemini/GEMINI.md`, `~/.config/opencode/AGENTS.md` (only for agents
  that are installed). To add an agent, add its path to `AGENT_FILES` at the top of `ai-setup/ai-setup`.
  Every repo's pre-push hook runs `ai-setup link --quiet`, so the links are restored on each push.
- **Repo setup:** memory (AGENTS.md Memory section, CLAUDE.md import, `memory/progress.md`,
  `memory/decision.md`), lefthook (gitleaks, analyze, tests, AI review reminder, link refresh),
  `.gitleaks.toml` with mobile signing rules, `analysis_options.yaml` (Flutter), tools from `tools.conf`.
- Never deletes: anything replaced is kept as `<file>.bak-<time>`.
- Only run it on repos you trust: their git hooks run on every commit.
