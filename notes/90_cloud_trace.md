# Cloud Trace

## What Is Cloud Trace?

- **Distributed tracing system** that collects latency data from your applications
- Displays results in the Google Cloud Console
- Based on the internal tools Google uses to keep its own services running at extreme scale

---

## What It Does

- Tracks how **requests propagate** through your application
- Provides **near real-time performance insights**
- Automatically analyzes traces to generate **in-depth latency reports**
- Surfaces **performance degradations**

---

## Supported Sources

| Source                                         | Supported |
| ---------------------------------------------- | --------- |
| App Engine                                     | ✅        |
| Global external Application Load Balancers     | ✅        |
| Applications instrumented with Cloud Trace API | ✅        |

---

## Why It Matters

Managing request latency and operation time is a key part of overall application performance. Cloud Trace helps you identify slow requests and bottlenecks across distributed services.

## ACE Exam-Style Practice Questions

### Q1
A Cloud Trace requirement asks to collect logs from all current and future production projects only. What should you do?

A. Configure manual exports in each project every month
B. Configure aggregated log sink at production folder level
C. Disable Cloud Logging and use VM files
D. Send logs to Cloud DNS

Answer: B
Trap: Folder-level aggregated sinks capture both existing and future child projects.

### Q2
In a Cloud Trace incident, only a few requests are slow across many microservices. Which tool is best to identify the slow hop?

A. Cloud Trace
B. Cloud Storage lifecycle
C. Cloud Build trigger
D. Cloud Armor policy

Answer: A
Trap: Distributed tracing is designed for per-hop latency diagnosis.
