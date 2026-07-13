# Gaps Not In Original Notes

This file was first written after checking only the 6 topics from your Claude discussion, which found 3 gaps. You correctly pushed back — a proper check needs to scan the whole 150-file set. This is that full scan.

Method used: read through every module not yet covered in earlier passes (IAM, networking, compute pricing/special VMs, IP/routes/firewall, shared VPC/peering), then grep-checked the entire `notes/` folder for a checklist of well-known Google Cloud exam topics to confirm which are missing, thin, or fully covered.

Gaps are grouped by how much exam risk they carry.

---

# Tier 1 — Confirmed Completely Absent (highest risk)

These topics do not appear anywhere in your 150 notes, not even in passing.

## Gap 1: Cloud Tasks

What it is: a fully managed service for executing asynchronous work — you enqueue a task and Cloud Tasks reliably delivers it to an HTTP endpoint or App Engine service, with retries, rate limiting, and scheduling built in.

Exam signal:

- "reliably execute a task later, with retries and rate control, decoupled from the main request" -> Cloud Tasks
- Contrast with Pub/Sub: Pub/Sub is for many subscribers reacting to an event (fan-out messaging). Cloud Tasks is for controlled, individually-managed task execution (one task, one delivery, with retry/backoff control).

## Gap 2: Workflows (Cloud Workflows)

What it is: a serverless orchestration service that lets you chain together a sequence of Google Cloud services and HTTP-based APIs into a single, reliable workflow, defined declaratively (YAML/JSON).

Exam signal:

- "orchestrate multiple API calls or services in a defined sequence, serverless, no infrastructure" -> Workflows
- Contrast with Cloud Composer: Composer is for complex, scheduled, DAG-based data pipeline orchestration (built on Apache Airflow) — heavier weight. Workflows is lightweight service-to-service orchestration.

## Gap 3: Cloud Composer

What it is: a fully managed workflow orchestration service built on Apache Airflow, used to author, schedule, and monitor pipelines that span multiple services (e.g., Dataflow -> BigQuery -> notification).

Exam signal:

- "orchestrate a complex multi-step data pipeline with dependencies, need Airflow" -> Cloud Composer
- Contrast with Workflows (lightweight orchestration) and Dataflow (single pipeline execution engine, not multi-job orchestration).

## Gap 4: Cloud Armor

What it is: a web application firewall (WAF) and DDoS protection service that attaches to external load balancers to filter malicious traffic, block IP ranges/geographies, and defend against Layer 7 attacks.

Your notes only reference it once, as an org policy constraint name (`constraints/compute.restrictCloudArmor`), never as an explained service.

Exam signal:

- "protect a web app behind a load balancer from DDoS or common web attacks (SQLi, XSS), block traffic by IP or country" -> Cloud Armor
- Only works with external Application Load Balancers (Layer 7), not internal or passthrough Layer 4 load balancers.

## Gap 5: API Gateway / Cloud Endpoints

What it is: managed services for creating, securing, and monitoring APIs (typically fronting Cloud Functions, Cloud Run, or App Engine). API Gateway is the newer, simpler serverless option; Cloud Endpoints is the older, more configurable option (supports both managed and open-source Extensible Service Proxy).

Exam signal:

- "expose serverless backend as a managed, secured API with authentication and rate limiting" -> API Gateway
- "need API management on top of GKE/Compute Engine backends, more configuration control" -> Cloud Endpoints

## Gap 6: Anthos

What it is: Google's platform for managing Kubernetes workloads consistently across Google Cloud, on-premises, and other clouds (multi-cloud/hybrid Kubernetes management).

Exam signal:

- "run and manage Kubernetes consistently across on-prem and multiple clouds" -> Anthos
- Not the same as plain GKE, which is single-cloud (Google Cloud only) unless paired with Anthos.

## Gap 7: Data Catalog and Dataplex

What they are:

