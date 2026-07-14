# ACE Master One-Pager (Built From 667 Real Practice Questions)

Running revision notes style: short explanations plus quick-lookup tables. Read top to bottom once, then use as a last-minute scan.

---

## 1. SERVICE SELECTION

The exam almost never asks "can this service technically do it." Nearly everything overlaps. It asks "which is the intended fit given the ops-overhead, control, and lifecycle constraints stated." Compute Engine = you own everything above the hardware, most control, most maintenance. GKE Standard = you still manage nodes/scaling policy but get full Kubernetes control. GKE Autopilot = Google manages nodes entirely, you only manage workloads — pick this when the question says "minimize infrastructure configuration" AND "full control over the deployment via manifest," since Autopilot still gives you full K8s manifest control, just not node-level control. Cloud Run = serverless containers, HTTP-driven, scales to zero, cheapest for spiky/idle-heavy stateless HTTP work. Cloud Functions = single-purpose, short-lived, event-triggered; if the job can run long (tens of minutes) or needs a full runtime/custom binary, that pushes you to Cloud Run instead. App Engine Standard = fastest scale-to-zero PaaS for typical web/API workloads with supported runtimes. App Engine Flexible = when you need arbitrary language/library/binary support but still want a managed platform.

| Signal in question                                               | Answer                                           |
| ---------------------------------------------------------------- | ------------------------------------------------ |
| Full VM/OS control, custom binary, any OS                        | Compute Engine                                   |
| Container, need Kubernetes-level control                         | GKE Standard                                     |
| Container, minimize infra config, full manifest control          | GKE Autopilot                                    |
| Stateless HTTP container, serverless, scale to zero              | Cloud Run                                        |
| Internal-only container access + on-prem, minimal infra          | Cloud Run + Private Service Connect              |
| Single event trigger (file upload, Pub/Sub msg), short duration  | Cloud Functions                                  |
| Variable long-running per-file job (up to ~20 min), event-driven | Cloud Run (not Cloud Functions — duration limit) |
| Continual small load, spiky traffic, minimal management          | App Engine (Standard)                            |
| Any language/binary/library needed, still PaaS-like              | App Engine Flexible                              |
| Lift-and-shift containerized apps, future portability            | GKE (not Cloud Run — vendor lock-in concern)     |

One-line rule: if the question says "no infrastructure management" plus "event-driven" or "HTTP request," it is almost never Compute Engine, and usually not GKE Standard either unless Kubernetes-specific features (node pools, custom scheduling, DaemonSets) are explicitly needed.

## 2. DATABASE SELECTION

First classify the data shape (relational vs document vs wide-column vs analytical), then classify the scale/consistency need, then pick. Cloud SQL is the default for "normal" relational apps: single region, standard OLTP, existing MySQL/Postgres codebase you don't want to rewrite. Cloud Spanner is the upgrade path the moment the question adds "global," "unpredictable/massive growth," or "horizontal scaling with strong consistency" — it costs more and is more complex, so only jump to it when those specific words appear. Bigtable is for very high-throughput, low-latency, simple-schema workloads (IoT telemetry, time-series, ad-tech) where you already know your query patterns and they're simple (usually keyed by row). Firestore is the mobile/web-app NoSQL choice when the schema needs to be flexible and clients need offline sync or real-time listeners. BigQuery is for analytics, not transactional apps — recognize "SQL" + "analyze" + "large dataset" + "no infra to manage" as the BigQuery signature. Memory-optimized machine types (M1/M2) come up when the requirement is that the ENTIRE database must live in memory (SAP HANA-style ERP), which is a Compute Engine sizing question, not a managed-database question at all.

| Signal                                                                          | Answer                                                                                                     |
| ------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| Relational + point-in-time recovery + single region + cost-effective            | Cloud SQL (enable binary logging — NOT failover replicas)                                                  |
| Relational + global + unpredictable growth + ACID + minimal reconfig            | Cloud Spanner                                                                                              |
| Relational + region-limited market + managed                                    | Cloud SQL                                                                                                  |
| NoSQL + high write throughput + HBase migration + simple schema + IoT           | Bigtable                                                                                                   |
| NoSQL + document + mobile/web + flexible schema                                 | Firestore                                                                                                  |
| SQL analytics + serverless + minimal ops + write-once-read-many                 | BigQuery                                                                                                   |
| In-memory required for entire dataset (ERP, SAP HANA-style)                     | Compute Engine M1/M2 machine type                                                                          |
| Real-time streaming sensor data, atomic per-event writes, timestamp-based reads | Bigtable (row key = timestamp)                                                                             |
| Managed queue before processing (IoT ingestion buffer)                          | Pub/Sub                                                                                                    |
| Managed MongoDB with SLA                                                        | MongoDB Atlas via Cloud Marketplace                                                                        |
| Existing Postgres app, single-site, ACID, minimal code change                   | Cloud SQL                                                                                                  |
| Cloud Spanner query performance issue, single region, fast fix                  | Identify high-CPU queries via query statistics and rewrite them (not just adding nodes at a low threshold) |
| Cloud Spanner predictable traffic, automatic up/down scaling                    | Monitoring alert (upper/lower CPU) -> webhook -> Cloud Function -> resize Spanner nodes                    |

One-line rule: "analyze" + "SQL" almost always means BigQuery. "Global" + "unpredictable scale" + relational almost always means Spanner. Everything else relational defaults to Cloud SQL unless told otherwise.

## 3. STORAGE CLASS + LIFECYCLE

Storage class questions are almost always decided by ONE word describing access frequency — match that word first, don't overthink durability or region unless the question separately mentions global users or geo-redundancy. Standard = hot/frequent. Nearline = about monthly. Coldline = about quarterly (this is also Google's recommended class for most backup/DR scenarios, since Archive's minimum storage duration and retrieval latency are worse for a "might need it now" disaster scenario). Archive = yearly or less, deepest archive/compliance use. Lifecycle rules only support two real actions: SetStorageClass (move to a cheaper class) and Delete (remove the object) — there is no "move object to another bucket" or "copy" lifecycle action, so any answer suggesting that is automatically wrong. Age-based conditions always count from the object's original creation time, not from when a previous lifecycle action fired — this trips people up constantly on "archive at 90 days, delete after 1 year total" style questions, where delete must be set to 365, not 275.

