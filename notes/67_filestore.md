# Filestore — Managed Network File Storage

## What is Filestore?

**Filestore** is a fully managed **NFS (Network File System)** storage service for applications that need a shared file system interface.

- Works natively with **Compute Engine** and **GKE** instances
- Supports any **NFSv3 compatible** client
- Performance and capacity can be tuned **independently** → predictable, fast performance
- No plugins or client-side software required

---

## Key Capabilities

- Scale-out performance
- Hundreds of terabytes of capacity
- **File locking** support
- Native compatibility with existing enterprise applications

---

## Use Cases

| Use Case                               | Why Filestore                                                                            |
| -------------------------------------- | ---------------------------------------------------------------------------------------- |
| **Enterprise app migration**           | Many on-premises apps need a shared file system — Filestore supports lift-and-shift      |
| **Media rendering**                    | VFX artists collaborate on the same file share across fleets of Compute Engine VMs       |
| **EDA (Electronic Design Automation)** | Batch workloads across thousands of cores with large memory needs; universal file access |
| **Data analytics**                     | Low-latency file ops for complex financial models or environmental data analysis         |
| **Genomics / scientific research**     | Handles billions of data points per person; fast, scalable, secure                       |
| **Web content / WordPress hosting**    | Managed shared storage for web developers and hosting providers                          |

---

## When to Use Filestore vs Cloud Storage

| Need                                   | Use               |
| -------------------------------------- | ----------------- |
| Shared file system (NFS mount)         | **Filestore**     |
| Object storage (blobs, backups, media) | **Cloud Storage** |

---

## gcloud Commands

```bash
# List Filestore instances
gcloud filestore instances list

# Create a Filestore instance
gcloud filestore instances create my-filestore \
  --zone=us-central1-c \
  --tier=STANDARD \
  --file-share=name=my-share,capacity=1TB \
  --network=name=default

# Describe a Filestore instance (get NFS mount point)
gcloud filestore instances describe my-filestore --zone=us-central1-c

# Delete a Filestore instance
gcloud filestore instances delete my-filestore --zone=us-central1-c
```
