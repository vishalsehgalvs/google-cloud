# Ultra Crisp Essentials — High Probability Topics Only

No prose. One fact per line. If you only read one file before the exam, read this one.

---

## Projects, Billing, Organization

- Hierarchy: Organization -> Folder -> Project -> Resource
- Project = unit of billing, IAM, quota, API enablement
- Project ID: globally unique, immutable, cannot be reused
- Project Lien = prevents deletion only, not access/isolation control
- New team needing independence = new project, not shared access to existing one
- Billing account can link to zero or more projects
- Budget alerts: default 50%, 90%, 100% thresholds
- Budgets/alerts = notify only; Quotas = actually cap usage
- Billing Data Export to BigQuery + Looker Studio = cross-project/cross-billing-account cost visualization
- Rate quota = resets per time window; Allocation quota = max resource count

## IAM

- Principal + Role + Resource
- Basic roles (Owner/Editor/Viewer): broad, avoid if narrower role exists
- Predefined role = default correct answer for "give access to X service only"
- Custom role = only when no predefined role fits exactly
- Groups for humans, Service Accounts for workloads/apps — never personal creds in app runtime
- Default Compute Engine service account is SHARED across all VMs — isolate one VM's access = dedicated SA for that VM only
- Deny policies override allow policies always, regardless of role
- Org Policy = hard block org-wide (e.g., restrict resource locations); IAM = who can do what
- IAM Recommender = suggests removing excess permissions
- BigQuery: single-project team running SQL = `bigquery.user` on a Group
- BigQuery: billing project separate from data project = `jobUser` (billing project) + `dataViewer` (data project)
- Cross-org data sharing: THE PARTNER creates their own service account; you grant IT access to your resource — never the reverse

## Compute Choice

- Full VM/OS control, custom software -> Compute Engine
- Container orchestration, many microservices -> GKE
- Stateless HTTP container, scale to zero -> Cloud Run
- Single event-triggered function -> Cloud Run Functions
- Just deploy code, simpler than containers -> App Engine
- Entire DB held in memory (e.g. ERP/SAP HANA-style) -> M1/M2 memory-optimized machine type
- GPU -> parallel/ML compute, not in-memory DB speed
- Local SSD -> high disk IOPS, ephemeral data
- Different workloads, different CPU:memory ratio, same GKE cluster -> separate node pools per machine family (compute-optimized vs general-purpose)

## MIG / Autoscaling

- Regional MIG (default/recommended) = spread across zones, survives zone failure
- Zonal MIG = single zone, no redundancy
- Update type: "automated + minimal resources, no rush" -> Opportunistic
- Update type: "immediate/fast rollout" -> Proactive
- Stateful IPs = preserve IP across autohealing/recreation
- MIG fails to create instances -> check for colliding persistent disk name; set `disks.autoDelete=true`
- Health check = decides who gets traffic; Auto-healing = recreates crashed instance; Autoscaling = adds/removes instances by load
- GKE cluster autoscaling command: `gcloud container clusters update --enable-autoscaling --min-nodes=X --max-nodes=Y`

## Storage Class (Cloud Storage)

- Frequent access (multiple times/month) -> Standard
- ~Once a month -> Nearline
- ~Once a quarter / disaster recovery -> Coldline
- <Once a year / deep archive/compliance -> Archive
- Same-region consumers -> Region
- Regional perf + geo-redundancy -> Dual-region
- Global serving / max availability -> Multi-region
- Unpredictable access pattern -> Autoclass
- DR backups = Coldline is Google-recommended (not Archive — slower retrieval; not Nearline — too frequent-access-oriented)

## Database Selection

- Analyze + SQL + no infra to manage -> BigQuery
- Transactional app (orders, users), standard web framework -> Cloud SQL
- Global scale + strong consistency + horizontal scaling + unpredictable growth -> Cloud Spanner
- Mobile/web app, offline sync, flexible schema -> Firestore
- Huge throughput, wide-column, IoT/AdTech/finance/time-series -> Bigtable
- High-speed streaming clicks/sensor data, bursty writes -> Bigtable
- Cache/session store, microsecond latency -> Memorystore
- Immutable blobs >10MB -> Cloud Storage
- PostgreSQL + HTAP + ML integration -> AlloyDB
- Shared NFS file system -> Filestore
- Cloud SQL long-term (multi-year) audit retention -> EXPORT job to Cloud Storage (Archive class), NOT relying on automatic/on-demand backups (those are for operational recovery only)
- Migrate on-prem MySQL to Cloud SQL, zero downtime -> Database Migration Service
- Migrate on-prem VMs -> Migrate for Compute Engine
- Migrate Hadoop/Spark cluster -> Dataproc

## Data Pipeline / Analytics

