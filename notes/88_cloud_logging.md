# Cloud Logging

## What Is Cloud Logging?

- Fully managed service to **store, search, analyze, monitor, and alert** on log data and events
- Ingests application and system log data from thousands of VMs
- Works with Google Cloud and AWS

---

## Core Components

| Component     | Description                   |
| ------------- | ----------------------------- |
| Log storage   | Built-in storage for log data |
| Logs Explorer | UI to search and view logs    |
| Logging API   | Manage logs programmatically  |

### What You Can Do

- Read and write log entries
- Search and filter logs
- Create **log-based metrics**
- Set alerts on log data

---

## Log Retention and Export

- Logs are retained for **30 days** by default
- Export to extend retention or enable deeper analysis:

| Export Destination | Use Case                                                                           |
| ------------------ | ---------------------------------------------------------------------------------- |
| **Cloud Storage**  | Long-term retention (> 30 days)                                                    |
| **BigQuery**       | SQL analysis, capacity forecasting, network forensics, Looker Studio visualization |
| **Pub/Sub**        | Stream logs to applications or external endpoints in real time                     |

---

## Exporting to BigQuery — Use Cases

BigQuery runs fast SQL on gigabytes to petabytes — ideal for log analysis:

| Analysis Type              | Example                                                                       |
| -------------------------- | ----------------------------------------------------------------------------- |
| Traffic growth forecasting | Understand how network traffic is growing over time                           |
| Network cost optimization  | Identify expensive traffic patterns                                           |
| Network forensics          | Analyze incidents — find top IP addresses exchanging traffic with your server |
| Access control decisions   | Deny IP addresses that shouldn't access your web server                       |

> Visualize BigQuery log data with **Looker Studio** — transforms raw data into easy-to-read dashboards.

---

## gcloud Commands

```bash
# List log entries (recent logs for a project)
gcloud logging read "resource.type=gce_instance" --limit=10

# Write a log entry
gcloud logging write my-log "This is a test log entry" --severity=INFO

# List log sinks (exports)
gcloud logging sinks list

# Create a log sink to Cloud Storage
gcloud logging sinks create my-storage-sink \
  storage.googleapis.com/my-log-bucket \
  --log-filter='severity>=ERROR'

# Create a log sink to BigQuery
gcloud logging sinks create my-bq-sink \
  bigquery.googleapis.com/projects/my-project/datasets/my_dataset \
  --log-filter='resource.type="gce_instance"'

# Create a log sink to Pub/Sub
gcloud logging sinks create my-pubsub-sink \
  pubsub.googleapis.com/projects/my-project/topics/my-topic

# Delete a log sink
gcloud logging sinks delete my-storage-sink

# List logs available in the project
gcloud logging logs list
```

---

## Log Severity Levels

Cloud Logging uses the following severity levels (ascending order):

| Severity    | Numeric | Use case                                |
| ----------- | ------- | --------------------------------------- |
| `DEFAULT`   | 0       | Unspecified / uncategorised             |
| `DEBUG`     | 100     | Detailed diagnostic info                |
| `INFO`      | 200     | Routine operational events              |
| `NOTICE`    | 300     | Normal but significant events           |
| `WARNING`   | 400     | Events that might cause problems        |
| `ERROR`     | 500     | Error conditions that require attention |
| `CRITICAL`  | 600     | Critical failures                       |
| `ALERT`     | 700     | Action must be taken immediately        |
| `EMERGENCY` | 800     | System is unusable                      |

---

## Structured Logging (JSON Format)

Write structured logs so Cloud Logging can parse and query fields automatically:

```json
{
  "severity": "ERROR",
  "message": "Payment processing failed",
  "httpRequest": {
    "requestMethod": "POST",
    "requestUrl": "/pay",
    "status": 500
  },
  "labels": {
    "env": "production",
    "version": "1.2.3"
  }
}
```

- Write JSON to **stdout** from Cloud Run or GKE — automatically ingested as structured logs
- The `severity` field is mapped to Cloud Logging severity automatically
- Special fields: `httpRequest`, `labels`, `trace`, `spanId`, `sourceLocation`

---

## Ops Agent vs Legacy Logging Agent

| Agent                               | VM support  | Collects                    |
| ----------------------------------- | ----------- | --------------------------- |
| **Ops Agent** (recommended)         | GCE (gen2+) | Logs + metrics in one agent |
| **Cloud Logging agent** (legacy)    | GCE         | Logs only (fluentd-based)   |
| **Cloud Monitoring agent** (legacy) | GCE         | Metrics only                |

