# Compute Engine Module Notes: Virtual Machine Instances

## Overview

- Virtual machines (VMs) are the most common infrastructure component in cloud environments.
- In Google Cloud, VMs are created and managed through **Compute Engine**.
- A VM is similar to a physical computer, but it is software-defined and runs on shared cloud hardware.

## Core VM Building Blocks

- **vCPU**: virtual processor capacity
- **Memory (RAM)**: runtime memory for workloads
- **Disk storage**: persistent data and operating system storage
- **IP address**: network identity and connectivity

## What Makes Compute Engine Powerful

- Compute Engine is highly flexible and supports many machine configurations.
- Some capabilities are cloud-specific and do not exist in traditional physical servers.

### Examples of Cloud-Only Behavior

- **Micro VM model**: CPU can be shared across VMs, reducing cost for smaller workloads.
- **Burst capability**: some VMs can temporarily run above baseline CPU capacity when shared physical resources are available.

## Main Configuration Areas

- CPU
- Memory
- Disks
- Networking

## Module Roadmap

1. Compute Engine fundamentals
2. Intro lab: create virtual machines
3. CPU and memory configuration options
4. Images and disk choices
5. Common day-to-day Compute Engine operations
6. Deep-dive lab covering module features and services

## Quick Summary

This module introduces Compute Engine VM fundamentals and prepares you to choose machine types, storage, and networking options for real-world workloads.

---

## Compute Engine: IaaS Model

- Compute Engine is a pure **Infrastructure as a Service (IaaS)** offering.
- You have full control over the VM and operating system — run any language or stack.
- You are responsible for managing the OS, autoscaling rules, and configuration.
- **Primary use case**: any generic workload, especially enterprise applications originally designed to run on server infrastructure.
  - This makes Compute Engine very portable and easy to lift-and-shift from on-premises.
  - Other services (e.g., GKE with containerized workloads) may not be as straightforward to migrate.

---

## What is Compute Engine?

- Physical servers running inside the Google Cloud environment with many configuration options.
- Supports both **predefined** and **custom machine types** — choose your own memory and CPU.
- Disk options: persistent disks (HDD or SSD), local SSDs, Cloud Storage, or a mix.
- Supports configurable networking interfaces.
- Supports both **Linux and Windows** machines.

### Features Covered in This Module

- Machine rightsizing
- Startup and shutdown scripts
- Metadata
- Availability policies
- OS patch management
- Pricing and usage discounts

---

## TPUs (Tensor Processing Units)

- CPUs and GPUs can no longer scale fast enough to meet ML demand.
- In **2016**, Google introduced the **Tensor Processing Unit (TPU)**.
- TPUs are **custom-developed application-specific integrated circuits (ASICs)** designed to accelerate machine learning workloads.
- They are **domain-specific hardware** (vs. general-purpose hardware like CPUs/GPUs).
  - Tailored for operations like matrix multiplication in ML.
- TPUs are generally **faster** than current GPUs and CPUs for AI workloads.
- TPUs are also significantly **more energy-efficient**.
- Cloud TPUs are integrated across Google products and available to Google Cloud customers.
- **Best suited for**: models that train for long durations, or large models with large effective batch sizes.

---

## Compute Options: CPU and Network Throughput

- Compute Engine provides several predefined machine types; you can also customize your own.
- **Network throughput scales with CPU count**:
  - **2 Gbps per vCPU core** (general rule)
  - Instances with **2 or 4 vCPUs**: up to **10 Gbps**
  - Theoretical maximum: **200 Gbps** for an instance with **176 vCPUs** on the **C3 machine series**
- Each **vCPU** is implemented as a single **hardware hyper-thread** on one of the available CPU platforms.
  - This is different from on-premises physical cores, which have hyperthreading on top.

---

## Disk Options

Three types of disk storage are available:

| Type                         | Description                             | Best For                              |
| ---------------------------- | --------------------------------------- | ------------------------------------- |
| **Standard persistent disk** | Backed by spinning hard drives (HDD)    | Higher capacity per dollar            |
| **SSD persistent disk**      | Backed by solid-state drives            | Higher IOPS per dollar                |
| **Local SSD**                | Physically attached to the host machine | Highest throughput and lowest latency |

### Key Points

- Standard vs. SSD persistent disks: **same capacity options**, different performance/cost trade-offs.
- **Local SSD**:
  - Higher throughput and lower latency than SSD persistent disks.
  - Data **persists only until the instance is stopped or deleted** (ephemeral).
  - Common use: swap disk or high-speed temporary storage (similar to a ramdisk).
- **Standard and non-local SSD persistent disks**: can be sized up to **257 TB per instance**.
- Disk performance **scales with the amount of GB allocated**.

---

## Networking

- Compute Engine supports **Application Load Balancing** and **Network Load Balancing**.
- Load balancers in Google Cloud **do not require pre-warming** — they are not hardware devices.
- A load balancer is essentially a **set of traffic engineering rules** applied at the Google network level.
  - VPC applies your rules to traffic destined for your IP address and subnet range.

