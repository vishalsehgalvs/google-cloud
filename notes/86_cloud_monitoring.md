# Cloud Monitoring

## What Is Cloud Monitoring?

- Foundation of **Site Reliability Engineering (SRE)** — applies software engineering to operations for ultra-scalable, highly reliable systems
- Dynamically configures monitoring after resources are deployed
- Ingests **metrics, events, and metadata** to generate insights via dashboards, charts, and alerts

---

## Metrics Scope

- The **root entity** that holds monitoring and configuration in Cloud Monitoring
- Each metrics scope can monitor **1 to 375 projects**
- The first project added = **scoping project** (its name becomes the scope name)
- Contains: custom dashboards, alerting policies, uptime checks, notification channels, group definitions
- Metric data and log entries **remain in individual projects** — the scope just provides a unified view
- Acts as a **single pane of glass** across multiple GCP projects and AWS accounts

### Access Control Note

All users with access to a metrics scope see all data by default. A role assigned on one project applies equally to all monitored projects. To give different roles per project, place them in **separate metrics scopes**.

### AWS Support

Configure a Google Cloud project to hold an **AWS Connector** to monitor AWS accounts.

---

## Dashboards and Charts

- Create custom dashboards with charts for any metric
- Example metrics:
  - CPU utilization
  - Network packets/bytes sent and received
  - Packets/bytes dropped by firewall
- Customize charts with:
  - **Filters** — remove noise
  - **Groups** — reduce number of time series
  - **Aggregates** — combine multiple time series

---

## Alerting Policies

Notify you when specific conditions are met — without needing someone to watch dashboards 24/7.

### Example Alert

- Trigger: VM network egress exceeds a threshold for a specific timeframe
- Notification channels: email, SMS, or other channels

### Alerting Best Practices

| Best Practice                      | Detail                                                   |
| ---------------------------------- | -------------------------------------------------------- |
| Alert on symptoms, not causes      | Monitor failing DB queries → then identify if DB is down |
| Use multiple notification channels | Email + SMS — avoid single point of failure              |
| Customize alerts for the audience  | Describe what actions to take or what to examine         |
| Avoid noise                        | Only set actionable alerts; don't alert on everything    |

---

## Uptime Checks

Test availability of public services from locations around the world.

| Setting        | Options                                                                          |
| -------------- | -------------------------------------------------------------------------------- |
| Protocol       | HTTP, HTTPS, TCP                                                                 |
| Resource types | App Engine app, Compute Engine instance, URL/host, AWS instance or load balancer |
| Check interval | e.g. every 1 minute                                                              |
| Timeout        | e.g. 10 seconds (no response = failure)                                          |

- Each uptime check can have an associated alerting policy
- View latency per global check location

---

## Ops Agent (Data Collection for Compute Engine)

The hypervisor **cannot** access internal VM metrics (e.g. memory usage) — the **Ops Agent** fills that gap.

- **Primary agent** for collecting telemetry from Compute Engine instances
- Installed on the VM; collects data beyond system-level metrics
- Supports monitoring many third-party applications
- Supports: CentOS, Ubuntu, Windows, and most major OS

```
Compute Engine VM
  └─ Ops Agent
        └─ Collects metrics (CPU, memory, disk, app-specific)
              └─ Cloud Monitoring
                    └─ Dashboards, Alerts, Uptime Checks, Notifications
```

---

## Custom Metrics

Use when standard metrics don't fit your needs.

**Example:** A game server with a 50-user capacity.

- Standard approach: use CPU or network load as a proxy for user count
- Better approach: pass **current user count directly** from the app into Cloud Monitoring as a custom metric

### Custom Metrics + Autoscaling

| Scenario                                 | Autoscaler behavior                                          |
| ---------------------------------------- | ------------------------------------------------------------ |
| Metric comes from each VM in a MIG       | Takes average across all VMs; compares to utilization target |
| Metric applies to whole MIG (not per VM) | Compares metric value directly to utilization target         |
| Metric has multiple values               | Apply a filter to autoscale on a specific individual value   |

- Autoscaler **creates VMs** when metric > target
- Autoscaler **deletes VMs** when metric < target

---

## gcloud Commands

```bash
# List uptime checks
gcloud monitoring uptime list-configs

# Create an alerting policy from a JSON file
gcloud alpha monitoring policies create --policy-from-file=policy.json

# List alerting policies
gcloud alpha monitoring policies list

# List monitored resource descriptors
gcloud monitoring resource-descriptors list

# Install Ops Agent on a Compute Engine VM (run on the VM)
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install

# Check Ops Agent status (run on the VM)
sudo systemctl status google-cloud-ops-agent

# List Cloud Monitoring dashboards
gcloud monitoring dashboards list

# Create a dashboard from a JSON file
gcloud monitoring dashboards create --config-from-file=dashboard.json
```
