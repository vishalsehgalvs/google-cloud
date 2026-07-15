# Real-World Scenario Drills

All scenarios are original practice-style prompts.
Each block includes answer logic and option elimination.

## Domain A - Foundations, Billing, Governance

### Scenario A1

- Question: A new business unit needs independent IAM, API control, and billing ownership. What should you do first?
- Best answer: Create a separate project and link the required billing account.
- Why not folder only: folder is not a billing and API boundary.
- Why not reuse existing project: governance and ownership boundaries become unclear.
- Command:

```bash
gcloud projects create bu-analytics-prd --name="bu-analytics-prd"
gcloud billing projects link bu-analytics-prd --billing-account=BILLING_ACCOUNT_ID
```

### Scenario A2

- Question: Finance wants alerts before overspend and hard prevention of runaway usage.
- Best answer: Configure budget alerts and service quotas.
- Why not only budget: budget does not cap resource creation.
- Why not only manual review: delayed reaction risk.

### Scenario A3

- Question: Leadership needs cost by team and environment across many projects.
- Best answer: enforce labels, export billing to BigQuery, build dashboard.
- Why not only logs: logs do not provide clean cost rollups by business tag.
- Why not one-time CSV exports: not operationally sustainable.

## Domain B - IAM and Security

### Scenario B1

- Question: One VM must read a sensitive bucket. Other VMs must have no bucket access.
- Best answer: Use a dedicated service account on that VM and bucket-level role binding.
- Why not default VM service account: broad shared blast radius.
- Why not project-level Editor: excessive privilege.
- Command:

```bash
gcloud iam service-accounts create reports-reader --display-name="Reports Reader"
gcloud storage buckets add-iam-policy-binding gs://finance-reports \
  --member=serviceAccount:reports-reader@PROJECT_ID.iam.gserviceaccount.com \
  --role=roles/storage.objectViewer
```

### Scenario B2

- Question: On-call engineer needs temporary compute admin for one incident window.
- Best answer: grant role with IAM Condition expiration.
- Why not permanent role with reminder: cleanup can be missed.
- Why not Owner role: unnecessary privilege.

### Scenario B3

- Question: External partner needs read-only access to your BigQuery data.
- Best answer: partner keeps their own service account; you grant dataset-level access.
- Why not create identity for partner in your tenant: ownership and audit mismatch.
- Why not share user credential: security policy violation.

## Domain C - Networking, Hybrid, Load Balancing

### Scenario C1

- Question: Private VMs need package updates from internet and access to Google APIs, without public IPs.
- Best answer: Cloud NAT plus Private Google Access.
- Why not external IP on each VM: larger attack surface.
- Why not Private Google Access only: does not provide general internet egress.
- Command:

```bash
gcloud compute routers create nat-router --network=prod-vpc --region=us-central1
gcloud compute routers nats create nat-config --router=nat-router --region=us-central1 \
  --nat-all-subnet-ip-ranges --auto-allocate-nat-external-ips
gcloud compute networks subnets update app-subnet --region=us-central1 \
  --enable-private-ip-google-access
```

### Scenario C2

- Question: Public web platform needs host and path routing globally with managed TLS.
- Best answer: external Application Load Balancer with URL maps.
- Why not passthrough NLB: no Layer 7 URL decisions.
- Why not direct VM DNS records: no global traffic engineering.

### Scenario C3

- Question: Enterprise needs resilient private connectivity from on-prem with dynamic routing.
- Best answer: HA VPN and Cloud Router using BGP.
- Why not static routes: high manual operations burden.
- Why not classic single-tunnel design: weaker availability pattern.

## Domain D - Compute, GKE, Serverless

### Scenario D1

- Question: New API service is stateless with unpredictable spikes. Team wants minimal infra management.
- Best answer: Cloud Run.
- Why not Compute Engine: unnecessary VM operations.
- Why not GKE Standard: too much cluster management for requirement.
- Command:

```bash
gcloud run deploy orders-api \
  --image=us-central1-docker.pkg.dev/PROJECT_ID/apps/orders-api:1.0 \
  --region=us-central1 --allow-unauthenticated
```

### Scenario D2

- Question: Platform team needs Kubernetes objects, custom node pools, and daemon workloads.
- Best answer: GKE Standard.
- Why not Autopilot: reduced node-level flexibility for this ask.
- Why not Cloud Run: not Kubernetes object-level platform.

### Scenario D3

- Question: Existing VM app must self-heal and autoscale by CPU.
- Best answer: regional MIG with health check and autoscaling.
- Why not unmanaged instance group: no built-in managed autohealing.
- Why not single high-spec VM: poor elasticity and resilience.

## Domain E - Storage and Databases

### Scenario E1

- Question: Access pattern is frequent for 30 days, then rare. Keep costs low automatically.
- Best answer: Standard class with lifecycle transition and delete rules.
- Why not Archive from day one: wrong retrieval profile.
- Why not manual movement process: avoidable operational overhead.

### Scenario E2

- Question: Global order system needs relational consistency with massive growth.
- Best answer: Spanner.
- Why not Cloud SQL: global scale and consistency constraints.
- Why not Firestore: document model mismatch.

### Scenario E3

- Question: Team has existing PostgreSQL app and needs managed HA with minimal app changes.
- Best answer: Cloud SQL for PostgreSQL with regional availability type.
- Why not self-managed DB VMs: too much maintenance.
- Why not Spanner first: unnecessary migration complexity.

## Domain F - Data Pipelines and Analytics

### Scenario F1

- Question: Sensor stream must be transformed and visualized near real-time.
- Best answer: Pub/Sub to Dataflow to BigQuery.
- Why not Cloud SQL: analytics mismatch.
- Why not cron batch only: latency mismatch.

### Scenario F2

- Question: Existing Spark jobs must migrate quickly with minimal code changes.
- Best answer: Dataproc.
- Why not full rewrite: contradicts migration constraint.
- Why not BigQuery only: cannot run existing Spark jobs as-is.

### Scenario F3

- Question: Repeated analytics query costs are rising unexpectedly.
- Best answer: partition and cluster tables, validate with dry run.
- Why not just add capacity first: cost root cause remains.
- Why not SELECT \* patterns: expensive scans.
- Command:

```bash
bq query --use_legacy_sql=false --dry_run \
"SELECT COUNT(*) FROM analytics.events WHERE event_date >= '2026-07-01'"
```

## Domain G - Operations, Observability, Cost

### Scenario G1

- Question: Security team needs long-term searchable audit history.
- Best answer: Cloud Logging sink to BigQuery.
- Why not only default log retention: limited for long-term analysis.
- Why not local service logs: not centralized governance.

### Scenario G2

- Question: Production latency spikes, but errors are low. Need service-level root cause.
- Best answer: Cloud Trace with correlated logs.
- Why not Error Reporting only: focuses on exceptions, not latency path.
- Why not CPU metrics only: misses distributed request timeline.

### Scenario G3

- Question: Team wants automatic budget notifications and owner accountability by project.
- Best answer: one budget per project with labels for accountability.
- Why not one global budget: no precise project owner signal.
- Why not quotas only: no forecast and communication workflow.

## Self-Check Method

- Track confidence before answer: 0 to 100.
- If wrong at high confidence, write one line correction rule.
- Group misses by tag: IAM, Network, Compute, Storage, Data, Cost, Operations.
