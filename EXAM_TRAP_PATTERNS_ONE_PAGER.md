# Exam Trap Patterns — One Pager

Consolidates all of `exam_trap_patterns/00` through `10`, plus the non-overlapping facts from `high_probability/00_ultra_crisp_essentials.md` and `practitioner_super_crisp/*`, into a single running revision file, same style as `ACE_MASTER_ONE_PAGER.md`: short explanation, then the trap, then a one-line rule. The individual files still exist with more worked examples if you want to go deeper on any one topic. (`practitioner_deep_dive_path/*` is a study-plan/topic-map, not extra facts, so nothing further to merge from there.)

---

## 0. CLOUD FUNDAMENTALS & RESOURCE HIERARCHY (quick base layer before the traps)

These rarely trap you on their own, but they're the assumed background for almost every scenario question, so a fast recap first:

- Service models: **IaaS** (Compute Engine — you manage OS/runtime/app) → **PaaS** (App Engine — platform handles infra, you handle code) → **Serverless** (Cloud Run/Functions — auto-scales, pay-per-use) → **SaaS** (finished product, e.g. Workspace). More control = more ops burden; less control = faster delivery.
- Hierarchy: **Organization → Folder → Project → Resource**. Project is the anchor for IAM, billing, quota, and API enablement. Project ID is globally unique and immutable — can never be reused once chosen.
- A new team needing independent resource management → new **project**, not shared access to an existing one. A **Project Lien** only blocks deletion, it does nothing for access/isolation.
- IAM = principal + role + resource; allow policies inherit down the hierarchy (parent grants flow to children).
- Ops tool one-liners: **Cloud Monitoring** = metrics/dashboards/alerts/uptime checks. **Cloud Logging** = centralized logs + sinks + log-based metrics. **Cloud Trace** = find the slowest microservice in a request chain. **Cloud Profiler** = continuous CPU/memory profiling. **Error Reporting** = automatic error grouping/alerting. **Cloud CDN** = edge-cached content delivery. **Cloud DNS** = domain-name-to-endpoint mapping (public or private zones).
- **SLO** = target reliability (e.g. 99.9%). **Error budget** = 1 − SLO, i.e. how much downtime/failure is allowed before you must stop shipping features and fix reliability instead.
- **Confidential VM** = encrypts data **in use** (in memory), not just at rest/in transit — uses AMD SEV on N2D instances; different from Shielded VM (which protects boot integrity, not runtime memory).
- **Shared VPC vs VPC Peering**: Shared VPC = centralized admin, same organization, cross-project. VPC Peering = each side keeps its own admin control, works cross-org, but has no transitive routing (if A peers with B and B peers with C, A cannot reach C through B).
- Quick elimination method when unsure between options: (1) remove anything requiring unnecessary manual management, (2) remove over-privileged roles, (3) remove anything mismatched to the stated workload type, (4) pick whichever remains with the lowest ops burden and best security-by-default.

---

## THE ONE META-RULE THAT EXPLAINS MOST TRAPS

Almost every trap question offers two or three answers that are all technically capable of solving the problem. The exam is never testing "can this work," it's testing "is this the intended, documented, least-effort, least-privilege fit for the exact words used." When stuck between two plausible answers, apply these in order:

1. Match the **exact frequency/scale/security word** in the question (monthly vs quarterly, regional vs global, read vs write) — don't round up to "close enough."
2. If the question says **"minimize cost"** or **"fewest steps"**, the fully-managed/no-code option beats any answer requiring custom code or a pipeline you must maintain.
3. Prefer the **narrowest IAM role or most specific config flag** over a broader one that "would also work."
4. If the question says **"Google-recommended"** or similar, that's a signal the clever workaround is wrong — pick the straightforward, documented, managed-service path.

---

## 1. STORAGE & DATABASE TRAPS

Storage class questions are decided by ONE access-frequency word, not by durability or region unless those are separately mentioned. Database questions are decided by data shape (relational/document/wide-column/analytical) plus the scale/consistency word, not by "could this technically hold the data."

