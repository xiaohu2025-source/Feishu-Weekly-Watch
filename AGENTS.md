# Feishu Weekly Watch — Codex Environment Instructions

This repository is the persistent environment anchor for the Commercial Robotic Mower Weekly Watch workflow.

## Bootstrap

At the beginning of a fresh Codex/cloud workspace, run:

```bash
bash scripts/setup.sh
bash scripts/health-check.sh
```

## Security

- Never commit Feishu/Lark tokens, cookies, App Secret, user access tokens, refresh tokens, or generated auth bundles.
- Keep `FEISHU_APP_ID` and `FEISHU_APP_SECRET` in Codex Environment secrets/variables.
- Runtime-only credential material belongs under `.runtime/`, which is gitignored.

## Feishu CLI

Official package:

```bash
npm install -g @larksuite/cli
npx -y skills add https://open.feishu.cn --skill -y
```

First-time configuration / re-authentication when needed:

```bash
lark-cli config init --new
lark-cli auth login --recommend
lark-cli auth status
```

Do not run interactive auth during unattended scheduled execution unless the environment has already been authorized.

## Weekly Watch defaults

- Timezone: `Asia/Shanghai`
- Repository: `xiaohu2025-source/Feishu-Weekly-Watch`
- Default branch: `main`
- Health check: `bash scripts/health-check.sh`

The scheduled-task definition itself is managed outside this repository unless explicitly migrated here.
