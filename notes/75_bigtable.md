# Bigtable

## What Is Bigtable?

- Fully managed **NoSQL database** with **petabyte-scale** and very low latency
- The same database that powers Google Search, Analytics, Maps, and Gmail
- Seamlessly scales for throughput; **learns and adapts to specific access patterns**

---

## Use Cases

- IoT data ingestion
- User analytics
- Financial data analysis
- Machine learning storage engine
- Any workload needing **high read/write throughput at low latency**

---

## Key Features

| Feature            | Detail                                                |
| ------------------ | ----------------------------------------------------- |
| Scale              | Petabytes of data                                     |
| Latency            | Sub-10ms read/write                                   |
| Throughput scaling | Linear — each node added = linear throughput increase |
| Consistency        | Strong consistency                                    |
| HBase API          | Supports open source HBase API                        |
| Integrations       | Hadoop, Dataflow, Dataproc                            |
| Sparse tables      | Empty cells take up no space                          |

---

## Data Model

- Data stored in **massively scalable sorted key/value tables**
- Each **row** describes a single entity, indexed by a **row key**
- Related columns grouped into **column families**
- Each column identified by: `column family` + `column qualifier`
- Each row/column intersection can have **multiple cells at different timestamps** (versioning)
- Tables are **sparse** — empty cells consume no storage

### Example (Presidents Social Network)

```
Row Key (username) | follows:georgewashington | follows:johnadams | follows:jefferson
-------------------+--------------------------+-------------------+------------------
abrahamlincoln     | 1                        |                   | 1
ulyssesgrant       |                          | 1                 |
```

- Column qualifiers used as data (sparseness advantage)
- Evenly distributed row keys (e.g. alphabetical usernames) → uniform data access

---

## Architecture

```
Client Requests
      │
      ▼
Frontend Server Pool + Nodes   ← processing layer (separate from storage)
      │
      ▼
Tablets (sharded row blocks)   ← balance query workload across nodes
      │
      ▼
Colossus (Google File System)  ← stored as SSTables
                                  (persistent, ordered, immutable key/value map)
```

- **Tablets** = blocks of contiguous rows, similar to HBase regions
- **SSTable** = ordered immutable map of keys → values (arbitrary byte strings)
- Bigtable automatically rebalances tablets across nodes based on access patterns

---

## Throughput Scaling

- Scales **linearly** with nodes added
- Minimum cluster: **3 nodes** → handles ~**30,000 operations/second**
- You pay for nodes whether your app is using them or not (unlike Firestore which scales to zero)

---

## When to Use Bigtable — Decision Tree

```
Need to store > 1 TB of structured data? OR
Have very high volume of writes? OR
Need read/write latency < 10ms with strong consistency? OR
Need HBase API compatibility?
  └─ Yes → Bigtable

  └─ No → Need a service that scales down to zero?
              └─ Yes → Firestore
```

---

## Bigtable vs Firestore

|                           | Bigtable                      | Firestore              |
| ------------------------- | ----------------------------- | ---------------------- |
| Type                      | NoSQL wide-column             | NoSQL document         |
| Scale                     | Petabytes                     | Terabytes              |
| Latency                   | Sub-10ms                      | Low                    |
| Minimum cost              | Always-on nodes (min 3)       | Scales to zero         |
| Transactional consistency | Not required                  | Supported (ACID)       |
| HBase API                 | ✅                            | ❌                     |
| Best for                  | High-throughput analytics/IoT | Mobile/web/server apps |

---

## gcloud Commands

```bash
# List Bigtable instances
gcloud bigtable instances list

# Create a Bigtable instance
gcloud bigtable instances create my-instance \
  --display-name="My Bigtable Instance" \
  --cluster=my-cluster \
  --cluster-zone=us-central1-a \
  --cluster-num-nodes=3

# List clusters in an instance
gcloud bigtable clusters list --instances=my-instance

# Create a table
gcloud bigtable instances tables create my-table \
  --instance=my-instance

# List tables in an instance
gcloud bigtable instances tables list --instances=my-instance

# Add a column family to a table
gcloud bigtable instances tables create my-table \
  --instance=my-instance \
  --column-families=follows

# Scale cluster (add/remove nodes)
gcloud bigtable clusters update my-cluster \
  --instance=my-instance \
  --num-nodes=5

# Delete a Bigtable instance
gcloud bigtable instances delete my-instance
```

