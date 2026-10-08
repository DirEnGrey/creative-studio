#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
python3 -m venv .venv
.venv/bin/python -m pip install --disable-pip-version-check -r requirements.txt
if [[ "$(uname -s)" == "Linux" ]] && command -v apt-get >/dev/null; then
  if [[ "$(id -u)" == "0" ]]; then
    apt-get update
    apt-get install -y --no-install-recommends libreoffice-writer libreoffice-impress fonts-noto-cjk poppler-utils
  elif command -v sudo >/dev/null && sudo -n true 2>/dev/null; then
    sudo -n apt-get update
    sudo -n apt-get install -y --no-install-recommends libreoffice-writer libreoffice-impress fonts-noto-cjk poppler-utils
  else
    echo '需要管理员安装：libreoffice-writer libreoffice-impress fonts-noto-cjk poppler-utils' >&2
    exit 1
  fi
fi
.venv/bin/python tools/studio.py doctor --require-render
