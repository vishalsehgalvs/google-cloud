# Security, Governance, And Cost Deep Dive

## Resource hierarchy and governance

Hierarchy model:

- Organization -> Folders -> Projects -> Resources

Governance impact:

- Policies can be inherited from parent to child.
- Project remains the principal boundary for operations and billing.

## IAM deep understanding

IAM model:

- Principal + Role + Resource

Principal types:

- user, group, service account

Role types:

- basic, predefined, custom

High-value exam behavior:

- avoid broad permissions when targeted role exists
- use predefined role before custom role
- use custom role only for precise requirement gaps

## Service account discipline

- Assign per workload where feasible.
- Keep minimal required permissions.
- Avoid using user identity in production automation.

## Security posture baseline

- identity and access controls first
- network controls second
- monitoring and logging always on
- encryption and auditability as defaults

## Cost governance system

- Budget: expected spend target.
- Alert: proactive warning threshold.
- Report: spending visibility by project/service.
- Quota: hard or soft guardrail against overuse.

Recommended combined control:

- budget + threshold alerts + quota + monitoring

## Scenario patterns

Scenario A:

- Team needs read access to storage only.
- Correct pattern: narrow predefined storage role, no broad project role.

Scenario B:

- Application needs Pub/Sub publish rights.
- Correct pattern: service account with publisher role only.

Scenario C:

- Finance wants no surprise bills.
- Correct pattern: budget and threshold alerts, plus service-level cost reports.

## Trap checklist

- Owner/Editor granted when not needed.
- no budget alerts configured.
- user account used in app runtime.
- security answer with no logging/monitoring.

## Fast self-test

1. Why are service accounts preferred for application runtime identity?
2. What is the minimum cost-control trio to mention in scenario answers?
3. What is the strongest reason to avoid broad basic IAM roles?
