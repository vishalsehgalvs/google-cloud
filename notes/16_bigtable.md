# 📊 Bigtable

## What is Bigtable?
- Google's **NoSQL big data** database service
- Powers core Google services: Search, Analytics, Maps, Gmail
- Designed for **massive workloads** at consistent **low latency and high throughput**
- Great for both **operational** and **analytical** applications

---

## When to Use Bigtable

Choose Bigtable if:
- Working with **more than 1 TB** of semi-structured or structured data
- Data is fast with **high throughput** or rapidly changing
- Working with **NoSQL** data (no need for strong relational semantics)
- Data is a **time-series** or has natural semantic ordering
- Running **async batch or real-time processing** on big data
- Running **machine learning algorithms** on the data

Use cases: IoT, user analytics, financial data analysis

---

## Integrations

### APIs
- Read/write via a data service layer:
  - Managed VMs
  - HBase REST Server
  - Java Server using HBase client
- Typically used to serve data to apps, dashboards, and data services

### Stream Processing
- **Dataflow Streaming**
- **Spark Streaming**
- **Storm**

### Batch Processing
- **Hadoop MapReduce**
- **Dataflow**
- **Spark**

> Summarized or newly calculated data is often written back to Bigtable or to a downstream database.
