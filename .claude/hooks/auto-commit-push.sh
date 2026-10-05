#!/usr/bin/env bash
# Dijalankan oleh hook PostToolUse (Write|Edit): git add, commit, lalu push.
cd "${CLAUDE_PROJECT_DIR:-.}" || exit 1

git add -A
git diff --cached --quiet && exit 0

files=$(git diff --cached --name-only | head -n 3 | paste -sd ',' - | sed 's/,/, /g')
git commit -q -m "Auto-commit: $files" -m "Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>" || exit 1
git push -q -u origin HEAD
