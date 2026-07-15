# 🏷️ Cloud Storage Classes & Data Movement

## Four Primary Storage Classes

| Class        | Best for / Access Pattern             | Min. Duration | Example Use Cases                  |
| ------------ | ------------------------------------- | ------------- | ---------------------------------- |
| **Standard** | Frequently accessed ("hot") data      | None          | Active content, short-term storage |
| **Nearline** | Infrequently accessed (~1/mo or less) | 30 days       | Backups, archives, long-tail media |
| **Coldline** | Rarely accessed (~1/90 days or less)  | 90 days       | Disaster recovery, archival        |
| **Archive**  | Accessed <1/year, lowest cost         | 365 days      | Deep archive, compliance, DR       |

- All classes: unlimited storage, no min object size, global access, low latency, high durability, uniform security/tools/APIs, geo-redundancy (multi/dual-region)

---

## Autoclass

- Automatically transitions objects to the right storage class based on access patterns
- Moves cold data to cheaper classes, hot data to Standard
- Simplifies cost savings

---

## Security & Cost

- No minimum fee — pay only for what you use
- No need to pre-provision capacity
- Data is always encrypted at rest (server-side) and in transit (HTTPS/TLS)

---

## Data Ingestion & Transfer

- **gcloud storage** (Cloud SDK) — command-line uploads
- **Cloud Console** — drag-and-drop (in Chrome)
- **Storage Transfer Service** — schedule/manage large online transfers (from other clouds, regions, HTTP(S))
- **Transfer Appliance** — lease a physical device, load data, ship to Google for upload (up to 1 PB per appliance)
- **Tight integration** with other Google Cloud products (BigQuery, Cloud SQL, App Engine, Firestore, Compute Engine, etc.)

## ACE Exam-Style Practice Questions

### Q1
In a Cloud Storage Classes scenario, files are used continually by an analytics pipeline in one region. Which storage class is best for minimal cost and performance fit?

A. Standard in closest region
B. Nearline in closest region
C. Archive in dual-region
D. Coldline in dual-region

Answer: A
Trap: Continual access generally means Standard, while colder classes penalize frequent retrieval.

### Q2
Backup files older than 90 days must be removed automatically in a Cloud Storage Classes bucket. What should you do?

A. Manual deletion script only
B. Lifecycle rule in JSON with Delete action and Age condition 90
C. Rename old files to another prefix only
D. Disable object versioning

Answer: B
Trap: Lifecycle rules are the managed and auditable approach for retention cleanup.

<!-- ACE_DEEP_ENRICHMENT_START -->
## ACE Deep Enrichment

### Think Like a Google Engineer
- Primary optimization axis: Durability and access-pattern fit at the lowest lifecycle cost.
- Start with constraints first: SLO, security, compliance, latency, budget, and team operations capacity.
- Prefer managed services if they satisfy requirements with lower long-term operational toil.
- Minimize blast radius using environment isolation, least privilege, and failure-domain awareness.
- Design for day-2 operations: observability, rollback strategy, and quota or budget guardrails.

### Most Correct Option Filter (60 Seconds)
1. Eliminate options with broad access, single points of failure, or missing monitoring.
2. Confirm the option meets non-negotiables first: security and reliability requirements.
3. Compare remaining options on operational simplicity and long-term maintainability.
4. Use cost as an optimizer only after requirements and risk controls are satisfied.

### Weighted Decision Matrix
| Dimension | Weight | Strong Signal |
| --- | --- | --- |
| Security | 3 | Least privilege, secure defaults, no exposed blast radius |
| Reliability | 3 | Multi-zone or HA design, health checks, tested recovery path |
| Operability | 2 | Clear monitoring, alerting, rollout and rollback simplicity |
| Cost Efficiency | 2 | Right-sized resources, no waste, no reliability regression |
| Performance | 1 | Meets latency and throughput targets with headroom |

### Real-Life Scenario
A healthcare SaaS stores user documents, transactional data, and low-latency session state. They must balance cost, durability, and performance under compliance constraints.

