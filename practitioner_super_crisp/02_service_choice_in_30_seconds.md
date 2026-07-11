# Service Choice In 30 Seconds

Use this as the primary decision page in the exam.

## Compute

| Situation                                                      | Best Choice         | Why                                                    |
| -------------------------------------------------------------- | ------------------- | ------------------------------------------------------ |
| Need full control of VM, OS, startup scripts, special software | Compute Engine      | Highest control, most responsibility                   |
| Many containerized services with orchestration needs           | GKE                 | Kubernetes platform with managed control plane options |
| Stateless containerized web service or API, minimal ops        | Cloud Run           | Serverless containers, scales to zero                  |
| Event-based lightweight logic                                  | Cloud Run Functions | Trigger-based execution, minimal runtime management    |
| Managed application platform with simpler deployment model     | App Engine          | App-focused platform experience                        |

Quick warning:

- If question says no infra management, avoid VM-heavy answers unless explicitly required.

## Storage and Databases

| Situation                                                          | Best Choice   | Why                                  |
| ------------------------------------------------------------------ | ------------- | ------------------------------------ |
| Store files, backups, media, logs, static assets                   | Cloud Storage | Durable object storage               |
| Typical transactional relational app                               | Cloud SQL     | Managed relational database          |
| Global relational database with strong consistency and large scale | Spanner       | Planet-scale relational architecture |
| Flexible schema, document model app data                           | Firestore     | Managed document NoSQL               |
| Very high throughput, wide-column datasets                         | Bigtable      | Low-latency wide-column at scale     |
| Ultra-fast cache/session store                                     | Memorystore   | Managed Redis or Memcached           |

## Data and Analytics

| Situation                                      | Best Choice | Why                                   |
| ---------------------------------------------- | ----------- | ------------------------------------- |
| SQL analytics and data warehouse workloads     | BigQuery    | Serverless analytics engine           |
| Data processing pipelines, batch and streaming | Dataflow    | Managed pipeline processing           |
| Spark and Hadoop ecosystem workloads           | Dataproc    | Managed cluster-based data processing |
| Data cleaning and preparation workflows        | Dataprep    | Data wrangling focused interface      |

## Networking and Delivery

| Situation                                           | Best Choice          | Why                                   |
| --------------------------------------------------- | -------------------- | ------------------------------------- |
| Private network in cloud                            | VPC                  | Core network boundary                 |
| Domain name resolution                              | Cloud DNS            | Managed authoritative DNS             |
| Global edge caching for static or cacheable content | Cloud CDN            | Reduced latency and origin load       |
| Distribute traffic across backends                  | Cloud Load Balancing | High availability and traffic control |

## Security and Governance

| Situation                     | Best Choice                     | Why                              |
| ----------------------------- | ------------------------------- | -------------------------------- |
| Identity and permissions      | IAM                             | Policy-based access control      |
| App or service identity       | Service Accounts                | Non-human workload identity      |
| Cost governance               | Budgets, Alerts, Quotas         | Control spend and blast radius   |
| Enterprise resource structure | Organization, Folders, Projects | Governance and policy boundaries |

## Mini Scenario Practice

- Scenario: Startup wants API hosting with zero server management and variable traffic.
  Answer: Cloud Run.

- Scenario: Enterprise needs globally consistent relational transactions.
  Answer: Spanner.

- Scenario: Team needs SQL analytics over large data with low admin overhead.
  Answer: BigQuery.

- Scenario: Company wants least-privilege access model for staff and apps.
  Answer: IAM roles for groups, service accounts for workloads.

## Elimination Rules

- Remove options that require unnecessary manual operations.
- Remove options using over-privileged access roles.
- Remove options mismatched to data shape or workload type.
- Between two valid options, choose the simpler managed option.
