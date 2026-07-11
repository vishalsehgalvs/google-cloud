# Master Standalone Revision Sheet

This single file is enough for your final practitioner-level revision.

## A) Core Mindset For This Exam

This exam mostly tests whether you can choose the right Google Cloud service for a business requirement with:

- low operational overhead
- good security practice
- clear scalability and reliability
- cost awareness

If two options look correct, choose the one that is more managed and secure by default.

## B) Cloud Model Clarity

- IaaS: You manage most layers above infrastructure.
- PaaS: Platform abstracts infrastructure, you focus on app.
- Serverless: Runtime scales automatically and you pay for use.
- SaaS: Fully finished software product.

Practical rule:

- More control gives more flexibility but also more maintenance.

## C) Resource Hierarchy And IAM

Hierarchy:

- Organization -> Folder -> Project -> Resource

Why project matters:

- IAM assignment scope
- API enablement
- quota boundaries
- billing attribution

IAM basics:

- Principal: who needs access
- Role: what permissions are granted
- Resource: where access is granted

Best practice:

- Least privilege
- groups for people
- service accounts for apps and services

## D) Billing And Cost Controls

- Billing account is linked to projects.
- Budgets define planned spend.
- Alerts notify before or at threshold crossings.
- Reports show spend by project and service.
- Quotas prevent accidental or runaway usage.

Strong answer pattern:

- budget plus alerts plus quota plus monitoring

## E) Compute Selection

- Compute Engine: VM and OS control required.
- GKE: Kubernetes orchestration for containerized platforms.
- App Engine: managed app platform.
- Cloud Run: stateless serverless containers.
- Cloud Run Functions: event-driven function execution.

Quick exam mapping:

- If no strict infra control is required, prefer Cloud Run or App Engine over VM-heavy options.

## F) Storage And Database Selection

- Cloud Storage: object storage for files, media, backups.
- Cloud SQL: managed relational DB for standard transactional apps.
- Spanner: global relational scale with strong consistency.
- Firestore: document NoSQL for app-centric flexible schema.
- Bigtable: wide-column high-throughput workloads.
- Memorystore: in-memory cache.

Decision shortcut:

- First classify data shape and access pattern, then pick service.

## G) Data And Analytics Selection

- BigQuery: SQL analytics warehouse.
- Dataflow: batch plus streaming pipelines.
- Dataproc: Spark and Hadoop managed clusters.
- Dataprep: data preparation and cleaning workflows.

Exam cue:

- Analytics with SQL at scale usually points to BigQuery.

## H) Networking Basics

- VPC provides private virtual network boundary.
- Subnets are regional.
- Firewall rules control traffic.
- Cloud Load Balancing distributes traffic and improves availability.
- Cloud DNS handles domain mapping.
- Cloud CDN accelerates content via edge caching.

## I) Operations And Reliability

- Cloud Monitoring for metrics and alerts.
- Cloud Logging for centralized logs and troubleshooting.
- Error Reporting, Trace, Profiler for deeper diagnostics.

Exam cue:

- Reliable operation answers include observability, not just deployment.

## J) Security Defaults

- Identity-first security model.
- Principle of least privilege.
- Service account for workloads.
- Encryption and audit visibility expected.
- Logging and monitoring for detection and response.

## K) Most Common Question Archetypes

1. Best service for a scenario.
2. Secure access with least privilege.
3. Cost control and governance.
4. Reliability and operational visibility.
5. Data platform choice.

## L) 10-Second Elimination Method

1. Remove options requiring unnecessary manual management.
2. Remove options with over-privileged roles.
3. Remove options mismatched to workload type.
4. Choose the option with lower ops burden and better security defaults.

## M) Ultra-Fast Recall Set

- Stateless container API: Cloud Run
- Event trigger function: Cloud Run Functions
- Full VM control: Compute Engine
- Managed relational: Cloud SQL
- Global relational scale: Spanner
- Document NoSQL: Firestore
- Wide-column scale: Bigtable
- SQL analytics warehouse: BigQuery
- Stream or batch pipelines: Dataflow
- Spark or Hadoop: Dataproc
- Access control: IAM
- Workload identity: Service Account
- Spend guardrails: Budget plus Alerts plus Quotas

## N) Final Hour Before Exam

1. Read this file once slowly.
2. Recite service-choice lines from memory.
3. Rehearse elimination method on 10 imaginary scenarios.
4. Do not cram deep implementation details; prioritize selection logic and security-cost reasoning.