- For new VMs: always install the **Ops Agent**
- Cloud Run, GKE, App Engine: automatic log collection, no agent needed

---

## Audit Logs (Detail)

| Type               | What it captures                                                           | Always on?                      |
| ------------------ | -------------------------------------------------------------------------- | ------------------------------- |
| **Admin Activity** | API calls that modify config/metadata (e.g. create VM, grant IAM role)     | Yes (free)                      |
| **Data Access**    | API calls that read/write user data (e.g. read GCS object, query BigQuery) | No (enable per service; billed) |
| **System Event**   | Automated GCP system events (e.g. Live Migration)                          | Yes (free)                      |
| **Policy Denied**  | Requests denied by VPC Service Controls                                    | Yes (free)                      |

```bash
# Query admin activity logs
gcloud logging read \
  'logName="projects/PROJECT_ID/logs/cloudaudit.googleapis.com%2Factivity"' \
  --limit=20
```

---

## Log-Based Metrics

Create custom Cloud Monitoring metrics from log entries:

```bash
# Counter metric: count ERROR logs
gcloud logging metrics create error-count \
  --description="Count of ERROR log entries" \
  --log-filter='severity=ERROR'

# Distribution metric: extract a numeric value from log field
gcloud logging metrics create request-latency \
  --description="Request latency distribution" \
  --log-filter='resource.type="gae_app"' \
  --value-extractor='EXTRACT(jsonPayload.latency)'
```

- After creation, the metric appears in Cloud Monitoring as `logging.googleapis.com/user/METRIC_NAME`
- Use to alert on log patterns (e.g. 5xx spike)

---

## Log Sink Permissions

When you create a log sink, Cloud Logging creates a **service account** for the sink. You must grant it write access to the destination:

| Destination          | Required role                 |
| -------------------- | ----------------------------- |
| Cloud Storage bucket | `roles/storage.objectCreator` |
| BigQuery dataset     | `roles/bigquery.dataEditor`   |
| Pub/Sub topic        | `roles/pubsub.publisher`      |
| Cloud Logging bucket | No extra grant needed         |

```bash
# Get the sink's writer identity
gcloud logging sinks describe my-bq-sink --format='value(writerIdentity)'

# Grant it access to the BigQuery dataset
bq add-iam-policy-binding --member=SERVICE_ACCOUNT --role=roles/bigquery.dataEditor PROJECT:DATASET
```

---

## Log Pricing

| Log type                                     | Cost                   |
| -------------------------------------------- | ---------------------- |
| **Admin Activity audit logs**                | Free                   |
| **System Event audit logs**                  | Free                   |
| **First 50 GiB/project/month** of other logs | Free                   |
| **Above 50 GiB**                             | ~$0.01/GiB             |
| **Data Access audit logs**                   | Billed as regular logs |

- Reduce costs: use **exclusion filters** to drop verbose/noisy logs before ingestion
- Route high-volume logs directly to BigQuery or Cloud Storage via sinks instead of storing in Cloud Logging

---

## Key Takeaways — Cloud Logging

| Topic                  | Key Point                                                               |
| ---------------------- | ----------------------------------------------------------------------- |
| **Structured logging** | Write JSON to stdout; `severity` and `httpRequest` parsed automatically |
| **Audit logs**         | Admin Activity is always on and free; Data Access must be enabled       |
| **Log-based metrics**  | Bridge logs to Cloud Monitoring alerts                                  |
| **Sink permissions**   | Always grant sink's writer identity write access to destination         |
| **Ops Agent**          | Recommended for GCE; replaces both legacy agents                        |
| **Cost control**       | Use exclusion filters; export high-volume logs via sinks                |

## ACE Exam-Style Practice Questions

### Q1
A Cloud Logging requirement asks to collect logs from all current and future production projects only. What should you do?

A. Configure manual exports in each project every month
B. Configure aggregated log sink at production folder level
C. Disable Cloud Logging and use VM files
D. Send logs to Cloud DNS

Answer: B
Trap: Folder-level aggregated sinks capture both existing and future child projects.

### Q2
In a Cloud Logging incident, only a few requests are slow across many microservices. Which tool is best to identify the slow hop?

A. Cloud Trace
B. Cloud Storage lifecycle
C. Cloud Build trigger
D. Cloud Armor policy

Answer: A
Trap: Distributed tracing is designed for per-hop latency diagnosis.
