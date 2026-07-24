#!/bin/bash
# Claude Code Skills sync — run on new machine to install all skills
set -e

SKILLS_DIR="$HOME/.claude/skills"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$SKILLS_DIR"

echo "Linking skills from $REPO_DIR/skills/ to $SKILLS_DIR ..."
for skill in "$REPO_DIR/skills/"*; do
  name=$(basename "$skill")
  target="$SKILLS_DIR/$name"
  if [ -e "$target" ]; then
    echo "  skip: $name (already exists)"
  else
    ln -s "$skill" "$target" 2>/dev/null || cp -r "$skill" "$target"
    echo "  done: $name"
  fi
done

echo "All skills synced."
