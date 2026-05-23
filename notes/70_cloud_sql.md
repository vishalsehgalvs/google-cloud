# Cloud SQL

## Managed vs Self-Managed

| Approach            | Details                                                                                      |
| ------------------- | -------------------------------------------------------------------------------------------- |
| Self-managed (VM)   | Install MySQL/PostgreSQL/SQL Server on a Compute Engine VM; you manage patching, backups, HA |
| Cloud SQL (managed) | Google handles patches, updates, replication, backups; you manage database users             |

---

## What Is Cloud SQL?

- Fully managed service for **MySQL**, **PostgreSQL**, or **Microsoft SQL Server**
- Patches and updates applied automatically
- You still manage database users via native auth tools

### Supported Clients

- Cloud Shell, App Engine, Google Workspace scripts
- SQL Workbench, Toad, any app using standard MySQL/PostgreSQL drivers

---

## Performance & Scale

| Resource      | Limit                     |
| ------------- | ------------------------- |
| Storage       | Up to 64 TB               |
| IOPS          | Up to 60,000              |
| RAM           | Up to 624 GB per instance |
| CPU cores     | Up to 96 (scale up)       |
| Read replicas | Yes (scale out)           |

---

## Supported Versions

| Engine     | Versions                                          |
| ---------- | ------------------------------------------------- |
| MySQL      | 5.6, 5.7, 8.0                                     |
| PostgreSQL | 9.6, 10, 11, 12, 13, 14, 15                       |
| SQL Server | Web, Express, Standard, Enterprise — 2017 or 2019 |

---

## High Availability (HA)

- Regional instance = **primary** + **standby** instance across two zones
- Writes are **synchronously replicated** to persistent disks in both zones before being committed
- On instance or zone failure → persistent disk attaches to standby → standby becomes new primary
- Users are rerouted automatically — this is called a **failover**

---

## Other Features

| Feature                | Details                                                     |
| ---------------------- | ----------------------------------------------------------- |
| Backups                | Automated and on-demand backups                             |
| Point-in-time recovery | Restore to any point in time                                |
| Import/Export          | `mysqldump` or CSV files                                    |
| Scaling                | Scale up (requires restart) or scale out with read replicas |

> For **horizontal scalability**, consider **Spanner** instead.

---

## Connection Types

| Scenario                                       | Recommended Connection                                                          |
| ---------------------------------------------- | ------------------------------------------------------------------------------- |
| App in same project & region as Cloud SQL      | **Private IP** — never exposed to internet; most performant & secure            |
| App in different region/project or outside GCP | **Cloud SQL Auth Proxy** — handles auth, encryption, key rotation automatically |
| Need manual SSL control                        | Generate and rotate certificates yourself                                       |
| Simple/dev use case                            | Authorize a specific IP over external IP (unencrypted)                          |

---

## Relational Database Decision Tree

```
Need microsecond response / traffic spikes (gaming, real-time)?
  └─ Yes → Memorystore (in-memory)
  └─ No  → Is the workload primarily analytics?
              └─ Yes → BigQuery
              └─ No  → Do you need horizontal scaling or global availability?
                          └─ Yes → Spanner
                          └─ No  → Cloud SQL (cost-effective)
```

---

## gcloud Commands

```bash
# List Cloud SQL instances
gcloud sql instances list

# Create a MySQL instance
gcloud sql instances create my-instance \
  --database-version=MYSQL_8_0 \
  --tier=db-n1-standard-2 \
  --region=us-central1

# Create a PostgreSQL instance
gcloud sql instances create my-pg-instance \
  --database-version=POSTGRES_15 \
  --tier=db-n1-standard-2 \
  --region=us-central1

# Enable High Availability on an instance
gcloud sql instances patch my-instance \
  --availability-type=REGIONAL

# Create a database inside an instance
gcloud sql databases create my-database --instance=my-instance

# Connect to an instance via Cloud SQL Auth Proxy (download proxy first)
./cloud-sql-proxy my-project:us-central1:my-instance

# Create a backup
gcloud sql backups create --instance=my-instance

# List backups
gcloud sql backups list --instance=my-instance

# Create a read replica
gcloud sql instances create my-replica \
  --master-instance-name=my-instance \
  --region=us-central1

# Scale up instance tier
gcloud sql instances patch my-instance --tier=db-n1-standard-4

# Import from Cloud Storage (CSV)
gcloud sql import csv my-instance gs://my-bucket/data.csv \
  --database=my-database \
  --table=my-table

# Export to Cloud Storage
gcloud sql export csv my-instance gs://my-bucket/export.csv \
  --database=my-database \
  --query="SELECT * FROM my-table"

# Delete an instance
gcloud sql instances delete my-instance
```
