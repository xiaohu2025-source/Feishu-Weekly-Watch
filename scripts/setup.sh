#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RUNTIME_DIR="$ROOT/.runtime"
mkdir -p "$RUNTIME_DIR"

printf '[setup] repo: %s\n' "$ROOT"
printf '[setup] node: '; node --version
printf '[setup] npm: '; npm --version

if ! command -v lark-cli >/dev/null 2>&1; then
  echo '[setup] installing Feishu/Lark CLI...'
  npm install -g @larksuite/cli
fi

printf '[setup] lark-cli: '; lark-cli --version || true

# Install Feishu CLI skill when supported. This is idempotent and non-fatal.
if command -v npx >/dev/null 2>&1; then
  npx -y skills add https://open.feishu.cn --skill -y || true
fi

# Optional application configuration. Keep credentials in Codex Environment
# secrets / environment variables, never in Git.
if [[ -n "${FEISHU_APP_ID:-}" && -n "${FEISHU_APP_SECRET:-}" ]]; then
  cat > "$RUNTIME_DIR/feishu-app.env" <<EOF
FEISHU_APP_ID=${FEISHU_APP_ID}
FEISHU_APP_SECRET=${FEISHU_APP_SECRET}
EOF
  chmod 600 "$RUNTIME_DIR/feishu-app.env"
  echo '[setup] Feishu application secrets detected and staged in runtime only.'
else
  echo '[setup] FEISHU_APP_ID / FEISHU_APP_SECRET not set; interactive auth may be required.'
fi

cat > "$RUNTIME_DIR/environment.txt" <<EOF
repo=xiaohu2025-source/Feishu-Weekly-Watch
branch=$(git -C "$ROOT" branch --show-current 2>/dev/null || echo unknown)
created_at=$(date -u +%Y-%m-%dT%H:%M:%SZ)
lark_cli=$(command -v lark-cli || true)
EOF

echo '[setup] environment bootstrap complete.'
