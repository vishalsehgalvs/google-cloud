# Official-Style Practice Quiz — Deep Analysis

This file analyzes a full 38-question ACE-style practice quiz (Google Cloud Skills Boost format) question by question, but only for the parts that reveal a gap, nuance, or trap not already fully covered elsewhere in this repo. Where a question just reinforces something already in `02` to `07`, it is noted briefly with a pointer instead of repeated in full.

Use this file after you have already read `01_keyword_to_answer_master_index.md` at least once.

---

## New Gap: BigQuery IAM Roles Split Across Billing Project vs Data Project

Question pattern: data lives in Project A, queries must be billed to Project B, users should query but never edit, and no cost should hit Project A.

Correct pattern:

- `roles/bigquery.jobUser` on the **billing project** — lets the user run (and pay for) query jobs there
- `roles/bigquery.dataViewer` on the **data project** — lets the user read the dataset without being able to edit it or run billed jobs against that project

Why the other combinations are wrong:

- Granting `dataViewer` on the billing project makes no sense — there is no data there to view.
- Granting `bigquery.user` everywhere is too broad and does not separate "who pays" from "who can only view."

One-line rule: "who pays" -> `jobUser` on the billing project. "Who can only view data" -> `dataViewer` on the data project. This split is a distinct, testable IAM pattern that is not just generic least privilege.

## New Gap: Billing Data Export To BigQuery For Cost Visualization

Question pattern: multiple projects, multiple billing accounts, want one unified visual view of cost, and want new cost data to show up quickly.

Correct pattern: **Billing Data Export to BigQuery**, then visualize with Looker Studio (formerly Data Studio).

Why the distractors are wrong:

- Cost Table CSV export is manual and not near-real-time.
- Pricing Calculator only estimates future cost, it does not report actual incurred cost.
- The Reports view in the Billing Console is a built-in view, but it does not give you a single custom visual layer across multiple billing accounts the way an exported dataset does.

One-line rule: "near real-time, cross-project/cross-billing-account, custom visualization" -> Billing Export to BigQuery + Looker Studio.

## New Gap: Managed Instance Group Fails To Create New Instances (Troubleshooting)

Question pattern: a MIG throws an error creating new instances, and you must keep the instance count at the template-defined level.

Correct troubleshooting checklist:

1. Verify the instance template syntax is valid.
2. Check whether a persistent disk already exists with the same name as the instance the MIG is trying to create — this is a common silent failure cause.
3. Set `disks.autoDelete=true` in the instance template so that disks are cleaned up automatically when instances are deleted, preventing this name collision from recurring.

One-line rule: "MIG can't create new instances, template looks fine" -> check for a leftover persistent disk with a colliding name, and make sure `autoDelete` is enabled.

## New Gap: Cloud Storage Read Auditing — Data Access Audit Logs

Question pattern: you must be able to prove/record every read request against sensitive data in a Cloud Storage bucket, for legal/compliance reasons.

Correct answer: enable **Data Access audit logs** for the Cloud Storage API.

Why the distractors are wrong:

- IAP is an access-control layer, not a logging mechanism by itself.
- DLP scans and classifies data, it does not log who read it.
- Restricting to a single service account reduces exposure but does not "record all requests."

Background you need: Cloud Audit Logs has multiple log types —

- **Admin Activity** logs (always on, free): who changed configuration/permissions
- **Data Access** logs (must be explicitly enabled for most services, can incur cost): who read/wrote/accessed data
- **System Event** logs: Google-initiated administrative actions
- **Policy Denied** logs: requests denied by security policies like VPC Service Controls

One-line rule: "must record read access to data for compliance" -> Data Access audit logs, not Admin Activity (which only covers config changes).

## New Gap: Docker Build Optimization For Faster Deployments

Question pattern: an application's container deployments are slow, and you must speed up build/deploy time without breaking functionality.

Correct actions:

- Use a smaller/slimmer base image (e.g., Alpine Linux) to reduce image size and pull time.
- Order Dockerfile instructions so that source code is copied **after** installing dependencies — this lets Docker's layer caching reuse the dependency-install layer when only source code changes, instead of reinstalling dependencies on every build.