---

## Creating a VM in the GCP Console (Walkthrough)

### Getting to Compute Engine

- Navigation menu → **Compute Engine** → **VM instances**.
- Pin Compute Engine to the nav menu for quicker access (useful since it's used frequently).

### Step 1: Name and Location

- Give the instance a name.
- Choose a **region** — shown with the region ID and nearest city.
- Choose a **zone** within that region.
- The **estimated cost** on the right updates in real time as you change settings.
  - Cost varies by region — e.g., Europe West 1 may differ from US Central 1.

### Step 2: Machine Type

- Choose from predefined machine types (or create a custom one).
- Example: `n1-standard-1` = 1 vCPU + 3.75 GB memory.
- Increasing CPU/memory increases cost; choosing a smaller type (micro, small) drives cost down significantly.
- The cost breakdown shows separate line items for **CPU**, **memory**, **persistent disk**, and **sustained use discounts**.
- Cost is shown both as a **monthly** and **hourly** estimate.

### Region and Zone Considerations (Beyond Cost)

- Place instances **close to your users** to reduce latency.
- Spread across regions for **high availability**.
- Some workloads have **data locality requirements** — data must stay in a specific region.

### Step 3: Boot Disk

- Default: **10 GB standard persistent disk**.
- You can change the **image** (OS) and the **disk type** (Standard HDD or SSD).
- Boot disk must be a persistent disk — local SSDs cannot be used as boot disks.
- Both Standard and SSD persistent disks support the same maximum size.
- Increasing the disk size increases cost (visible in real time).

### Step 4: Additional Disks (Management Tab)

- Navigate to **Management, Security, Disk, Networking** → **Disks** tab.
- Choose **encryption type** for disks:
  - Google-managed key
  - Customer-managed key (CMEK)
  - Customer-supplied key (CSEK)
- Add additional disks and choose types including **local SSD**.
- Disk performance (IOPS and sustained throughput) scales with the number and size of disks, up to a limit.

### Step 5: Networking

- Configure the **network interface**: choose the VPC network, subnet, internal IP, and whether to assign an external IP.

### Bonus: Console → Command Line

- The GCP Console shows the equivalent **`gcloud` command** for the current configuration.
- Useful for learning the CLI — it spells out every option you chose as a command-line flag.
- Great starting point for automating VM creation later.

### After Creation

- The VM instances list shows columns like: name, zone, machine type, network, creation time.
- You can customize which columns are visible in the list view.

---

## Accessing a VM

### Linux Instances

- The **instance creator** has full **root privileges** by default.
- Creator has **SSH access** and can grant SSH access to other users via the GCP Console.
- Required firewall rule: allow TCP port **22** (SSH).

### Windows Instances

- The creator uses the Console to generate a **username and password**.
- Anyone with those credentials can connect using an **RDP (Remote Desktop Protocol)** client.
- Required firewall rule: allow TCP port **3389** (RDP).

> If you're using the **default network**, these firewall rules are already defined — no manual setup needed.

---

## VM Lifecycle

A VM moves through several states from creation to deletion:

| State | What's Happening |
|---|---|
| **Provisioning** | Resources (CPU, memory, disks) are being reserved; VM not running yet |
| **Staging** | Resources acquired; IP addresses added, system image booting |
| **Running** | VM is live; startup scripts run; SSH/RDP access enabled |
| **Stopping** | Shutdown scripts run; transitioning to terminated |
| **Terminated** | VM is stopped; can be restarted or deleted |
| **Repairing** | Internal error or host unavailable; VM unusable; not billed; not covered by SLA |
| **Suspending / Suspended** | VM is being suspended; can be resumed or deleted |

### While Running, You Can

- **Live migrate** the VM to another host in the same zone (no reboot needed).
- Move the VM to a **different zone**.
- Take a **snapshot** of the persistent disk.
- **Export** the system image.
- **Reconfigure metadata**.

### Stopping a VM (Required For)

- Upgrading machine type (e.g., adding more CPU).
- Changing the image is **not possible** on a stopped VM.

### Reset vs. Stop

- **Reset**: wipes memory and restarts the VM back to its initial state; VM stays in the **running** state throughout.
- **Stop**: transitions the VM to **terminated**; can then restart or delete.

### Shutdown Timing

- Normal shutdown (stop, reboot, delete): allows ~**90 seconds** for shutdown scripts.
- **Preemptible VMs**: if the instance doesn't stop within **30 seconds**, Compute Engine sends an **ACPI G3 Mechanical Off** signal — keep this in mind when writing shutdown scripts.

### Billing While Terminated

- You are **not charged** for CPU and memory when a VM is terminated.
- You **are charged** for any **attached persistent disks** and **reserved static IP addresses**.

---

## Availability Policies

- **On host maintenance**: default behavior is **live migrate**; can be changed to **terminate** during maintenance events.
- **Automatic restart**: if a VM is terminated due to a crash or maintenance, it **restarts automatically** by default; this can be disabled.
- These settings can be configured at **creation time** or **while the VM is running**.

---

## OS Patch Management

- When you use a **premium OS image**, the cost includes both OS usage and **patch management**.
- Use **OS Patch Management** to apply OS patches across a fleet of Compute Engine VMs.
- Long-running VMs need regular updates to stay secure and stable.

### Two Main Components

1. **Patch compliance reporting** — shows patch status across Windows and Linux VMs, with recommendations.
2. **Patch deployment** — automates OS and software patch updates via scheduled patch jobs.

### What You Can Do

- Create **patch approvals** — choose exactly which patches to apply from the available set.
- Set up **flexible scheduling** — one-time or recurring patch schedules.
- Apply **advanced configurations** — add pre/post patching scripts.
- Manage all patch jobs from a **centralized location**.

---

## Machine Families and CPU/Memory Options

### Ways to Create and Configure a VM

1. **GCP Console** — visual, easy, shows real-time cost
2. **Cloud Shell / `gcloud` CLI** — good for scripting and automation
3. **RESTful API** — best for complex, programmatic configurations

> Tip: Configure a VM in the Console first, then use the equivalent REST/CLI output to avoid typos and see all available options.

---

### Machine Family Overview

When creating a VM, you pick a **machine type** from a **machine family**. Each family is optimized for different workloads.

There are **four machine families**:

1. General-purpose
2. Compute-optimized
3. Memory-optimized
4. Accelerator-optimized

---

### 1. General-Purpose

Best price-performance; most flexible vCPU-to-memory ratios; targets standard and cloud-native workloads.

| Series | Description | vCPUs | Memory/vCPU | Use Cases |
|---|---|---|---|---|
| **E2** | Lowest cost; no CPU architecture dependency | 2–32 | 0.5–8 GB | Web servers, small/medium DBs, dev/test |
| **E2 Shared-core** | Uses context-switching to share a physical core | 0.25–1 | 0.5–8 GB | Small, non-resource-intensive apps |
| **N2** (Intel) | Next-gen after N1; flexible shapes; Cascade Lake (≤80 vCPU) / Ice Lake (larger) | Up to 128 | 0.5–8 GB | Enterprise apps, medium-large DBs, web serving |
| **N2D** (AMD) | AMD EPYC Milan/Rome; large node sizes | Up to 224 | 0.5–8 GB | Same as N2 |
| **T2D** (AMD) | 3rd Gen AMD EPYC; scale-out workloads; full x86 | Up to 60 | 4 GB | Web servers, microservices, media transcoding, Java apps |
| **T2A** (Arm) | First Arm-based series in GCP; Ampere Altra 64-core @ 3 GHz | — | — | Containerized workloads; supported by GKE node pools |

---

### 2. Compute-Optimized

Highest performance per core; best for compute-intensive workloads.

| Series | Processor | vCPUs | Memory | Use Cases |
|---|---|---|---|---|
| **C2** | Intel Cascade Lake (up to 3.8 GHz all-core turbo) | 4–60 | Up to 240 GB | Gaming, EDA, HPC, simulations, genomics, media transcoding |
| **C2D** | AMD EPYC Milan; largest LLC per core | 2–112 | 4 GB/vCPU | High-performance computing |
| **H3** | Intel Sapphire Rapids + Google custom IPU | 88 | 352 GB DDR5 | High-performance computing |

- C2 and C2D can attach up to **3 TB of local storage** for storage-intensive workloads.

---

### 3. Memory-Optimized

Most memory per vCPU of any family; lowest cost per GB of memory on Compute Engine.

| Series | Max Memory | Use Cases |
|---|---|---|
| **M1** | Up to 4 TB | SAP HANA, in-memory databases, analytics |
| **M2** | Up to 12 TB | Large in-memory databases, analytics |
| **M3** | Up to 128 vCPUs, 30.5 GB/vCPU (Intel Ice Lake) | Genomic modeling, EDA, HPC |

- M1 and M2 offer up to **30% sustained use discounts** and **>60% savings** with 3-year committed use discounts.

---

### 4. Accelerator-Optimized

Best for massively parallel GPU workloads (CUDA); ideal for ML and HPC.

| Series | vCPUs | Memory | GPU | Use Cases |
|---|---|---|---|---|
| **A2** | 12–96 | Up to 1,360 GB | Up to 16x NVIDIA A100 (40 GB GPU memory each) | LLMs, HPC, large databases |
| **G2** | 4–96 | Up to 432 GB (Intel Cascade Lake) | NVIDIA L4 | CUDA ML training/inference, video transcoding, remote visualization |

---

### Custom Machine Types

Use when no predefined type fits your workload exactly.

- Specify your own **vCPU count** and **memory amount**.
- Costs slightly more than an equivalent predefined type.

**Constraints:**
- vCPUs must be **1 or an even number**.
- Memory must be between **1 GB and 8 GB per vCPU**.
- Total memory must be a **multiple of 256 MB**.
- Need more than 8 GB/vCPU? Use **extended memory** (available at additional cost).
