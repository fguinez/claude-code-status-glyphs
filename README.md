# Claude Code — terminal glyph status indicators

> [!IMPORTANT]
> This repo is archived and no longer maintained. Its successor is
> [claude-code-terminal-signals](https://github.com/fguinez/claude-code-terminal-signals),
> which ships these same hooks plus a background-work glyph (⧗), a bar color
> per session, and a title reset when a session ends.

Shows the state of each Claude Code session as a glyph in the terminal tab title,
so when you run several sessions you can tell at a glance which one needs you.

| State | Glyph | Set by |
|-------|-------|--------|
| Working | moving dot | Claude (native) |
| Stopped / waiting | ✳ | Claude (native) |
| Clarifying question (with options) | ✦ | this hook |
| Asking for permission | ✿ | this hook |

The tab name is `<glyph> <name>`, where `<name>` is `$CLAUDE_TITLE` if set,
otherwise the current folder name. Name a session like:

    CLAUDE_TITLE="api" claude

## Install

    sh install.sh

Then restart your `claude` sessions.

The installer copies `term-title.sh` and `term-perm.sh` to `~/.claude/` and
merges two hooks into `~/.claude/settings.json` (it leaves all your other
settings untouched).

## Cursor / VS Code integrated terminal

Add this to your Cursor/VS Code `settings.json` so the tab shows the OSC title:

    "terminal.integrated.tabs.title": "${sequence}"

(Not needed for standalone terminals like Ghostty/iTerm — they show OSC titles
natively.)

## Requirements

- Claude Code v2.1.141+ (uses the `terminalSequence` hook output)
- `python3` (only for the installer's JSON merge)
- macOS or Linux (POSIX `sh`)

## Customize

Edit the glyphs in `~/.claude/settings.json` (✦ / ✿) and in `term-perm.sh`.
