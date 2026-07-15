# Cloud Spanner

## What Is Spanner?

- Fully managed **relational database** with **non-relational horizontal scale**
- Built specifically for the cloud
- Combines: schemas, SQL, strong consistency + high availability, horizontal scaling, global replication

### Key Stats

- Capacity: up to **petabytes**
- Replication: **automatic synchronous** replication across zones/regions
- Consistency: **transactional consistency at global scale**
- SLA: differs for regional vs multi-regional instances (check docs for current numbers)

---

## Spanner vs Relational vs Non-Relational

| Feature                  | Relational DB | Non-Relational DB | Spanner |
| ------------------------ | ------------- | ----------------- | ------- |
| Schema                   | ✅            | ❌                | ✅      |
| SQL                      | ✅            | ❌                | ✅      |
| Strong consistency       | ✅            | ❌                | ✅      |
| High availability        | ❌ (limited)  | ✅                | ✅      |
| Horizontal scalability   | ❌            | ✅                | ✅      |
| Configurable replication | ❌            | ✅                | ✅      |

> Spanner gives you the best of both worlds.

---

## Architecture

- A Spanner instance replicates data across **N cloud zones** (one region or multiple regions)
- Database placement is **configurable** — you choose the region
- Replication synchronized via **Google's global fiber network**
- Uses **atomic clocks** to ensure atomicity during updates

---

## Use Cases

- Financial applications (transactions, payments)
- Inventory management (retail)
- Any mission-critical system requiring global consistency

---

## When to Use Spanner — Decision Tree

```
Have you outgrown your relational DB? OR
Are you sharding databases for throughput? OR
Do you need transactional consistency + global data + strong consistency? OR
Want to consolidate multiple databases?
  └─ Yes → Spanner

  └─ No → Do you need full relational capabilities?
              └─ No → Consider NoSQL (e.g. Firestore)
              └─ Yes → Cloud SQL (if no horizontal scale needed)
```

---

## Spanner vs Cloud SQL

|                     | Cloud SQL                           | Spanner                          |
| ------------------- | ----------------------------------- | -------------------------------- |
| Scale               | Vertical (scale up) + read replicas | Horizontal (truly distributed)   |
| Capacity            | Up to 64 TB                         | Petabytes                        |
| Global availability | Regional                            | Regional or multi-regional       |
| Use case            | Standard web/app databases          | Global, mission-critical systems |
| Cost                | Lower                               | Higher                           |

> If you're currently using MySQL and want to migrate to Spanner, refer to the official migration documentation.

---

## gcloud Commands

```bash
# List Spanner instances
gcloud spanner instances list

# Create a Spanner instance (regional)
gcloud spanner instances create my-instance \
  --config=regional-us-central1 \
  --description="My Spanner Instance" \
  --nodes=1

# Create a Spanner instance (multi-regional)
gcloud spanner instances create my-global-instance \
  --config=nam6 \
  --description="Multi-region Spanner" \
  --nodes=3

# Create a database inside an instance
gcloud spanner databases create my-database \
  --instance=my-instance

# Run a SQL query
gcloud spanner databases execute-sql my-database \
  --instance=my-instance \
  --sql="SELECT * FROM my-table"

# Describe an instance
gcloud spanner instances describe my-instance

# Delete a Spanner instance
gcloud spanner instances delete my-instance
```

---

## Schema Design

### Interleaved Tables

Spanner co-locates child rows physically next to their parent row — eliminates cross-node joins for parent-child queries:

```sql
CREATE TABLE Singers (
  SingerId INT64 NOT NULL,
  Name     STRING(MAX),
) PRIMARY KEY (SingerId);

CREATE TABLE Albums (
  SingerId  INT64 NOT NULL,
  AlbumId   INT64 NOT NULL,
  Title     STRING(MAX),
) PRIMARY KEY (SingerId, AlbumId),
  INTERLEAVE IN PARENT Singers ON DELETE CASCADE;
```