| Signal                                                             | Answer                                                                                                                 |
| ------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------- |
| Backup/DR, Google-recommended                                      | Coldline (not Archive — faster retrieval; not Nearline — too frequent)                                                 |
| Frequently analyzed / accessed multiple times/month                | Standard (Regional)                                                                                                    |
| Accessed ~once/month                                               | Nearline                                                                                                               |
| Accessed ~once/quarter                                             | Coldline                                                                                                               |
| Accessed <once/year                                                | Archive                                                                                                                |
| Retain 5yr, 5 versions, move to cheap tier after 1yr               | Object Versioning + lifecycle conditions (SetStorageClass + version count + delete) — NOT retention policy             |
| Archive after 90d, delete after 1yr (365 total)                    | Lifecycle Age condition: SetStorageClass@90d, Delete@365d (NOT 275d — age counts from creation, not from prior action) |
| Encryption at rest                                                 | Default — Google encrypts automatically, no action needed                                                              |
| Sequential/date-prefixed filenames + high write throughput         | Causes hotspotting — randomize filename prefix                                                                         |
| Uniform bucket-level access enabled, some users lost access        | Those users had ACL-based access, not IAM — uniform access only respects IAM                                           |
| Share sensitive object externally, no Google account, time-limited | Signed URL with expiration                                                                                             |
| Compliance: record every read request                              | Enable Data Access audit logs for Cloud Storage API                                                                    |
| Serve PDF inline instead of forcing download                       | Set Content-Type metadata to application/pdf on the object                                                             |
| Low-risk cloud trial: archive huge logs + test analytics           | Store logs in Cloud Storage (archive/DR) + analyze in BigQuery                                                         |
| Remove backup files older than 90 days                             | Cloud Storage lifecycle JSON rule: Delete with Age=90 (apply via gsutil)                                               |

One-line rule: match the exact frequency word to the class, remember lifecycle only does SetStorageClass/Delete, and remember age is always measured from object creation.

## 4. COMPUTE ENGINE / MIG PATTERNS

Managed Instance Groups have three separate self-healing/scaling concepts that get tested as if they were interchangeable, and they are not. Health checks decide whether an instance currently receives traffic. Autohealing decides whether an unhealthy or crashed instance gets recreated — this is configured ON the MIG itself, not on a load balancer. Autoscaling decides how many instances exist based on load metrics (CPU, LB capacity, custom metric, queue depth, or schedule). A question about "recreate the VM after it fails health checks N times" is always an autohealing configuration question, never an HTTP load balancer setting. Instance templates are the reusable blueprint MIGs are built from — you cannot autoscale or standardize a fleet without one. For disk resilience, remember the distinction between zonal persistent disks (need snapshot + manual restore on zone failure) and regional persistent disks (synchronously replicated to a second zone, so zone failure recovery is near-instant with no restore step) — regional PD is the answer whenever the question wants "immediate" or "no downtime" recovery from a zone outage.

| Signal                                                               | Answer                                                                                             |
| -------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| Autohealing MIG, recreate after N failed health checks               | Managed Instance Group + Autohealing health check (NOT HTTP LB health check)                       |
| Exactly 1 instance always running, no scaling                        | Autoscaling OFF, min=max=1                                                                         |
| Heterogeneous on-prem cluster migration                              | Unmanaged instance group (MIG requires identical instance template)                                |
| Dynamic VM provisioning via config file, Google-recommended          | Deployment Manager (not Cloud Composer/MIG alone)                                                  |
| Scale single binary app by CPU, must use VMs directly (policy)       | Instance template + MIG + autoscaling (NOT GKE)                                                    |
| Fault-tolerant batch job, want cheapest compute                      | Preemptible/Spot VM (test with simulated maintenance events first)                                 |
| Need full control, custom OS/software, org requires VMs              | Compute Engine, never GKE/serverless                                                               |
| Rootkit/kernel malware protection required                           | Shielded VM (Secure Boot + Measured Boot + Integrity Monitoring)                                   |
| Physical isolation required (compliance)                             | Sole-tenant node (restricted to same project only)                                                 |
| Clone a persistent disk                                              | Zone, region, AND disk type must match source                                                      |
| Custom service account on new VM (not default)                       | Specify at VM creation in "Identity and API Access" section (NOT JSON key in metadata)             |
| One VM needs bucket access, others must not                          | Dedicated service account for that VM only (default SA is shared by all VMs)                       |
| Target pool not working, 2 zones same region                         | Missing health check                                                                               |
| MIG fails to create new instances                                    | Check instance template syntax + delete colliding persistent disk names; set disks.autoDelete=true |
| MIG flapping (scaling up/down too often)                             | Increase the cooldown period                                                                       |
| Health check marks instances healthy before app is actually ready    | Increase the health check's initial delay so autoscaling doesn't overprovision                     |
| Windows RDP access, fewest steps                                     | Set username/password in console + firewall port 3389 + RDP button (NOT port 22)                   |
| Windows password unknown after VM creation                           | `gcloud compute reset-windows-password` (not your Google Account creds, not a service account key) |
| VM needs to reach licensing server at fixed IP, no app config change | Reserve that exact IP as static internal IP                                                        |
| Regional resilience, zero downtime, minimize cost                    | Multiple regional MIGs + external Global HTTP(S) LB across regions                                 |
| Zone failure = instant recovery of disk data (no restore step)       | Regional Persistent Disk (NOT zonal + snapshot — snapshot needs a restore step)                    |
| MIG CPU saturated and autoscaling already at max                     | Increase autoscaling upper limit immediately, then optimize app/instance sizing                    |
| Prevent accidental instance deletion from console                    | Enable Delete Protection on the instance                                                           |
| VM memory needs a precise custom amount (not a predefined size)      | Stop VM, set a custom machine type with the exact vCPU/memory, restart                             |

