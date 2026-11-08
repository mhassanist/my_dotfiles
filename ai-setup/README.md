# ai-setup

Checks a repo's AI dev setup and offers to fix what's missing: agent guides, `memory/`,
security tooling, gitleaks, lefthook hooks, the global agent guide and the Cubit → repository rule.

    bash ~/.ai-msaudi/ai-setup/install.sh   # once: links `ai-setup` onto your PATH
    ai-setup                                # current repo, asks y/N before each fix
    ai-setup ~/development/muslim-book-v4   # any repo
    ai-setup --check                        # report only (also used automatically in git hooks)
    ai-setup --yes                          # apply every offered fix

- Each repo's required tools: `tools/security_tools.conf` (created from `templates/` if missing).
- Templates for new files: `templates/`. Edit them to change what new repos get.
- Never overwrites or deletes. Files it appends to are backed up first unless git can restore them.
- Only run it on repos you trust: it installs their git hooks, which then run that repo's commands on every commit.
