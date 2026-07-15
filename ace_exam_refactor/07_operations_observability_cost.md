# Domain 7 - Operations, Observability, Reliability, Cost

## Observability Core

- Cloud Monitoring: metrics, dashboards, alert policies
- Cloud Logging: centralized logs, sinks, log routes
- Error Reporting: grouped runtime errors
- Cloud Trace: distributed latency tracing
- Cloud Profiler: continuous CPU and memory profiling

## Cost and Reliability Core

- Budgets for notification
- Quotas for enforcement
- SLO target and error budget for reliability governance
- Labels for cost attribution by team and env

## Decision Signals

- "investigate slow microservice chain" -> Cloud Trace
- "long-term audit analysis" -> Logging sink to BigQuery
- "single pane across projects" -> Monitoring Workspace
- "stop cost runaway" -> quota plus alerting
- "who caused spend" -> labels and billing export

## Pinpoint Traps

- Budget alerts do not stop resource growth.
- Logs in one project are not enough for org-wide visibility.
- Trace and Profiler solve different problems.
- Dashboard without alert policy is incomplete operations design.

## Scenario Example 1

- Trigger words: compliance, searchable long-term audit trail
- Best answer: route audit logs to BigQuery via log sink
- Why not local VM logs: not centralized and weak governance
- Why not ad-hoc exports: poor repeatability

```bash
gcloud logging sinks create audit-to-bq \
  bigquery.googleapis.com/projects/PROJECT_ID/datasets/audit_logs \
  --log-filter='logName:"cloudaudit.googleapis.com"'
```

## Scenario Example 2

- Trigger words: API latency spikes across microservices
- Best answer: use Cloud Trace and correlate with logs
- Why not only CPU metrics: does not show end-to-end request path
- Why not only Error Reporting: not latency-focused

```bash
gcloud logging read 'resource.type="k8s_container" AND severity>=ERROR' \
  --limit=20
```

## Scenario Example 3

- Trigger words: finance wants spend by team in near real time
- Best answer: labels plus billing export to BigQuery and dashboard
- Why not cost report screenshot: not scalable for operations
- Why not only quotas: no attribution detail

```bash
gcloud compute instances add-labels api-01 \
  --labels=team=platform,env=prod,cost_center=finops \
  --zone=us-central1-a
```

## Reliability Checklist

- Define SLO and error budget
- Add health checks and alerts
- Add runbook links to alerts
- Track changes with audit logs

## One-Line Rules

- Monitoring detects, logging explains, trace localizes latency.
- If the question asks enforcement, alerts alone are not enough.
- Always combine reliability controls with visibility controls.
