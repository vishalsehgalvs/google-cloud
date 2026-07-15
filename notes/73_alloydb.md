# AlloyDB for PostgreSQL

## What Is AlloyDB?

- Fully managed, **PostgreSQL-compatible** database service
- Designed for **demanding workloads** — hybrid transactional and analytical processing (HTAP)
- Pairs a **Google-built database engine** with a cloud-based, multi-node architecture

---

## Key Features

| Feature               | Detail                                                                                                          |
| --------------------- | --------------------------------------------------------------------------------------------------------------- |
| Compatibility         | Fully PostgreSQL-compatible                                                                                     |
| Administration        | Automated backups, replication, patching, capacity management                                                   |
| Intelligence          | Adaptive algorithms + ML for vacuum management, storage/memory management, data tiering, analytics acceleration |
| Vertex AI integration | Built-in — call ML models directly from the database                                                            |

---

## Performance

| Metric                  | AlloyDB vs Standard PostgreSQL |
| ----------------------- | ------------------------------ |
| Transactional workloads | **4x faster**                  |
| Analytical queries      | **100x faster**                |

---

## Availability

- **99.99% uptime SLA** — inclusive of maintenance
- High availability built into the architecture

---

## Use Cases

- High transaction throughput (enterprise OLTP)
- Large data sizes requiring PostgreSQL compatibility
- Multiple read replicas
- Real-time business insights alongside transactional data (HTAP)
- Applications needing integrated ML inference via Vertex AI

---

## AlloyDB vs Cloud SQL (PostgreSQL)

|                     | Cloud SQL (PostgreSQL) | AlloyDB                               |
| ------------------- | ---------------------- | ------------------------------------- |
| Engine              | Standard PostgreSQL    | Google-built + PostgreSQL-compatible  |
| Transactional speed | Baseline               | 4x faster                             |
| Analytical speed    | Baseline               | 100x faster                           |
| ML integration      | No                     | Yes (Vertex AI)                       |
| Use case            | Standard apps          | Demanding enterprise / HTAP workloads |
| SLA                 | 99.95%                 | 99.99% (incl. maintenance)            |

---

## gcloud Commands

```bash
# List AlloyDB clusters
gcloud alloydb clusters list --region=us-central1

# Create an AlloyDB cluster
gcloud alloydb clusters create my-cluster \
  --region=us-central1 \
  --password=my-password

# Create a primary instance inside a cluster
gcloud alloydb instances create my-primary \
  --instance-type=PRIMARY \
  --cpu-count=2 \
  --cluster=my-cluster \
  --region=us-central1

# Create a read pool instance
gcloud alloydb instances create my-read-pool \
  --instance-type=READ_POOL \
  --cpu-count=2 \
  --read-pool-node-count=2 \
  --cluster=my-cluster \
  --region=us-central1

# Describe a cluster
gcloud alloydb clusters describe my-cluster --region=us-central1

# Create an on-demand backup
gcloud alloydb backups create my-backup \
  --cluster=my-cluster \
  --region=us-central1

# Delete a cluster
gcloud alloydb clusters delete my-cluster --region=us-central1
```

## ACE Exam-Style Practice Questions

### Q1
In a Alloydb scenario, the team wants PostgreSQL compatibility with strong performance for transactional and analytical mixed workloads. Which service fits best?

A. AlloyDB
B. Cloud SQL for SQL Server
C. Memorystore
D. Cloud Storage

Answer: A
Trap: AlloyDB targets PostgreSQL compatibility with high-performance managed architecture.

### Q2
When comparing Alloydb to self-managed Postgres on VMs, what is a key benefit?

A. More manual patching
B. Reduced operational overhead with managed reliability features
C. No IAM integration
D. Requires custom networking stack

Answer: B
Trap: Managed data services are typically preferred when low operations burden is explicit.
