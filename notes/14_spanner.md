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

| Feature              | Cloud SQL          | Spanner                    |
| -------------------- | ------------------ | -------------------------- |
| Scale                | Vertical           | Horizontal (global)        |
| Consistency          | Regional           | Strong, global             |
| Use case             | Standard apps      | Mission-critical, high I/O |
| Throughput           | Moderate           | Tens of thousands+ ops/sec |