### Worked Example
- Map each data type to the right storage service by access pattern and consistency needs.
- Use lifecycle policies for object storage to control long-term cost.
- Select database engines based on query shape, scale, and relational requirements.
- Back up critical datasets and validate restore runbooks regularly.

### Flowchart
```mermaid
flowchart TD
    A[Data Requirement] --> B{Object, Relational, or NoSQL?}
    B -->|Object| C[Cloud Storage + Lifecycle]
    B -->|Relational| D[Cloud SQL or AlloyDB]
    B -->|NoSQL| E[Firestore or Bigtable]
    C --> F{Access Frequency?}
    F -->|Hot| G[Standard Class]
    F -->|Cold| H[Nearline or Archive]
    D --> I[Backup and HA Strategy]
    E --> I
    G --> I
    H --> I
```

### Optimization Decision Flow
```mermaid
flowchart TD
    A[Read Requirement] --> B[Identify Hard Constraints]
    B --> C{Security and Reliability Met?}
    C -->|No| D[Reject Option]
    C -->|Yes| E[Score Operability and Cost]
    E --> F{Managed Service Meets Needs?}
    F -->|Yes| G[Prefer Managed Path]
    F -->|No| H[Use Custom Design with Guardrails]
    G --> I[Validate Observability and Rollback]
    H --> I
    I --> J[Pick Highest Weighted Score]
```

### Interaction Sequence
```mermaid
sequenceDiagram
    participant App
    participant Storage
    participant DB
    participant Backup
    App->>Storage: Upload object
    Storage-->>App: Return object path
    App->>DB: Write metadata record
    DB-->>App: Commit transaction
    DB->>Backup: Schedule snapshot
```

### Extra Exam Practice (15 Questions)
#### Q1

Scenario Focus: 🏷️ Cloud Storage Classes & Data Movement

Your logs are rarely accessed after 90 days. What storage policy is best?

A. Use lifecycle rules to transition objects to colder storage classes after 90 days.  
B. Keep everything in the most expensive hot class forever.  
C. Use local disk snapshots as the only backup strategy.  
D. Pick a database only by familiarity and ignore access patterns.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q2

Scenario Focus: 🏷️ Cloud Storage Classes & Data Movement

A workload requires relational transactions and managed operations. Which database is best?

A. Use local disk snapshots as the only backup strategy.  
B. Use Cloud SQL or AlloyDB for managed relational workloads with transaction support.  
C. Pick a database only by familiarity and ignore access patterns.  
D. Store transactional records only in object storage.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q3

Scenario Focus: 🏷️ Cloud Storage Classes & Data Movement

Which practice improves durability and recovery posture most?

A. Pick a database only by familiarity and ignore access patterns.  
B. Store transactional records only in object storage.  
C. Enable backups with tested restore procedures and clear recovery objectives.  
D. Skip restore drills because backups are assumed valid.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q4

Scenario Focus: 🏷️ Cloud Storage Classes & Data Movement

A key-value workload needs very high scale and low latency. Which service fits?

A. Store transactional records only in object storage.  
B. Skip restore drills because backups are assumed valid.  
C. Keep everything in the most expensive hot class forever.  
D. Use Bigtable for high-throughput low-latency wide-column workloads.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q5

Scenario Focus: 🏷️ Cloud Storage Classes & Data Movement

How should you choose a storage class on the exam?

A. Choose based on access frequency, retention period, and retrieval latency requirements.  
B. Skip restore drills because backups are assumed valid.  
C. Keep everything in the most expensive hot class forever.  
D. Use local disk snapshots as the only backup strategy.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q6

Scenario Focus: 🏷️ Cloud Storage Classes & Data Movement

Two designs both satisfy the happy path for 🏷️ Cloud Storage Classes & Data Movement. Which choice is most correct?

A. Keep everything in the most expensive hot class forever.  
B. Choose the option that preserves reliability and security while reducing operational burden.  
C. Use local disk snapshots as the only backup strategy.  
D. Pick a database only by familiarity and ignore access patterns.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q7

