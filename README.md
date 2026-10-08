# 创作工作室

适用于科幻小说、TVC 广告、企业宣传片、纪录片、电影剧本的创作、修订和分镜提案。

**Python CLI 创作工作区**，推荐 Python 3.12，最低 3.11。无需后台服务。仓库内已包含安装、启动检查、测试、打包脚本和启动／发布技能。Codex Cloud 的实际发布状态请以环境界面为准；GitHub 推送不能代替环境发布。

## 开始工作

直接向 Codex 描述项目，例如：
- “新建一个 30 秒 TVC，产品是……，受众是……，先给三个创意方向。”
- “检查这篇科幻小说的人物动机、时间线和科技设定，保留我的叙述风格。”
- “把这个定稿转为分镜清单，再制作可编辑的 16:9 PPTX。”

默认使用中文。项目缺失信息先记录为待确认项；不会把假设写成客户事实。

## 文件位置

| 目录 | 用途 |
|---|---|
| templates/ | 各类型项目模板 |
| projects/ | 每个项目的独立文件夹 |
| references/ | 索引及参考资料；大型素材用链接管理 |
| outputs/ | 项目交付文件 |
| work/ | 临时生成物和排版检查图 |
| docs/ | 云端配置及操作说明 |
| tools/ | 项目初始化、文字统计、版本比较、Word 和分镜 PPTX 导出 |

## 命令

首次安装：`bash scripts/install.sh`。已有虚拟环境会复用；可通过 `PYTHON=/path/to/python` 指定解释器。完整 Linux 云端环境使用 `bash scripts/install.sh --with-render`，会安装 LibreOffice、Noto CJK、Poppler 和 fontconfig（需要 root 或免密 sudo）。macOS 请先准备 LibreOffice、Poppler 与 Noto CJK 字体并加入 PATH；默认安装只安装 Python 依赖。

统一入口：

```bash
bash scripts/start.sh                      # 依赖就绪检查
bash scripts/start.sh --help                # CLI 命令
bash scripts/test.sh                       # 原稿保护、模板、分镜与 Office 导出测试
bash scripts/test.sh --require-render      # 加做 PDF / 中文检查与逐页 PNG
bash scripts/build.sh                      # 测试后打包工具源码至 dist/
```

源码包不含 Python 环境和创作项目；解压后先运行安装脚本。测试生成的样例位于 work/smoke-*，不写入真实项目；正式交付仍需查看逐页 PNG。

GitHub Actions 配置为 Python 3.11/3.12 基础验证和 Ubuntu 完整渲染验证；工作流成功不能代替 Codex Cloud 环境的发布与新任务复测。

仓库技能在 `.agents/skills/`：`studio-start` 用于安装、就绪检查和项目启动；`studio-publish` 用于验证与环境发布。在此仓库内启动 Codex 后可按任务自动发现，也可显式引用 `$studio-start` 或 `$studio-publish`。这些技能无需复制到个人全局目录，也不会自动设置云端环境的 Start skill 字段。

以下命令也可直接使用 `.venv/bin/python`：

```bash
.venv/bin/python tools/studio.py new tvc 我的广告
.venv/bin/python tools/studio.py new scifi 星海回声
.venv/bin/python tools/studio.py stats projects/星海回声/brief.md
.venv/bin/python tools/studio.py diff 旧稿.md 新稿.md
.venv/bin/python tools/studio.py docx projects/我的广告/brief.md outputs/项目简报.docx
.venv/bin/python tools/studio.py pptx templates/storyboard.json outputs/分镜模板.pptx
.venv/bin/python tools/studio.py doctor
```

PPTX 导出为每镜一页的可编辑文字与可替换画面；JSON 中 image 使用相对该 JSON 文件的本地图片路径。缺少图片时明确显示“画面待补”。工具会拒绝过长字段，避免静默截断。正式交付仍需渲染并逐页检查。Word 导出支持标题和段落；复杂表格、修订痕迹和定制品牌版式由 Codex 单独制作。

所有作品按项目保存；修改生成新版本，保留原稿。Git 只跟踪文本、模板和工具；大型素材和交付文件默认不入库。

云端接入见 [docs/云端接入.md](docs/云端接入.md)。
