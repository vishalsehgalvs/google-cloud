# Must Know One-Page Revision

## 1) Cloud Service Models

- IaaS: virtual machines, disks, and networking. You manage OS, patching, runtime, and app.
- PaaS: platform handles most infrastructure. You focus mostly on code and configuration.
- Serverless: no server management. Auto scales, pay per use, ideal for variable traffic.
- SaaS: complete software product delivered over the internet.

Memory hook:

- More control means more operational burden.
- Less control means faster delivery and lower ops work.

## 2) Resource Hierarchy and Access

- Structure: Organization -> Folders -> Projects -> Resources.
- Project is the most important exam object: APIs, IAM, quota, and billing are all anchored here.
- IAM allow policies inherit from parent to child.
- Least privilege means only required permissions, nothing extra.
- Groups for humans, service accounts for applications.

## 3) Billing and Cost Control

- Billing account is linked to one or more projects.
- Budgets give visibility and threshold-based alerts.
- Quotas cap usage and prevent accidental cost explosions.
- Reports help identify which service or project is driving spend.

Exam preference:

- Any answer including budget, alerts, and monitoring is usually stronger than pure manual tracking.

## 4) Compute Selection

- Compute Engine: choose when you need full OS or VM-level control.
- GKE: choose when you need Kubernetes orchestration for many containerized workloads.
- App Engine: choose when you want managed app hosting with less infrastructure management.
- Cloud Run: choose for stateless HTTP/container services with serverless operations.
- Cloud Run Functions: choose for event-driven single-purpose code.

Default ranking for practitioner-style questions:

- Start from managed/serverless unless the scenario explicitly needs deep infrastructure control.

## 5) Storage and Database Selection

- Cloud Storage: object data, backups, static files, media.
- Cloud SQL: managed relational databases for common transactional apps.
- Spanner: global relational scale with strong consistency.
- Firestore: document model for app-centric NoSQL use cases.
- Bigtable: high-throughput wide-column store for massive scale.
- Memorystore: managed in-memory caching layer.

Rule:

- Pick by data shape first: object, relational, document, wide-column, cache.

## 6) Networking Basics

- VPC is your private network boundary in Google Cloud.
- Subnets are regional ranges inside a VPC.
- Firewall rules control allowed traffic.
- Load balancing spreads traffic for availability and scale.
- Cloud DNS maps domain names to service endpoints.

## 7) Operations and Reliability

- Cloud Monitoring: metrics, dashboards, alerts.
- Cloud Logging: centralized logs for troubleshooting and auditing.
- Error Reporting, Trace, Profiler: deeper diagnostics and performance insight.

Exam preference:

- Reliable operations means visibility first. If an option lacks monitoring and alerting, it is often weaker.

## 8) Data and AI Business Story

- BigQuery: serverless analytics warehouse for SQL at scale.
- Dataflow: managed batch and streaming data processing.
- Dataproc: managed Spark or Hadoop clusters.
- Gemini for Google Cloud: AI-assisted productivity and analysis workflows.

## 9) How Questions Are Usually Framed

Most questions ask for the best balance of:

- correct service fit
- low operational overhead
- secure access model
- cost control
- scalability and reliability

If two answers look valid, choose the one that is more managed, more secure by default, and easier to operate.
