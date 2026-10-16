#!/bin/bash

TARGET="project"
SKILL=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --target)
            TARGET="$2"
            shift 2
            ;;
        --skill)
            SKILL="$2"
            shift 2
            ;;
        *)
            echo "未知参数: $1"
            echo "用法: bash install.sh --target [project|global] [--skill <skill-name>]"
            exit 1
            ;;
    esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ "$TARGET" = "global" ]; then
    DEST_ROOT="$HOME/.marscode/builtin/global/skills"
else
    DEST_ROOT="$(pwd)/.trae/skills"
fi

mkdir -p "$DEST_ROOT"

echo ""
echo "安装目标: $DEST_ROOT"
echo "----------------------------------------"

COUNT=0
for SKILL_DIR in "$SCRIPT_DIR"/*/; do
    SKILL_NAME=$(basename "$SKILL_DIR")
    
    if [ "$SKILL_NAME" = ".git" ]; then
        continue
    fi
    
    if [ ! -f "$SKILL_DIR/SKILL.md" ]; then
        continue
    fi
    
    if [ -n "$SKILL" ] && [ "$SKILL_NAME" != "$SKILL" ]; then
        continue
    fi
    
    DEST_PATH="$DEST_ROOT/$SKILL_NAME"
    
    if [ -d "$DEST_PATH" ]; then
        rm -rf "$DEST_PATH"
        echo "覆盖: $SKILL_NAME"
    else
        echo "安装: $SKILL_NAME"
    fi
    
    cp -r "$SKILL_DIR" "$DEST_PATH"
    COUNT=$((COUNT + 1))
done

if [ -n "$SKILL" ] && [ "$COUNT" -eq 0 ]; then
    echo "错误: 未找到 skill '$SKILL'"
    echo "可用的 skill:"
    for d in "$SCRIPT_DIR"/*/; do
        name=$(basename "$d")
        if [ "$name" != ".git" ] && [ -f "$d/SKILL.md" ]; then
            echo "  - $name"
        fi
    done
    exit 1
fi

echo "----------------------------------------"
echo "完成! 已安装 $COUNT 个 skill 到 $DEST_ROOT"
echo ""