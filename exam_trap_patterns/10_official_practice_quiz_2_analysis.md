# Official-Style Practice Quiz 2 — Deep Analysis

Same format as `09`. Only new gaps and important nuances get full write-ups here; anything already covered elsewhere just gets a one-line pointer at the bottom.

---

## New Gap: GKE Node Pools For Heterogeneous Workloads (CPU-Heavy vs General-Purpose)

Question pattern: one microservice needs a lot of CPU relative to memory (e.g., image rendering), while other microservices are fine on general-purpose machine types. You need the whole cluster to use resources efficiently.

Correct answer: create **separate node pools** — one using **compute-optimized** machine types for the CPU-heavy microservice, and one using **general-purpose** machine types for everything else. Pods are then scheduled onto the right pool (via node selectors/affinity/taints in practice, though the exam answer usually just tests "separate node pools by workload shape").

Why the distractors are wrong:

- Pod priority only affects scheduling order/eviction under resource pressure, it does not change what machine type backs a node.
- Putting the CPU-heavy workload on general-purpose nodes (or vice versa) wastes resources — general-purpose nodes are not optimized for CPU-heavy workloads, and compute-optimized nodes are wasteful/costly for the lighter memory-oriented workloads.
- Setting resource requests alone controls scheduling and bin-packing within existing node types, but it does not fix the underlying mismatch between workload profile and machine type family.

One-line rule: "different workloads have very different CPU:memory needs in the same GKE cluster" -> use multiple node pools with the machine type family matched to each workload, not just resource requests or pod priority.

## New Gap: Project Liens vs Organizational Separation

Question pattern: one team's project already exists; a second team needs similar resources but organized **independently**.

Correct answer: create a **new project** with its own unique project ID for the second team, and deploy resources there.

Why the distractors are wrong:

- Granting Project Editor to the second team on the first team's project does not give them independent organization — they would be sharing (and could affect) the first team's resources.
- A **Project Lien** is a distractor here — a Project Lien is a mechanism that **prevents a project from being deleted** until the lien is removed. It has nothing to do with organizing resources independently between teams.
- You cannot reuse an existing project ID for a new project — project IDs must be globally unique across all of Google Cloud, so "create a new project named X and use the same ID as an existing project" is not even technically possible.

One-line rule: "team needs independent resource organization" -> new project with its own unique ID, not shared access to an existing project. Also remember: **Project Lien = delete protection**, not organizational isolation — a classic distractor pairing.

## New Gap: App Engine Versions And Traffic Splitting (Canary Releases + Fast Rollback)

Your notes mention App Engine "traffic splitting" only once, in passing, inside a features list. This quiz shows it is tested as its own concept with two distinct angles.

### Angle 1 — Canary testing on a portion of real traffic

Question pattern: test an update on a small percentage of real users while most users stay on the stable version.

Correct answer: deploy the update as a **new version of the same service**, then configure **traffic splitting** to send a small percentage of traffic to the new version.

Why "new service" is wrong: creating a new service is a separate deployable unit with its own URL/routing — it does not sit inside the same traffic-splitting pool as the existing service's versions. Traffic splitting operates **between versions of the same service**, not between different services.

### Angle 2 — Fast rollback safety net

Question pattern: deploy an update without impacting users, and be able to roll back as fast as possible if it fails.

Correct answer: deploy the update as a **new version**, then migrate traffic from the current version to the new version.

Why this enables fast rollback: because the old version is still deployed and untouched, rolling back is just re-pointing traffic to it — no redeploy needed. Deploying to the **same version identifier**, or deleting the current version first, destroys your safety net — there is nothing stable left to fall back to.

One-line rule: App Engine safe releases always mean **new version + traffic migration**, never overwrite the current version and never delete it before the new one is proven. This single pattern answers both "canary testing" and "safe rollback" style questions.

## New Gap: Default Compute Engine Service Account Is Shared Across All VMs

Question pattern: you need one specific new VM to access certain Cloud Storage files, but you must prevent other existing VMs (running with default configuration) from accessing those same files.

Correct answer: create a **new, dedicated service account**, attach it only to the new instance, and grant **that** service account permission on the Cloud Storage objects.

Why using the default service account is wrong: the **default Compute Engine service account is shared across every VM in the project** that uses default configuration. Granting permissions to the default service account would grant access to all of those other VMs too — not just the new one. Object metadata does not function as an access-control mechanism at all, so any option involving "matching metadata" is a distractor with no real security effect.

One-line rule: "isolate access to only one VM" -> that VM needs its **own dedicated service account**, because the shared default service account extends access to every VM using it, silently defeating the isolation requirement.

## New Gap: Cloud Monitoring Workspaces For Multi-Project Single-Pane-Of-Glass Observability

Question pattern: you must monitor CPU, memory, and disk across three separate projects (A, B, C) as one unified view.

Correct answer: enable the Monitoring API, **create a Cloud Monitoring Workspace under project A**, then **add projects B and C to that workspace**. All three projects' metrics become visible together in one place.

Why the distractors are wrong: manually sharing individual charts does not give a unified live view. Granting `roles/monitoring.viewer` (metrics reader) alone does not merge projects into a single dashboard experience — it only grants read access, it does not create the cross-project aggregation. Viewing default dashboards "in sequence" is manual and not a single pane of glass at all.

One-line rule: "single pane of glass across multiple projects for metrics" -> Cloud Monitoring Workspace (one project hosts the workspace, others are added to it), not per-project dashboards or shared charts.

## New Gap: Cloud SQL Export Jobs vs Backups For Long-Term Audit Retention

Question pattern: you must retain a month-end copy of a Cloud SQL database for **three years** for audit purposes.

