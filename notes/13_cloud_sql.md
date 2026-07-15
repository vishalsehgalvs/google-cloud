# 🗃️ Cloud SQL

## What is Cloud SQL?

- Fully managed **relational database** service
- Supports **MySQL, PostgreSQL, and SQL Server**
- No software installation or maintenance required

---

## What Google Manages for You

- Applying patches and updates
- Managing backups
- Configuring replication

---

## Scale & Capacity

- Up to **128 vCPUs**
- Up to **864 GB RAM**
- Up to **64 TB storage**

---

## Key Features

| Feature         | Details                                                                          |
| --------------- | -------------------------------------------------------------------------------- |
| **Replication** | Supports Cloud SQL primary, external primary, external MySQL                     |
| **Backups**     | Managed backups included (7 backups per instance cost)                           |
| **Encryption**  | Data encrypted on Google's internal networks, in tables, temp files, and backups |
| **Firewall**    | Built-in network firewall for each database instance                             |

---

## Integrations

- **App Engine** — via standard drivers (Connector/J for Java, MySQLdb for Python)
- **Compute Engine** — authorize VMs to access Cloud SQL; can place in the same zone
- **External tools** — SQL Workbench, Toad, and other apps using standard MySQL drivers

---

## gcloud Commands

```bash
# List Cloud SQL instances
gcloud sql instances list

# Create a Cloud SQL instance
gcloud sql instances create my-instance \
  --database-version=MYSQL_8_0 --tier=db-n1-standard-2 --region=us-central1

# Connect to an instance
gcloud sql connect my-instance --user=root

# Create a database
gcloud sql databases create my-db --instance=my-instance

# Delete an instance
gcloud sql instances delete my-instance
```

## ACE Exam-Style Practice Questions

### Q1
In a Cloud Sql scenario, production MySQL must survive zonal failure with minimal manual intervention. What is the best setup?

A. Single-zone instance with snapshots only
B. Cloud SQL with availability type set to REGIONAL
C. Cloud SQL read replica in same zone only
D. Self-managed MySQL on one VM

Answer: B
Trap: Read replicas improve read scale but are not the same as HA failover configuration.

### Q2
For Cloud Sql audit requirements, month-end data must be retained for three years in low-cost storage. What should you do?

A. Rely only on automatic backup retention
B. Create scheduled Cloud SQL export jobs to Archive class Cloud Storage
C. Keep data only in local SSD snapshots
D. Use Cloud NAT logging only

Answer: B
Trap: Long-term audit retention is an export and archive policy problem, not only operational backup.