## ACE Exam-Style Practice Questions

### Q1
A Bigtable use case ingests timestamped sensor data at very high write rates with low-latency reads. Which service is best?

A. Cloud SQL
B. Bigtable
C. Cloud Storage
D. Firestore

Answer: B
Trap: High-ingest time-series workloads are a classic Bigtable pattern.

### Q2
For Bigtable schema design, what is a key performance practice?

A. Use random keys that break query patterns
B. Design row keys to match primary access pattern and avoid hotspots
C. Store only in one giant JSON column
D. Disable column families

Answer: B
Trap: Row-key design directly influences distribution and query performance.

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

### Extra Exam Practice (10 Questions)
#### Q1
Scenario Focus: Bigtable
Your logs are rarely accessed after 90 days. What storage policy is best?

A. Use lifecycle rules to transition objects to colder storage classes after 90 days.
B. Keep everything in the most expensive hot class forever.
C. Use local disk snapshots as the only backup strategy.
D. Pick a database only by familiarity and ignore access patterns.

Answer: A
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q2
Scenario Focus: Bigtable
A workload requires relational transactions and managed operations. Which database is best?

A. Use local disk snapshots as the only backup strategy.
B. Use Cloud SQL or AlloyDB for managed relational workloads with transaction support.
C. Pick a database only by familiarity and ignore access patterns.
D. Store transactional records only in object storage.

Answer: B
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q3
Scenario Focus: Bigtable
Which practice improves durability and recovery posture most?

A. Pick a database only by familiarity and ignore access patterns.
B. Store transactional records only in object storage.
C. Enable backups with tested restore procedures and clear recovery objectives.
D. Skip restore drills because backups are assumed valid.

Answer: C
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q4
Scenario Focus: Bigtable
A key-value workload needs very high scale and low latency. Which service fits?

A. Store transactional records only in object storage.
B. Skip restore drills because backups are assumed valid.
C. Keep everything in the most expensive hot class forever.
D. Use Bigtable for high-throughput low-latency wide-column workloads.

Answer: D
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q5
Scenario Focus: Bigtable
How should you choose a storage class on the exam?

A. Choose based on access frequency, retention period, and retrieval latency requirements.
B. Skip restore drills because backups are assumed valid.
C. Keep everything in the most expensive hot class forever.
D. Use local disk snapshots as the only backup strategy.

Answer: A
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q6
Scenario Focus: Bigtable
Two designs both satisfy the happy path for Bigtable. Which choice is most correct?

A. Keep everything in the most expensive hot class forever.
B. Choose the option that preserves reliability and security while reducing operational burden.
C. Use local disk snapshots as the only backup strategy.
D. Pick a database only by familiarity and ignore access patterns.

Answer: B
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q7
Scenario Focus: Bigtable
What should you validate first before choosing an architecture for Bigtable?

A. Use local disk snapshots as the only backup strategy.
B. Pick a database only by familiarity and ignore access patterns.
C. Validate SLO fit, blast radius, and least-privilege controls before comparing convenience.
D. Store transactional records only in object storage.

Answer: C
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q8
Scenario Focus: Bigtable
A proposal lowers cost but increases failure risk. What is the best decision?

A. Pick a database only by familiarity and ignore access patterns.
B. Store transactional records only in object storage.
C. Skip restore drills because backups are assumed valid.
D. Reject it unless reliability and recovery objectives remain within required targets.

Answer: D
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q9
Scenario Focus: Bigtable
Which option best reflects optimization for Durability and access-pattern fit at the lowest lifecycle cost?

A. Select the design that best meets Durability and access-pattern fit at the lowest lifecycle cost while keeping constraints balanced.
B. Store transactional records only in object storage.
C. Skip restore drills because backups are assumed valid.
D. Keep everything in the most expensive hot class forever.

Answer: A
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q10
Scenario Focus: Bigtable
How should you evaluate a design that needs frequent manual interventions?

A. Skip restore drills because backups are assumed valid.
B. Treat it as high risk and prefer automation-friendly designs with observability and rollback.
C. Keep everything in the most expensive hot class forever.
D. Use local disk snapshots as the only backup strategy.

Answer: B
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