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
