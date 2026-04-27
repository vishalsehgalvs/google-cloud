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
