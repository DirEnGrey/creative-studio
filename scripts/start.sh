#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
if [[ ! -x .venv/bin/python ]]; then
  echo '请先运行 bash scripts/install.sh（云端加 --with-render）。' >&2
  exit 1
fi
if (( $# )); then
  exec .venv/bin/python tools/studio.py "$@"
fi
.venv/bin/python tools/studio.py doctor
echo '创作工作室已就绪；本项目无后台服务。可运行 bash scripts/start.sh --help 查看命令。'