| Trap | Rule |
|---|---|
| Storage class by frequency | Standard = frequent/multiple times a month. Nearline = ~monthly. Coldline = ~quarterly, and it's Google's recommended class for **backup/DR** (faster retrieval than Archive, cheaper than Standard). Archive = <once/year. |
| Location type | Region = same-region consumers, cheapest. Dual-region = regional performance + geo-redundancy. Multi-region = global serving / users outside Google's network. |
| BigQuery vs Cloud SQL vs Spanner vs Firestore | "Analyze" + "SQL" + large dataset + no infra → BigQuery. Transactional web app data → Cloud SQL. Global + unpredictable growth + strong consistency → Spanner. Flexible schema + mobile/offline sync → Firestore. |
| Bigtable vs Firestore | Huge write throughput, HBase-like, simple known query pattern (IoT/ad-tech) → Bigtable. Flexible app-facing document data → Firestore. |
| Cloud Storage vs Filestore | Object/blob data → Cloud Storage. Shared POSIX/NFS mount used by multiple VMs simultaneously → Filestore. |
| Cloud SQL vs AlloyDB | Standard managed relational → Cloud SQL. PostgreSQL-compatible + HTAP (transactions+analytics together) + ML integration → AlloyDB. |
| Object lifecycle age math | Age always counts from **object creation**, never from a prior lifecycle action. "Archive at 90d, delete at 1yr total" = Delete at 365d, not 275d. |
| Lifecycle actions available | Only **SetStorageClass** and **Delete** exist. There is no "move to another bucket" or "copy" lifecycle action — any such answer is automatically wrong. |
| Uniform bucket-level access | Silently breaks anyone who had ACL-based (not IAM-based) access — only IAM survives. |

## 2. COMPUTE ENGINE & MIG TRAPS

Three separate MIG concepts get tested as if interchangeable — keep them mentally separate: health check (who gets traffic right now), autohealing (recreate after failure — configured on the MIG itself, never on the LB health check), autoscaling (how many instances exist based on load). Update type (Opportunistic vs Proactive) is a separate fourth concept about *how* a rollout happens.

| Trap | Rule |
|---|---|
| Opportunistic vs Proactive MIG update | "Automated + minimal resources, doesn't need to happen now" → Opportunistic (only updates on natural recreation events). "Immediate/fast rollout" → Proactive (actively replaces instances now, uses more resources). |
| Regional vs Zonal MIG | Default production answer is Regional (survives zone failure) unless the question restricts to one zone. |
| Stateful IPs | "IP must stay the same after instance is recreated/autohealed" → configure Stateful IPs on the MIG, not just a static IP reservation. |
| Health check vs Autohealing vs Autoscaling | Health check = current traffic eligibility. Autohealing = replace it when it crashes. Autoscaling = instance count from load. Never substitute one for another. |
| Heterogeneous on-prem migration | Dissimilar VMs → Unmanaged instance group (MIG requires one identical instance template for all members). |
| Custom service account on a VM | Set at creation via Identity and API Access, never by uploading a JSON key into metadata. |
| One VM needs isolated bucket access | Give it its **own dedicated service account** — the default Compute Engine service account is shared across every VM in the project, so granting access to the default SA leaks access to all of them. |
| Regional Persistent Disk vs zonal + snapshot | Regional PD = near-instant zone-failure recovery, no restore step. Zonal + snapshot = requires a manual restore first. Pick Regional PD whenever "instant"/"no downtime" recovery is required. |
| Windows RDP / password reset | Firewall port 3389 (not 22) + `gcloud compute reset-windows-password` — never your own Google Account credentials. |
| Dynamic VM provisioning via config file | Deployment Manager (Google-native IaC) — not Cloud Composer (that's data-pipeline orchestration, unrelated) and not a MIG alone (a MIG needs a template, it doesn't read a generic config file). |

## 3. NETWORKING & LOAD BALANCER TRAPS

Network Service Tier and load balancer type are both decided by scope (single-region vs global) and protocol/layer (HTTP-aware vs raw TCP/UDP), not by which option "sounds more powerful."

