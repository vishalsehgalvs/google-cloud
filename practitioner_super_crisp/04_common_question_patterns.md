# Common Question Patterns (What Is Generally Asked)

These patterns match typical entry-level Google Cloud question style.

## Pattern 1: Best Service Fit

Prompt style:

- Organization needs a solution with minimal operations.
- Team wants faster delivery with managed services.

Solve with this sequence:

1. Identify workload type: compute, storage, database, analytics, networking.
2. Check if question requires deep control or not.
3. If no strict control requirement, prefer managed or serverless.

## Pattern 2: Access and Security

Prompt style:

- Grant access while reducing risk.
- Workload needs secure API access.

Solve:

1. Humans via groups and IAM roles.
2. Workloads via service accounts.
3. Prefer predefined least-privilege role.

## Pattern 3: Cost Governance

Prompt style:

- Prevent overspend.
- Get alerted before threshold breach.

Solve:

1. Budget for target limit.
2. Alert thresholds for proactive action.
3. Billing report for analysis.
4. Quota for usage boundaries.

## Pattern 4: Reliability and Operations

Prompt style:

- Improve availability and observability.
- Troubleshoot production behavior quickly.

Solve:

1. Monitoring for metrics and dashboards.
2. Alerting for incidents.
3. Logging for root-cause analysis.
4. Managed platform where possible.

## Pattern 5: Data Platform Choice

Prompt style:

- Need analytics, ETL, streaming, or Hadoop ecosystem.

Solve:

- BigQuery for SQL analytics warehouse workloads.
- Dataflow for batch and streaming pipelines.
- Dataproc for Spark or Hadoop workloads.

## Pattern 6: Networking Basics

Prompt style:

- Build private network.
- Route internet traffic.
- Reduce latency globally.

Solve:

- VPC for private network architecture.
- Cloud DNS for naming.
- Load Balancing for traffic distribution.
- Cloud CDN for edge caching.

## Mini Practice Items

- Question: startup wants container API, variable traffic, no server management.
  Best answer pattern: Cloud Run.

- Question: app needs global relational transactions and scaling.
  Best answer pattern: Spanner.

- Question: platform team needs spend alerts before monthly budget breach.
  Best answer pattern: budget plus alert thresholds.

## 10-Second Elimination Technique

- Remove answers that increase manual operations without need.
- Remove answers that violate least privilege.
- Remove answers that mismatch workload type.
- Choose the option that is secure, managed, and scalable with lowest ops burden.
