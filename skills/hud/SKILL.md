---
name: hud
description: Use Hud's production runtime data (function-level invocations, latency, errors, exceptions, deployments, forensics) whenever a question depends on how code actually behaves in production. Trigger on production errors, slow endpoints or queues, deployment impact, "is this function used", "what calls this", or before changing code that runs in production. Also use for Hud MCP setup and sign-in problems.
---

# Hud: production runtime context

Hud's Runtime Code Sensor records how every function behaves in production: invocations, latency percentiles, error rates, exceptions, and the endpoints, queues and services it feeds. The `hud` MCP server exposes that data to you.

## How to work with Hud

1. **Call `hud-get-schema` first** in every session, before any other Hud tool.
2. **Call `hud-get-skill` before starting any investigation.** Its description lists the playbooks the server provides (endpoint errors, slow endpoints, deployment impact, forensics, Hud links, plus any custom skills for your account). If one matches, follow it rather than improvising.
3. Then query with `hud-query` and drill into instances with `hud-get-forensics`, as the schema and playbooks describe.

## How to use the data

- Tie every production signal back to code: resolve the function, open the file, and explain the behavior in terms of the source.
- Quote real numbers (invocations, p95/p99, error rate, time window) and say which service and environment they came from.
- Separate what Hud shows from your inference. If data is missing (function not instrumented, no traffic in the window), say so rather than assuming it is unused or healthy.

## Setup and sign-in

- The plugin connects to the hosted server at `https://mcp.hud.io/mcp` with OAuth. The first time a Hud tool is needed, sign in with your Hud account in the browser.
  - Claude Code: run `/mcp`, select `hud`, then authenticate.
  - Cursor: Settings, then Tools & MCP, then toggle `hud` on.
  - Codex: run `codex mcp login hud`.
- If tools return auth errors, re-run the sign-in step above. If no data comes back, the Hud SDK may not be installed in that service: see https://docs.hud.io.
- For CI or headless agents, use an API key instead of OAuth: send header `X-Hud-Mcp-Key` (keys at https://www.app.hud.io/settings/api-keys).
- Support: support@hud.io or https://www.app.hud.io/?support_chat=true
