# Quotas in Google Cloud

## What Are Quotas?

All resources in Google Cloud are subject to **project quotas** (limits) — the maximum amount of a resource type you can create or use.

> Quotas do **not** guarantee resource availability. If a region is out of a resource (e.g. local SSDs), you cannot create it even if you have quota remaining.

---

## Types of Quotas

| Type                       | Description                             | Example                            |
| -------------------------- | --------------------------------------- | ---------------------------------- |
| Resource count per project | Max number of a resource you can create | 15 VPC networks per project        |
| Rate limits (API requests) | Max API calls per second per project    | 5 admin actions/sec on Spanner API |
| Regional quotas            | Max resources per region                | 24 CPUs per region (default)       |

---

## Why Quotas Exist

| Reason                      | Detail                                                                                                   |
| --------------------------- | -------------------------------------------------------------------------------------------------------- |
| Prevent runaway consumption | Protects against accidental over-provisioning (e.g. creating 100 VMs instead of 10) or malicious attacks |
| Prevent billing spikes      | Caps unexpected cost surprises                                                                           |
| Force sizing consideration  | Encourages periodic review — do you really need a 96-core VM?                                            |

---

## Managing Quotas

- View current quotas on the **Quotas page** in the Google Cloud Console
- Quotas may **increase automatically** as your usage of Google Cloud grows over time
- You can **proactively request quota increases** from the Quotas page before an expected usage spike

---

## gcloud Commands

```bash
# List quotas for a project (requires Compute API)
gcloud compute project-info describe --project=my-project

# List regional quotas
gcloud compute regions describe us-central1 --project=my-project

# List quotas via the Service Usage API
gcloud services quota list --service=compute.googleapis.com --project=my-project

# Request a quota increase (opens browser to Cloud Console)
gcloud alpha quotas update --project=my-project
```

## ACE Exam-Style Practice Questions

### Q1
For Quotas, you need to be notified at 50%, 90%, and 100% spend and also prevent runaway usage. What is best?

A. Budgets only
B. Quotas only
C. Budget alerts plus quotas
D. Cloud Trace only

Answer: C
Trap: Budgets notify while quotas enforce hard limits.

### Q2
You manage many sandbox projects in a Quotas scenario and need owner-specific overspend alerts. What is best?

A. One shared budget for all projects
B. Budget per project with alert thresholds
C. CSV export once per quarter
D. Single alert at billing account only

Answer: B
Trap: Per-project budgets improve accountability and alert precision.

<!-- ACE_DEEP_ENRICHMENT_START -->
## ACE Deep Enrichment

### Think Like a Google Engineer
- Primary optimization axis: Predictable spend guardrails without reliability regression.
- Start with constraints first: SLO, security, compliance, latency, budget, and team operations capacity.
- Prefer managed services if they satisfy requirements with lower long-term operational toil.
- Minimize blast radius using environment isolation, least privilege, and failure-domain awareness.
- Design for day-2 operations: observability, rollback strategy, and quota or budget guardrails.

### Most Correct Option Filter (60 Seconds)
1. Eliminate options with broad access, single points of failure, or missing monitoring.
2. Confirm the option meets non-negotiables first: security and reliability requirements.
3. Compare remaining options on operational simplicity and long-term maintainability.
4. Use cost as an optimizer only after requirements and risk controls are satisfied.

### Weighted Decision Matrix
| Dimension | Weight | Strong Signal |
| --- | --- | --- |
| Security | 3 | Least privilege, secure defaults, no exposed blast radius |
| Reliability | 3 | Multi-zone or HA design, health checks, tested recovery path |
| Operability | 2 | Clear monitoring, alerting, rollout and rollback simplicity |
| Cost Efficiency | 2 | Right-sized resources, no waste, no reliability regression |
| Performance | 1 | Meets latency and throughput targets with headroom |

### Real-Life Scenario
A scale-up exceeded budget for two months due to idle resources and untracked growth. Leadership needs predictable spend without breaking product velocity.

### Worked Example
- Set budgets and alerts at billing account and project levels.
- Use labels for environment, team, and cost center to attribute spend.
- Right-size compute and remove idle disks, snapshots, and static IPs.
- Export billing data for trend analysis and anomaly detection.

### Flowchart
```mermaid
flowchart TD
    A[Monthly Cost Review] --> B{Budget Breach Risk?}
    B -->|Yes| C[Trigger Alerts]
    B -->|No| D[Continue Monitoring]
    C --> E[Find Top Cost Drivers]
    E --> F[Rightsize and Cleanup]
    F --> G[Add Labels and Guardrails]
    G --> H[Recheck Forecast]
```

