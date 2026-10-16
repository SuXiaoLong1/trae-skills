# TRAE Skills 仓库

本仓库汇集了 TRAE IDE 的全部内置 Skill，方便备份、共享和快速安装。

## 可用 Skill 列表

<!-- SKILLS_TABLE_START -->
| Skill 名称 | 描述 |
|---|---|
| **skill-creator** | 创建新 Skill 的引导工具，创建后自动备份到仓库。当用户想要创建/添加 skill 时必须调用 |
| **plan-before-execute** | 计划先行模式。执行操作前先制定分步计划，用户确认后逐步执行 |
| **TRAE-browseruse** | 浏览器自动化指南。用于浏览网页、抓取内容、测试前端 UI |
| **TRAE-browseruse-external** | 外部 Chrome 浏览器自动化。操作用户本地 Chrome 浏览器 |
| **TRAE-code-mode-orchestrator** | 代码模式编排器。用于并行调用、管道处理、条件分支等复杂工具编排 |
| **TRAE-computer-use** | 计算机使用指南。通过 UI 操作控制本地应用程序 |
| **TRAE-computer-use-ptc** | 计算机使用（PTC 模式）。通过 Computer Use MCP 进行桌面交互 |
| **digital-avatar-creator** | 数字分身创建器。创建自主运行的 SubAgent 数字分身 |
| **dynamic-ui** | 动态 UI 内联可视化。生成图表、架构图、交互式 demo 等可视化内容 |
<!-- SKILLS_TABLE_END -->

> ℹ️ **skill-backup** 为全局专用 skill，负责将其他 skill 备份到本仓库，不放入仓库中。

## 安装方式

### 方式一：安装到当前项目（推荐）

将 skill 安装到当前项目的 `.trae/skills/` 目录下：

**Windows (PowerShell):**
```powershell
.\install.ps1 -Target "project"
```

**macOS / Linux:**
```bash
bash install.sh --target project
```

### 方式二：安装为全局 Skill

将 skill 安装到用户级全局目录，所有项目可用：

**Windows (PowerShell):**
```powershell
.\install.ps1 -Target "global"
```

**macOS / Linux:**
```bash
bash install.sh --target global
```

### 方式三：安装指定 Skill

只安装你需要的某个 skill：

**Windows (PowerShell):**
```powershell
.\install.ps1 -Target "project" -Skill "skill-creator"
```

**macOS / Linux:**
```bash
bash install.sh --target project --skill skill-creator
```

### 方式四：手动安装

直接将对应的 skill 文件夹复制到目标位置：

- **项目级**: `<项目根目录>/.trae/skills/<skill-name>/`
- **全局级**: `~/.marscode/builtin/global/skills/<skill-name>/` (Windows: `C:\Users\<用户名>\.marscode\builtin\global\skills\`)

## 目录结构

```
trae-skills/
├── skill-creator/                  # Skill 创建器（自动备份）
│   └── SKILL.md
├── plan-before-execute/            # 计划先行模式
│   └── SKILL.md
├── TRAE-browseruse/                # 浏览器自动化
│   └── SKILL.md
├── TRAE-browseruse-external/       # 外部浏览器自动化
│   └── SKILL.md
├── TRAE-code-mode-orchestrator/    # 代码模式编排器
│   ├── SKILL.md
│   └── references/
├── TRAE-computer-use/              # 计算机使用
│   └── SKILL.md
├── TRAE-computer-use-ptc/          # 计算机使用 (PTC)
│   └── SKILL.md
├── digital-avatar-creator/         # 数字分身创建器
│   └── SKILL.md
├── dynamic-ui/                     # 动态 UI
│   ├── SKILL.md
│   ├── scenes/
│   ├── templates/
│   └── tokens/
├── install.ps1                     # Windows 安装脚本
├── install.sh                      # macOS/Linux 安装脚本
├── LICENSE                         # MIT 开源协议
└── README.md
```