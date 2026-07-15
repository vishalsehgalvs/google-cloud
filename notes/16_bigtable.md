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

---

## gcloud Commands

```bash
# List Bigtable instances
gcloud bigtable instances list

# Create a Bigtable instance
gcloud bigtable instances create my-instance \
  --display-name="My Bigtable" \
  --cluster-config=id=my-cluster,zone=us-central1-a,nodes=3

# List clusters in an instance
gcloud bigtable clusters list --instances=my-instance

# Delete a Bigtable instance
gcloud bigtable instances delete my-instance
```

## ACE Exam-Style Practice Questions

### Q1
A Bigtable use case ingests timestamped sensor data at very high write rates with low-latency reads. Which service is best?

A. Cloud SQL
B. Bigtable
C. Cloud Storage
D. Firestore

Answer: B
Trap: High-ingest time-series workloads are a classic Bigtable pattern.

### Q2
For Bigtable schema design, what is a key performance practice?

A. Use random keys that break query patterns
B. Design row keys to match primary access pattern and avoid hotspots
C. Store only in one giant JSON column
D. Disable column families

Answer: B
Trap: Row-key design directly influences distribution and query performance.
