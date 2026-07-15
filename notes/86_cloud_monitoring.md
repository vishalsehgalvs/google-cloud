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

---

## Metric Types

| Type           | Description                                 | Example                           |
| -------------- | ------------------------------------------- | --------------------------------- |
| **Gauge**      | Point-in-time value (no aggregation needed) | CPU utilisation at a moment       |
| **Delta**      | Change over a time interval                 | Request count in the last minute  |
| **Cumulative** | Monotonically increasing total since reset  | Total bytes sent since VM started |

- Delta and cumulative metrics need an **alignment function** (rate, delta) before charting

---

## SLOs and Error Budgets

**Service Level Objective (SLO):** a target reliability goal (e.g. 99.9% availability).

**Error budget:** the allowed downtime/failures before the SLO is breached.

```
Error budget = 1 - SLO
99.9% SLO → 0.1% budget = ~43.8 min/month of allowed downtime
```

Cloud Monitoring supports SLO monitoring via the **Service Monitoring** section:

- Define a service and its SLI (request-based or window-based)
- Set the SLO percentage and rolling window
- Alert when error budget burn rate is too high

---

## Alerting Policy Details

### Notification Channels

| Channel       | Setup                             |
| ------------- | --------------------------------- |
| **Email**     | Add directly in Console           |
| **PagerDuty** | Provide integration key           |
| **Slack**     | OAuth integration; choose channel |
| **Webhook**   | HTTPS endpoint; payload is JSON   |
| **SMS**       | Via phone number                  |
| **Pub/Sub**   | Route to any downstream system    |

### Alert Conditions

- **Metric threshold** — value crosses a threshold for N consecutive minutes
- **Metric absence** — no data received (e.g. dead VM or broken agent)
- **Log-based metric** — alert when a log pattern exceeds a count
- **Uptime check failure** — HTTP/TCP health check fails from multiple regions

### Maintenance Windows

Suppress alerts during planned maintenance so on-call teams aren't paged:

```bash
gcloud alpha monitoring policies update POLICY_ID \
  --add-notification-channel=CHANNEL_ID
# Maintenance windows configured in Console (Cloud Monitoring > Alerting > Maintenance windows)
```

---

## Monitoring Query Language (MQL)

MQL is a text-based query language for writing complex metric queries in Cloud Monitoring:

```
fetch gce_instance
| metric 'compute.googleapis.com/instance/cpu/utilization'
| filter resource.zone = 'us-central1-a'
| align mean_aligner()
| every 1m
| mean
```

- More powerful than the GUI-based chart builder
- Supports joins, ratios, and multi-resource aggregations
- Used in both dashboards and alerting policies

---

## Ops Agent

The **Ops Agent** is the recommended agent for Compute Engine VMs (replaces the old Stackdriver Logging and Monitoring agents):

- Collects **system metrics** (CPU, memory, disk, network) and **logs** in one agent
- Configured via `/etc/google-cloud-ops-agent/config.yaml`
- Supports log parsing (syslog, Apache, Nginx, custom)

```bash
# Install Ops Agent
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install
sudo systemctl status google-cloud-ops-agent
```

---

## Key Takeaways — Cloud Monitoring

| Topic                      | Key Point                                               |
| -------------------------- | ------------------------------------------------------- |
| **Gauge/Delta/Cumulative** | Choose correct alignment before aggregating metrics     |
| **SLOs**                   | Define SLI → SLO → alert on error budget burn rate      |
| **Notification channels**  | PagerDuty/Slack/Webhook all supported natively          |
| **MQL**                    | Use for complex multi-resource queries or ratio metrics |
| **Ops Agent**              | Replaces legacy agents; collects metrics + logs in one  |
| **Maintenance windows**    | Suppress noisy alerts during planned downtime           |

## ACE Exam-Style Practice Questions

### Q1
A Cloud Monitoring requirement asks to collect logs from all current and future production projects only. What should you do?

A. Configure manual exports in each project every month
B. Configure aggregated log sink at production folder level
C. Disable Cloud Logging and use VM files
D. Send logs to Cloud DNS

Answer: B
Trap: Folder-level aggregated sinks capture both existing and future child projects.

### Q2
In a Cloud Monitoring incident, only a few requests are slow across many microservices. Which tool is best to identify the slow hop?

A. Cloud Trace
B. Cloud Storage lifecycle
C. Cloud Build trigger
D. Cloud Armor policy

Answer: A
Trap: Distributed tracing is designed for per-hop latency diagnosis.
