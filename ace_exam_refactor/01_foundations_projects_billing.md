# Domain 1 - Foundations, Projects, Billing, Governance

## Must Know

- Hierarchy: Organization -> Folder -> Project -> Resource
- Project is the unit for IAM, API enablement, billing, and quotas
- Budgets alert only, quotas enforce usage limits
- Labels are the easiest way to attribute spend by team and environment
- Billing export to BigQuery is the best base for cost analytics at scale

## Decision Signals

- "new team with separate ownership" -> create a new project
- "prevent runaway spend" -> quota, not only budget alerts
- "need spend analytics across many projects" -> billing export to BigQuery
- "organization-wide policy guardrail" -> Organization Policy
- "who can do what" -> IAM role binding

## Pinpoint Traps

- Project lien prevents deletion only. It does not isolate access.
- One shared budget cannot identify the exact project owner of overspend.
- Billing reports alone are weak for deep analysis. Export first.
- Labels are for attribution. Logs are for activity audit.

## Scenario Example 1

- Trigger words: new product team, independent lifecycle, separate billing owner
- Best answer: create a dedicated project and link billing account
- Why not shared project: weak isolation and noisy IAM boundaries
- Why not only folder: folder is not billing and API boundary

```bash
gcloud projects create ace-team-a-prd --name="ace-team-a-prd"
gcloud billing accounts list
gcloud billing projects link ace-team-a-prd --billing-account=BILLING_ACCOUNT_ID
```

## Scenario Example 2

- Trigger words: cost spike risk, hard cap required
- Best answer: set quota and add budget alerts
- Why not budget-only: budget does not stop usage
- Why not manual monitoring-only: high operational risk

```bash
# Example quota checks are done in Console per service.
# Keep budgets for visibility and quotas for enforcement.
```

## Scenario Example 3

- Trigger words: finance asks spend by team and env across projects
- Best answer: enforce labels + billing export to BigQuery + dashboard
- Why not logs-only: logs do not provide clean cost rollup by team
- Why not one-off CSV: does not scale for ongoing review

```bash
gcloud compute instances add-labels web-01 \
  --labels=team=payments,env=prod,cost_center=finops \
  --zone=us-central1-a
```

## Governance Pattern

- Org Policy for global guardrails: allowed regions, domain restrictions
- IAM for scoped permissions
- Group-based access for humans
- Service accounts for workloads

## One-Line Rules

- Scope and ownership boundary question usually ends at project.
- Alert means visibility. Cap means quota.
- If attribution is asked, labels should appear in the answer.
