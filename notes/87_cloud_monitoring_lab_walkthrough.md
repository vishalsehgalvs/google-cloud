# Cloud Monitoring Lab Walkthrough

## Lab Overview

- Verify VMs created by Deployment Manager
- Set up a Cloud Monitoring workspace
- Create a dashboard with a chart
- Create an alerting policy with multiple conditions
- Create a resource group
- Create an uptime check

---

## Task 1 — Verify VM Instances

- Navigate to **Compute Engine** → confirm 3 nginx VMs were pre-created via Deployment Manager

---

## Task 2 — Set Up Monitoring Workspace

- Navigate to **Cloud Monitoring** → opens in a new tab
- Monitoring automatically sets up a workspace for your project
- Wait a few minutes — you'll be redirected to the **Monitoring Overview** page once ready

---

## Task 3 — Create a Dashboard and Chart

1. **Monitoring → Dashboards → Create Dashboard**
2. Name: `My Dashboard` → press Enter
3. Click **Add Chart**:
   - Title: `My Chart`
   - Resource type: `GCE VM Instance`
   - Metric: `CPU Utilization`
   - Filters: none (to see all instances)
   - View Options: select **X-Ray mode**
   - Click **Save**

### Metrics Explorer (no dashboard required)

- **Monitoring → Resources → Metrics Explorer**
- Search any metric (e.g. `CPU Utilization`) to explore without creating a chart

---

## Task 4 — Create an Alerting Policy with Multiple Conditions

1. **Monitoring → Alerting → Create Policy**
2. **Add first condition:**
   - Resource: `GCE VM Instance`
   - Metric: `CPU Usage`
   - Condition: `is above`
   - Threshold: `20`
   - Duration: `1 minute`
   - Click **Save**
3. **Add second condition:**
   - Different metric (e.g. `Reserved Cores`)
   - Condition: `is above 15`
   - Click **Save**
4. **Policy trigger:** set to **"All conditions are met"**
5. **Notifications:**
   - Add channel: **Email** → enter email address → **Add**
6. **Documentation** (best practice): describe what happened, why the alert fired, and how to fix it — makes alerts actionable
7. Name the policy: `My First Alerting Policy` → click **Save**

---

## Task 5 — Create a Resource Group

1. **Monitoring → Groups → Create Group**
2. Name: `VM Instances`
3. Criteria: **Name contains** `nginx`
4. Click **Save Group**

> All 3 nginx VMs appear in the group because their names match the filter.

---

## Task 6 — Create an Uptime Check

1. **Monitoring → Uptime Checks → Create Uptime Check**
2. Title: `My First Uptime Check`
3. Protocol: `HTTP`
4. Applies to: **Group** → select `VM Instances`
5. Check interval: **every 1 minute**
6. Click **Save** (skip creating an alert policy for now)

---

## Lab Summary

| Task              | What was done                                                   |
| ----------------- | --------------------------------------------------------------- |
| Workspace setup   | Auto-created by Cloud Monitoring for your project               |
| Dashboard + chart | CPU utilization chart with X-Ray mode                           |
| Alerting policy   | Two conditions (CPU usage + reserved cores); email notification |
| Resource group    | Grouped all nginx VMs by name filter                            |
| Uptime check      | HTTP check on VM group every 1 minute                           |

## ACE Exam-Style Practice Questions

### Q1
A Cloud Monitoring Lab Walkthrough requirement asks to collect logs from all current and future production projects only. What should you do?

A. Configure manual exports in each project every month
B. Configure aggregated log sink at production folder level
C. Disable Cloud Logging and use VM files
D. Send logs to Cloud DNS

Answer: B
Trap: Folder-level aggregated sinks capture both existing and future child projects.

### Q2
In a Cloud Monitoring Lab Walkthrough incident, only a few requests are slow across many microservices. Which tool is best to identify the slow hop?

A. Cloud Trace
B. Cloud Storage lifecycle
C. Cloud Build trigger
D. Cloud Armor policy

Answer: A
Trap: Distributed tracing is designed for per-hop latency diagnosis.

<!-- ACE_DEEP_ENRICHMENT_START -->
## ACE Deep Enrichment

### Think Like a Google Engineer
- Primary optimization axis: SLO-driven reliability and faster mean time to recovery.
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
A customer-facing API has intermittent latency spikes and error bursts. The team needs faster detection, cleaner triage, and safer remediation during peak traffic.

### Worked Example
- Define SLOs and monitor latency, error rate, and saturation.
- Correlate logs, metrics, and traces using request IDs.
- Create alert policies for burn-rate and critical error thresholds.
- Run incident playbooks and validate post-incident action items.

