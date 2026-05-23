# 📄 Firestore

## What is Firestore?

- Flexible, horizontally scalable **NoSQL** cloud database
- Designed for **mobile, web, and server** development

---

## Data Model

- Data is stored in **documents** organized into **collections**
- Documents can contain:
  - Key-value pairs (e.g. `firstname: "John"`, `lastname: "Doe"`)
  - Complex nested objects
  - Subcollections

---

## Querying

- NoSQL queries to retrieve individual documents or all documents matching filters
- Supports multiple **chained filters** and combined filtering + sorting
- **Indexed by default** — query performance is proportional to the result set size, not the total dataset size

---

## Offline Support & Sync

- Caches data the app is actively using — supports read/write/query **even offline**
- When device comes back online, local changes are automatically synchronized

---

## Infrastructure Benefits

- **Automatic multi-region data replication**
- **Strong consistency** guarantees
- **Atomic batch operations**
- **Real transaction support**

---

## gcloud Commands

```bash
# List Firestore databases
gcloud firestore databases list

# Create a Firestore database
gcloud firestore databases create --location=us-central1

# Export data to Cloud Storage
gcloud firestore export gs://my-bucket/firestore-backup

# Import data from Cloud Storage
gcloud firestore import gs://my-bucket/firestore-backup
```