| Trap | Rule |
|---|---|
| Standard vs Premium network tier | All traffic stays in one region + cost-sensitive → Standard Tier. Multi-region/global performance over Google's backbone → Premium Tier. |
| Choosing the frontend LB for a web app | Web-facing, needs SSL + content-based routing → External HTTPS (Application) Load Balancer. Internal-only between tiers in the same VPC → Internal Load Balancer. A plain TCP/UDP Network LB is usually the wrong pick for a secure web frontend — it lacks Layer 7 features. |
| ALB vs Proxy NLB vs Passthrough NLB | HTTP(S) + flexible routing → Application LB (Layer 7). TLS offload for raw TCP across regions, no HTTP awareness needed → Proxy/SSL Proxy LB. Must preserve client source IP or need UDP/ESP/ICMP → Passthrough Network LB. |
| Global vs Regional LB | Backends spread across regions, route to closest → Global. Compliance/"must stay in this region" language → Regional, even if Global is technically available. |
| Egress cost | Internal IP, same zone → free. External IP, same zone → charged (treated as inter-zone). Between zones/regions → charged. To Google products (YouTube, Gmail, Drive) → free. |
| Cloud NAT vs external IP | Private VMs need outbound-only internet, no inbound → Cloud NAT (never allows unsolicited inbound). Must be reachable directly from the internet → external IP. |
| Largest custom subnet CIDR | `10.0.0.0/8` is correct — bigger than `/12`/`/16`, and `0.0.0.0/0` is not a valid subnet range at all. |
| Root domain vs subdomain DNS | Root domain → A record only (CNAME is illegal at the zone apex). Subdomain → CNAME is fine. |

## 4. IAM & SECURITY TRAPS

The recurring theme: broad roles (Owner/Editor/Admin) "would technically work" for almost anything, which is exactly why they're usually the wrong answer. Assign roles to Groups, not individuals, whenever more than one person needs the same access. Service accounts represent workloads, never humans.

| Trap | Rule |
|---|---|
| Owner/Editor vs Predefined vs Custom role | If a narrower predefined or custom role satisfies the need, the broad role is wrong even though it "would work." |
| Cloud SQL HA/replica flags | Automatic failover on zone outage → `--availability-type=REGIONAL`. Read replica config → `--replica-type` / `--master-instance-name`. Choosing the standby's zone → `--secondary-zone` (only meaningful once REGIONAL is already set — it does NOT enable HA by itself). |
| Service account vs user account | App/automated workload calling an API → service account. Human logging in → user account via IAM, ideally through a group. |
| Org Policy vs IAM | "Block this action entirely, regardless of role held" → Organization Policy constraint. "Control who can do it" → IAM role/binding. Org Policy is also **not retroactive** — existing violations need manual cleanup. |
| Deny policy vs removing a role | A hard block that can't be bypassed by any future granted role → IAM Deny Policy, not just un-assigning a role. |
| `add-iam-policy-binding` vs `set-iam-policy` | Binding **adds** one role to one member. set-iam-policy **replaces the entire policy document** — destructive if it omits existing grantees. |
| Cross-project/cross-org data sharing | The **consuming party** creates and owns their own service account in **their own project**; the data owner only grants that external SA a role on the owner's resource. Never create an identity on someone else's behalf. |
| Access Approval / sensitive approval roles | Always assigned to a **Group**, never to individuals, so the workflow survives staff turnover. |
| Signed URL vs granting IAM/ACL | Recipient has no Google account + access should expire → Signed URL. Granting `allUsers`/`allAuthenticatedUsers` is a red flag the exam wants you to avoid. |
| BigQuery role split across projects | Billing in Project B, data in Project A → `bigquery.jobUser` on Project B (who pays) + `bigquery.dataViewer` on Project A (who can only view). Contrast with a normal single-project team, which just needs `bigquery.user` on a Group. |

## 5. DATA PIPELINE & BIGQUERY TRAPS

The recurring trap: a fully-managed, no-code, scheduled service beats a custom-code pipeline whenever the question says "minimize cost" or "fewest steps" — even a *simple* Cloud Function is often the second-best answer, not the best.

| Trap | Rule |
|---|---|
| Scheduled/hourly/slowly-changing load into BigQuery | BigQuery Data Transfer Service — zero custom code, no separate compute cost, schedules down to ~15 minutes. Beats a standalone Cloud Function (still requires writing/maintaining code) and definitely beats Cloud Function + Dataflow (spins up worker VMs even for simple batch, contradicts "minimize cost"). |
| Real-time/immediate per-file reaction | Cloud Function triggered on `google.storage.object.finalize` — this is the one case event-driven genuinely wins over the scheduled transfer service. |
| Dataflow vs Dataproc vs Data Transfer Service | Real transform logic, streaming+batch → Dataflow. Lift-and-shift existing Spark/Hadoop jobs → Dataproc. Simple scheduled movement into BigQuery, no transform → BigQuery Data Transfer Service. |
| Dataprep vs Dataflow | Visual/no-code cleaning before analysis → Dataprep. Code-based transformation pipeline at scale → Dataflow. |
| BigQuery cost estimation | `bq query --dry_run` estimates **bytes scanned**, not bytes returned — this is what you're billed for, which is why partitioning/clustering cuts cost even if the result size doesn't change. |
| Compliance auto-delete with ongoing ingestion | Time-partitioned table + **partition expiration** (not flat table expiration) for BigQuery. Lifecycle DELETE by Age for Cloud Storage. A flat table-level expiration can't let old partitions age out independently while new data keeps arriving. |

