# Cloud Observability — Third-Party Integrations

## Partner Ecosystem

Google Cloud Observability supports a rich ecosystem of technology partners to expand IT ops, security, and compliance capabilities.

---

## BindPlane (Blue Medora) Integration

BindPlane collects metrics and logs from external sources and pushes them into Google Cloud's open APIs.

```
External log/metric sources
        │
        ▼
    BindPlane
   ┌─────────────────┐
   │ Logs ──────────►│ Cloud Logging  → view, search, log-based metrics, alerts
   │ Metrics ───────►│ Cloud Monitoring → dashboards, alerts
   └─────────────────┘
```

Once ingested into Cloud Logging, external logs behave exactly like native GCP logs:

- View and search raw log data
- Create metrics from log files
- View logs in real time in the Console
- Use log-based metrics to view logs and metrics side-by-side
- Set alerts on logs

---

## Splunk Integration

Export Cloud Logging data to **Splunk Enterprise** or **Splunk Cloud** for in-depth analysis.

### Architecture

```
Cloud Logging (centralized log collection)
        │
        ▼
    Pub/Sub (temporary message store)
        │
        ├─► Primary Dataflow pipeline ──────► Splunk (analysis)
        │
        └─► Secondary Dataflow pipeline ────► Splunk (error recovery / retry)
```

### Key Points

- **Pub/Sub** temporarily stores logged messages before delivery to Splunk
- **Primary Dataflow pipeline** extracts from Pub/Sub and delivers to Splunk
- **Secondary Dataflow pipeline** runs in parallel — resends logs if primary delivery fails
- Uses the **Pub/Sub to Splunk Dataflow template** — any message in a Pub/Sub topic can be forwarded to Splunk
- Splunk can be deployed **on-premises**, **in Google Cloud (SaaS)**, or **hybrid**