### Optimization Decision Flow
```mermaid
flowchart TD
    A[Read Requirement] --> B[Identify Hard Constraints]
    B --> C{Security and Reliability Met?}
    C -->|No| D[Reject Option]
    C -->|Yes| E[Score Operability and Cost]
    E --> F{Managed Service Meets Needs?}
    F -->|Yes| G[Prefer Managed Path]
    F -->|No| H[Use Custom Design with Guardrails]
    G --> I[Validate Observability and Rollback]
    H --> I
    I --> J[Pick Highest Weighted Score]
```

### Interaction Sequence
```mermaid
sequenceDiagram
    participant Billing
    participant Alerting
    participant Team
    participant Resources
    Billing->>Alerting: Budget threshold crossed
    Alerting-->>Team: Send notification
    Team->>Resources: Cleanup and right-size
    Resources-->>Billing: Lower projected spend
```

### Extra Exam Practice (10 Questions)
#### Q1
Scenario Focus: Quotas in Google Cloud
A project is constantly over budget. What is the highest-impact first step?

A. Create budgets with alerts and investigate top cost drivers immediately.
B. Wait until the invoice arrives, then react next month.
C. Disable all monitoring because it has a minor cost.
D. Give every team unrestricted quotas for speed.

Answer: A
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q2
Scenario Focus: Quotas in Google Cloud
Which resource tagging strategy improves chargeback visibility?

A. Disable all monitoring because it has a minor cost.
B. Apply consistent labels for owner, environment, and cost center.
C. Give every team unrestricted quotas for speed.
D. Keep orphaned resources as backups without tracking.

Answer: B
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q3
Scenario Focus: Quotas in Google Cloud
How should you control runaway spend in exam scenarios?

A. Give every team unrestricted quotas for speed.
B. Keep orphaned resources as backups without tracking.
C. Use quotas, budgets, and alerting guardrails before incidents happen.
D. Use one shared project for all environments and teams.

Answer: C
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q4
Scenario Focus: Quotas in Google Cloud
What is the best way to identify long-term cost trends?

A. Keep orphaned resources as backups without tracking.
B. Use one shared project for all environments and teams.
C. Wait until the invoice arrives, then react next month.
D. Export billing data and analyze trends with dashboards and anomaly checks.

Answer: D
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q5
Scenario Focus: Quotas in Google Cloud
Which decision reduces waste while preserving reliability?

A. Right-size resources using utilization metrics and remove idle assets.
B. Use one shared project for all environments and teams.
C. Wait until the invoice arrives, then react next month.
D. Disable all monitoring because it has a minor cost.

Answer: A
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q6
Scenario Focus: Quotas in Google Cloud
Two designs both satisfy the happy path for Quotas in Google Cloud. Which choice is most correct?

A. Wait until the invoice arrives, then react next month.
B. Choose the option that preserves reliability and security while reducing operational burden.
C. Disable all monitoring because it has a minor cost.
D. Give every team unrestricted quotas for speed.

Answer: B
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q7
Scenario Focus: Quotas in Google Cloud
What should you validate first before choosing an architecture for Quotas in Google Cloud?

A. Disable all monitoring because it has a minor cost.
B. Give every team unrestricted quotas for speed.
C. Validate SLO fit, blast radius, and least-privilege controls before comparing convenience.
D. Keep orphaned resources as backups without tracking.

Answer: C
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q8
Scenario Focus: Quotas in Google Cloud
A proposal lowers cost but increases failure risk. What is the best decision?

A. Give every team unrestricted quotas for speed.
B. Keep orphaned resources as backups without tracking.
C. Use one shared project for all environments and teams.
D. Reject it unless reliability and recovery objectives remain within required targets.

Answer: D
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q9
Scenario Focus: Quotas in Google Cloud
Which option best reflects optimization for Predictable spend guardrails without reliability regression?

A. Select the design that best meets Predictable spend guardrails without reliability regression while keeping constraints balanced.
B. Keep orphaned resources as backups without tracking.
C. Use one shared project for all environments and teams.
D. Wait until the invoice arrives, then react next month.

Answer: A
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q10
Scenario Focus: Quotas in Google Cloud
How should you evaluate a design that needs frequent manual interventions?

A. Use one shared project for all environments and teams.
B. Treat it as high risk and prefer automation-friendly designs with observability and rollback.
C. Wait until the invoice arrives, then react next month.
D. Disable all monitoring because it has a minor cost.

Answer: B
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

### Quick Commands
```bash
gcloud beta billing budgets list --billing-account=BILLING_ACCOUNT_ID
gcloud compute instances list --project=PROJECT_ID
gcloud compute disks list --project=PROJECT_ID
gcloud resource-manager tags keys list --parent=projects/PROJECT_NUMBER
```

### Fast Recall
- Budgets and alerts are preventive controls, not reporting after the fact.
- Label discipline enables real cost accountability.
- Rightsizing requires metrics, not assumptions.
<!-- ACE_DEEP_ENRICHMENT_END -->