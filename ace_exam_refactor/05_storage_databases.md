# Domain 5 - Storage and Databases

## Storage Class Core

- Standard: frequent access
- Nearline: about monthly access
- Coldline: about quarterly access and strong backup pattern
- Archive: very rare access and long retention

## Database Choice Core

- Cloud SQL: relational OLTP, common app stack
- Spanner: global scale, strong consistency, horizontal relational scale
- Firestore: document model, mobile and web app style data
- Bigtable: high-throughput wide-column and time-series workloads
- BigQuery: analytics SQL warehouse, not OLTP replacement
- Memorystore: cache and session acceleration

## Pinpoint Traps

- Deep archive class can hurt retrieval objectives for DR workloads.
- Lifecycle age is measured from object creation time.
- Spanner is not default relational answer unless global scale and consistency are explicit.
- BigQuery is not a transactional app database.

## Scenario Example 1

- Trigger words: logs hot 30 days, cheap retention after, auto policy
- Best answer: Standard then lifecycle transition to colder class
- Why not Archive on day 1: retrieval latency mismatch
- Why not manual moves: high operations burden

```json
{
  "rule": [
    {
      "action": { "type": "SetStorageClass", "storageClass": "COLDLINE" },
      "condition": { "age": 30 }
    },
    {
      "action": { "type": "Delete" },
      "condition": { "age": 365 }
    }
  ]
}
```

```bash
gsutil lifecycle set lifecycle.json gs://app-log-bucket
```

## Scenario Example 2

- Trigger words: relational, global users, strict consistency, unpredictable growth
- Best answer: Spanner
- Why not Cloud SQL: scaling and global consistency limits
- Why not Firestore: document model mismatch

```bash
gcloud spanner instance-configs list

gcloud spanner instances create orders-spanner \
  --config=CONFIG_ID \
  --processing-units=1000 \
  --description="Global orders database"
```

## Scenario Example 3

- Trigger words: existing Postgres app, managed DB, minimal code changes
- Best answer: Cloud SQL for PostgreSQL
- Why not Spanner: unnecessary complexity and migration overhead
- Why not self-managed DB on VMs: higher ops burden

```bash
gcloud sql instances create app-sql \
  --database-version=POSTGRES_15 \
  --cpu=2 \
  --memory=8GB \
  --region=us-central1 \
  --availability-type=REGIONAL
```

## Fast Selection Table

- File objects and backups -> Cloud Storage
- Shared NFS -> Filestore
- Common transactional relational -> Cloud SQL
- Global transactional relational -> Spanner
- App document NoSQL -> Firestore
- Massive throughput key-value and time-series -> Bigtable
- Analytics warehouse -> BigQuery

## One-Line Rules

- Match access frequency exactly for storage class questions.
- Use Cloud SQL by default for relational apps unless global scale constraints force Spanner.
- If question says analyze large datasets with SQL, think BigQuery first.
