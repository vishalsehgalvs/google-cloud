# Cloud Storage — Lab Overview

## What You'll Do

- Create Cloud Storage buckets
- Set **Access Control Lists (ACLs)** to limit who can access data and what they can do
- Supply and manage your own **customer-supplied encryption keys (CSEK)**
- Enable **Object Versioning** to track changes
- Configure **Lifecycle Management** to automatically archive or delete objects after a set period
- Use **Directory Synchronization** to sync a local directory with a bucket

## ACE Exam-Style Practice Questions

### Q1
In a Cloud Storage Lab Overview scenario, files are used continually by an analytics pipeline in one region. Which storage class is best for minimal cost and performance fit?

A. Standard in closest region
B. Nearline in closest region
C. Archive in dual-region
D. Coldline in dual-region

Answer: A
Trap: Continual access generally means Standard, while colder classes penalize frequent retrieval.

### Q2
Backup files older than 90 days must be removed automatically in a Cloud Storage Lab Overview bucket. What should you do?

A. Manual deletion script only
B. Lifecycle rule in JSON with Delete action and Age condition 90
C. Rename old files to another prefix only
D. Disable object versioning

Answer: B
Trap: Lifecycle rules are the managed and auditable approach for retention cleanup.
