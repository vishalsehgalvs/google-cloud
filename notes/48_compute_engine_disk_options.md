# Compute Engine: Disk Options

## Root Persistent Disk

- Every VM comes with a **single root persistent disk** loaded with the chosen base image.
- The boot disk is:
  - **Bootable** — can be attached to a VM and booted from.
  - **Durable** — survives if the VM terminates (by default).
- To keep the boot disk after deleting the VM, disable **"Delete boot disk when instance is deleted"** in the instance properties.

---

## Persistent Disks

- Attached to the VM through the **network interface** — not physically attached.
- This separation means the disk **survives if the VM terminates**.
- Supports **snapshots** (incremental backups).
- Can be **dynamically resized** while running and attached to a VM.
- Can be attached in **read-only mode to multiple VMs** — useful for sharing static data without replicating it.

### Zonal vs. Regional Persistent Disks

| Type         | Description                                                                                                                          |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------ |
| **Zonal**    | Efficient, reliable block storage in a single zone                                                                                   |
| **Regional** | Active-active synchronous replication across two zones in the same region; great for high-availability databases and enterprise apps |

### Persistent Disk Types

| Type                  | Backed By | Best For                                                                                                                                |
| --------------------- | --------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| **Standard**          | HDD       | Large data processing workloads with sequential I/O; cheapest                                                                           |
| **Balanced**          | SSD       | General-purpose apps; balance of performance and cost; same max IOPS as Performance SSD but lower IOPS/GB                               |
| **Performance (SSD)** | SSD       | Enterprise apps and high-performance databases needing low latency and high IOPS                                                        |
| **Extreme**           | SSD       | High-end database workloads; consistently high performance for both random access and bulk throughput; lets you provision your own IOPS |

---

## Encryption at Rest

- Compute Engine **encrypts all data at rest by default** — no action needed.
- Options if you want to manage encryption yourself:
  - **Customer-managed encryption keys (CMEK)** — use Cloud Key Management Service to create and manage keys.
  - **Customer-supplied encryption keys (CSEK)** — create and manage your own keys entirely.

---

## Local SSDs

- **Physically attached** to the VM — not networked.
- **Ephemeral**: data survives a **reset** but is lost on **stop or termination** (cannot be reattached to a different VM).
- Very high IOPS.
- Size: **375 GB per partition**.
- Maximum: **24 partitions = 9 TB per instance**.

---

## RAM Disks (tmpfs)

- Store data in memory using `tmpfs`.
- **Fastest** type of storage available.
- Best for small data structures that need the highest possible performance.
- Recommended pairing: a **high-memory VM** + a **persistent disk** to back up the RAM disk data.
- Most volatile — data is lost on any stop or restart.

---

## Disk Comparison Summary

| Type               | Persistent?    | Snapshots | Redundancy                              | Performance |
| ------------------ | -------------- | --------- | --------------------------------------- | ----------- |
| **Persistent HDD** | Yes            | Yes       | Yes (distributed across physical disks) | Low–Medium  |
| **Persistent SSD** | Yes            | Yes       | Yes                                     | High        |
| **Local SSD**      | No (ephemeral) | No        | No                                      | Very High   |
| **RAM disk**       | No (volatile)  | No        | No                                      | Highest     |

**When to choose:**

- **Persistent HDD** — need capacity, not performance.
- **Persistent SSD** — need high performance with durability.
- **Local SSD** — need maximum throughput and can tolerate data loss on stop.
- **RAM disk** — need the absolute fastest access for small, temporary data.

---

## Disk Attachment Limits

| Machine Type                                                         | Max Persistent Disks |
| -------------------------------------------------------------------- | -------------------- |
| Shared-core                                                          | 16                   |
| Standard, High Memory, High CPU, Memory-optimized, Compute-optimized | 128                  |

---

## Disk I/O and Network Bandwidth

- Disk I/O throughput **shares bandwidth with network egress/ingress**.
- If you plan on heavy Disk I/O, it will compete with network throughput — keep this in mind when adding more disks.

---

## Persistent Disks vs. Physical Disks

| Physical Hard Disk                               | Cloud Persistent Disk                                        |
| ------------------------------------------------ | ------------------------------------------------------------ |
| Must be partitioned manually                     | No partitioning needed                                       |
| Resizing requires repartitioning or reformatting | Resize dynamically at any time                               |
| Redundancy requires a RAID setup                 | Redundancy built in (data distributed across physical disks) |
| Encryption must be set up manually               | Automatically encrypted; can use your own keys               |
