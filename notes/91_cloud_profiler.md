# Cloud Profiler

## What Is Cloud Profiler?

- Continuously analyzes the performance of **CPU or memory-intensive functions** across an application
- Uses **statistical techniques and extremely low-impact instrumentation** — does not slow down production code
- Runs across **all production application instances** for a complete picture of performance

---

## Why Profiling in Production Matters

| Problem                                          | Detail                                                          |
| ------------------------------------------------ | --------------------------------------------------------------- |
| Dev environment results don't reflect production | Behavior differs significantly between environments             |
| Traditional profiling slows down code            | Most production profiling techniques add overhead               |
| Limited coverage                                 | Many techniques can only inspect a small subset of the codebase |

Cloud Profiler solves all three — it's lightweight, runs everywhere, and covers the full app.

---

## Key Features

- Identifies **poorly performing code** that increases latency and cost
- Works on **Google Cloud, other cloud platforms, and on-premises**
- Supports: **Java, Go, Node.js, Python**

---

## Observability Services Summary

| Service          | Purpose                                                   |
| ---------------- | --------------------------------------------------------- |
| Cloud Monitoring | Metrics, dashboards, alerts, uptime checks                |
| Cloud Logging    | Log storage, search, export, log-based metrics            |
| Error Reporting  | Counts, aggregates, and alerts on application errors      |
| Cloud Trace      | Distributed request tracing and latency analysis          |
| Cloud Profiler   | Continuous CPU/memory performance profiling in production |
