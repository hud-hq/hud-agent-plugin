---
name: hud-deploy-check
description: Check whether a recent deployment caused a production regression and recommend ROLLBACK, INVESTIGATE, WARN or CLEAN. Use after a deploy, when the user asks "did my deploy break anything", "is the new version slower", or wants to compare performance before and after a release.
---

# Post-deployment regression check

Requires the `hud` MCP server. Follow the `hud` skill's order (schema first, and check `hud-get-skill` for a deployment-analysis playbook).

## Steps

1. **Identify the deployment.** Service, version and deploy time. If not given, use the most recent deployment for the service in Hud.
2. **Set windows.** Post-deploy window (from deploy time to now) vs a baseline of the same hours over the previous 7 days, to avoid time-of-day bias.
3. **Compare endpoints** served by the new version: error rate and p95/p99 latency, post vs baseline. Flag meaningful regressions (both relative change and absolute volume matter).
4. **Attribute.** For each regressed endpoint, find the functions whose behavior changed, prioritizing functions changed in this release or newly invoked since the deploy.
5. **Check collateral damage** on other services that depend on this one.
6. **Pull forensics** for the regressed functions and classify the cause: code, outbound dependency, or environment.

## Verdict

- **ROLLBACK**: clear regression caused by code in this release, with user-facing impact
- **INVESTIGATE_OUTBOUND**: regression driven by a downstream dependency
- **INVESTIGATE_ENVIRONMENTAL**: regression driven by infra or resources, not code
- **WARN**: small or low-traffic regression worth watching
- **CLEAN**: no meaningful change

Report the verdict first, then the evidence per endpoint and function, then the suggested next action.
