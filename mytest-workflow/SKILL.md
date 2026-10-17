---
name: "mytest-workflow"
description: "Manages the mytest development workflow: develop code in mytest/, merge into the main project, and push to GitHub. Invoke when the user says '合并', '提交', '推送', or asks about commit/push strategy for this repo."
---

# Mytest 开发工作流

## 概述

本 skill 管理以下完整开发工作流：

```
在 mytest/ 中写代码 → 验证通过 → 用户说"合并" → 按策略合并 → 用户确认"提交" → 推送到 GitHub
```

## 核心原则

1. **隔离开发**：所有新代码必须放在 `mytest/` 目录下，不得直接修改原项目文件
2. **先验证后合并**：合并前必须在 `mytest/` 中运行验证通过
3. **用户确认才推送**：只有在用户明确说"提交"或"推送"后，才执行 git push
4. **可追溯**：每次提交有清晰的 commit message，方便回溯

---

## 仓库信息

| 项目 | 值 |
|------|-----|
| 本地路径 | `f:\python\March7thAssistant` |
| 上游仓库 (origin) | `https://github.com/moesnow/March7thAssistant` |
| 当前分支 | `main` |
| 开发目录 | `mytest/` |

> 如需推送到自己的 fork，请先执行：
> ```bash
> git remote add myfork https://github.com/<你的用户名>/March7thAssistant.git
> ```
> 之后所有推送将使用 `myfork` 远程。

---

## 工作流详解

### 阶段一：开发 (在 mytest/ 中)

**规则**：
- 所有新建代码文件、脚本、资源都放在 `mytest/` 目录下
- 如果需要在原项目文件中添加引用（如 import），这是允许的，但必须最小化修改
- 修改原项目文件前，必须向用户说明并确认

**用户指令示例**：
> "在 mytest 里写一个 xxx 功能"

**AI 行为**：
1. 在 `mytest/` 中创建/修改代码
2. 在 `mytest/` 中运行测试验证
3. 不需要 git 操作

---

### 阶段二：合并 (用户说"合并"时触发)

**触发词**：`合并`、`merge`、`整合`

**执行步骤**：
1. 检查 `mytest/` 中的代码是否可正常运行
2. 生成合并计划，列出：
   - 哪些文件从 `mytest/` 移动到项目目录
   - 哪些原项目文件需要修改（如添加 import）
   - 影响的目录/模块
3. 展示计划给用户确认
4. 用户确认后执行合并操作

**代码放置规则**：
- 如果 mytest 中的代码是对原项目某模块的增强 → 合并到对应模块目录
- 如果是独立新功能 → 在项目根目录创建新模块目录
- `mytest/` 中的 `.md` 文档保留在 `mytest/`（不合并）

---

### 阶段三：提交策略

**分支策略**：

```
main (上游同步)
  └── feature/mytest-xxx (你的功能分支)
```

**操作流程**：

```bash
# 1. 从 main 创建功能分支
git checkout -b feature/mytest-<功能名>

# 2. 提交合并后的代码
git add <文件列表>
git commit -m "<type>(<scope>): <描述>"

# 3. (可选) 合并回 main
git checkout main
git merge feature/mytest-<功能名>
```

**Commit Message 规范 (Conventional Commits)**：

```
<type>(<scope>): <简短描述>

<详细说明（可选）>
```

| type | 说明 | 示例 |
|------|------|------|
| `feat` | 新功能 | `feat(mytest): 添加自动签到模块` |
| `fix` | 修复 bug | `fix(mytest): 修复签到超时问题` |
| `refactor` | 重构代码 | `refactor(mytest): 优化 OCR 调用逻辑` |
| `docs` | 文档修改 | `docs(mytest): 更新使用说明` |
| `test` | 添加测试 | `test(mytest): 添加签到模块单元测试` |
| `chore` | 构建/工具 | `chore(mytest): 更新依赖配置` |

**scope** 建议使用：
- `mytest` — mytest 目录内的变更
- 或具体模块名，如 `ocr`、`notification`、`game`

---

### 阶段四：推送 (用户说"提交"或"推送"时触发)

**触发词**：`提交`、`推送`、`commit`、`push`

**前置确认清单**（AI 必须先展示给用户）：
```
## 📋 准备提交

| 检查项 | 状态 |
|--------|------|
| 代码在 mytest/ 中验证通过 | ✅/❌ |
| 合并后的文件列表正确 | ✅/❌ |
| commit message 格式正确 | ✅/❌ |
| 推送目标分支确认 | main / feature/xxx |

**Commit Message**:
<type>(<scope>): <描述>

**推送目标**:
git push origin main
# 或
git push myfork main

确认后我将执行提交和推送。
```

**用户确认后执行**：
```bash
git add <文件列表>
git commit -m "<commit message>"
git push <remote> <branch>
```

---

## 完整示例流程

```
用户: 在 mytest 里写一个每天自动签到的脚本
 AI : [在 mytest/auto_checkin.py 创建代码]
 AI : [在 mytest/ 中运行验证，确认通过]

用户: 合并
 AI : [生成合并计划]
      - 移动 mytest/auto_checkin.py → tasks/activity/auto_checkin.py
      - 修改 tasks/activity/__init__.py 添加 import
      - 修改 utils/tasks.py 注册新任务
      确认？

用户: 确认
 AI : [执行文件移动和修改]

用户: 提交
 AI : [展示提交清单]
      Commit: feat(activity): 添加自动签到模块
      Push:  git push origin main
      确认？

用户: 确认
 AI : [执行 git add → git commit → git push]
```

---

## 注意事项

1. **上游同步**：如果上游仓库 (`moesnow/March7thAssistant`) 有更新，先执行：
   ```bash
   git fetch origin
   git merge origin/main
   ```
   确保你的分支基于最新代码。

2. **冲突处理**：合并时如遇冲突，优先保留你的修改，再手动调整兼容上游变更。

3. **mytest 目录**：`mytest/` 是开发沙盒目录。合并后其中的文件被移走，`mytest/` 可以保留为空或删除，等待下一次开发。

4. **不要直接 push 到 upstream**：除非你有 moesnow/March7thAssistant 的写权限并打算提交 PR，否则应推送到你自己的 fork。

5. **`.gitignore`**：确认 `mytest/` 是否在 `.gitignore` 中。如果在，合并后的代码不受影响；原项目已配置 `.trae/` 被忽略。