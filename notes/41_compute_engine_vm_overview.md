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

## gcloud Commands

```bash
# List all VM instances
gcloud compute instances list

# Describe a VM
gcloud compute instances describe my-vm --zone=us-central1-a

# Create a VM
gcloud compute instances create my-vm --zone=us-central1-a \
  --machine-type=e2-medium \
  --image-family=debian-11 --image-project=debian-cloud
```
