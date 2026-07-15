# Error Reporting

## What Is Error Reporting?

- **Counts, analyzes, and aggregates errors** in your running cloud services
- Centralized error management interface with sorting and filtering
- Supports **real-time notifications** when new errors are detected

---

## Supported Platforms

| Platform                 | Supported |
| ------------------------ | --------- |
| App Engine (Standard)    | ✅        |
| App Engine (Flexible)    | ✅        |
| Apps Script              | ✅        |
| Compute Engine           | ✅        |
| Cloud Run                | ✅        |
| Cloud Run Functions      | ✅        |
| Google Kubernetes Engine | ✅        |
| Amazon EC2               | ✅        |

---

## Supported Languages

Error Reporting can parse exception stack traces for:

- Go
- Java
- .NET
- Node.js
- PHP
- Python
- Ruby

## ACE Exam-Style Practice Questions

### Q1
A Error Reporting requirement asks to collect logs from all current and future production projects only. What should you do?

A. Configure manual exports in each project every month
B. Configure aggregated log sink at production folder level
C. Disable Cloud Logging and use VM files
D. Send logs to Cloud DNS

Answer: B
Trap: Folder-level aggregated sinks capture both existing and future child projects.

### Q2
In a Error Reporting incident, only a few requests are slow across many microservices. Which tool is best to identify the slow hop?

A. Cloud Trace
B. Cloud Storage lifecycle
C. Cloud Build trigger
D. Cloud Armor policy

Answer: A
Trap: Distributed tracing is designed for per-hop latency diagnosis.
