# Compute Engine Machine Families

## Ways to Create and Configure a VM

1. **GCP Console** — visual, easy, shows real-time cost
2. **Cloud Shell / `gcloud` CLI** — good for scripting and automation
3. **RESTful API** — best for complex, programmatic configurations

> Tip: Configure a VM in the Console first, then use the equivalent REST/CLI output to avoid typos and see all available options.

---

## Machine Family Overview

When creating a VM, you pick a **machine type** from a **machine family**. Each family is optimized for different workloads.

There are **four machine families**:

1. General-purpose
2. Compute-optimized
3. Memory-optimized
4. Accelerator-optimized

---

## 1. General-Purpose

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

## 2. Compute-Optimized

Highest performance per core; best for compute-intensive workloads.

| Series | Processor | vCPUs | Memory | Use Cases |
|---|---|---|---|---|
| **C2** | Intel Cascade Lake (up to 3.8 GHz all-core turbo) | 4–60 | Up to 240 GB | Gaming, EDA, HPC, simulations, genomics, media transcoding |
| **C2D** | AMD EPYC Milan; largest LLC per core | 2–112 | 4 GB/vCPU | High-performance computing |
| **H3** | Intel Sapphire Rapids + Google custom IPU | 88 | 352 GB DDR5 | High-performance computing |

- C2 and C2D can attach up to **3 TB of local storage** for storage-intensive workloads.

---

## 3. Memory-Optimized

Most memory per vCPU of any family; lowest cost per GB of memory on Compute Engine.

| Series | Max Memory | Use Cases |
|---|---|---|
| **M1** | Up to 4 TB | SAP HANA, in-memory databases, analytics |
| **M2** | Up to 12 TB | Large in-memory databases, analytics |
| **M3** | Up to 128 vCPUs, 30.5 GB/vCPU (Intel Ice Lake) | Genomic modeling, EDA, HPC |

- M1 and M2 offer up to **30% sustained use discounts** and **>60% savings** with 3-year committed use discounts.

---

## 4. Accelerator-Optimized

Best for massively parallel GPU workloads (CUDA); ideal for ML and HPC.

| Series | vCPUs | Memory | GPU | Use Cases |
|---|---|---|---|---|
| **A2** | 12–96 | Up to 1,360 GB | Up to 16x NVIDIA A100 (40 GB GPU memory each) | LLMs, HPC, large databases |
| **G2** | 4–96 | Up to 432 GB (Intel Cascade Lake) | NVIDIA L4 | CUDA ML training/inference, video transcoding, remote visualization |

---

## Custom Machine Types

Use when no predefined type fits your workload exactly.

- Specify your own **vCPU count** and **memory amount**.
- Costs slightly more than an equivalent predefined type.

**Constraints:**

- vCPUs must be **1 or an even number**.
- Memory must be between **1 GB and 8 GB per vCPU**.
- Total memory must be a **multiple of 256 MB**.
- Need more than 8 GB/vCPU? Use **extended memory** (available at additional cost).
