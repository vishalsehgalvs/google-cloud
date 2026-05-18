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