## 6. COST & BILLING TRAPS

Budgets and alerts only **notify** — they never automatically stop spend. Quotas are the only thing that actually caps usage. "Minimize cost" almost always pairs with "fewest steps," meaning the boring managed service beats a cheaper-sounding custom build that actually needs more infrastructure to run.

| Trap | Rule |
|---|---|
| Budgets vs Quotas | Need visibility only → Budget + alert (50/90/100%). Need to actually prevent overspend/abuse → Quotas. |
| Per-developer/per-team spend alerts | **One budget per project**, never one shared budget across all projects — a shared budget can't isolate whose spend crossed the line. |
| Sustained/Committed/Preemptible/Spot discounts | Sustained Use Discount: automatic, kicks in above ~25% month usage, up to ~30% off. Committed Use Discount: 1-3yr commitment, up to 57-70% off (deepest, requires commitment). Preemptible VM: max 24hr runtime, 60-91% off, 30-second termination warning. Spot VM: same discount idea, no max runtime cap, newer model. |
| Rate quota vs Allocation quota | "X per time window" → rate quota. "Maximum you can have at once" → allocation quota. |
| Cross-project/cross-billing-account cost visibility | Billing Data Export to BigQuery + Looker Studio — beats CSV export (manual, not real-time) and the Pricing Calculator (only estimates future cost, doesn't report actual spend). |
| Multi-year audit retention for a database | Export job into a Cloud Storage bucket (Archive class) on a schedule — not relying on the database's own automatic/on-demand backups, which are for operational recovery, not indefinite archival. |

## 7. GKE / KUBERNETES TRAPS (from practice quiz analysis)

| Trap | Rule |
|---|---|
| HPA vs VPA vs Cluster Autoscaler | HPA = pod **count**. VPA (recommendation mode) = pod CPU/mem **size**, suggests only, doesn't apply. Cluster Autoscaler = **node** count. These are three separate answers to three separate questions, not interchangeable. |
| Enable autoscaling on an existing GKE cluster | `gcloud container clusters update --enable-autoscaling --min-nodes --max-nodes` — not a fixed resize, not tagging instances, not recreating the cluster. |
| Heterogeneous CPU:memory needs, same cluster | Separate **node pools** matched to machine type family (compute-optimized vs general-purpose) — not pod priority, not resource requests alone. |
| Node Auto-Upgrade vs Auto-Repair | Upgrade = keeps Kubernetes version current/supported. Repair = only recreates nodes that fail health checks. Neither substitutes for the other. |
| Simulate one microservice being unavailable | Istio Fault Injection — not deleting a node (too blunt) and not taints (affects scheduling, not live traffic). |

## 8. SERVICES MISSING OR TOO THIN IN THE ORIGINAL 150 NOTES

These service names barely or never appear in the main `notes/` folder, which makes them a blind spot risk. Quick definitions:

| Service | One-line definition | Exam signal |
|---|---|---|
| Cloud Tasks | Managed queue for reliable, retryable, rate-limited execution of individual tasks | "Run this later reliably, decoupled from the request, with retry/rate control" |
| Workflows | Lightweight serverless orchestration chaining API calls/services declaratively | "Orchestrate a sequence of API calls, serverless, no infra" |
| Cloud Composer | Managed Apache Airflow for complex, scheduled, DAG-based data pipeline orchestration | "Multi-step data pipeline with dependencies, needs Airflow" |
| Cloud Armor | WAF + DDoS protection attached to external Layer 7 load balancers | "Protect a web app from SQLi/XSS/DDoS, block by IP/country" |
| API Gateway / Cloud Endpoints | Managed API front-ends with auth/rate limiting for serverless backends | "Expose a serverless backend as a secured, managed API" |
| Anthos | Consistent Kubernetes management across on-prem + multi-cloud | "Manage Kubernetes consistently across on-prem and multiple clouds" |
| Data Catalog / Dataplex | Metadata discovery/governance layer across storage systems without moving data | "Discover/tag/govern data across systems without duplicating it" |
| BigQuery ML | Build ML models with plain SQL directly inside BigQuery | "Simple ML model, only SQL, no data movement out of BigQuery" |
| App Engine Standard vs Flexible | Standard = sandboxed, fast scale-to-zero, supported runtimes only. Flexible = Docker on Compute Engine VMs, any language/binary, slower scaling | "Need custom runtime/dependencies" → Flexible. "Fast scale-to-zero, typical web app" → Standard |
| Migrate for Compute Engine / Database Migration Service | Lift-and-shift VM migration / minimal-downtime DB migration into Cloud SQL | "Move on-prem VMs/DB into Google Cloud with minimal rework/downtime" |
| Secret Manager | Managed storage/versioning/IAM-controlled access for API keys, passwords, certs | Anywhere hardcoded credentials or env vars are the wrong answer |
| Cloud KMS | Create/rotate/manage encryption keys (CMEK = Google-managed using your key; CSEK = you supply raw key material) | "Create/rotate encryption keys for services" |
| Workload Identity | Binds a Kubernetes service account to a GCP service account — replaces baking SA keys into pods | "GKE pods need secure API access, no downloaded key" |
| Binary Authorization | Allowlist policy for which container images are permitted to run | "Only allow approved/signed images to run in the cluster" |
| Terraform vs Deployment Manager | Terraform = multi-cloud, HCL, industry standard, one config parameterized per environment. Deployment Manager = Google-native only | "Consistent, repeatable, version-controlled infra across environments" → Terraform |
| Support Tiers | Basic (free) → Standard → Enhanced → Premium (dedicated TAM, fastest response) | "Need guaranteed fast response / dedicated technical account manager" |

## 9. GOOGLE'S OFFICIAL CASE STUDY PATTERNS

If a question describes a named fictional company with a backstory, it's referencing Google's official recurring case studies. Recognize the pattern, don't memorize the story:

- **Mountkirk Games** — many small microservices, multi-region, public frontend only, single global IP, immutable deploys → GKE + Artifact Registry + Global HTTP(S) LB.
- **EHR Healthcare** — replacing VPN with zero-trust for remote workforce using existing SSO → Identity-Aware Proxy (IAP), i.e. the **BeyondCorp** model. ("BeyondCorp" in a question just names this zero-trust philosophy; the product is IAP.)
- **AutonomousDrive / TerramEarth** — vehicle/IoT fleets, high-volume telemetry, cost-sensitive ML storage, security-by-design → streaming ingestion (Dataflow) into Bigtable/BigQuery, plus zero trust between components + hardware root of trust (TPM/secure boot) — same integrity philosophy as Shielded VM, applied to embedded hardware.

## 10. QUICK KEYWORD → ANSWER INDEX

A fast-scan cheat list for the highest-frequency signal phrases:

- "frequently analyzed / accessed often" → Standard storage class
- "once a month / once a quarter / once a year or less" → Nearline / Coldline / Archive
- "global + unpredictable growth + relational + ACID" → Spanner
- "analyze + SQL + no infra" → BigQuery
- "automated + minimal resources" (MIG update) → Opportunistic
- "immediate/fast rollout" (MIG update) → Proactive
- "preserve IP across recreation" → Stateful IPs on the MIG
- "HTTP(S) + content-based routing" → Application Load Balancer
- "preserve client IP / UDP / ICMP" → Passthrough Network Load Balancer
- "single region + cost-sensitive" → Standard network tier
- "automatic failover, Cloud SQL, zone outage" → `--availability-type=REGIONAL`
- "reliable retryable task execution, decoupled" → Cloud Tasks
- "prevent overspend automatically" → Quotas, not budgets
- "per-developer/per-team spend alert" → one budget per project
- "hourly/scheduled/minimize cost load into BigQuery" → BigQuery Data Transfer Service
- "react instantly to each new file" → Cloud Function on `google.storage.object.finalize`
- "block a specific user no matter what role they get later" → IAM Deny Policy
- "restrict where resources can be created, org-wide" → Organization Policy (resource location constraint)
- "collect logs from a folder including future projects" → aggregated sink at folder level
- "partner needs access to your data" → partner creates their own service account, you grant it access
- "single pane of glass across multiple projects" → Cloud Monitoring Workspace
- "entire database must live in memory" → M1/M2 memory-optimized machine type
- "isolate access to one VM only" → dedicated service account for that VM (default SA is shared by all)
- "keep a DB copy for years, independent of DB's own retention" → scheduled export job into Archive-class Cloud Storage