Why the distractors are wrong:

- Removing Python after `pip` breaks the app (Python is the runtime).
- Removing dependencies from `requirements.txt` breaks functionality.
- Bigger machine types for the node pool do not meaningfully speed up image build/pull time.

One-line rule: "slow container deploys, don't break functionality" -> smaller base image + correct layer ordering (dependencies before source code copy), not bigger machines or removing needed packages.

## New Gap: Compute Engine VM Cannot Reach BigQuery — Service Account Scopes

Question pattern: a script running on a Compute Engine VM fails to connect to BigQuery, and you must fix it without assuming the code itself is broken.

Correct answer: update the privileges (IAM role, and/or Compute Engine access scopes) of the **service account attached to the VM**.

Why this is the default answer, not a library/tool install:

- If the client library and `gcloud`/`bq` tools were the problem, the error would usually be an import/command-not-found error, not an authorization/connection error.
- Compute Engine VMs authenticate to Google APIs using their attached service account. If that service account lacks the BigQuery role, or the VM's access scopes exclude BigQuery, API calls fail regardless of code correctness.

One-line rule: "VM code can't connect to a Google API" -> check the VM's attached service account's IAM roles and access scopes first, before assuming a missing library.

## New Gap: GKE Cluster (Node) Autoscaler — Exact Update Pattern

Question pattern: you need an already-running GKE cluster to scale nodes automatically as demand changes.

Correct answer: update the existing cluster to enable the cluster autoscaler with min/max node bounds, for example:

```
gcloud container clusters update CLUSTER_NAME --enable-autoscaling --min-nodes=1 --max-nodes=10
```

Why the distractors are wrong:

- A fixed `resize` command sets a static count, it does not enable ongoing autoscaling.
- Adding tags to instances does not configure the autoscaler.
- Creating a brand-new cluster and redeploying is unnecessary churn when the existing cluster can be updated in place.

One-line rule: "enable autoscaling on an existing GKE cluster" -> `gcloud container clusters update --enable-autoscaling --min-nodes --max-nodes`, not resize or recreate.

## New Gap: Official Google Cloud Exam Case Studies

This is one of the most important gaps found. Several questions in this quiz reference **Mountkirk Games**, **EHR Healthcare**, and **AutonomousDrive/TerramEarth** — these are official recurring case studies used across Google Cloud certification exams (both Professional and Associate level). Your notes never mention these case studies at all.

What you need to know conceptually (not memorize the fictional companies, but recognize the pattern each represents):

- **Mountkirk Games** pattern: many small microservices, multi-region deployment, public frontend only, single global frontend IP, immutable deployment artifacts -> typically points to GKE + Artifact Registry + global HTTP(S) Load Balancer.
- **EHR Healthcare** pattern: replacing VPN with a zero-trust access model for a remote workforce using existing SSO -> typically points to Identity-Aware Proxy (IAP), i.e., the BeyondCorp access model.
- **AutonomousDrive / TerramEarth** pattern: large fleets of vehicles/sensors generating high-volume telemetry, cost-sensitive storage for ML training, and strong security-by-design requirements -> typically points to streaming ingestion (Dataflow) into Bigtable or BigQuery depending on query needs, plus zero-trust security principles (treat every internal call as untrusted) and hardware root-of-trust concepts (TPM, verified/secure boot).

One-line rule: if a question describes a named fictional company with a distinctive backstory (gaming, healthcare, vehicles/agriculture, racing), recognize it as a Google official case study pattern — the "trick" is usually just applying standard best-fit architecture reasoning to a longer narrative, not a different rule set.

## New Gap: BeyondCorp Access Model Terminology

Directly tied to the case study above: **BeyondCorp** is Google's zero-trust access model name — access is granted based on user and device identity/context rather than network location (no VPN required). The practical implementation on Google Cloud is **Identity-Aware Proxy (IAP)**.

One-line rule: "BeyondCorp" in a question is just naming the zero-trust philosophy; the Google Cloud product that implements it is IAP.

## New Gap: Zero Trust And Hardware Root Of Trust For IoT/Embedded Devices

