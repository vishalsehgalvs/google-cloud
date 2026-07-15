# 🖥️ Compute Engine

## What is Compute Engine?

Google Cloud's **IaaS** solution — lets you create and run virtual machines on Google's infrastructure.

- No upfront investment needed.
- Thousands of virtual CPUs can run simultaneously.
- Designed for speed and consistent performance.

---

## What a VM Can Do

Each VM has the full power of an operating system. You configure it like a physical server:

- How many **CPUs** and how much **memory**
- How much **storage** and what **type**
- Which **operating system**

### Ways to Create a VM

- **Google Cloud Console** — web-based UI
- **Google Cloud CLI** — command line
- **Compute Engine API** — programmatically

### Supported Operating Systems

- Linux and Windows Server images provided by Google
- Customized versions of those images
- Other operating systems you build yourself

---

## Cloud Marketplace

A quick way to get started — offers pre-configured solutions from Google and third-party vendors.

- No manual setup of software, VMs, storage, or networking.
- Most packages are free beyond normal Google Cloud usage fees.
- Third-party images with commercial software may have extra charges — all shown upfront before launch.

---

## Pricing & Billing

### Billing by the Second

- Compute Engine bills **per second**, with a **1-minute minimum**.

### Sustained-Use Discounts

- Automatically applied the longer a VM runs.
- If a VM runs for **more than 25% of a month**, Google automatically discounts every additional minute.

### Committed-Use Discounts

- For stable, predictable workloads.
- Commit to **1 year or 3 years** of a specific amount of vCPUs and memory.
- Save up to **57% off** normal prices.

---

## Preemptible & Spot VMs

For workloads that don't need a human waiting on them (e.g. batch jobs, data processing).

> Save up to **90%** compared to regular VMs.

The trade-off: Google can **terminate the VM at any time** if it needs those resources elsewhere.
You must ensure your job can be **stopped and restarted**.

### Preemptible vs. Spot VMs

| Feature             | Preemptible VM | Spot VM    |
| ------------------- | -------------- | ---------- |
| Max runtime         | 24 hours       | No maximum |
| More features       | ❌             | ✅         |
| Pricing (currently) | Same           | Same       |

---

## Storage

- High throughput between processing and persistent disks is the **default** — no special configuration needed.
- No extra cost for this.

---

## Custom Machine Types

You're not locked into predefined sizes. Choose exactly what you need:

- Set your own number of **virtual CPUs**
- Set your own amount of **memory**
- Pay only for what you actually use

---

## gcloud Commands

```bash
# List all VM instances
gcloud compute instances list

# Create a VM
gcloud compute instances create my-vm --zone=us-central1-a \
  --machine-type=e2-medium --image-family=debian-11 --image-project=debian-cloud

# SSH into a VM
gcloud compute ssh my-vm --zone=us-central1-a

# Delete a VM
gcloud compute instances delete my-vm --zone=us-central1-a
```

---

## Machine Families

| Family       | Purpose                                          | Examples                |
| ------------ | ------------------------------------------------ | ----------------------- |
| **E2**       | Cost-optimised, general purpose                  | e2-micro, e2-standard-2 |
| **N2 / N2D** | Balanced price-performance                       | n2-standard-4           |
| **C2 / C2D** | Compute-optimised (high CPU)                     | c2-standard-8           |
| **M1 / M2**  | Memory-optimised (SAP HANA, large in-memory DBs) | m1-ultramem-40          |
| **A2**       | Accelerator-optimised (GPU/ML workloads)         | a2-highgpu-1g           |
| **T2D**      | Scale-out workloads (AMD, cost-efficient)        | t2d-standard-1          |

- **Custom machine types** — set exact vCPU and memory; charged per vCPU-hour and per GB-hour
- **Extended memory** — add more RAM beyond standard ratio for memory-heavy workloads

---

## Disk Options

| Type                  | Speed                               | Use case                                  |
| --------------------- | ----------------------------------- | ----------------------------------------- |
| **Zonal Standard PD** | HDD — low cost                      | Sequential read/write, cold data          |
| **Zonal Balanced PD** | SSD — balanced                      | Most workloads                            |
| **Zonal SSD PD**      | SSD — high IOPS                     | Databases, latency-sensitive apps         |
| **Extreme PD**        | Highest IOPS                        | Large DBs (Oracle, SAP)                   |
| **Local SSD**         | Fastest (ephemeral)                 | Scratch space, caches — data lost on stop |
| **Hyperdisk**         | Next-gen (scalable IOPS/throughput) | Enterprise workloads                      |

