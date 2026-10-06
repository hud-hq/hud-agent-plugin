# Contributing

## Layout

- `skills/` is shared by Claude Code, Cursor and Codex. Keep skills thin: investigation playbooks belong on the Hud MCP server (`hud-get-skill`), so every MCP client gets them without a plugin release.
- MCP config is split per agent (`.mcp.json`, `agents/codex/mcp.json`, `agents/cursor/mcp.json`) because each agent spells static OAuth settings differently. Change all three together.

## Releasing

1. Bump `version` in `.claude-plugin/plugin.json`, `.codex-plugin/plugin.json` and `.cursor-plugin/plugin.json` (CI fails if they differ).
2. Merge to `main` through a PR.
3. Tag the merge commit `vX.Y.Z` and create a GitHub release.

The Anthropic directory picks up new commits on `main` automatically (with a re-scan). Cursor re-reviews updates.

## OAuth callbacks

The plugin uses Hud's public OAuth client `XyvD6NaPGbrpOL9mxglq7KUYuPXbyNB4` (PKCE, no secret). Each agent signs in through its own fixed callback, and each must be allowed on that client:

| Agent | Callback |
|-------|----------|
| Claude Code | `http://localhost:2425/callback` |
| Cursor (desktop) | `http://localhost:8787/callback`, `cursor://anysphere.cursor-mcp/oauth/callback` |
| Codex | `http://127.0.0.1:2425/callback/KCvWksKb-TdJ` (suffix derived from the MCP URL) |

If the MCP URL changes, the Codex suffix changes too: it is the first 9 bytes of `sha256(<mcp url>)`, base64url without padding.
