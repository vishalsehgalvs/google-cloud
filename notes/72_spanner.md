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