- Data Catalog: a fully managed metadata management service for discovering, cataloging, and tagging data assets across BigQuery, Cloud Storage, and more.
- Dataplex: a data governance and management layer that unifies distributed data (lakes, warehouses, marts) with consistent access controls and metadata, without moving the data.

Exam signal:

- "discover, tag, or govern data across multiple storage systems without duplicating it" -> Dataplex or Data Catalog

## Gap 8: BigQuery ML

What it is: lets you create and run machine learning models directly inside BigQuery using SQL syntax, without exporting data to a separate ML platform.

Exam signal:

- "build a simple ML model using only SQL, directly on data already in BigQuery, no data movement" -> BigQuery ML
- Contrast with Vertex AI: use Vertex AI for more advanced/custom ML workflows; BigQuery ML is for SQL-native, in-warehouse modeling.

## Gap 9: Cloud Functions Generation 1 vs Generation 2

What it is: Cloud Functions has two generations. Gen 2 is built on Cloud Run and Eventarc under the hood, supports longer request timeouts, larger instances, concurrency (multiple requests per instance), and more event sources. Gen 1 is the original, simpler, more limited runtime.

Exam signal:

- "need longer execution time, more concurrency, or broader event source support for a function" -> Gen 2
- "simple, minimal function, generation not specified" -> Gen 1 is still the default answer for the most basic use cases in older exam content.

## Gap 10: App Engine Standard vs Flexible Environment

Your notes describe App Engine only at a high level (managed platform, supported languages). The Standard vs Flexible distinction is not covered.

What you need to know:

- **Standard environment**: sandboxed runtime, fast scale-to-zero, supports specific language runtime versions, cheaper, best for typical stateless web/mobile backends.
- **Flexible environment**: runs in Docker containers on Compute Engine VMs, supports any language/library/binary, slower scaling, no scale-to-zero, better for workloads needing custom dependencies.

Exam signal:

- "need custom runtime/dependencies not supported by standard sandboxed runtimes" -> Flexible environment
- "fast scale-to-zero, typical web app, minimize cost" -> Standard environment

## Gap 11: Migrate for Compute Engine and Database Migration Service

What they are:

- Migrate for Compute Engine: automates lift-and-shift migration of on-premises or other-cloud VMs into Compute Engine.
- Database Migration Service: automates migration of databases (e.g., on-prem/other-cloud MySQL/PostgreSQL) into Cloud SQL with minimal downtime.

Exam signal:

- "move existing on-prem VMs into Compute Engine with minimal rework" -> Migrate for Compute Engine
- "migrate existing on-prem database into Cloud SQL with minimal downtime" -> Database Migration Service

## Gap 12: Google Cloud Support Tiers

What it is: Google Cloud offers tiered support plans — Basic (free, community/docs only), Standard, Enhanced, and Premium — differing in response times, technical account management, and coverage.

Exam signal:

- "need guaranteed fast response times / dedicated technical account manager" -> Premium support
- "no paid support needed, community/self-service is fine" -> Basic support

## Gap 13: Deployment Manager As An IaC Alternative To Terraform

Your notes mention Deployment Manager only as the mechanism behind Cloud Marketplace deployments — never explained as Google's own native infrastructure-as-code tool, positioned as an alternative to Terraform.

What you need to know:

- Deployment Manager: Google-native, YAML/Python/Jinja2-based IaC tool, Google Cloud only.
- Terraform: multi-cloud, HCL-based, broader ecosystem, generally the more commonly recommended default today.

Exam signal:

- "Google-native IaC tool, no third-party dependency" -> Deployment Manager
- "multi-cloud or hybrid infrastructure as code" -> Terraform

---

# Tier 2 — Present But Too Thin (medium risk)

These are mentioned in your notes but only as passing references inside other topics, never explained as their own concept. This is risky because a question can test the concept directly and your notes will not give you a full answer.

## Gap 14: Secret Manager

