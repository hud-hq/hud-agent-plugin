---
name: hud-investigate
description: Root-cause a production problem with Hud, then propose a code fix. Use when the user reports an endpoint failing or returning 5xx, an exception or TypeError in a service, a queue or job erroring, a slowdown or latency spike, or asks "why is X broken/slow in production".
---

# Investigate a production issue with Hud

Requires the `hud` MCP server. Follow the `hud` skill's order (schema first, check `hud-get-skill` for a matching playbook).

## Steps

1. **Pin the symptom.** Identify the service, endpoint/queue/function, environment and when it started. If the user gave none, find the top offenders by error rate or p95 over the last 24h.
2. **Establish the baseline.** Compare the problem window against the previous 7 days. Is this new, getting worse, or long-standing?
3. **Find the failing function.** Walk from the endpoint down to the functions it calls. Look for the function whose error rate or latency changed at the same time as the symptom.
4. **Pull forensics.** Use `hud-get-forensics` on failing or slow instances. Read the exception, stack trace and parameters. Group instances by distinct exception or input pattern.
5. **Correlate with change.** Check whether a deployment or version change lines up with the start time. If so, inspect the diff for the implicated functions (`git log` / `git blame` locally).
6. **Classify the cause:** code bug, bad input, downstream/outbound dependency, or environment (CPU, memory, infra).
7. **Fix.** Open the implicated source, explain the failure in terms of the code and the forensic data, and propose a minimal fix. Add a test that reproduces the failing input when possible.

## Report back

- Symptom, scope and start time, with numbers
- Root cause, with the evidence (function, exception, sample trace IDs)
- The fix (or next step if the cause is outside the code)
- Confidence, and what data was missing
