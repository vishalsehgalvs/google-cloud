# Creating a VM in the GCP Console

## Getting to Compute Engine

- Navigation menu → **Compute Engine** → **VM instances**.
- Pin Compute Engine to the nav menu for quicker access (used frequently in the course).

---

## Step 1: Name and Location

- Give the instance a name.
- Choose a **region** — shown with the region ID and nearest city.
- Choose a **zone** within that region.
- The **estimated cost** on the right updates in real time as you change settings.
  - Cost varies by region — e.g., Europe West 1 may differ from US Central 1.

---

## Step 2: Machine Type

- Choose from predefined machine types (or create a custom one).
- Example: `n1-standard-1` = 1 vCPU + 3.75 GB memory.
- Increasing CPU/memory increases cost; choosing a smaller type (micro, small) drives cost down significantly.
- The cost breakdown shows separate line items for **CPU**, **memory**, **persistent disk**, and **sustained use discounts**.
- Cost is shown both as a **monthly** and **hourly** estimate.

---

## Region and Zone Considerations (Beyond Cost)

- Place instances **close to your users** to reduce latency.
- Spread across regions for **high availability**.
- Some workloads have **data locality requirements** — data must stay in a specific region.

---

## Step 3: Boot Disk

- Default: **10 GB standard persistent disk**.
- You can change the **image** (OS) and the **disk type** (Standard HDD or SSD).
- Boot disk must be a persistent disk — local SSDs cannot be used as boot disks.
- Both Standard and SSD persistent disks support the same maximum size.
- Increasing the disk size increases cost (visible in real time).

---

## Step 4: Additional Disks (Management Tab)

- Navigate to **Management, Security, Disk, Networking** → **Disks** tab.
- Choose **encryption type** for disks:
  - Google-managed key
  - Customer-managed key (CMEK)
  - Customer-supplied key (CSEK)
- Add additional disks and choose types including **local SSD**.
- Disk performance (IOPS and sustained throughput) scales with the number and size of disks, up to a limit.

---

## Step 5: Networking

- Configure the **network interface**: choose the VPC network, subnet, internal IP, and whether to assign an external IP.

---

## Bonus: Console → Command Line

- The GCP Console shows the equivalent **`gcloud` command** for the current configuration.
- Useful for learning the CLI — it spells out every option you chose as a command-line flag.
- Great starting point for automating VM creation later.

---

## After Creation

- The VM instances list shows columns like: name, zone, machine type, network, creation time.
- You can customize which columns are visible in the list view.

## ACE Exam-Style Practice Questions

### Q1
A Compute Engine Vm Creation Console workload requires full OS control and custom runtime with strict policy against managed platforms. Which compute option is best?

A. Compute Engine
B. Cloud Run Functions
C. App Engine Standard
D. Dataflow

Answer: A
Trap: Full host-level control is a strong Compute Engine signal.

### Q2
In a Compute Engine Vm Creation Console scenario, a fault-tolerant nightly batch workload is too expensive. What should you test and then use?

A. Spot or preemptible VMs after simulated interruption testing
B. Owner role on all instances
C. Single large sole-tenant node
D. Cloud DNS autoscaling

Answer: A
Trap: Interruptible workloads are classic candidates for discounted VM pricing models.
