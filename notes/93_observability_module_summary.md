# Google Cloud Observability — Module Summary

## Services Covered

| Service          | Purpose                                                   |
| ---------------- | --------------------------------------------------------- |
| Cloud Monitoring | Metrics, dashboards, alerts, uptime checks                |
| Cloud Logging    | Log storage, search, export, log-based metrics            |
| Error Reporting  | Count, analyze, and alert on application errors           |
| Cloud Trace      | Distributed request tracing and latency analysis          |
| Cloud Profiler   | Continuous CPU/memory performance profiling in production |

---

## Key Takeaway

Having monitoring, logging, error reporting, tracing, and profiling **integrated into a single platform** enables you to operate and maintain applications reliably — the practice known as **Site Reliability Engineering (SRE)**.

> For deeper learning, explore the **SRE Book** or Google's SRE courses.

## ACE Exam-Style Practice Questions

### Q1
A Observability Module Summary requirement asks to collect logs from all current and future production projects only. What should you do?

A. Configure manual exports in each project every month
B. Configure aggregated log sink at production folder level
C. Disable Cloud Logging and use VM files
D. Send logs to Cloud DNS

Answer: B
Trap: Folder-level aggregated sinks capture both existing and future child projects.

### Q2
In a Observability Module Summary incident, only a few requests are slow across many microservices. Which tool is best to identify the slow hop?

A. Cloud Trace
B. Cloud Storage lifecycle
C. Cloud Build trigger
D. Cloud Armor policy

Answer: A
Trap: Distributed tracing is designed for per-hop latency diagnosis.