Question pattern: an autonomous vehicle/IoT architecture needs strong security during operation.

Correct answers (multi-select):

- Treat every microservice-to-microservice call, even within the same device, as untrusted (zero trust internally, not just at the network perimeter).
- Use a Trusted Platform Module (TPM) and verify firmware/binaries at boot (hardware root of trust, similar in spirit to Shielded VM's Secure Boot and Measured Boot, but applied to embedded/vehicle hardware).

Why the distractors are wrong: IPv6 alone is not a security control, custom programming language choice does not meaningfully change your security posture, redundant connectivity subsystems address availability not security, and Faraday cages address physical signal isolation, not the stated software/firmware integrity requirement.

One-line rule: "secure IoT/embedded device architecture" -> zero trust between internal components + hardware-verified boot (TPM/secure boot), which is the same integrity philosophy as Shielded VMs, just applied outside Compute Engine.

## New Gap: BigQuery Partition Expiration vs Table Expiration (GDPR-Style Retention)

Question pattern: must automatically delete data after a fixed retention window (e.g., 36 months) for compliance, across both BigQuery and Cloud Storage.

Correct pattern:

- Use a **time-partitioned BigQuery table** with a **partition expiration** setting (not just a flat table expiration), so each partition ages out and deletes independently based on its own data age.
- For Cloud Storage, use a **lifecycle management rule with a DELETE action** based on an Age condition of 36 months.

Why the distractors are wrong: a flat table-level retention period does not let old partitions expire independently while new data keeps arriving into the same table. `SetStorageClass` to a class named "NONE" is not a real lifecycle action — the real action for permanent removal is DELETE, not a storage class change.

One-line rule: "auto-delete data after N months, ongoing ingestion" -> time-partitioned table + partition expiration (BigQuery) and lifecycle DELETE by Age (Cloud Storage) — not flat table expiration or a storage-class-change action.

## New Gap: Aggregated Log Sinks At The Folder Level

Question pattern: a folder contains all production projects (current and future), and a security team needs all their logs centrally, without seeing non-production logs.

Correct answer: configure an **aggregated sink at the folder level** covering the production folder.

Why this beats the alternatives: an aggregated sink automatically includes logs from projects created in the future under that folder, with no per-project setup required each time a new production project appears. Configuring sinks per-project does not scale and misses future projects. Rerouting to on-prem or building custom Pub/Sub replication is unnecessary engineering effort when a built-in folder-level aggregated sink solves it directly.

One-line rule: "collect logs from a whole folder, including future projects, automatically" -> aggregated sink at the folder level.

## New Gap: Cross-Project Resource Sharing Direction (Who Creates The Service Account)

Question pattern: a partner company, running their own project, needs read access to a BigQuery dataset that lives in your project.

Correct answer: the **partner creates a service account in their own project**, and you grant **that service account** access to your BigQuery dataset.

Why direction matters: the identity that needs access should belong to (and be managed by) the organization that owns and controls that identity's lifecycle — the partner's own project. You are only responsible for granting access on your resource, not for creating or owning the partner's identity.

One-line rule: for cross-project/cross-org data sharing, the **consuming party's own service account** gets granted access to the **resource owner's data** — you do not create identities on behalf of another company.

## New Gap: Organization Policy — Restrict Resource Locations

Question pattern: a company wants to prevent cloud resources from being created outside regions where the company is physically present, enforced organization-wide.

Correct answer: configure an **Organization Policy** constraint restricting resource locations (`constraints/gcp.resourceLocations`).

Why the distractors are wrong: custom Terraform validators only apply to Terraform-provisioned resources and can be bypassed by any other creation method (Console, gcloud, API). IAM Conditions control who can act, not where resources can be created. Alerting after the fact does not prevent creation, it only reports it.

One-line rule: "hard org-wide restriction on where resources can be created" -> Organization Policy, not IAM Conditions and not alerting.

## New Gap: Istio Fault Injection For Chaos-Style Testing

Question pattern: a development team wants to test how their microservices-based application behaves when one specific dependent microservice becomes unavailable, without physically breaking infrastructure.

Correct answer: use **Istio's Fault Injection** mechanism to simulate the target service being unavailable (inject delays/errors/aborts at the service mesh layer).

Why the distractors are wrong: manually deleting a cluster node is too blunt an instrument and affects more than the intended service. Taints affect scheduling, not live traffic behavior to a specific service.

One-line rule: "simulate one microservice's unavailability in a controlled test" -> Istio Fault Injection, not node deletion or taints.

## New Gap: Cloud Spanner Has No Native Autoscaler (Older Exam Pattern)

Question pattern: predictable traffic pattern, want Spanner compute (node count) to scale up/down automatically.

Correct pattern (as tested historically): Cloud Monitoring alerting policy on Spanner CPU utilization, sending the alert to a webhook, which triggers a Cloud Function that resizes the Spanner instance's node count programmatically.

Why this matters: this question format assumes Spanner does not autoscale on its own, so the "automatic" part has to be built using Monitoring + a webhook + a Cloud Function, not by relying on a built-in autoscaler or on humans (SREs/Support) manually resizing it.

One-line rule: if a Spanner question insists on a fully automatic scaling response without human intervention, the expected shape is Monitoring alert -> webhook -> Cloud Function that performs the resize, not a manual/human-in-the-loop answer.

## New Gap: Managed Third-Party Database Via Marketplace (MongoDB Atlas Pattern)

Question pattern: an application on GKE needs a managed MongoDB deployment with a support SLA.

Correct answer: deploy **MongoDB Atlas from Google Cloud Marketplace**, rather than self-hosting MongoDB on Compute Engine/a Managed Instance Group, and rather than trying to force a different Google-native database (like Bigtable via the HBase API) to stand in for MongoDB.

One-line rule: "need a managed version of a specific named third-party database technology, with an SLA" -> check Cloud Marketplace for a fully managed partner offering before assuming you must self-host on Compute Engine or substitute a different Google-native database.

## Reinforced (Already Covered) Patterns Seen In This Quiz

These questions matched patterns already documented in `02` to `07`, just confirming they are correctly understood:

- Firewall targeting by service account/network tag instead of static IP, for autoscaling workloads (see `04`).
- Storage class and location selection by access frequency and user location (see `02`).
- Cloud Spanner for global relational scale with unpredictable growth (see `02`).
- Preemptible VMs for fault-tolerant, cost-sensitive batch workloads (see `07`).
- Regional MIGs + external Load Balancer for cross-region failover (see `03`, `04`).
- Cloud Trace for pinpointing which microservice adds the most latency (see `05` deep-dive networking/ops file in the other folder).
- Budgets configured per-project when you need to track spend per individual/team, not one shared budget.
- Rollback-first incident response before diagnosing in a safe environment, rather than debugging live in production or escalating externally first.

## Summary Of Brand-New Topics From This Quiz

Add these to your revision alongside the Tier 1/Tier 2 gaps in `08_gaps_not_in_original_notes.md`:

1. BigQuery IAM roles split (`jobUser` on billing project, `dataViewer` on data project)
2. Billing Data Export to BigQuery + Looker Studio for cost visualization
3. MIG instance-creation troubleshooting (disk name collision, `autoDelete`)
4. Cloud Audit Logs — Data Access logs specifically (vs Admin Activity)
5. Docker build optimization (slim base image, layer-order caching)
6. Compute Engine VM service account scopes as the default suspect for API connection failures
7. GKE cluster autoscaler exact update command
8. Google's official exam case studies (Mountkirk Games, EHR Healthcare, AutonomousDrive/TerramEarth)
9. BeyondCorp as the zero-trust model name behind IAP
10. Zero trust + hardware root of trust (TPM/secure boot) for embedded/IoT devices
11. BigQuery partition expiration vs flat table expiration for compliance retention
12. Aggregated log sinks at folder level for current + future projects
13. Cross-project data sharing direction (consumer creates and owns the service account)
14. Organization Policy resource location restriction
15. Istio Fault Injection for controlled dependency-failure testing
16. Cloud Spanner manual/custom autoscaling pattern (Monitoring + webhook + Cloud Function)
17. Marketplace-managed third-party databases (MongoDB Atlas) for SLA-backed managed services
