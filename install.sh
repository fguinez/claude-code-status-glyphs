#!/bin/sh
# Installer for the Claude Code terminal-glyph status indicators.
# Copies the helper scripts into ~/.claude and merges the hooks into
# ~/.claude/settings.json WITHOUT touching any of your other settings.
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
SETTINGS="$CLAUDE_DIR/settings.json"

mkdir -p "$CLAUDE_DIR"
cp "$DIR/term-title.sh" "$DIR/term-perm.sh" "$CLAUDE_DIR/"
chmod +x "$CLAUDE_DIR/term-title.sh" "$CLAUDE_DIR/term-perm.sh"
echo "✓ Copied helper scripts to $CLAUDE_DIR"

python3 - "$SETTINGS" <<'PY'
import json, os, sys
path = sys.argv[1]
try:
    with open(path) as f:
        s = json.load(f)
except (FileNotFoundError, ValueError):
    s = {}

hooks = s.setdefault("hooks", {})
hooks["PreToolUse"] = [{
    "matcher": "AskUserQuestion",
    "hooks": [{"type": "command", "command": 'sh "$HOME/.claude/term-title.sh" "✦"'}],
}]
hooks["PermissionRequest"] = [{
    "hooks": [{"type": "command", "command": 'sh "$HOME/.claude/term-perm.sh"'}],
}]

with open(path, "w") as f:
    json.dump(s, f, indent=2, ensure_ascii=False)
print("✓ Merged hooks into", path)
PY

echo
echo "Done! Restart your 'claude' sessions to load the hooks."
echo "If you use the Cursor / VS Code integrated terminal, also add this to"
echo "Cursor settings.json so the tab shows the title:"
echo '    "terminal.integrated.tabs.title": "${sequence}"'