Regional DR failover (crisp): cross-region MIG backends + Global HTTP(S) LB; avoid single-instance/on-prem/separate-project designs unless explicitly required.

One-line rule: health check = who gets traffic now, autohealing = replace it when it breaks, autoscaling = how many exist right now. Regional PD beats zonal+snapshot whenever "instant" zone recovery is required.

## 5. IAM AND SECURITY PATTERNS

IAM is principal + role + resource. The single biggest recurring trap: broad roles (Owner, Editor, Project Editor, Compute Admin) almost always look tempting because they "would work," but the correct answer is nearly always the narrowest predefined role that satisfies the stated need, and when no predefined role fits exactly, a custom role built with only the required permissions. Assign roles to Groups, not individual users, whenever more than one person needs the same access — this is the recurring "least maintenance" answer. Service accounts represent workloads, never humans; if a question describes an app, VM, or pipeline needing access, the answer path runs through a service account, not a personal/user identity. For cross-project or cross-organization data sharing, always remember direction: the party that needs access creates and controls their own service account in their own project, and the data owner grants that external service account permission on the owner's resource — never the reverse, and the data owner never creates an identity on behalf of someone else's organization.

| Signal                                                               | Answer                                                                                                                                                                                                                  |
| -------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Admin team needs VM SSH access, trackable per-person, efficient      | Each user's own SSH key on their Google account + `roles/compute.osAdminLogin` on the group (NOT shared key pair)                                                                                                       |
| External contractor, no Google account, needs SSH                    | They generate keypair, give you public key, you add it manually, they use private key (NOT IAP — requires Google account)                                                                                               |
| Internal-only, no public IP, secure SSH                              | Cloud IAP for SSH/TCP + `gcloud compute ssh --tunnel-through-iap`                                                                                                                                                       |
| Grant minimum permission to list disks/images                        | Custom role with exact `compute.disks.list` + `compute.images.list` (NOT Compute Storage Admin)                                                                                                                         |
| Delegate Cloud Storage bucket/file management                        | `roles/storage.admin` (NOT Project Editor — too broad)                                                                                                                                                                  |
| VMs need write-only access to one bucket                             | Service account + `roles/storage.objectCreator` on that bucket                                                                                                                                                          |
| Auditor needs to view IAM but not modify                             | `roles/browser` or `roles/iam.roleViewer`, assigned via GROUP                                                                                                                                                           |
| Auditor needs BigQuery + logs read-only                              | `logging.viewer` + `bigquery.dataViewer` predefined roles on a GROUP                                                                                                                                                    |
| Manager needs team-wise resource and cost visibility across projects | Use Labels (for example `team`, `cost_center`, `env`) and analyze billing by label; Audit/Trace/IAM are not cost-attribution tools                                                                                      |
| Many microservices need DB credentials stored securely               | Secret Manager (never source code/plain config/env var secrets)                                                                                                                                                         |
| Team needs to run custom SQL in single project                       | `roles/bigquery.user` on a GROUP                                                                                                                                                                                        |
| GCE VM script cannot query BigQuery                                  | Grant required BigQuery role(s) to that VM's service account (least privilege)                                                                                                                                          |
| Billing project separate from data project                           | `bigquery.jobUser` on billing project + `bigquery.dataViewer` on data project                                                                                                                                           |
| Approve Google Support access requests                               | `roles/accessapproval.approver` assigned to a GROUP (never individuals directly)                                                                                                                                        |
| Remove users with mismatched email domain                            | Org Policy constraint (limits future) + MANUAL retroactive removal (org policy is not retroactive)                                                                                                                      |
| New employee, personal Gmail conflicts with work email               | Use an email alias to resolve — do NOT delete their personal account                                                                                                                                                    |
| Cross-project resource sharing (partner needs your BigQuery data)    | PARTNER creates their own service account in THEIR project; YOU grant that SA access to YOUR dataset                                                                                                                    |
| Standardize IAM across projects for one team, least effort           | Custom role at ORG level, assign to a Cloud Identity Group                                                                                                                                                              |
| Compliance team: view only, never modify orders                      | `roles/bigquery.dataViewer` on a GROUP (simplest, least maintenance)                                                                                                                                                    |
| Prevent accidental dataset deletion but allow edits                  | Custom role with delete permission removed, assigned via group                                                                                                                                                          |
| New billing account creation permission                              | `billing.accounts.create`                                                                                                                                                                                               |
| Billing viewer only (no admin)                                       | `roles/billing.viewer`                                                                                                                                                                                                  |
| Link project to billing account permission                           | Billing Account User role (`roles/billing.user`)                                                                                                                                                                        |
| View who has Owner role on a project                                 | `gcloud projects get-iam-policy PROJECT_ID`                                                                                                                                                                             |
| Grant IAM role to identity (CLI)                                     | `gcloud projects add-iam-policy-binding --member --role` (NOT set-iam-policy, which replaces everything)                                                                                                                |
| Manage VM as a service account (create/attach disk/set metadata)     | `roles/compute.instanceAdmin.v1` + `roles/iam.serviceAccountUser`                                                                                                                                                       |
| Manage projects (view + IAM read/write)                              | `resourcemanager.projects.get` + `.getIamPolicy` + `.setIamPolicy`                                                                                                                                                      |
| Temporary elevated access for a developer                            | `roles/iam.serviceAccountTokenCreator` (time-bound), NOT permanent Editor/Owner                                                                                                                                         |
| Custom role — first version, want production-ready                   | Use 'testing' support-level permissions, stage = ALPHA                                                                                                                                                                  |
| Service account has too broad access (Owner)                         | Audit usage 90 days, create custom role with only used permissions                                                                                                                                                      |
| App/service can't call a Google API (e.g. Pub/Sub), API disabled     | APIs must be explicitly enabled per project (API Library, `gcloud services enable`, or Terraform `google_project_service`) before use — granting a role or deploying via Deployment Manager does NOT auto-enable an API |
| Employees outside company domain have resource access                | Organization Policy: restrict identities by domain (constraint applies going forward; existing mismatched users need manual removal)                                                                                    |
| Prevent resources from being created outside allowed regions         | Organization Policy: Resource Location Restriction constraint                                                                                                                                                           |
| SREs need to approve Google Support access requests                  | `roles/accessapproval.approver`, assigned to a GROUP                                                                                                                                                                    |
| Team needs identical IAM roles copied to a new project               | `gcloud iam roles copy` with the new project as destination                                                                                                                                                             |
| Make a Cloud Storage bucket public read via CLI                      | `gsutil iam ch allUsers:objectViewer gs://BUCKET` (NOT `gcloud`)                                                                                                                                                        |

