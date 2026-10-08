# 创作工作室

适用于科幻小说、TVC 广告、企业宣传片、纪录片、电影剧本的创作、修订和分镜提案。

**当前状态：工作区文件已准备；Codex 云端环境尚待创建、安装验证与发布。**

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

首次安装：`bash scripts/install.sh`。之后使用 `.venv/bin/python`。

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
