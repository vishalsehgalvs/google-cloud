# Pinpoint Trap Matrix

Use this as a last-mile elimination sheet.

| Domain     | Trap Trigger                           | Correct Answer                     | Common Wrong Option                   | Why Wrong                              |
| ---------- | -------------------------------------- | ---------------------------------- | ------------------------------------- | -------------------------------------- |
| Projects   | "need independent ownership"           | New project                        | Shared project with more IAM bindings | Weak isolation and audit boundaries    |
| Billing    | "prevent overspend"                    | Quota + budget alerts              | Budget only                           | Alert does not enforce                 |
| Billing    | "cost by team"                         | Labels + billing export            | Logs only                             | Logs are not cost attribution model    |
| IAM        | "workload access"                      | Service account                    | Human user credential                 | Identity model mismatch                |
| IAM        | "temporary elevated access"            | IAM Condition with expiry          | Permanent admin role                  | Manual cleanup risk                    |
| IAM        | "least privilege"                      | Narrow predefined role             | Owner or Editor                       | Excess privilege                       |
| IAM        | "cross-project access"                 | Grant role to external SA          | Share personal account                | No workload identity governance        |
| IAM        | "hard block action"                    | Deny policy or Org Policy          | Remove one role only                  | Can be bypassed by future grants       |
| IAM        | "single VM needs access"               | Dedicated SA on that VM            | Default Compute Engine SA             | Default SA is reused widely            |
| Storage    | "monthly access"                       | Nearline                           | Standard                              | Cost mismatch                          |
| Storage    | "quarterly backup retrieval"           | Coldline                           | Archive                               | Retrieval objective mismatch           |
| Storage    | "very rare compliance archive"         | Archive                            | Standard                              | Cost mismatch                          |
| Storage    | "auto-tier then delete"                | Lifecycle SetStorageClass + Delete | Manual scripts only                   | Higher operations burden               |
| Storage    | "rename object"                        | gsutil mv                          | Non-existent rename command           | Wrong command family                   |
| Storage    | "uniform bucket-level access"          | IAM-only access model              | ACL-specific answer                   | ACLs are disabled in that mode         |
| Databases  | "global relational strong consistency" | Spanner                            | Cloud SQL                             | Scaling and consistency constraints    |
| Databases  | "normal OLTP app"                      | Cloud SQL                          | Spanner by default                    | Over-engineered and costly             |
| Databases  | "mobile app flexible schema"           | Firestore                          | Cloud SQL                             | Document model mismatch                |
| Databases  | "massive throughput time-series"       | Bigtable                           | Firestore                             | Throughput model mismatch              |
| BigQuery   | "estimate query cost"                  | bq dry run                         | Run full query first                  | Uncontrolled scan cost                 |
| BigQuery   | "reduce scan cost"                     | Partition + cluster                | Add more users slots only             | Does not fix scanned bytes pattern     |
| Pub/Sub    | "topic exists no delivery"             | Create subscription                | Add more publishers                   | Delivery path missing                  |
| Dataflow   | "streaming transform at scale"         | Dataflow                           | Cloud Functions-only pipeline         | Throughput and ops mismatch            |
| Dataproc   | "existing Spark jobs"                  | Dataproc                           | Rewrite to another stack first        | Violates minimal-change objective      |
| Networking | "private VM internet egress"           | Cloud NAT                          | External IP per VM                    | Security and operations risk           |
| Networking | "private VM to Google APIs"            | Private Google Access              | Cloud NAT only                        | NAT does not replace PGA use case      |
| Networking | "cross-project centralized network"    | Shared VPC                         | VPC Peering only                      | Peering does not centralize admin      |
| Networking | "cross-org VPC connectivity"           | VPC Peering or VPN/Interconnect    | Shared VPC                            | Shared VPC is org-scoped               |
| Networking | "path-based web routing"               | Application LB + URL map           | Passthrough NLB                       | L4 does not do URL routing             |
| Networking | "preserve client IP and UDP"           | Passthrough NLB                    | Application LB                        | Protocol and source-IP mismatch        |
| Hybrid     | "HA dynamic routing"                   | HA VPN + Cloud Router              | Classic VPN static routes only        | Lower resilience and higher manual ops |
| Compute    | "VM fleet self-healing + autoscale"    | Regional MIG                       | Unmanaged instance group              | Lacks managed healing/scaling          |
| Compute    | "quick cheap fault-tolerant batch"     | Spot VMs                           | On-demand VMs                         | Cost objective missed                  |
| GKE        | "minimal node ops"                     | Autopilot                          | Standard by default                   | More node operations                   |
| GKE        | "custom node tuning"                   | Standard                           | Autopilot                             | Control objective missed               |
| GKE        | "update image with low downtime"       | kubectl set image rolling update   | Delete and recreate deployment        | Unnecessary risk                       |
| Operations | "slow request chain"                   | Cloud Trace                        | Error Reporting only                  | Not latency path analysis              |
| Operations | "read access auditing evidence"        | Data Access audit logs + sink      | Metrics only                          | No request-level audit trail           |
| Cost       | "project owner overspending"           | One budget per project             | One shared budget for all             | Poor accountability                    |

## One-Line Trap Rules

- If enforcement is required, alerts alone are weak.
- If least privilege is explicit, broad roles are wrong even if functional.
- If question says managed and minimal ops, avoid self-managed compute first.
- If question says path routing, think Layer 7 load balancing.
