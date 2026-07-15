# Compute Engine: Images

## What a Boot Disk Image Contains

When creating a VM, you choose a **boot disk image**. It includes:

- Boot loader
- Operating system
- File system structure
- Pre-configured software
- Any other customizations

---

## Public Images

- Available for both **Linux** and **Windows**.
- Some are **premium images** (marked with a `p`):
  - Charged **per second** after a 1-minute minimum.
  - Exception: **SQL Server images** are charged **per minute** after a 10-minute minimum.
  - Premium image prices vary with **machine type** but are **global** — they do not vary by region or zone.

---

## Custom Images

- Create a custom image by pre-installing software authorized for your organization.
- Can be **imported** from:
  - On-premises or a local workstation
  - Another cloud provider
- Importing is a **no-cost service** — just install an agent.
- Custom images can be **shared** within the same project or across other projects.

---

## Machine Images

- A **machine image** is a Compute Engine resource that stores all of the following from one or more disks:
  - Configuration
  - Metadata
  - Permissions
  - Data
- Used to create a full VM instance from a saved state.
- Ideal for:
  - **Disk backups**
  - **Instance cloning and replication**
  - System maintenance scenarios (creation, backup and recovery)

---

## gcloud Commands

```bash
# List available public images
gcloud compute images list

# Create a custom image from a disk
gcloud compute images create my-image \
  --source-disk=my-disk --source-disk-zone=us-central1-a

# Create a machine image from a running VM
gcloud compute machine-images create my-machine-image \
  --source-instance=my-vm --source-instance-zone=us-central1-a

# Delete a custom image
gcloud compute images delete my-image
```

## ACE Exam-Style Practice Questions

### Q1
A Compute Engine Images workload requires full OS control and custom runtime with strict policy against managed platforms. Which compute option is best?

A. Compute Engine
B. Cloud Run Functions
C. App Engine Standard
D. Dataflow

Answer: A
Trap: Full host-level control is a strong Compute Engine signal.

### Q2
In a Compute Engine Images scenario, a fault-tolerant nightly batch workload is too expensive. What should you test and then use?

A. Spot or preemptible VMs after simulated interruption testing
B. Owner role on all instances
C. Single large sole-tenant node
D. Cloud DNS autoscaling

Answer: A
Trap: Interruptible workloads are classic candidates for discounted VM pricing models.