Appears only as "use Secret Manager for credentials" inside Cloud Run and Cloud Storage notes. Never explained on its own.

What you need to know: a managed service for storing, versioning, and accessing sensitive values (API keys, passwords, certificates) with IAM-controlled access and audit logging, instead of hardcoding secrets or environment variables.

## Gap 15: Cloud KMS (Key Management Service)

Appears only inside the CMEK/CSEK encryption comparison in the Cloud Storage note. Never explained as a standalone service.

What you need to know: Cloud KMS lets you create, use, rotate, and destroy cryptographic keys used for encrypting data across Google Cloud services (CMEK = Google manages encryption using your Cloud KMS key; CSEK = you supply your own raw key material per request).

## Gap 16: Network Service Tiers (Standard vs Premium)

Only appears as a single passing mention inside a load balancer note.

- **Premium Tier**: routes over Google's private global backbone, lower latency, higher cost, needed for multi-region/global reach.
- **Standard Tier**: routes over the public internet within the originating region, cheaper, regional-only.

Exam signal: "single region + cost-sensitive" -> Standard Tier. "Global reach + lowest latency worldwide" -> Premium Tier.

## Gap 17: Cost Recommender (beyond VM rightsizing)

Your notes mention VM rightsizing recommendations and IAM Recommender, but not the broader Recommender product family (e.g., idle resource recommendations, committed use discount recommendations, firewall rule insights).

What you need to know: Recommender is a general Google Cloud engine that surfaces cost, security, and performance recommendations across many services, not just VM sizing.

---

# Tier 3 — Originally Identified Gaps (from the first pass)

## Gap 18: MIG Update Types — Opportunistic vs Proactive

Not covered in your notes at all.

- **Opportunistic**: updates only apply when instances naturally recreate (autoscale event, health-check failure, manual recreation). Minimal extra resource usage, slower rollout.
- **Proactive**: actively and immediately replaces instances per your rolling update settings (max surge, max unavailable). Faster, but uses more resources right now.

Exam signal: "automated + minimal resources, doesn't need to happen right away" -> Opportunistic. "Immediate/fast rollout" -> Proactive.

## Gap 19: BigQuery Data Transfer Service

Not mentioned anywhere in your notes. Your BigQuery, Dataflow, and Dataproc notes cover analytics and processing, but not this specific scheduled-ingestion service.

What you need to know:

- A fully managed, no-code service for scheduling recurring data loads into BigQuery from sources like Cloud Storage, other Google services (Google Ads, YouTube, etc.), and some third-party SaaS apps.
- You configure: source, destination table, and schedule. No pipeline code required.
- Supports scheduling intervals as frequent as roughly every 15 minutes, which comfortably covers "hourly" requirements.
- No separate compute infrastructure to manage or pay for beyond the transfer service itself.

Exam signal:

- "scheduled / hourly / batch load into BigQuery, minimize cost, fewest steps, no custom code" -> BigQuery Data Transfer Service
- Contrast with Cloud Functions (custom code, event-driven) and Dataflow (custom pipeline, real transformation logic).

---

# The Meta-Pattern Behind Almost All Of These

Two repeating themes explain why these specific gaps exist and why they matter:

1. **"Boring managed service beats custom build."** Cloud Tasks, Workflows, Cloud Composer, BigQuery Data Transfer Service, API Gateway — all of these are the "less exciting, fully-managed, low-code" option that beats a hand-built alternative when a question emphasizes low cost or few steps.

2. **"Security/governance add-ons are easy to forget because they sit beside the main service, not inside it."** Cloud Armor, Secret Manager, Cloud KMS, VPC Service Controls, support tiers — these are not the star of any architecture, so they are easy to under-revise, but exams like testing whether you remember to bolt them on.

## Suggested Action

If you want, the Tier 1 gaps (13 topics) can also be added as short new notes inside your main `notes/` folder so your original 150-note set becomes fully complete. This trap file will still exist separately either way as the fast-recall version.
