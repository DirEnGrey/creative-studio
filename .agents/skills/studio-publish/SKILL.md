---
name: studio-publish
description: 验证、打包和发布 creative-studio 的工具配置或 Codex Cloud 环境；不用于发布小说、客户作品或其他应用。
---

读取 docs/云端接入.md，识别用户要求的是源码更新还是 Codex Cloud 环境发布。Git 推送与环境 Publish 是两个不同结果。

先运行 `bash scripts/test.sh` 和 `bash scripts/build.sh`。完整云端发布还需 `bash scripts/test.sh --require-render` 并检查生成的逐页图片；源码包位于 dist/creative-studio.tar.gz，只含工具、模板和配置。

提交前核对 git diff 和远程状态，仅选择工具与配置文件。projects、references、outputs、work 内的私人内容不得随工具配置自动公开。用户提出发布请求时按其授权执行；没有发布请求时仅验证和准备文件。

云端使用 `bash scripts/install.sh --with-render` 作为 Install script，Start skill 内容见 docs/云端接入.md。设置保存后执行 Publish/Republish，确认 Environment published，并在新任务复测。没有可操作的已登录云端设置界面、仓库授权或目标环境时，保留已完成的代码和验证报告，明确报告阻塞，不声称已发布。不要用未经文档支持的接口或读取本机认证文件代替云端配置。