One-line rule: whenever a broad role "would technically work," that is usually the signal it is the wrong answer — look for the narrower predefined or custom role instead.

## 6. NETWORKING

VPCs are global, subnets are regional, and firewall rules are stateful (return traffic for an allowed connection is automatically allowed, no second rule needed). The single largest RFC1918 private range usable for "largest possible subnet" questions is `10.0.0.0/8` — bigger than the `/12` and `/16` distractors, and `0.0.0.0/0` is not a valid private subnet at all (it represents "everything," used in routes/firewalls, not subnet creation). For hybrid/private access, keep three concepts distinct: Private Google Access (subnet-level, lets VMs without a public IP reach Google APIs like Cloud Storage), Cloud NAT (lets private VMs reach the general internet outbound only, never inbound), and Cloud VPN/Interconnect (connects your on-prem network to a VPC). Load balancer choice comes down to layer and traffic type: Application Load Balancer for HTTP(S) with content-based routing, Passthrough Network Load Balancer when you must preserve the original client IP or use non-HTTP protocols like UDP/ESP/ICMP, and Proxy/SSL Proxy Load Balancer when you need TLS termination for raw TCP/SSL traffic across regions without needing HTTP awareness.

| Signal                                                              | Answer                                                                                                         |
| ------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| Custom VPC, single subnet, largest possible range                   | `10.0.0.0/8` (NOT 0.0.0.0/0, NOT /12, NOT /16)                                                                 |
| Multi-project shared network, centralized admin                     | Shared VPC                                                                                                     |
| Need centralized observability across projects                      | Cloud Monitoring Workspace / centralized Logging sinks (NOT Shared VPC — networking only)                      |
| Multi-org / cross-org VPC connectivity                              | VPC Network Peering (Shared VPC is org-internal only)                                                          |
| Need highly available on-prem connectivity with dynamic routes      | HA VPN + Cloud Router (BGP)                                                                                    |
| Need dedicated high-throughput private on-prem connectivity         | Cloud Interconnect (+ Cloud Router for route exchange)                                                         |
| Diagnose blocked egress/ingress traffic                             | Enable Firewall Rule Logging                                                                                   |
| Restrict traffic between tiers (web→app not web→db)                 | Network tags or service accounts on firewall rules (service account = more secure/dynamic than tags)           |
| VM needs external service access, no public IP allowed              | Private Google Access (enable on subnet) — NOT VPC Service Controls, NOT Cloud NAT for GCS access specifically |
| Need private app reachability from on-prem                          | Use VPN/Interconnect/peering as needed — Private Google Access does NOT provide app reachability from on-prem  |
| VM needs general internet access, no public IP                      | Cloud NAT                                                                                                      |
| Subnet out of IPs, need more, no new routes                         | Expand existing subnet CIDR range (gcloud compute networks subnets expand-ip-range) — cannot shrink a range    |
| GKE VPC-native cluster IPs exhausted                                | Expand the subnet CIDR range (same fix)                                                                        |
| SSL/TLS traffic offload needed, TCP-based                           | SSL Proxy Load Balancer                                                                                        |
| Global low-latency, SSL-encrypted TCP:443, worldwide users          | SSL Proxy Load Balancer                                                                                        |
| Public web app on MIG + custom domain                               | External HTTP(S) Load Balancer + public DNS zone + A record to LB IP                                           |
| Internal-only TCP traffic, single region                            | Internal TCP/UDP (passthrough) Load Balancer                                                                   |
| Preserve client IP + UDP/ESP/ICMP                                   | External Passthrough Network Load Balancer                                                                     |
| Static content + web app + managed SSL                              | External HTTP(S) LB + URL map → Cloud Storage backend                                                          |
| DNS: root domain → LB IP                                            | A record (NOT CNAME — root domains can't use CNAME)                                                            |
| DNS: subdomain → root domain                                        | CNAME record                                                                                                   |
| Auto mode VPC subnet ranges                                         | Predefined, non-overlapping, fit within `10.128.0.0/9`                                                         |
| Firewall priority for "apply only if nothing else denies it"        | 65535 (lowest priority number wins; highest number = last resort)                                              |
| Default network firewall behavior if all rules deleted              | Implied deny-all ingress, allow-all egress                                                                     |
| VPC with hundreds of GB traffic to on-prem, secure, low-maintenance | Cloud VPN (not Cloud Interconnect — that's for high-throughput/expensive dedicated links)                      |
| Two VPC networks in different projects need low-latency direct link | VPC Network Peering                                                                                            |
| Firewall traffic diagnostics for compliance/SIEM                    | Enable VPC Flow Logs                                                                                           |

One-line rule: firewall rules are stateful, `10.0.0.0/8` is the largest usable custom subnet, and Private Google Access vs Cloud NAT is decided by "needs Google APIs only" vs "needs general internet."

## 7. GKE / KUBERNETES

Three autoscalers get conflated constantly. Horizontal Pod Autoscaler (HPA) changes the NUMBER of pod replicas based on load. Vertical Pod Autoscaler (VPA) changes the CPU/memory REQUESTS of existing pods, and in recommendation mode it only suggests values without applying them — this is the answer whenever a question wants cost-effective sizing suggestions without forcing changes. Cluster/Node Autoscaler changes the NUMBER of nodes in the cluster. Node Auto-Upgrade and Node Auto-Repair are also frequently confused: Auto-Upgrade keeps the cluster on a supported, current Kubernetes version automatically; Auto-Repair only recreates nodes that fail health checks. Node pools let you mix machine types in one cluster — this is the standard answer whenever different workloads in the same cluster have very different CPU:memory ratios, or whenever you want cheap Spot node pools for fault-tolerant work alongside standard node pools for critical work.

| Signal                                                           | Answer                                                                                                                 |
| ---------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| Monitoring pod must run on every node                            | DaemonSet (not Deployment/StatefulSet)                                                                                 |
| Different CPU:memory needs, same cluster                         | Separate node pools by machine type (compute-optimized vs general-purpose)                                             |
| Autoscale nodes on existing cluster                              | `gcloud container clusters update --enable-autoscaling --min-nodes --max-nodes`                                        |
| Enable Cloud Operations for GKE at creation                      | `--logging` and `--monitoring` flags                                                                                   |
| GKE default log destinations                                     | STDOUT and STDERR                                                                                                      |
| Node identity verifiable + no public access + minimal ops        | Private Autopilot cluster (Shielded Nodes on by default)                                                               |
| Keep cluster on supported/stable K8s version automatically       | Enable Node Auto-Upgrade (not Auto-Repair — that's for crashed nodes)                                                  |
| Production reliability release channel                           | Stable channel (not Rapid)                                                                                             |
| Deploy Dockerfile-based app to GKE                               | Build image → push to Artifact Registry → Deployment YAML → `kubectl apply -f`                                         |
| Update GKE app with minimal downtime                             | `kubectl set image deployment/NAME CONTAINER=NEW_IMAGE` (rolling update); do NOT delete/recreate Deployment or Service |
| Dockerfile-based rollout too slow                                | Use slim base image and copy source after dependency install to maximize layer-cache reuse                             |
| Each microservice independently scalable                         | One Deployment per microservice (not Job/CustomResourceDefinition/DocsCompose)                                         |
| Stable internal IP for backend service                           | Kubernetes Service of type ClusterIP                                                                                   |
| Expose app publicly via HTTPS                                    | Service type NodePort + Ingress + Cloud Load Balancer (not ClusterIP, not manual HAProxy)                              |
| Persistent data across pod reschedules + stable identity         | StatefulSet (not Deployment+PVC, not DaemonSet)                                                                        |
| GPU workload, occasional/non-restartable                         | Node auto-provisioning (NOT fixed min-1 GPU pool — wastes cost when idle)                                              |
| Cost-efficient mixed critical/non-critical workloads             | Standard VM node pool for critical, Spot VM node pool for fault-tolerant                                               |
| VPA vs HPA vs Cluster Autoscaler                                 | VPA = right-size CPU/mem recommendations; HPA = scale pod count by load; Cluster Autoscaler = scale node count         |
| Unknown resource needs, cost-effective suggestions               | HPA for availability + VPA (recommendation mode) for suggestions                                                       |
| Pod stuck Pending                                                | Check pod events/warnings first (`kubectl describe pod`), often insufficient cluster resources                         |
| GKE pulling images from Artifact Registry in another project     | Grant `artifactregistry.reader` to the node service account in the OTHER project                                       |
| Isolate untrusted client code in shared cluster pods             | gVisor sandbox node pool (`runtimeClassName: gvisor`)                                                                  |
| Change node machine type, zero downtime                          | Create NEW node pool with desired machine type, migrate pods, delete old pool                                          |
| Test how the app behaves if one microservice becomes unavailable | Istio Fault Injection (not manually deleting a node)                                                                   |
| GKE cluster autoscaler feature name at creation                  | `--enable-autoscaling` with `--min-nodes` / `--max-nodes`                                                              |
| Persist frontend-to-backend pod communication across restarts    | Kubernetes Service grouping backend pods, frontend talks to the Service, not pod IPs                                   |

One-line rule: HPA = pod count, VPA = pod size (recommendation mode = suggest only), Cluster Autoscaler = node count. Auto-Upgrade = version currency, Auto-Repair = crash recovery.

## 8. DATA PIPELINE / BIGQUERY

The recurring theme here is "the boring, fully-managed, no-code option beats the sophisticated custom pipeline" whenever the question emphasizes minimizing cost or minimizing steps. A scheduled, slowly-changing, hourly-or-less-frequent load into BigQuery should point you to the BigQuery Data Transfer Service before you reach for Cloud Functions or Dataflow — those require writing and maintaining code, while the Transfer Service needs only a source, destination, and schedule. Event-driven, near-real-time, per-file reactions are the one scenario where Cloud Functions genuinely wins, triggered on Cloud Storage's `google.storage.object.finalize` event. Dataflow is for genuine transform logic across streaming and batch; Dataproc is specifically for lifting-and-shifting existing Spark/Hadoop jobs with minimal rewrite; Dataprep/Data Fusion are the no-code/low-code data preparation options.

| Signal                                                                                | Answer                                                                                                                           |
| ------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Estimate BigQuery query cost before running                                           | `bq query --dry_run` (estimates BYTES READ, not returned) → Pricing Calculator                                                   |
| Reduce BigQuery scan cost, filter by ingestion time                                   | Ingestion-time partitioned tables + `_PARTITIONTIME` filter                                                                      |
| SQL analysis of Cloud Logging data, Google-recommended                                | Enable Log Analytics on log bucket → auto-linked BigQuery dataset                                                                |
| Load CSV from GCS into BigQuery, automate daily                                       | `bq load` via cron/Cloud Scheduler (simplest, no custom code)                                                                    |
| Query external AVRO/CSV in GCS via SQL, no data movement                              | BigQuery external tables                                                                                                         |
| Reduce BigQuery cost — 2 valid levers                                                 | Custom query quotas per user/project + switch to flat-rate slots                                                                 |
| quotaExceeded BigQuery error, diagnose                                                | `INFORMATION_SCHEMA` views + Cloud Audit Logs                                                                                    |
| Search 1000+ datasets for a specific column name                                      | Data Catalog search                                                                                                              |
| Service publishes to Pub/Sub topic, but app receives nothing                          | Create a subscription (push or pull); topic alone does not deliver messages                                                      |
| Time-series ingestion pipeline (IoT)                                                  | Pub/Sub → Dataflow → Bigtable/BigQuery                                                                                           |
| BigQuery scans stay high on repeated filtered analytics queries                       | Use time partitioning plus clustering on frequent filter columns                                                                 |
| ETL with visual/no-code interface                                                     | Cloud Data Fusion or Dataprep                                                                                                    |
| Migrate existing Hadoop/Spark jobs, minimal rewrite                                   | Dataproc                                                                                                                         |
| Batch load hourly, minimize cost, fewest steps                                        | BigQuery Data Transfer Service (no custom code)                                                                                  |
| React to each new file in Cloud Storage immediately                                   | Cloud Function triggered on `google.storage.object.finalize`                                                                     |
| Copy Redshift analytics data + S3 assets + large video files into GCP, no custom code | Transfer Appliance (huge one-time video move) + BigQuery Data Transfer Service (Redshift) + Storage Transfer Service (S3 assets) |
| GDPR delete-after-36-months across BigQuery and Cloud Storage                         | BigQuery time-partitioned tables + partition expiration; Cloud Storage lifecycle Delete at 36 months                             |

One-line rule: scheduled/batch/no-transform → managed transfer service. Real-time per-file reaction → Cloud Function. Real transform logic at scale → Dataflow. Lift-and-shift Spark/Hadoop → Dataproc.

## 9. BILLING / COST

Budgets and alerts are visibility tools — they notify but do not automatically stop spending. Quotas are the only mechanism that actually caps usage. When a question wants per-person or per-team spend alerts (e.g., "notify me if any developer's sandbox exceeds $X"), the answer is always one budget PER PROJECT, never a single shared budget across all projects, because a shared budget cannot isolate whose spend triggered it. For cross-project or cross-billing-account cost visibility with near-real-time updates and custom querying, the standard answer is Billing Data Export to BigQuery, visualized in Looker Studio — this beats CSV exports, the built-in Reports view, and the Pricing Calculator (which only estimates future cost, it doesn't report actual spend).

| Signal                                                                     | Answer                                                                   |
| -------------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| Consolidate multi-project, multi-billing-account cost view, near real-time | Billing Data Export to BigQuery + Looker Studio dashboard                |
| Alert before budget threshold                                              | Budget + Alert at 50/90/100% (default)                                   |
| Prevent runaway resource usage/abuse                                       | Quotas (budgets only notify, don't stop usage)                           |
| Per-developer sandbox spend alert                                          | ONE budget PER PROJECT (not one shared budget)                           |
| Programmatic cost automation (e.g., shut down on overspend)                | Budget → Pub/Sub topic → Cloud Function                                  |
| New Google Cloud project, first billing account setup                      | Create billing account + payment method via Console (not support ticket) |
| Estimate cost before deployment                                            | Google Cloud Pricing Calculator                                          |
| Fault-tolerant nightly batch, reduce cost                                  | Preemptible/Spot VMs, test w/ simulated maintenance event first          |

## 10. gcloud / CLI EXACT COMMANDS (high frequency)

The exam tests exact flag names and exact command families, not just "which tool." Remember the three CLI tools stay separate: `gcloud` manages GCP resources (projects, IAM, Compute, GKE cluster control-plane), `kubectl` manages objects INSIDE a Kubernetes cluster once it exists, and `gsutil`/`bq` are the older dedicated tools for Cloud Storage and BigQuery respectively (the newer unified `gcloud storage` also works, but these older forms still appear throughout this question set). `add-iam-policy-binding` vs `set-iam-policy` is the most-tested CLI trap: binding only adds one role to one member; set-iam-policy overwrites the ENTIRE policy document and can accidentally wipe out other people's access if used carelessly.

```
gcloud config set compute/zone ZONE          # set default zone
gcloud config set compute/region REGION      # set default region
gcloud config set project PROJECT_ID         # set default project
gcloud config configurations create NAME     # new named config
gcloud config configurations activate NAME   # switch config
gcloud auth login                            # user auth
gcloud auth activate-service-account --key-file=KEY.json   # SA auth
gcloud projects describe PROJECT_ID          # project metadata
gcloud projects get-iam-policy PROJECT_ID    # view IAM bindings
gcloud projects add-iam-policy-binding PROJECT_ID --member=X --role=Y
gcloud iam roles list --project=PROJECT_ID
gcloud iam roles describe ROLE_ID
gcloud iam roles copy --source X --destination-project Y   # copy roles between projects
gcloud compute instances create NAME --machine-type=... (use n1-standard-N, not --cpus=N)
gcloud compute instances set-service-account NAME --service-account=SA
gcloud compute snapshots describe NAME       # find source disk of a snapshot
gcloud compute images create NAME --source-snapshot=SNAP
gcloud compute networks subnets expand-ip-range NAME --prefix-length=N   # only way to grow subnet; cannot shrink
gcloud container clusters create NAME --enable-autoscaling --min-nodes=X --max-nodes=Y
gcloud container clusters update NAME --enable-autoscaling --min-nodes=X --max-nodes=Y
gcloud container node-pools create POOL --cluster=NAME --service-account=...
kubectl config use-context CONTEXT           # switch GKE context (inactive cluster inspection)
kubectl config view                          # view current kubeconfig
kubectl apply -f file.yaml                   # deploy manifest
kubectl autoscale deployment NAME --min=X --max=Y --cpu-percent=Z
gcloud datastore indexes create index.yaml   # deploy Datastore indexes from config
gcloud spanner instances update INSTANCE --nodes=N   # resize Cloud Spanner nodes
bq query --dry_run 'SQL'                     # estimate cost, no execution
gsutil mb -c coldline gs://BUCKET            # create bucket with storage class
gsutil cp LOCAL_FILE gs://BUCKET             # upload/copy objects
gsutil mv gs://BUCKET/old gs://BUCKET/new    # move/rename object path/name
gsutil ls gs://BUCKET                        # list buckets/objects
gsutil rm gs://BUCKET/OBJECT                 # delete object
gsutil rewrite -s coldline gs://OBJECT       # change existing object's storage class
gsutil lifecycle set lifecycle.json gs://BUCKET   # apply lifecycle policy JSON
gsutil iam ch allUsers:objectViewer gs://BUCKET   # public read (iam = IAM policy ops, ch = change)
gsutil acl ch -u AllUsers:R gs://BUCKET/OBJECT    # ACL change form (legacy style in some labs/questions)
gsutil stat gs://BUCKET/OBJECT               # object metadata (creation time, content-type)
```

## 11. TOP 25 "TWO-ANSWERS-LOOK-RIGHT" TRAPS FROM THIS SET

These are the patterns that cause the most wrong answers because both options sound plausible. In each case, the wrong option is the one that sounds fancier or more manual; the right option is usually the specific documented feature built exactly for that purpose.

1. Point-in-time recovery for Cloud SQL → enable **binary logging**, NOT "create failover replicas" (that's HA, a different feature entirely — HA protects against instance failure, binary logging enables rolling back to any point in time).
2. MIG "autohealing" → configure a health check ON THE MIG itself, NOT an HTTP load balancer health check — the LB health check only controls traffic routing, not instance recreation.
3. Object lifecycle age math → age always counts from object creation date, so "archive at 90 days, delete after 1 year total" needs Delete set to **365 days**, not 275 (365 minus 90).
4. Custom service account on a VM → set at creation time via the Identity and API Access section, NEVER by uploading a JSON key into instance metadata (that's an older, less secure pattern the exam treats as wrong).
5. IAP for SSH → only works when the user HAS a Google account tied to your org. No Google account = manual SSH keypair exchange instead, IAP is not usable.
6. Uniform bucket-level access → silently breaks ACL-based access for anyone who only had ACL grants; only IAM-based access survives the switch.
7. Custom role for a narrow permission (e.g., list disks/images only) → build the role from scratch with only the exact permissions needed; don't start from Storage Admin/Compute Storage Admin and assume trimming later is fine — the exam wants least-privilege from the start.
8. Cross-project data sharing → the CONSUMING party creates and owns their own service account in their own project; the data owner only grants that external SA a role on their resource, never creates an identity on someone else's behalf.
9. `add-iam-policy-binding` vs `set-iam-policy` → binding ADDS a role to the existing policy; set-iam-policy REPLACES the entire policy document (destructive if you don't include everyone who already had access).
10. Root domain DNS → must be an A record; CNAME records are not legal at the zone apex/root domain, only on subdomains.
11. Public web traffic to a MIG with custom domain → use External HTTP(S) Load Balancer (Layer 7) plus PUBLIC DNS zone and A record to the LB IP; SSL Proxy LB is for non-HTTP(S) traffic, private zones are internal-only, and CNAME does not point directly to an IP.
12. Largest custom subnet CIDR → `10.0.0.0/8` is correct; `0.0.0.0/0` means "everything" and is invalid as an actual subnet range, while `/12` and `/16` are smaller than `/8`.
13. Data Access audit logs vs Admin Activity logs → Data Access logs (off by default for most services) explain sudden storage/logging cost spikes because of their huge volume; Admin Activity logs are free, always on, but low volume and only capture config changes.
14. Node Auto-Upgrade vs Node Auto-Repair → Auto-Upgrade keeps the Kubernetes version current/supported; Auto-Repair only recreates nodes that fail health checks — neither one substitutes for the other.
15. Regional Persistent Disk vs zonal disk + snapshot schedule → Regional PD gives near-instant zone-failure recovery with no restore step; the snapshot approach requires a manual restore before the app can come back up.
16. Billing budget per developer sandbox → must be ONE BUDGET PER PROJECT; a single shared budget across all projects cannot isolate whose spend crossed the threshold.
17. Autoscaling vs Autohealing vs Health Checks (MIG) → these are three separate settings tested as if interchangeable: health checks decide current traffic eligibility, autohealing decides recreation after failure, autoscaling decides instance count from load.
18. HPA vs VPA vs Cluster Autoscaler → HPA changes pod COUNT, VPA changes pod CPU/memory REQUESTS (recommendation mode = suggest only, doesn't apply), Cluster Autoscaler changes NODE count. Mixing these up is one of the most common wrong-answer patterns in GKE questions.
19. Private Google Access vs Cloud NAT → Private Google Access lets a no-public-IP VM reach Google APIs (e.g., Cloud Storage) only; Cloud NAT lets it reach the general internet outbound. Neither one provides inbound connectivity.
20. Shared VPC vs VPC Peering → Shared VPC is for multiple projects inside the SAME organization needing centralized network administration; Peering is for connecting separate VPCs (including across organizations) while each side keeps its own admin control.
21. SSL Proxy/TCP Proxy LB vs Passthrough Network LB → Proxy load balancers terminate the connection at Google's edge (needed for global reach and TLS offload); Passthrough Network LB preserves the original client IP and supports protocols proxy LBs don't (UDP, ESP, ICMP), but only works within one region.
22. Org Policy constraints are NOT retroactive → e.g., a domain-restriction policy stops future violations but existing non-compliant members/resources must be removed manually.
23. Access Approval / sensitive approval roles → always assigned to a GROUP, never to individual users directly, so the approval workflow survives staff turnover.
24. Signed URLs vs IAM/ACL grants for external sharing → when the recipient has no Google account and access must expire automatically, a Signed URL is correct; granting IAM/ACL to `allUsers` or `allAuthenticatedUsers` is a security red flag the exam expects you to avoid.
25. BigQuery `--dry_run` measures BYTES SCANNED, not bytes returned → this is what query cost is actually based on, which is why partitioning/clustering reduce cost even when the result set size is unchanged.
26. Windows VM password reset → use `gcloud compute reset-windows-password`, not your own Google Account credentials and not a manually uploaded service account key — this is the documented, secure path for regaining RDP access.
27. `gsutil` is not only for upload/copy → it is the Cloud Storage operations tool family (copy/move/list/delete/IAM/ACL). If the task is changing bucket/object access, `gsutil iam ch` is still the right command family (`iam` = IAM policy operations, `ch` = change).
28. Missing App Engine Datastore indexes → deploy `index.yaml` with `gcloud datastore indexes create`; do not rely on uploading the file to a bucket or deleting/recreating indexes manually in Console.

## 12. FINAL SANITY CHECKS BEFORE THE EXAM

- If two answers are both technically possible, pick the one matching the EXACT frequency/scale/security word in the question, not just "a service that could work."
- If a question says "fewest steps" or "minimize operational overhead," the no-code/fully-managed option almost always wins over anything requiring custom scripts.
- If a question involves a service account or IAM role, check for the narrowest role that satisfies the stated need — broad roles (Owner/Editor/Admin) are usually the wrong answer even when they'd technically work.
- If a question mentions "Google-recommended practices" explicitly, that is a strong signal the "clever workaround" answer is wrong and the straightforward, documented, managed-service answer is right.

## 13. ADDITIONAL SERVICES THAT SHOW UP REPEATEDLY (gap-filled after re-checking coverage against all 667 questions)

These didn't have dedicated space above but recur often enough in the source set to need their own quick-reference.

| Service                                 | When it's the answer                                                                                                                                                                                                                                                                                                                    |
| --------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Cloud Scheduler                         | Anything described as "runs on a schedule / daily / hourly / cron-like" that then triggers a Cloud Function, Cloud Run job, or Dataflow batch job. Cloud Scheduler is the trigger, not the worker — pair it with a Function/Run/Dataflow job that does the actual work.                                                                 |
| Cloud Tasks                             | Decoupling a slow/long-running operation from the main request path with per-task retry, rate-limiting, and delay control. Different from Pub/Sub (pure pub/sub messaging, no per-task scheduling) and from Cloud Scheduler (fixed recurring schedule, not per-request queuing).                                                        |
| Deployment Manager                      | If choices are Deployment Manager vs scripts/curl/console for Google-native IaC automation, Deployment Manager is the intended answer.                                                                                                                                                                                                  |
| Terraform                               | The default correct IaC answer whenever a question emphasizes "consistent, repeatable, version-controlled infrastructure across environments," "industry standard," or "avoid bash/curl scripts." One Terraform configuration parameterized per environment beats writing a separate template per environment when reuse is emphasized. |
| Container Registry / Artifact Registry  | Where a built Docker image goes before Cloud Run / GKE / Compute Engine can pull it. Standard flow: build image → push to (Artifact) Registry → deploy referencing that image. A Cloud Storage bucket is never the right place to store container images.                                                                               |
| Cloud DNS (private zone)                | Whenever an app currently hardcodes a database or service IP and that IP might change, or multiple internal services need name-based (not IP-based) discovery within a VPC — a private Cloud DNS zone removes the need to reconfigure the app on every IP change.                                                                       |
| Filestore                               | Shared, POSIX-compliant file storage mounted by multiple VMs/pods simultaneously (e.g., several drones/devices appending to a shared file, or legacy apps expecting an NFS mount). Cloud Storage is object storage and is the wrong answer whenever concurrent file-system-style appends from multiple clients are described.           |
| Memorystore (Redis/Memcached)           | A caching layer described as sitting "in front of" a database to reduce read latency/load — this is a caching question, not a database-replacement question; the underlying database (BigQuery/Cloud SQL/etc.) stays as the system of record.                                                                                           |
| Workload Identity                       | GKE pods needing to call Google APIs securely without using a downloaded node/service-account JSON key — Workload Identity binds a Kubernetes service account to a GCP service account, which is the modern, more secure replacement for baking keys into pods.                                                                         |
| Binary Authorization                    | "Only allow approved/signed container images to run in the cluster" — this is a Binary Authorization policy question, not an IAM or Artifact Registry permissions question.                                                                                                                                                             |
| App Engine traffic splitting / versions | Canary release, gradual rollout, or instant rollback for an App Engine app — done via deploying a new version and splitting traffic by percentage (or routing 100% back to the previous version for instant rollback), all from the App Engine Versions page/`gcloud app services set-traffic`.                                         |
| App Engine release regression response  | Roll back to last known-good version first, then diagnose with Cloud Trace/Logging in non-prod.                                                                                                                                                                                                                                         |
| Anthos Service Mesh                     | Traffic splitting / canary specifically for microservices running on GKE (not App Engine or Cloud Run) — when the question is GKE-specific and mentions gradual/canary rollout between service versions.                                                                                                                                |
| VPC Service Controls                    | Restricting which APIs (e.g., `storage.googleapis.com`) can be reached from inside a security perimeter, to prevent data exfiltration — different from a firewall rule (which controls network paths) and from IAM (which controls identity permissions); this controls API-level data boundaries.                                      |

One-line rule: scheduled trigger → Cloud Scheduler; decoupled retryable work → Cloud Tasks; repeatable multi-environment infra → Terraform; image storage → Artifact/Container Registry; shared file-system access → Filestore; cache in front of a DB → Memorystore; secure pod-to-API auth → Workload Identity; image allowlisting → Binary Authorization; canary/rollback → traffic splitting (App Engine) or Anthos Service Mesh (GKE); API-level data exfiltration boundary → VPC Service Controls.
