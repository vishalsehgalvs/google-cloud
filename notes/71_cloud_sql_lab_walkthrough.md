# Cloud SQL Lab Walkthrough

## Lab Overview

- Create a Cloud SQL (MySQL) instance
- Connect to it via **Cloud SQL Auth Proxy** (external, secure)
- Connect to it via **Private IP** (internal, direct)
- Deploy a WordPress application backed by Cloud SQL

---

## Task 1 — Create a Cloud SQL Instance

1. Navigate to **SQL** → **Create Instance** → **MySQL**
2. Name: `wordpress-db`, set a simple password, region: `us-central1`
3. Expand configuration → **Connectivity** → select **Private IP**
4. Click **Enable API** → **Allocate and Connect** (takes a few minutes)
5. Once IP is allocated, click **Create** (instance creation takes 3–5 min)

> While the instance is creating, you can proceed with other tasks.

---

## Task 2 — Set Up the Proxy VM

Two Compute Engine VMs are pre-created:

- `wordpress-europe-proxy` — for the proxy connection
- `wordpress-private-ip` — for the private IP connection

### On the proxy VM (SSH):

```bash
# Download Cloud SQL Proxy
wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy
chmod +x cloud_sql_proxy

# Set the instance connection name as an env variable
export SQL_CONNECTION=<your-project>:<region>:<instance-name>

# Verify it's set
echo $SQL_CONNECTION

# Start the proxy in the background
./cloud_sql_proxy -instances=$SQL_CONNECTION=tcp:3306 &
# Expected output: Ready for new connections
```

> The instance connection name is found in Cloud SQL → click instance → **Overview** → `Instance connection name`

---

## Task 3 — Create the Database

Once the instance shows a green checkmark:

1. Go to **Cloud SQL** → `wordpress-db` → **Databases** → **Create Database**
2. Name: `wordpress` → **Create**

---

## Task 4 — Connect WordPress via Proxy

1. Get the external IP of the proxy VM: `curl -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip`
2. Open that IP in a browser → WordPress setup page → **Let's Go**
3. Settings:
   - Database name: `wordpress`
   - Username: `root`
   - Password: `password`
   - Database host: `127.0.0.1` (proxy listens on localhost)
4. Submit → **Run the Installation** → fill in site details → **Install WordPress**
5. Navigate to the external IP → WordPress blog loads ✅

> Traffic flows: Browser → VM external IP → proxy on 127.0.0.1 → Cloud SQL Auth Proxy → Cloud SQL instance

---

## Task 5 — Connect WordPress via Private IP

1. Go to **Cloud SQL** → `wordpress-db` → note the **Private IP address**
2. Go to **Compute Engine** → copy external IP of `wordpress-private-ip` VM
3. Open that IP in browser → WordPress setup → **Let's Go**
4. Settings:
   - Database host: `<Cloud SQL private IP>` (instead of 127.0.0.1)
   - Username: `root`, Password: `password`
5. Submit → **Run the Installation** → **Already Installed** (WordPress recognizes the same DB)
6. Navigate to the VM's external IP → same WordPress blog loads ✅

> Traffic flows: VM → Cloud SQL private IP directly (never leaves Google's network)

---

## Key Takeaways

| Connection Type         | When to Use                              | Traffic Path                                   |
| ----------------------- | ---------------------------------------- | ---------------------------------------------- |
| Cloud SQL Auth Proxy    | App in different region, VPC, or project | Encrypted tunnel over external IP              |
| Private IP              | App in same region/VPC as Cloud SQL      | Internal Google network, never public internet |
| Unencrypted external IP | Dev/test only                            | Public internet — not recommended              |

## ACE Exam-Style Practice Questions

### Q1
In a Cloud Sql Lab Walkthrough scenario, production MySQL must survive zonal failure with minimal manual intervention. What is the best setup?

A. Single-zone instance with snapshots only
B. Cloud SQL with availability type set to REGIONAL
C. Cloud SQL read replica in same zone only
D. Self-managed MySQL on one VM

Answer: B
Trap: Read replicas improve read scale but are not the same as HA failover configuration.

### Q2
For Cloud Sql Lab Walkthrough audit requirements, month-end data must be retained for three years in low-cost storage. What should you do?

A. Rely only on automatic backup retention
B. Create scheduled Cloud SQL export jobs to Archive class Cloud Storage
C. Keep data only in local SSD snapshots
D. Use Cloud NAT logging only

Answer: B
Trap: Long-term audit retention is an export and archive policy problem, not only operational backup.
