---
name: hud-change-risk
description: Check the production impact of a code change before making or merging it. Use before editing, refactoring or deleting a function, when reviewing a diff or pull request, or when the user asks about blast radius, "is it safe to change this", "who calls this in production", or "how hot is this code path".
---

# Production blast radius of a change

Requires the `hud` MCP server. Follow the `hud` skill's order (schema first).

## Steps

1. **List the functions being changed.** From the working diff (`git diff`, or the PR diff against the base branch), or from the function the user is about to edit.
2. **Resolve them in Hud.** Match each to Hud's function records (name, file, service). Note any that Hud has never seen.
3. **Pull production stats for the last 7 days** per function: invocations, p50/p95/p99 latency, error rate, exceptions.
4. **Map the reach.** Which endpoints, queues and services call these functions, and how much traffic do they carry?
5. **Score the risk** as Low / Medium / High, weighing: traffic volume, number of endpoints and services reached, latency sensitivity (hot paths), current error rate, and how invasive the code change is.

## Report back

- Risk level and one-line reason
- Table: function, invocations/7d, p95, error rate, endpoints reached
- Specific cautions (e.g. "called on every checkout request, p95 already 800ms")
- Suggested safeguards proportional to the risk: tests to add, a feature flag, or what to watch after deploy

Functions with zero production invocations are low risk to change but confirm they are truly unused (see `hud-dead-code`) before deleting.