- Hourly/scheduled/slowly-changing, minimize cost, fewest steps, no code -> BigQuery Data Transfer Service
- Real-time, react per file immediately -> Cloud Function on `google.storage.object.finalize`
- Complex custom transform, streaming+batch -> Dataflow
- Spark/Hadoop existing jobs -> Dataproc
- Visual no-code data cleaning -> Dataprep
- Multi-step pipeline orchestration with dependencies (Airflow) -> Cloud Composer
- Lightweight orchestration of API/service calls -> Workflows
- SQL-only ML model, no data movement -> BigQuery ML
- BigQuery compliance auto-delete over time, ongoing ingestion -> time-partitioned table + partition expiration (not flat table expiration)

## Networking

- VPC = private network boundary; Subnets = regional
- Firewall: stateful, default deny-all ingress / allow-all egress if rules deleted
- Restrict instance-to-instance traffic on autoscaling app -> firewall rules by service account or network tag (NOT static IP/subnet)
- Standard Tier = cheap, single-region, public internet routing
- Premium Tier = costly, global, Google backbone routing
- External HTTPS LB = secure web frontend (SSL termination, content routing)
- Internal LB = backend-to-backend traffic within VPC
- Passthrough NLB = preserve client IP, UDP/ESP/ICMP
- Proxy NLB = TLS offload, multi-region backends, no HTTP awareness needed
- Cloud NAT = outbound-only internet access for private VMs
- Cloud Armor = WAF/DDoS, only on external Layer 7 (HTTPS) LB
- Egress free: internal IP same zone, to Google products, same-region GCP-to-GCP
- Egress charged: external IP same zone, cross-zone, cross-region
- Shared VPC = centralized admin, same org, cross-project
- VPC Peering = decentralized, cross-org allowed, no transitive routing

## Operations / Monitoring

- Cloud Monitoring = metrics/dashboards/alerts/uptime checks
- Cloud Logging = centralized logs, sinks, log-based metrics
- Cloud Trace = find slowest microservice in a request chain
- Cloud Profiler = continuous CPU/memory profiling
- Error Reporting = auto error grouping/alerting
- Multi-project single pane of glass -> Cloud Monitoring Workspace (create under one project, add others)
- Audit logs: Admin Activity (always on, config changes) vs Data Access (must enable, read/write access — needed for "record all reads" requirements)
- Aggregated log sink at FOLDER level = captures current + future projects automatically
- SLO = target reliability (e.g. 99.9%); Error budget = 1 - SLO (allowed downtime)

## Security / Compliance

- Secret Manager = store/rotate API keys, passwords, certs
- Cloud KMS = create/rotate encryption keys (CMEK = Google-managed via your key; CSEK = you supply raw key)
- VPC Service Controls = perimeter around APIs, blocks data exfiltration
- IAP = app-level access control, no VPN, = BeyondCorp model in practice
- Zero trust for IoT/vehicles = treat every internal call as untrusted + TPM/verified boot at hardware level
- Shielded VM = Secure Boot + Measured Boot + Integrity Monitoring
- Confidential VM = encrypts data in use (memory), AMD SEV, N2D instances

## Load Balancer Decision (fast path)

1. HTTP(S) traffic, content routing -> Application Load Balancer
2. Preserve client IP / non-HTTP protocol -> Passthrough NLB
3. TLS offload, multi-region, no HTTP awareness -> Proxy NLB
4. Internal only -> Internal ALB or Internal Passthrough NLB
5. Compliance/must-stay-in-region -> Regional, not Global

## App Engine

- Standard env = sandboxed, fast scale-to-zero, cheaper, limited runtimes
- Flexible env = Docker on Compute Engine VMs, any language/binary, slower scale, no scale-to-zero
- Canary test on real traffic -> new VERSION of SAME service + traffic splitting (not new service)
- Safe rollback -> new version + traffic migration (never overwrite/delete current version first)

## Cost Optimization

- Sustained Use Discount: automatic, >25% month usage, up to 30%
- Committed Use Discount: 1-3yr commitment, up to 57-70%
- Preemptible VM: max 24hr runtime, 60-91% off, 30s warning
- Spot VM: no max runtime, same idea as preemptible, newer model
- Fault-tolerant batch workload, cost too high -> test with simulated maintenance events, then use Preemptible/Spot
- Unused static IP costs MORE than in-use IP — release when idle

## Case Study Pattern Recognition

- Named fictional company + gaming/microservices/multi-region/public frontend only -> GKE + Artifact Registry + global HTTPS LB
- Named fictional company + healthcare/remote workforce/replace VPN/existing SSO -> IAP (BeyondCorp)
- Named fictional company + vehicles/IoT/telemetry/ML training/cost -> streaming Dataflow -> Bigtable/BigQuery + zero trust + TPM boot

## Gotchas To Never Forget

- Static IP unused = higher cost than in use
- `--secondary-zone` alone does NOT enable HA — needs `--availability-type=REGIONAL` too
- `--replica-type` / `--master-instance-name` = read replicas, NOT HA failover
- Deployment Manager = Google-native IaC (YAML/Python); Terraform = multi-cloud IaC (HCL)
- MongoDB with SLA on GKE -> MongoDB Atlas via Cloud Marketplace, not self-hosted
- Istio Fault Injection = simulate one microservice down for chaos testing
- `gcloud config set compute/region` (region) vs `compute/zone` (zone) — do not mix up
