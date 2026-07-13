# Keyword To Answer Master Index

Read this file the most. It is the fastest way to convert a question's wording into the correct answer.

Format: **signal word/phrase in the question** -> **answer it is pointing to** -> **why**

## Storage Class Signals

- "accessed frequently / multiple times a month / analyzed often" -> Standard (Regional or Multi-regional) -> hot data needs low latency, frequent access
- "accessed less than once a month / backups" -> Nearline
- "accessed less than once a quarter / disaster recovery" -> Coldline
- "accessed less than once a year / compliance / deep archive" -> Archive
- "data consumers in same region / analytics pipeline in same region" -> Regional location
- "serve globally / users outside Google network / maximum availability" -> Multi-region
- "regional performance + higher availability" -> Dual-region
- "unpredictable or mixed access pattern" -> Autoclass

## Database And Analytics Signals

- "analyze + SQL + large dataset + no infra to manage" -> BigQuery
- "transactional app / orders / user credentials / existing web framework" -> Cloud SQL
- "global scale + strong consistency + horizontal scaling + mission-critical" -> Spanner
- "mobile/web app + real-time sync + offline support + flexible schema" -> Firestore
- "huge throughput + wide-column + IoT/AdTech/finance + HBase-like" -> Bigtable
- "microsecond latency + cache + session store" -> Memorystore
- "immutable blobs > 10MB / images / videos / backups" -> Cloud Storage

## Compute Signals

- "full VM/OS control / custom software / legacy lift-and-shift" -> Compute Engine
- "container orchestration / many microservices / Kubernetes needed" -> GKE
- "stateless HTTP service / scale to zero / minimal ops" -> Cloud Run
- "single event trigger / file upload / small isolated logic" -> Cloud Run Functions
- "managed app platform / just deploy code" -> App Engine

## MIG And Instance Update Signals

- "automated + minimal resources / gradual / no rush" -> Opportunistic update type
- "immediate + fast rollout / force replace now" -> Proactive update type
- "protect against zone failure / spread across zones" -> Regional MIG
- "simple single-zone setup, no redundancy needed" -> Zonal MIG
- "preserve IP across recreation/autohealing" -> Stateful IPs

## Load Balancer Signals

- "HTTP(S) traffic + content-based routing + flexible feature set" -> Application Load Balancer (external)
- "internal-only traffic between app tiers, same VPC" -> Internal Application Load Balancer or Internal Passthrough NLB
- "preserve client source IP / UDP / ESP / ICMP / non-HTTP protocol" -> Passthrough Network Load Balancer
- "TLS offload + backends across multiple regions" -> Proxy Network Load Balancer
- "single region only + cost sensitive + all traffic local" -> Standard Tier network service
- "multi-region / global reach / lowest latency across globe" -> Premium Tier network service
- "secure web frontend" -> External HTTPS Load Balancer (not plain TCP/UDP NLB)

## IAM And Access Signals

- "broad admin access for one person managing everything" -> Owner (basic role) -- but usually wrong answer in access-control-best-practice questions
- "give access to only what's needed for a specific service" -> Predefined role
- "no predefined role fits exactly" -> Custom role
- "app/service identity, not a human" -> Service Account
- "automatic failover on zone outage for Cloud SQL" -> `--availability-type=REGIONAL`
- "read replica configuration" -> `--replica-type` or `--master-instance-name`
- "choose which zone the standby lives in" -> `--secondary-zone` (only works with availability-type=REGIONAL already set)

## Cost And Governance Signals

- "prevent overspend / notify before threshold" -> Budget + Alerts
- "limit resource usage / protect against abuse" -> Quotas
- "see historical spend by project/service" -> Billing Reports
- "cheapest option for single-region only traffic" -> Standard network tier
- "fewest steps / minimize cost / no custom code" -> Fully managed no-code service (e.g. BigQuery Data Transfer Service) over Cloud Functions/Dataflow custom pipeline

## Data Pipeline Signals

- "hourly / slowly changing / scheduled batch / minimize cost / fewest steps" -> BigQuery Data Transfer Service (no-code, managed, scheduled)
- "real-time / react immediately per file / event-driven" -> Cloud Function triggered on `google.storage.object.finalize`
- "complex transform + streaming + batch + custom pipeline logic" -> Dataflow
- "Spark/Hadoop existing jobs" -> Dataproc
- "visual data cleaning before analysis" -> Dataprep
- "orchestrate multi-step data pipeline with dependencies, need Airflow" -> Cloud Composer
- "build simple ML model with only SQL, no data movement out of BigQuery" -> BigQuery ML
- "discover/tag/govern data across systems without moving it" -> Data Catalog or Dataplex

## Application And Security Add-On Signals

- "reliably run a task later with retries/rate limiting, decoupled from request" -> Cloud Tasks
- "orchestrate a sequence of API calls/services, serverless, lightweight" -> Workflows
- "protect web app behind LB from DDoS/SQLi/XSS, block by IP or country" -> Cloud Armor (external Layer 7 LB only)
- "expose serverless backend as managed secured API" -> API Gateway
- "manage Kubernetes consistently across on-prem and multiple clouds" -> Anthos
- "store and rotate API keys/passwords/certs, IAM-controlled" -> Secret Manager
- "create/rotate encryption keys for services" -> Cloud KMS
- "migrate on-prem VMs into Compute Engine" -> Migrate for Compute Engine
- "migrate on-prem database into Cloud SQL with minimal downtime" -> Database Migration Service
- "Google-native IaC, no third-party tool" -> Deployment Manager
- "need dedicated technical account manager / guaranteed fast response" -> Premium support tier

## The One Rule That Covers Almost Everything

When two answers are both technically possible, the correct one is usually:

1. The one matching the exact frequency/scale/security word in the question, not just "a service that could work"
2. The one with fewer manual steps and less custom code, when the question says minimize cost or fewest steps
3. The one that is regional/zonal exactly as stated, not more redundant than asked for
4. The one using the narrowest IAM role or most specific config flag, not the broadest one
