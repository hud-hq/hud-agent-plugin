---
name: hud-dead-code
description: Find functions that never run in production and safely remove them. Use when the user asks for dead code, unused functions, cleanup of legacy code, or "is this function still used in production".
---

# Dead code from production data

Requires the `hud` MCP server. Call `hud-get-schema` first, and check `hud-get-skill` for a matching playbook.

## Steps

1. **Scope.** Pick the service(s) and a lookback of at least 30 days (60 is safer for code tied to monthly or rare jobs).
2. **List local functions** in the relevant source directories.
3. **Query invocations** for those functions across all services and environments in the window. The candidate set is functions Hud tracks with zero invocations.
4. **Apply safety checks.** Skip anything that may run outside the observed window or outside Hud's view:
   - Public API, SDK or library exports
   - Framework hooks, lifecycle methods, decorators, event and signal handlers
   - Dynamically referenced code (reflection, string lookups, dependency injection)
   - Interface or abstract implementations
   - Code only used in tests, scripts, migrations, CLIs, or rarely scheduled jobs
   - Services or environments Hud does not cover
5. **Remove** the confirmed candidates, clean up now-unused imports, and run the build and tests.

## Report back

- Removed: function, file, last-seen status in Hud
- Kept on purpose: function and which safety check applied
- Lookback window and services covered

Keep each change reviewable. If the candidate list is large, propose batches instead of one big deletion.
