---
name: "skill-creator"
description: "MANDATORY tool for creating SKILLs - MUST be invoked IMMEDIATELY when user wants to create/add any skill. Auto-backs up new skills to trae-skills repo."
---

# Skill Creator

This skill helps you create new SKILLs for the workspace.

## When to Use

**CRITICAL: You MUST invoke this skill IMMEDIATELY as your FIRST action when:**
- User wants to create a new skill
- User wants to add a custom skill to the workspace
- User asks to set up a skill template
- User asks "how to create a skill"
- User mentions creating/adding/making any skill

**DO NOT:**
- Just explain how to create a skill without invoking this tool
- Provide manual instructions without calling this skill first
- Defer the skill creation to later steps

## SKILL Structure

A valid SKILL requires:

1. **Directory**: `.trae/skills/<skill-name>/`
2. **File**: `SKILL.md` inside the directory

## SKILL.md Format

```markdown
---
name: "<skill-name>"
description: "<concise description covering: (1) what the skill does, (2) when to invoke it. Keep it under 200 characters for best display>"
---

# <Skill Title>

<Detailed instructions, usage guidelines, and examples>
```

## Required Fields

| Field | Location | Description |
|-------|----------|-------------|
| `name` | frontmatter | Unique identifier for the skill |
| `description` | frontmatter | **CRITICAL**: Must include (1) what the skill does AND (2) when to invoke it. This helps the model decide when to use the skill. Keep under 200 chars. |
| `detail` | body | Full markdown content after frontmatter |

## Creation Steps

1. Ask user for skill name and purpose
2. **IMPORTANT**: When generating the `description` field, ALWAYS include:
   - What the skill does (functionality)
   - **MUST emphasize when to invoke it** (trigger conditions/scenarios)
   - Example format: "Does X. Invoke when Y happens or user asks for Z."
   - **Language**: Use English by default unless user specifies another language
3. Create directory:
   - Project-level: `.trae/skills/<skill-name>/`
   - Global: `C:\Users\14764\.marscode\builtin\global\skills\<skill-name>\`
4. Create `SKILL.md` with proper frontmatter and content
5. Validate the structure is correct

### Step 6: Auto-Backup to trae-skills Repository

**CRITICAL — Do this EVERY TIME you create a skill, without asking the user, UNLESS the user explicitly says "不要备份" or "不备份到仓库".**

After creating the skill, immediately back it up:

```powershell
# Copy the new skill to the local repo
powershell -Command "Copy-Item -Path '<skill-source-dir>' -Destination 'f:\办公\note\trae-skills\<skill-name>' -Recurse -Force"

# Stage, commit, and push
git -C "f:\办公\note\trae-skills" add "<skill-name>/"
git -C "f:\办公\note\trae-skills" commit -m "add: <skill-name> skill"
git -C "f:\办公\note\trae-skills" push
```

**Exception**: Do NOT backup `skill-backup` itself. Skip backup for it.

After backup, briefly inform: "已自动备份到 trae-skills 仓库并推送。"

## Example

To create a "code-reviewer" skill:

```bash
mkdir -p .trae/skills/code-reviewer
```

Then create `.trae/skills/code-reviewer/SKILL.md`:

```markdown
---
name: "code-reviewer"
description: "Reviews code for best practices, bugs, and improvements. Invoke when user asks for code review or before merging changes."
---

# Code Reviewer

This skill reviews code and provides feedback...
```