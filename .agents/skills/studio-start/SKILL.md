---
name: studio-start
description: 安装或启动 creative-studio 创作工作区，检查 Python、Office 导出和排版工具是否就绪；不用于其他仓库。
---

在包含 tools/studio.py 的仓库根目录工作。读取 AGENTS.md；已有创作任务还需读取该项目 brief 和最新反馈。

- 首次安装运行 `bash scripts/install.sh`；完整 Linux 云端环境运行 `bash scripts/install.sh --with-render`。需要 Python 3.11+，解释器可通过 PYTHON 指定。使用仓库的 .venv，不向全局 Python 安装依赖。
- 常规启动运行 `bash scripts/start.sh`。本仓库是 CLI 工作区，没有 HTTP 服务、端口或守护进程。
- 需要 Word/PPTX/PDF 正式交付时运行 `bash scripts/start.sh doctor --require-render`，再运行 `bash scripts/test.sh --require-render`。后者保存本次样例、PDF 和逐页 PNG 至 work/smoke-*；检查这些图片的中文、溢出和图片比例。
- 新项目用 `bash scripts/start.sh new <kind> <项目名>`，类型为 scifi、tvc、corporate、documentary、screenplay。先检查现有项目，避免重复创建或覆盖作品。

工具缺失时报告具体缺失项及失败命令。可生成基础 Office 文件不等于排版验收通过；本地测试不等于云端已发布。此技能不能代替云端环境设置中的 Start skill 字段；配置方法见 docs/云端接入.md。
