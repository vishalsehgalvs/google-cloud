# Memorystore

## What Is Memorystore?

- Fully managed **in-memory datastore** service built on Redis
- Runs on scalable, secure, highly available infrastructure managed by Google
- Fully compatible with the **Redis protocol** — lift-and-shift from open source Redis with no code changes

---

## Key Features

| Feature                | Detail                                                            |
| ---------------------- | ----------------------------------------------------------------- |
| Managed tasks          | High availability, failover, patching, monitoring — all automated |
| Latency                | Sub-millisecond                                                   |
| Max instance size      | 300 GB                                                            |
| Max network throughput | 12 Gbps                                                           |
| HA replication         | Replicated across **two zones**                                   |
| Availability SLA       | **99.9%** (HA instances)                                          |
| Migration              | Import/export from open source Redis — no code changes needed     |
| Client libraries       | All existing Redis tools and client libraries work as-is          |

---

## Scaling

- Start with lowest tier and smallest size
- Grow instance effortlessly with minimal impact to application availability

---

## Use Cases

- Caching (session data, query results)
- Real-time analytics
- Gaming leaderboards
- Applications requiring microsecond-to-millisecond response times
- High traffic spikes (gaming environments, live events)

---

## When to Use Memorystore

```
Need microsecond/sub-millisecond response times? OR
Have large spikes in traffic (gaming, real-time analytics)?
  └─ Yes → Memorystore

  └─ No → Consider a persistent storage service (BigQuery, Cloud SQL, Spanner, etc.)
```

---

## gcloud Commands

```bash
# List Memorystore (Redis) instances
gcloud redis instances list --region=us-central1

# Create a Redis instance (basic tier)
gcloud redis instances create my-redis \
  --size=1 \
  --region=us-central1 \
  --tier=basic

# Create a Redis instance (standard tier with HA)
gcloud redis instances create my-redis-ha \
  --size=1 \
  --region=us-central1 \
  --tier=standard

# Describe an instance (get connection IP/port)
gcloud redis instances describe my-redis --region=us-central1

# Scale an instance (increase memory size in GB)
gcloud redis instances update my-redis \
  --size=5 \
  --region=us-central1

# Import RDB file from Cloud Storage (lift-and-shift)
gcloud redis instances import my-redis \
  --source-rdb=gs://my-bucket/dump.rdb \
  --region=us-central1

# Export RDB file to Cloud Storage
gcloud redis instances export my-redis \
  --destination-rdb=gs://my-bucket/dump.rdb \
  --region=us-central1

# Delete a Redis instance
gcloud redis instances delete my-redis --region=us-central1
```

## ACE Exam-Style Practice Questions

### Q1
A Memorystore workload needs low-latency cache for sessions and frequent reads. Which service is best?

A. Memorystore
B. BigQuery
C. Cloud Spanner
D. Cloud Storage

Answer: A
Trap: Caching and in-memory access patterns are not a warehouse or relational primary-store use case.

### Q2
In a Memorystore architecture, what is a common role for this service?

A. Long-term immutable archive
B. Primary petabyte analytics warehouse
C. Cache layer in front of databases or APIs
D. Global DNS authority

Answer: C
Trap: Memorystore complements primary databases, it does not replace them for durable analytics storage.
