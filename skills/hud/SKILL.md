---
name: hud
description: Use Hud's production runtime data (function-level invocations, latency, errors, exceptions, deployments, forensics) whenever a question depends on how code actually behaves in production. Trigger on production errors, slow endpoints, "is this function used", "what calls this", deployment impact, or before changing code that runs in production. Also use for Hud MCP setup and sign-in problems.
---

# Hud: production runtime context

Hud's Runtime Code Sensor records how every function behaves in production: invocations, latency percentiles, error rates, exceptions, and the endpoints, queues and services it feeds. The `hud` MCP server exposes that data to you.

## Always follow this order

1. **Schema first.** Call `hud-get-schema` before your first query in a session. It returns the tables, query patterns and example SQL. Do not guess table or column names.
2. **Check for a matching server-side skill.** The `hud-get-skill` tool description lists investigation playbooks (endpoint errors, slow endpoints, deployment analysis, and more). If one matches the user's intent, call it and follow it.
3. **Query.** Use `hud-query` for SQL over runtime data. Filter by service, environment and time range to keep queries fast.
4. **Drill into instances.** Use `hud-get-forensics` for concrete failing or slow executions: parameters, exception messages, stack traces, trace IDs, machine metrics. Forensics may be written to a temp folder on disk; read those files with shell commands.

## How to use the data

- Tie every production signal back to code: resolve the function, open the file, and explain the behavior in terms of the source.
- Quote real numbers (invocations, p50/p95/p99, error rate, time window). Say which service and environment they came from.
- Separate what Hud shows from your inference. If data is missing (function not instrumented, no traffic in window), say so rather than assuming it is unused or healthy.
- Default lookback: last 24h for incidents, 7 days for risk and trends, 30-60 days for usage and dead-code questions. Widen if results are empty.

## Setup and sign-in

- The plugin connects to the hosted server at `https://mcp.hud.io/mcp` with OAuth. The first time a Hud tool is needed, sign in with your Hud account in the browser.
  - Claude Code: run `/mcp`, select `hud`, then authenticate.
  - Cursor: Settings, then Tools & MCP, then toggle `hud` on.
  - Codex: run `codex mcp login hud`.
- If tools return auth errors, re-run the sign-in step above. If no data comes back, the Hud SDK may not be installed in that service: see https://docs.hud.io.
- For CI or headless agents, use an API key instead of OAuth: send header `X-Hud-Mcp-Key` (keys at https://www.app.hud.io/settings/api-keys).
- Support: support@hud.io or https://www.app.hud.io/?support_chat=true
