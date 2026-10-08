#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
bash scripts/test.sh
# 白名单打包：不包含任何项目稿件、素材、工作文件或凭据。
mkdir -p dist
COPYFILE_DISABLE=1 tar --exclude=__pycache__ --exclude='*.pyc' -czf dist/creative-studio.tar.gz AGENTS.md README.md requirements.txt .python-version .gitignore .gitattributes .agents .github scripts tools tests templates docs
echo '源码包：dist/creative-studio.tar.gz（不含运行环境和作品）'
