# Contributing

## Layout

- `skills/` is shared by Claude Code, Cursor and Codex. Keep skills thin: investigation playbooks belong on the Hud MCP server (`hud-get-skill`), so every MCP client gets them without a plugin release.
- MCP config is split per agent (`.mcp.json`, `agents/codex/mcp.json`, `agents/cursor/mcp.json`) because each agent spells static OAuth settings differently. Change all three together.

## Releasing

1. Bump `version` (required: Claude Code caches installed plugins by version, so without a bump users never get the change; CI enforces it) in `.claude-plugin/plugin.json`, `.codex-plugin/plugin.json` and `.cursor-plugin/plugin.json` (CI fails if they differ).
2. Merge to `main` through a PR.
3. Tag the merge commit `vX.Y.Z` and create a GitHub release.

The Anthropic directory picks up new commits on `main` automatically (with a re-scan). Cursor re-reviews updates. The OpenAI directory needs a new ZIP for metadata or skill changes: run `scripts/build-openai-zip.sh` and upload it at platform.openai.com/plugins (MCP server changes are picked up by OpenAI's daily scan, no upload needed).

## OAuth callbacks

Claude Code and Cursor use Hud's public OAuth client `XyvD6NaPGbrpOL9mxglq7KUYuPXbyNB4` (PKCE, no secret), and their callbacks must be allowed on that client. Codex pins no client ID: login.hud.io supports Client ID Metadata Documents, so Codex signs in as `https://chatgpt.com/oauth/codex/client.json` with whatever local port it picks.

| Agent | Callback |
|-------|----------|
| Claude Code | `http://localhost:2425/callback` |
| Cursor (desktop) | `http://localhost:8787/callback`, `cursor://anysphere.cursor-mcp/oauth/callback` |
| Codex | none needed (client ID metadata document) |
