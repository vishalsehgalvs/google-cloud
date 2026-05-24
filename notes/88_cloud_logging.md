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
