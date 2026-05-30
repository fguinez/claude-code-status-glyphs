#!/bin/sh
# Emit a terminalSequence JSON that sets the tab title to: <emoji> <name>
# name = $CLAUDE_TITLE if set, else the current directory's basename.
name="${CLAUDE_TITLE:-$(basename "$PWD")}"
b='\'
printf '%s' "{\"terminalSequence\":\"${b}u001b]0;$1 ${name}${b}u0007\"}"
