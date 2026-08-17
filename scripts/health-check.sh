#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo '=== Feishu Weekly Watch environment health check ==='
echo "repo=$ROOT"
echo "branch=$(git -C "$ROOT" branch --show-current 2>/dev/null || echo unknown)"
echo "commit=$(git -C "$ROOT" rev-parse --short HEAD 2>/dev/null || echo unknown)"
echo "time_asia_shanghai=$(TZ=Asia/Shanghai date '+%Y-%m-%d %H:%M:%S %Z')"

echo -n 'node='; node --version || true
echo -n 'npm='; npm --version || true

if command -v lark-cli >/dev/null 2>&1; then
  echo "lark_cli=$(command -v lark-cli)"
  lark-cli --version || true
  echo '--- auth status ---'
  lark-cli auth status || true
else
  echo 'lark_cli=missing'
fi

if [[ -n "${FEISHU_APP_ID:-}" ]]; then
  echo 'FEISHU_APP_ID=present'
else
  echo 'FEISHU_APP_ID=missing'
fi

if [[ -n "${FEISHU_APP_SECRET:-}" ]]; then
  echo 'FEISHU_APP_SECRET=present'
else
  echo 'FEISHU_APP_SECRET=missing'
fi
