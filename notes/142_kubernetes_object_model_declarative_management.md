# Kubernetes Object Model and Declarative Management

## Two Core Concepts

### 1. The Kubernetes Object Model

- Everything Kubernetes manages is represented as an **object**
- You can view and change each object's attributes and state
- Objects are **persistent entities** that represent the state of something running in a cluster

Each object has two elements:

| Element           | Who sets it              | What it describes                 |
| ----------------- | ------------------------ | --------------------------------- |
| **Object spec**   | You                      | The _desired_ state of the object |
| **Object status** | Kubernetes control plane | The _current_ state of the object |

> **Kubernetes control plane** — the collection of system processes that collaborate to make a cluster work.

---

### 2. Declarative Management

- Tell Kubernetes the _desired state_; it figures out how to get there and stay there
- Implemented via a **watch loop**: Kubernetes continuously compares current state to desired state and remedies any drift

---

## Kubernetes Objects

- Objects represent:
  - Containerized applications
  - Resources available to them
  - Policies that affect their behavior
- Each object has a **kind** (its type)

---

## Pods — The Foundational Building Block

> A **Pod** is the smallest deployable Kubernetes object.

- Every running container in Kubernetes lives inside a Pod
- A Pod creates the environment where containers run
- A Pod can hold **one or more tightly coupled containers** that share resources

### Networking inside a Pod

- Kubernetes assigns each Pod a **unique IP address**
- All containers in a Pod share the same **network namespace** (IP address + ports)
- Containers within the same Pod communicate via **localhost (127.0.0.1)**

### Storage inside a Pod

- A Pod can specify **shared storage volumes** accessible by all its containers

---

## Declarative Management in Action — Example

**Goal:** Always keep 3 nginx web server containers running.

```
Desired state:  3 nginx Pods running
Current state:  0 Pods running
```

**Steps:**

1. Declare objects (Pods) representing the 3 nginx containers
2. Kubernetes control plane detects the mismatch (0 ≠ 3)
3. Kubernetes launches 3 Pods to match the desired state
4. Control plane **continuously monitors** the cluster, comparing reality to the declaration, and remediates as needed

```
Desired state (you declare) ──► Kubernetes watch loop ──► Current state (cluster)
                                        │
                          remediates drift automatically
```

## ACE Exam-Style Practice Questions

### Q1
In a Kubernetes Object Model Declarative Management cluster, one microservice is CPU-heavy while others are general purpose. How should you optimize?

A. Keep one node pool and only increase pod priority
B. Create dedicated compute-optimized node pool for CPU-heavy workload and keep general-purpose pool for others
C. Disable autoscaling
D. Move workload to Cloud Storage

Answer: B
Trap: Node pools allow workload-specific machine-family optimization.

### Q2
A Kubernetes Object Model Declarative Management deployment must be updated with minimal downtime. Which command pattern is best?

A. Delete and recreate service and deployment
B. kubectl set image deployment/NAME CONTAINER=NEW_IMAGE
C. Restart all cluster nodes
D. Create a new project for each version

Answer: B
Trap: Rolling image update is safer and faster than destructive redeploy patterns.