### Flowchart
```mermaid
flowchart TD
    A[Incident Signal] --> B{Metric or Log Alert?}
    B -->|Metric| C[Check SLO Burn Rate]
    B -->|Log| D[Find Error Fingerprint]
    C --> E[Trace Affected Requests]
    D --> E
    E --> F[Apply Safe Mitigation]
    F --> G[Post Incident Review]
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
    participant User
    participant Service
    participant Monitoring
    participant Logging
    participant OnCall
    User->>Service: Request
    Service-->>User: Error response
    Service->>Monitoring: Emit metrics
    Service->>Logging: Emit structured log
    Monitoring-->>OnCall: Alert triggered
    OnCall->>Logging: Investigate root cause
```

### Extra Exam Practice (10 Questions)
#### Q1
Scenario Focus: Cloud Monitoring Lab Walkthrough
Latency increases only for one endpoint. What is the best first triage action?

A. Check endpoint-specific metrics and traces before broad scaling actions.
B. Restart all services immediately without diagnosis.
C. Rely only on CPU metrics and ignore user-facing latency.
D. Disable alerts during busy periods to avoid noise.

Answer: A
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q2
Scenario Focus: Cloud Monitoring Lab Walkthrough
Which monitoring strategy best protects user experience?

A. Rely only on CPU metrics and ignore user-facing latency.
B. Track SLO-aligned latency and error burn-rate alerts.
C. Disable alerts during busy periods to avoid noise.
D. Investigate incidents only from one log line sample.

Answer: B
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q3
Scenario Focus: Cloud Monitoring Lab Walkthrough
A team has logs but no trace correlation. What should they add?

A. Disable alerts during busy periods to avoid noise.
B. Investigate incidents only from one log line sample.
C. Add request correlation IDs across logs and traces.
D. Skip retrospectives once service is healthy again.

Answer: C
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q4
Scenario Focus: Cloud Monitoring Lab Walkthrough
How should alerting be tuned to reduce noisy pages?

A. Investigate incidents only from one log line sample.
B. Skip retrospectives once service is healthy again.
C. Restart all services immediately without diagnosis.
D. Use severity-based alerts with actionable thresholds and runbooks.

Answer: D
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q5
Scenario Focus: Cloud Monitoring Lab Walkthrough
What should happen after mitigation is applied?

A. Run a post-incident review and capture prevention tasks.
B. Skip retrospectives once service is healthy again.
C. Restart all services immediately without diagnosis.
D. Rely only on CPU metrics and ignore user-facing latency.

Answer: A
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q6
Scenario Focus: Cloud Monitoring Lab Walkthrough
Two designs both satisfy the happy path for Cloud Monitoring Lab Walkthrough. Which choice is most correct?

A. Restart all services immediately without diagnosis.
B. Choose the option that preserves reliability and security while reducing operational burden.
C. Rely only on CPU metrics and ignore user-facing latency.
D. Disable alerts during busy periods to avoid noise.

Answer: B
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q7
Scenario Focus: Cloud Monitoring Lab Walkthrough
What should you validate first before choosing an architecture for Cloud Monitoring Lab Walkthrough?

A. Rely only on CPU metrics and ignore user-facing latency.
B. Disable alerts during busy periods to avoid noise.
C. Validate SLO fit, blast radius, and least-privilege controls before comparing convenience.
D. Investigate incidents only from one log line sample.

Answer: C
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q8
Scenario Focus: Cloud Monitoring Lab Walkthrough
A proposal lowers cost but increases failure risk. What is the best decision?

A. Disable alerts during busy periods to avoid noise.
B. Investigate incidents only from one log line sample.
C. Skip retrospectives once service is healthy again.
D. Reject it unless reliability and recovery objectives remain within required targets.

Answer: D
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q9
Scenario Focus: Cloud Monitoring Lab Walkthrough
Which option best reflects optimization for SLO-driven reliability and faster mean time to recovery?

A. Select the design that best meets SLO-driven reliability and faster mean time to recovery while keeping constraints balanced.
B. Investigate incidents only from one log line sample.
C. Skip retrospectives once service is healthy again.
D. Restart all services immediately without diagnosis.

Answer: A
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q10
Scenario Focus: Cloud Monitoring Lab Walkthrough
How should you evaluate a design that needs frequent manual interventions?

A. Skip retrospectives once service is healthy again.
B. Treat it as high risk and prefer automation-friendly designs with observability and rollback.
C. Restart all services immediately without diagnosis.
D. Rely only on CPU metrics and ignore user-facing latency.

Answer: B
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

### Quick Commands
```bash
gcloud monitoring policies list --project=PROJECT_ID
gcloud logging read "severity>=ERROR" --freshness=1d --project=PROJECT_ID --limit=30
gcloud alpha monitoring channels list --project=PROJECT_ID
gcloud logging metrics list --project=PROJECT_ID
```

### Fast Recall
- Observability is metrics plus logs plus traces together.
- Alerts should be actionable and aligned to SLO impact.
- Post-incident review turns outages into reliability improvements.
<!-- ACE_DEEP_ENRICHMENT_END -->