- Use interleaving when you always query child rows by parent key
- Maximum interleave depth: 7 levels

### Primary Key Design — Avoid Hotspots

Sequential keys (auto-increment integers, timestamps) cause **write hotspots** because all new rows land on the same split:

| Bad (hotspot)             | Good (distributed)                        |
| ------------------------- | ----------------------------------------- |
| `id INT64 AUTO_INCREMENT` | `id STRING(36) DEFAULT (GENERATE_UUID())` |
| `created_at TIMESTAMP`    | Hash prefix + timestamp                   |
| Sequential user IDs       | UUID or bit-reversed keys                 |

### Secondary Indexes

```sql
CREATE INDEX AlbumsByTitle ON Albums(Title);
```

- Indexes are stored as separate tables — writes update both base table and index
- Use `STORING` clause to avoid index-only table lookups:
  ```sql
  CREATE INDEX AlbumsByTitle ON Albums(Title) STORING (SingerId);
  ```

---

## Instance Configuration and Cost

### Instance Types

| Type                    | Use                                           |
| ----------------------- | --------------------------------------------- |
| **Provisioned**         | Fixed node count; predictable cost            |
| **Spanner Autoscaling** | Scales node count automatically based on load |

### Pricing Components

| Component           | Cost driver                                              |
| ------------------- | -------------------------------------------------------- |
| **Compute (nodes)** | Per node per hour (regional cheaper than multi-regional) |
| **Storage**         | Per GB per month                                         |
| **Network egress**  | Charged for cross-region reads                           |

- Regional instance: ~1/3 the cost of multi-regional
- Rule of thumb: start with 1 node per 2 TB of data or 2000 QPS writes

```bash
# Scale up/down node count
gcloud spanner instances update my-instance --nodes=3
```

---

## Backup and Restore

```bash
# Create a backup
gcloud spanner backups create my-backup \
  --instance=my-instance \
  --database=my-database \
  --expiration-date=2025-12-31T23:59:00Z

# Restore from backup
gcloud spanner databases restore my-database-restored \
  --instance=my-instance \
  --source-backup=my-backup \
  --source-instance=my-instance
```

- Backups are stored within the same instance config (regional/multi-regional)
- Retention: configurable, max 1 year
- **Point-in-time recovery** is not supported — use backups + Dataflow for fine-grained recovery

---

## Commit Timestamps and TrueTime

- Spanner assigns a **globally consistent commit timestamp** to every transaction
- Timestamps use **TrueTime** — Google's GPS/atomic-clock-based time API
- This guarantees **external consistency**: if transaction T1 commits before T2 starts, T1's timestamp is always lower
- You can store commit timestamps as columns for automatic audit trails:
  ```sql
  LastUpdated TIMESTAMP OPTIONS (allow_commit_timestamp=true)
  ```

---

## Key Takeaways

- **Interleave** child tables into parents for locality; avoid sequential primary keys to prevent hotspots
- **Secondary indexes** speed up reads but add write overhead — use `STORING` to reduce double lookups
- **Regional** for lower cost; **multi-regional** for global availability and higher SLA
- Use **UUID or hash-prefixed keys** to distribute writes evenly across splits
- Spanner is expensive — only use when Cloud SQL is no longer sufficient (global scale, horizontal sharding, >64 TB)

## ACE Exam-Style Practice Questions

### Q1
A Spanner workload is global, relational, and requires strong consistency with unpredictable growth. Which service is best?

A. Cloud SQL
B. Cloud Spanner
C. Firestore
D. Memorystore

Answer: B
Trap: Global consistency plus horizontal relational scale strongly signals Spanner.

### Q2
You need automatic up and down scaling for a predictable Spanner traffic pattern. What is best?

A. Manual weekly node changes only
B. Monitoring alert to webhook plus Cloud Function that resizes Spanner nodes
C. Ask Google support to resize when alerted
D. Restart application servers nightly

Answer: B
Trap: Automation should be policy-driven and integrated with monitoring, not manual email workflows.
