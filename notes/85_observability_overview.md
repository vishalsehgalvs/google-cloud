# Google Cloud Observability — Overview

## What Is Google Cloud Observability?

- A service providing **monitoring, logging, and diagnostics** for applications on Google Cloud and AWS
- Dynamically discovers cloud resources and application services via deep integration
- Provides **core visibility in minutes** thanks to smart defaults
- Pay only for what you use; free usage allotments to get started with no upfront fees

---

## Services Covered in This Module

| Service          | Purpose                                          |
| ---------------- | ------------------------------------------------ |
| Cloud Monitoring | Metrics, dashboards, alerts, uptime checks       |
| Cloud Logging    | Log ingestion, search, and analysis              |
| Error Reporting  | Automatic error detection and grouping           |
| Cloud Trace      | Distributed request tracing and latency analysis |
| Cloud Profiler   | Continuous CPU and memory profiling              |

---

## Why It Matters

In most environments, monitoring, logging, and tracing are handled by separate, loosely integrated tools. Google Cloud Observability combines them into a **single, comprehensive, integrated service** — critical for building reliable, stable, and maintainable applications.

## ACE Exam-Style Practice Questions

### Q1
A Observability Overview requirement asks to collect logs from all current and future production projects only. What should you do?

A. Configure manual exports in each project every month
B. Configure aggregated log sink at production folder level
C. Disable Cloud Logging and use VM files
D. Send logs to Cloud DNS

Answer: B
Trap: Folder-level aggregated sinks capture both existing and future child projects.

### Q2
In a Observability Overview incident, only a few requests are slow across many microservices. Which tool is best to identify the slow hop?

A. Cloud Trace
B. Cloud Storage lifecycle
C. Cloud Build trigger
D. Cloud Armor policy

Answer: A
Trap: Distributed tracing is designed for per-hop latency diagnosis.
