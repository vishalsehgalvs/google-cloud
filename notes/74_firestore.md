# Firestore

## What Is Firestore?

- Fast, fully managed, **serverless**, cloud-native **NoSQL document database**
- Designed for mobile, web, and IoT apps at global scale
- Next generation of **Cloud Datastore** — backward-compatible with all Datastore APIs

---

## Key Features

| Feature           | Detail                                                                           |
| ----------------- | -------------------------------------------------------------------------------- |
| Live sync         | Client libraries provide real-time synchronization                               |
| Offline support   | Works offline; syncs when reconnected                                            |
| ACID transactions | Full transaction support — if any operation fails, entire transaction rolls back |
| Replication       | Automatic multi-region replication                                               |
| Consistency       | Strong consistency                                                               |
| Queries           | Sophisticated queries on NoSQL data without performance degradation              |
| Integrations      | Firebase and Google Cloud integrations for serverless apps                       |

---

## Firestore Modes

|                                     | Datastore Mode                  | Native Mode                 |
| ----------------------------------- | ------------------------------- | --------------------------- |
| Best for                            | New **server-side** projects    | New **mobile and web** apps |
| Backwards compatible with Datastore | ✅                              | ❌                          |
| Strongly consistent queries         | ✅ (fixes Datastore limitation) | ✅                          |
| Transaction limit (entity groups)   | Removed (was 25)                | N/A                         |
| Write limit per entity group        | Removed (was 1/sec)             | N/A                         |
| Real-time updates                   | ❌                              | ✅                          |
| Mobile/web client libraries         | ❌                              | ✅                          |
| Collection + document data model    | ❌                              | ✅                          |

> To access all new Firestore features, use **Native mode**.

---

## Firestore vs Datastore Improvements

Firestore in Datastore mode removes these legacy Datastore limitations:

- Queries are no longer eventually consistent → **all strongly consistent**
- Transactions no longer limited to 25 entity groups
- Writes to an entity group no longer limited to 1 per second

---

## When to Use Firestore — Decision Tree

```
Does your schema change frequently? OR
Do you need to scale to zero? OR
Do you need low-maintenance scaling up to terabytes?
  └─ Yes → Firestore

Do you NOT need transactional consistency?
  └─ Yes → Consider Bigtable (depending on cost/size)
```

---

## gcloud Commands

```bash
# Create a Firestore database (Native mode)
gcloud firestore databases create \
  --location=us-east1 \
  --type=firestore-native

# Create a Firestore database (Datastore mode)
gcloud firestore databases create \
  --location=us-east1 \
  --type=datastore-mode

# List Firestore databases
gcloud firestore databases list

# Export Firestore data to Cloud Storage
gcloud firestore export gs://my-bucket/firestore-export

# Import Firestore data from Cloud Storage
gcloud firestore import gs://my-bucket/firestore-export

# Delete all documents in a collection (via CLI)
gcloud firestore operations list

# Describe a Firestore database
gcloud firestore databases describe --database="(default)"
```