Correct answer: set up an **export job** on the first of each month, and write the export file to an **Archive class** Cloud Storage bucket.

Why relying on Cloud SQL's own backups is wrong: Cloud SQL automatic (and even on-demand) backups are designed for **operational recovery**, not indefinite long-term archival — they are tied to Cloud SQL's own retention limits and lifecycle, not meant to be kept for multiple years as an independent audit artifact. To get a durable, independently-retained, long-term copy outside of Cloud SQL's own backup system, you export the data (as a SQL dump or CSV) into Cloud Storage, where you control the retention explicitly (in this case via the Archive storage class, matching the "access almost never, keep for years" access pattern).

One-line rule: "keep a copy for multi-year audit/compliance, independent of the database's own retention" -> **export job into a Cloud Storage bucket** (Archive class for multi-year, rarely-accessed retention), not relying on Cloud SQL's built-in backup retention.

## New Gap: M1/M2 Memory-Optimized Machine Types For In-Memory Database Workloads

Question pattern: an application (e.g., an ERP system) holds its **entire database in memory** for fast access, and you must choose the right Compute Engine configuration.

Correct answer: provision Compute Engine instances using the **M1 (or M2) memory-optimized machine type** family.

Why the distractors are wrong: preemptible instances can be reclaimed at any time, which is unacceptable for a stateful in-memory production database. GPUs accelerate parallel numeric/ML compute, not in-memory transactional database performance. Local SSDs help disk I/O throughput, but the stated requirement is specifically about holding the **entire database in memory**, which is what memory-optimized machine types (very high memory-to-vCPU ratio, used for workloads like SAP HANA) are purpose-built for.

One-line rule: "entire database must be held in memory" -> **M1/M2 memory-optimized machine type**, not GPU, not local SSD, not preemptible.

## Nuance: `bigquery.user` Alone vs The `jobUser` + `dataViewer` Split (Contrast With Quiz 1)

Quiz 1 covered a scenario where billing had to be isolated from the data project (`jobUser` on the billing project, `dataViewer` on the data project). This quiz shows the simpler, more common case:

Question pattern: a BI team, working within a normal single-project setup, needs to run **custom SQL queries** against the latest streaming data in BigQuery.

Correct answer: assign the **BigQuery User** (`roles/bigquery.user`) IAM role to a **Google Group** containing the BI team members.

Why the other options are weaker: a Data Studio/Looker Studio dashboard only supports pre-built visualizations, not ad hoc custom SQL. Distributing individual service account private keys to team members is a security anti-pattern (shared long-lived credentials, no per-user auditability). Scheduling a batch Dataflow copy job introduces delay and does not satisfy "latest data."

One-line rule: **`bigquery.user` on a Group** is the default answer for "let a team run their own custom SQL queries" in a normal single-project context. The more granular `jobUser` + `dataViewer` split only becomes necessary when billing and data ownership must be split across two different projects.

## Minor Gap: Setting The Default Region For gcloud Commands

Question pattern: you want all future `gcloud` commands to default to `europe-west1` without specifying it every time.

Correct answer:

```
gcloud config set compute/region europe-west1
```

Common trap: `gcloud config set compute/zone europe-west1` is wrong syntax for this purpose — a **region** (e.g. `europe-west1`) is not a valid value for the **zone** property, which expects a zone like `europe-west1-b`. Region and zone are configured as two separate properties.

One-line rule: setting a default **region** uses `compute/region`; setting a default **zone** uses `compute/zone` — do not mix the two properties or their values.

## Reinforced (Already Covered) Patterns Seen In This Quiz

- Petabyte-scale, high-speed, time-stamped IoT/click-stream data -> Cloud Bigtable (see `02`).
- GKE cluster (node) autoscaling -> enable the cluster autoscaler on GKE itself, not on the instance group directly or via DIY Compute Engine setups (see `03`, `09`).
- Cross-project BigQuery dataset sharing with a partner -> partner creates their own service account, you grant it access to your dataset (see `09`, repeated verbatim in this quiz).
- Migrating a large on-prem Hadoop/Spark cluster to Google Cloud -> Dataproc (see `02`, `06`).
- Relational data needing horizontal scale + ACID -> Cloud Spanner (see `02`).
- Cloud Storage class for disaster recovery backups -> Coldline (accessed rarely but needs faster retrieval than Archive) (see `02`).
- Automatic budget spend notifications -> budget alerts at 50%/90%/100% thresholds, not a credit card limit or manual export query (see `07`).
- On-prem MySQL migration to Google Cloud with no downtime -> conceptually this is Database Migration Service (see Gap 11 in `08`); this quiz's answer options only offered "CloudSQL" as the closest fit among non-existent/unrelated choices, which is a reminder that some question banks phrase this loosely — always look for "Database Migration Service" by name first if it appears as an option.

## Summary Of Brand-New Topics From This Quiz

1. GKE node pools matched to workload machine-type needs (compute-optimized vs general-purpose)
2. Project Liens (delete protection) as a distractor for organizational separation questions
3. App Engine versions + traffic splitting for both canary releases and fast rollback
4. Default Compute Engine service account is shared across all VMs — isolate access via a dedicated service account
5. Cloud Monitoring Workspaces for multi-project single-pane-of-glass observability
6. Cloud SQL export jobs (not backups) for multi-year independent audit retention
7. M1/M2 memory-optimized machine types for in-memory database workloads
8. `bigquery.user` on a Group as the default single-project answer, contrasted with the `jobUser`/`dataViewer` split from Quiz 1
9. `gcloud config set compute/region` vs `compute/zone` — do not confuse the two properties