Scenario Focus: 🏷️ Cloud Storage Classes & Data Movement

What should you validate first before choosing an architecture for 🏷️ Cloud Storage Classes & Data Movement?

A. Use local disk snapshots as the only backup strategy.  
B. Pick a database only by familiarity and ignore access patterns.  
C. Validate SLO fit, blast radius, and least-privilege controls before comparing convenience.  
D. Store transactional records only in object storage.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q8

Scenario Focus: 🏷️ Cloud Storage Classes & Data Movement

A proposal lowers cost but increases failure risk. What is the best decision?

A. Pick a database only by familiarity and ignore access patterns.  
B. Store transactional records only in object storage.  
C. Skip restore drills because backups are assumed valid.  
D. Reject it unless reliability and recovery objectives remain within required targets.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q9

Scenario Focus: 🏷️ Cloud Storage Classes & Data Movement

Which option best reflects optimization for Durability and access-pattern fit at the lowest lifecycle cost?

A. Select the design that best meets Durability and access-pattern fit at the lowest lifecycle cost while keeping constraints balanced.  
B. Store transactional records only in object storage.  
C. Skip restore drills because backups are assumed valid.  
D. Keep everything in the most expensive hot class forever.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q10

Scenario Focus: 🏷️ Cloud Storage Classes & Data Movement

How should you evaluate a design that needs frequent manual interventions?

A. Skip restore drills because backups are assumed valid.  
B. Treat it as high risk and prefer automation-friendly designs with observability and rollback.  
C. Keep everything in the most expensive hot class forever.  
D. Use local disk snapshots as the only backup strategy.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q11

Scenario Focus: 🏷️ Cloud Storage Classes & Data Movement

Two options have similar latency. Which tie-breaker is best?

A. Keep everything in the most expensive hot class forever.  
B. Use local disk snapshots as the only backup strategy.  
C. Pick the option with stronger operability, clearer failure isolation, and simpler incident response.  
D. Pick a database only by familiarity and ignore access patterns.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q12

Scenario Focus: 🏷️ Cloud Storage Classes & Data Movement

What is the best way to choose between a custom stack and a managed service?

A. Use local disk snapshots as the only backup strategy.  
B. Pick a database only by familiarity and ignore access patterns.  
C. Store transactional records only in object storage.  
D. Prefer managed services when they meet requirements with lower long-term maintenance effort.

Answer: D  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q13

Scenario Focus: 🏷️ Cloud Storage Classes & Data Movement

How do you confirm a solution is production-ready for 

A. Verify monitoring, alerting, rollback path, quota and budget controls, and secure defaults.  
B. Pick a database only by familiarity and ignore access patterns.  
C. Store transactional records only in object storage.  
D. Skip restore drills because backups are assumed valid.

Answer: A  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q14

Scenario Focus: 🏷️ Cloud Storage Classes & Data Movement

Which pattern usually wins in ACE scenario tie-breakers?

A. Store transactional records only in object storage.  
B. Managed-service-first plus least-privilege access plus clear observability usually wins.  
C. Skip restore drills because backups are assumed valid.  
D. Keep everything in the most expensive hot class forever.

Answer: B  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q15

Scenario Focus: 🏷️ Cloud Storage Classes & Data Movement

What is the best final check before locking the answer?

A. Skip restore drills because backups are assumed valid.  
B. Keep everything in the most expensive hot class forever.  
C. Run a weighted check across security, reliability, cost, performance, and operability.  
D. Use local disk snapshots as the only backup strategy.

Answer: C  
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.  
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

### Quick Commands
```bash
gcloud storage ls --project=PROJECT_ID
gcloud sql instances list --project=PROJECT_ID
gcloud firestore databases list --project=PROJECT_ID
gcloud bigtable instances list --project=PROJECT_ID
```

### Fast Recall
- Data service choice is a pattern-matching question.
- Lifecycle rules are a common cost optimization lever.
- Backup without restore validation is not a complete strategy.
<!-- ACE_DEEP_ENRICHMENT_END -->