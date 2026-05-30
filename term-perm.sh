#!/bin/sh
# Reads the PermissionRequest hook payload on stdin and picks the glyph:
#   AskUserQuestion (clarifying question) -> ✦
#   anything else (real permission prompt) -> ✿
payload="$(cat)"
case "$payload" in
  *AskUserQuestion*) glyph="✦" ;;
  *) glyph="✿" ;;
esac
exec sh "$HOME/.claude/term-title.sh" "$glyph"
