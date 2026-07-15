# 🌍 Spanner

## What is Spanner?

- Fully managed **relational database** service
- Scales **horizontally** (unlike traditional relational DBs that only scale vertically)
- **Strongly consistent** globally
- Speaks **SQL** (supports joins and secondary indexes)
- Battle-tested by Google's own mission-critical apps — powers Google's $80B business

---

## When to Use Spanner

Best for applications that need:

- SQL + joins + secondary indexes
- Built-in **high availability**
- **Strong global consistency**
- Very high throughput — **tens of thousands of reads/writes per second or more**

---

## Spanner vs Cloud SQL

| Feature     | Cloud SQL     | Spanner                    |
| ----------- | ------------- | -------------------------- |
| Scale       | Vertical      | Horizontal (global)        |
| Consistency | Regional      | Strong, global             |
| Use case    | Standard apps | Mission-critical, high I/O |
| Throughput  | Moderate      | Tens of thousands+ ops/sec |

---

## gcloud Commands

```bash
# List Spanner instances
gcloud spanner instances list

# Create a Spanner instance
gcloud spanner instances create my-instance \
  --config=regional-us-central1 --description="My Spanner" --nodes=1

# List databases in an instance
gcloud spanner databases list --instance=my-instance

# Delete an instance
gcloud spanner instances delete my-instance
```

## ACE Exam-Style Practice Questions

### Q1
A Spanner workload is global, relational, and requires strong consistency with unpredictable growth. Which service is best?

A. Cloud SQL
B. Cloud Spanner
C. Firestore
D. Memorystore

Answer: B
Trap: Global consistency plus horizontal relational scale strongly signals Spanner.

### Q2
You need automatic up and down scaling for a predictable Spanner traffic pattern. What is best?

A. Manual weekly node changes only
B. Monitoring alert to webhook plus Cloud Function that resizes Spanner nodes
C. Ask Google support to resize when alerted
D. Restart application servers nightly

Answer: B
Trap: Automation should be policy-driven and integrated with monitoring, not manual email workflows.
