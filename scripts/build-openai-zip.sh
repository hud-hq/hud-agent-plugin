#!/usr/bin/env bash
# Builds the ZIP uploaded to the OpenAI plugin directory (platform.openai.com/plugins).
# Only the Codex-format files go in, so the portal reads .codex-plugin/plugin.json and agents/codex/mcp.json.
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
version="$(jq -r .version "$root/.codex-plugin/plugin.json")"
out="$root/dist/hud-openai-$version.zip"
mkdir -p "$root/dist"; rm -f "$out"
cd "$root"
zip -qr "$out" .codex-plugin agents/codex skills assets/icon.png README.md LICENSE -x '*.DS_Store'
echo "$out"