- Persistent disks can be **resized** without stopping the VM
- **Boot disk** defaults to the OS image; data disks are attached separately
- Max 128 persistent disks per VM

### Snapshots

```bash
# Create a snapshot of a disk
gcloud compute disks snapshot my-disk --zone=us-central1-a \
  --snapshot-names=my-disk-snap

# Create a disk from a snapshot
gcloud compute disks create my-disk-restored \
  --source-snapshot=my-disk-snap --zone=us-central1-a
```

---

## Instance Templates and Managed Instance Groups (MIGs)

### Instance Template

A reusable VM configuration — machine type, boot disk, labels, metadata, network settings. Required for MIGs.

```bash
gcloud compute instance-templates create my-template \
  --machine-type=e2-medium \
  --image-family=debian-11 --image-project=debian-cloud
```

### Managed Instance Group (MIG)

A group of **identical VMs** created from an instance template. Used for autoscaling and high availability.

| Feature             | Detail                                                    |
| ------------------- | --------------------------------------------------------- |
| **Autoscaling**     | Scale out/in based on CPU, load balancing, custom metrics |
| **Autohealing**     | Replaces unhealthy VMs automatically using health checks  |
| **Rolling updates** | Update VMs progressively with zero downtime               |
| **Multi-zone**      | Spread VMs across zones for resilience                    |
| **Stateless**       | Best for stateless apps (web, API servers)                |

```bash
# Create a MIG
gcloud compute instance-groups managed create my-mig \
  --template=my-template --size=3 --zone=us-central1-a

# Set autoscaling
gcloud compute instance-groups managed set-autoscaling my-mig \
  --zone=us-central1-a --min-num-replicas=1 --max-num-replicas=10 \
  --target-cpu-utilization=0.6
```

---

## Startup and Shutdown Scripts

Run scripts automatically when a VM starts or stops:

```bash
# Pass a startup script at VM creation
gcloud compute instances create my-vm \
  --metadata=startup-script='#!/bin/bash
apt-get update
apt-get install -y nginx'

# Or reference a script file in GCS
gcloud compute instances create my-vm \
  --metadata=startup-script-url=gs://my-bucket/startup.sh
```

- Shutdown scripts run when the VM is stopped/preempted — useful for saving state or draining connections

---

## VM Images

| Type               | Description                                                    |
| ------------------ | -------------------------------------------------------------- |
| **Public images**  | Provided by Google, Canonical, Debian, etc.                    |
| **Custom images**  | Built from existing disk or snapshot; reusable across projects |
| **Machine images** | Full VM capture (disk + config + metadata) for backup/cloning  |

```bash
# Create a custom image from a disk
gcloud compute images create my-image --source-disk=my-disk \
  --source-disk-zone=us-central1-a
```

---

## OS Login

**OS Login** ties SSH access to Google accounts and IAM — replaces project-wide SSH key management.

- Enable per VM: `--metadata=enable-oslogin=TRUE`
- Grant SSH access: `roles/compute.osLogin` (non-sudo) or `roles/compute.osAdminLogin` (sudo)
- Keys are managed via your Google account — no manual key rotation

---

## Sole-Tenant Nodes

Physical servers dedicated exclusively to your project — useful for:

- Compliance requirements (no co-tenancy with other customers)
- Bring-your-own-license (BYOL) workloads (Windows Server, SQL Server)
- Performance isolation

---

## Key Takeaways

- Use **preemptible/spot VMs** for batch jobs to save up to 90%
- Use **committed-use discounts** for stable workloads (1 or 3 year)
- Use **instance templates + MIGs** for scalable, self-healing fleets
- Use **OS Login** instead of SSH keys for secure, auditable access
- Choose **machine family** based on workload: E2 (general), C2 (compute), M1/M2 (memory), A2 (GPU)

## ACE Exam-Style Practice Questions

### Q1
A Compute Engine workload requires full OS control and custom runtime with strict policy against managed platforms. Which compute option is best?

A. Compute Engine
B. Cloud Run Functions
C. App Engine Standard
D. Dataflow

Answer: A
Trap: Full host-level control is a strong Compute Engine signal.

### Q2
In a Compute Engine scenario, a fault-tolerant nightly batch workload is too expensive. What should you test and then use?

A. Spot or preemptible VMs after simulated interruption testing
B. Owner role on all instances
C. Single large sole-tenant node
D. Cloud DNS autoscaling

Answer: A
Trap: Interruptible workloads are classic candidates for discounted VM pricing models.
