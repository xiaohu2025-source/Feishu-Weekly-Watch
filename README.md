# Feishu Weekly Watch

Persistent repository anchor for the Commercial Robotic Mower Weekly Watch Codex/cloud workflow.

## What this repository persists

This repo stores the reproducible environment definition rather than credentials or ephemeral workspace state:

- `scripts/setup.sh` — installs/restores required CLI tooling and prepares runtime directories.
- `scripts/health-check.sh` — validates repository context, Asia/Shanghai time, Node/npm, Lark CLI, and auth state.
- `.env.example` — names the required environment variables without storing secrets.
- `AGENTS.md` — instructions automatically available to Codex when operating in the repository.
- `.gitignore` — prevents runtime tokens and secrets from being committed.

## Fresh environment bootstrap

```bash
bash scripts/setup.sh
bash scripts/health-check.sh
```

The setup follows the official Feishu CLI installation flow using `@larksuite/cli` and the Feishu CLI skill.

## First authorization

If `lark-cli auth status` reports that no user is authorized, complete a one-time interactive authorization inside the new Codex environment:

```bash
lark-cli config init --new
lark-cli auth login --recommend
lark-cli auth status
```

Credentials and authorization state must stay outside Git. Put application credentials in Codex Environment secrets/variables and keep generated runtime material under `.runtime/`.

## Weekly Watch

Default timezone: `Asia/Shanghai`.

The existing ChatGPT scheduled task is intentionally not changed by this repository setup.
