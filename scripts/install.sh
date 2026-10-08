#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
with_render=0
case "${1:-}" in
  '') ;;
  --with-render) with_render=1 ;;
  *) echo '用法：bash scripts/install.sh [--with-render]' >&2; exit 2 ;;
esac
if (( $# > 1 )); then exit 2; fi
if [[ ! -x .venv/bin/python ]]; then
  studio_python="${PYTHON:-}"
  if [[ -z "$studio_python" ]]; then
    for candidate in python3 python3.12 python3.11 python3.13 python3.14; do
      if command -v "$candidate" >/dev/null && "$candidate" -c 'import sys; sys.exit(sys.version_info < (3, 11))'; then
        studio_python="$candidate"
        break
      fi
    done
  fi
  if [[ -z "$studio_python" ]] || ! "$studio_python" -c 'import sys; sys.exit(sys.version_info < (3, 11))'; then
    echo '需要 Python 3.11+；可用 PYTHON=/path/to/python 指定解释器。' >&2
    exit 1
  fi
  "$studio_python" -m venv .venv
fi
.venv/bin/python -c 'import sys; sys.exit(sys.version_info < (3, 11))'
.venv/bin/python -m pip install --disable-pip-version-check -r requirements.txt
.venv/bin/python -m pip check
if (( with_render )); then
  if [[ "$(uname -s)" == Linux ]] && command -v apt-get >/dev/null; then
    elevated=()
    if [[ "$(id -u)" != 0 ]]; then
      if command -v sudo >/dev/null && sudo -n true 2>/dev/null; then
        elevated=(sudo -n)
      else
        echo '请由管理员安装 LibreOffice Writer/Impress、fonts-noto-cjk、poppler-utils、fontconfig。' >&2
        exit 1
      fi
    fi
    "${elevated[@]}" apt-get update
    "${elevated[@]}" env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libreoffice-writer libreoffice-impress fonts-noto-cjk poppler-utils fontconfig
  fi
  .venv/bin/python tools/studio.py doctor --require-render
else
  .venv/bin/python tools/studio.py doctor
  echo 'Python 工具已就绪；完整排版环境请使用 --with-render。'
fi
