# What Is Kubernetes?

## The Problem It Solves

- Containers are lean → teams create them in far greater numbers than they did VMs
- Containers need to communicate over the network — but without tooling they can't find each other
- **Kubernetes** is the solution for orchestrating containers at scale

---

## Definition

> **Kubernetes** is an open-source platform for managing containerized workloads and services.

- Orchestrate many containers on many hosts
- Scale them as microservices
- Deploy rollouts and rollbacks easily

---

## Architecture at a Glance

```
┌─────────────────────────────────────┐
│           Control Plane             │  ← primary components; manages the cluster
├─────────────────────────────────────┤
│  Node   │  Node   │  Node   │ ...   │  ← run the containers
└─────────────────────────────────────┘
              = Cluster
```

- Kubernetes is a **set of APIs** used to deploy containers on a **cluster** (a set of nodes)
- A **node** = a computing instance / machine
  - Different from a Google Cloud "node" which is a VM running in Compute Engine

---

## Declarative vs. Imperative Configuration

| Mode            | How it works                                                          | When to use                                                              |
| --------------- | --------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| **Declarative** | Describe the _desired state_; Kubernetes figures out how to get there | Default — keeps system conforming to desired state even through failures |
| **Imperative**  | Issue a series of commands to change state directly                   | Quick temporary fixes; building a declarative config                     |

- Declarative config always documents the system's desired state → **reduces risk of error**
- Kubernetes continuously works to keep the deployed system matching the declared state

---

## Key Features

| Feature                      | Detail                                                                                                                 |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| **Multiple workload types**  | Stateless apps (Nginx, Apache), stateful apps (persistent session/user data), batch jobs, daemon tasks                 |
| **Autoscaling**              | Automatically scales containers in and out based on resource utilization                                               |
| **Resource controls**        | Users specify _request levels_ and _limits_ per workload; improves overall cluster performance                         |
| **Extensibility**            | Rich ecosystem of plugins and add-ons; **Custom Resource Definitions (CRDs)** let developers define new resource types |
| **Portability / no lock-in** | Open-source; runs on-premises or on any cloud provider; workloads can move freely                                      |
