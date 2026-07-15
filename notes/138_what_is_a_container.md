# What Is a Container?

## Evolution of Application Deployment

### Era 1 — Physical Servers

- Apps ran on dedicated local computers
- Required physical space, power, cooling, and network connectivity
- Install OS → install dependencies → install app
- Each machine typically had **one purpose** (database, web server, CDN)
- Wasted resources; slow to deploy, maintain, and scale

---

### Era 2 — Virtualization

- **Virtualization** = creating a virtual version of a physical resource (server, storage, network)
- A **hypervisor** breaks the dependency of an OS on the underlying hardware, allowing multiple VMs to share one physical host
- **KVM (Kernel-based Virtual Machine)** is one well-known hypervisor

#### Benefits over physical servers

| Benefit            | Detail                          |
| ------------------ | ------------------------------- |
| Faster deployment  | New servers provisioned quickly |
| Less waste         | Fewer idle machines             |
| Better portability | VMs can be imaged and moved     |

#### Remaining problems with VMs

- App + all dependencies + full OS are still bundled together
- Moving a VM between hypervisor products is not easy
- Each VM boot requires a full OS start-up
- **Multiple apps sharing one VM are not isolated:**
  - One app's resource use can starve others
  - A dependency upgrade for one app can break another
- Running a **dedicated VM per app** solves isolation but duplicates full kernels — doesn't scale to hundreds or thousands of apps

---

### Era 3 — Containers

> "Virtualize at the level of the application and its dependencies, not the entire machine."

- Only the **user space** is virtualized (all code above the kernel: apps + their dependencies)
- The kernel is shared — no need to boot a full OS per app

---

## What Is a Container?

> **Containers are isolated user spaces for running application code.**

- **Lightweight** — do not carry a full OS
- **Efficient** — scheduled and integrated tightly with the underlying system
- **Fast** — start/stop by creating/destroying OS processes, not booting VMs

---

## Why Containers Appeal to Developers

| Benefit                          | Detail                                                                                           |
| -------------------------------- | ------------------------------------------------------------------------------------------------ |
| **Code-centric delivery**        | High-performing, scalable apps without infrastructure complexity                                 |
| **Reliable, consistent runtime** | Linux kernel base means code runs the same locally and in production                             |
| **Fast incremental updates**     | Changes to a container built on a production image deploy with a single file copy                |
| **Microservices-friendly**       | Loosely coupled, fine-grained components; OS can scale/upgrade parts without affecting the whole |

---

## Key Concept: User Space vs. Kernel Space

```
┌────────────────────────────────┐
│  User space                    │  ← containers live here
│  (apps + dependencies)         │
├────────────────────────────────┤
│  Linux Kernel                  │  ← shared by all containers on the host
├────────────────────────────────┤
│  Hardware                      │
└────────────────────────────────┘
```

## ACE Exam-Style Practice Questions

### Q1
In a What Is A Container scenario, two answers seem technically possible. What tie-breaker should you apply first?

A. Pick the option with most manual steps
B. Pick the option with least privilege and least operational overhead that still meets requirements
C. Pick highest-cost option
D. Pick the oldest product

Answer: B
Trap: ACE-style scenarios reward secure, managed, requirement-fit decisions.

### Q2
For What Is A Container, what is the best way to reduce wrong answers in multi-choice questions?

A. Ignore scaling and security words
B. Identify trigger words, eliminate over-privileged choices, then choose the managed fit
C. Always pick Compute Engine
D. Always pick the shortest option

Answer: B
Trap: Structured elimination is more reliable than memorization alone.
