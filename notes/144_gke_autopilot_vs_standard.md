# GKE Autopilot vs Standard Mode

## High-Level Comparison

| Aspect                    | Autopilot                            | Standard                                                     |
| ------------------------- | ------------------------------------ | ------------------------------------------------------------ |
| **Management overhead**   | Low — hands-off experience           | High — you configure and manage everything                   |
| **Configuration options** | More restrictive                     | Full fine-grained control                                    |
| **Billing**               | Pay only for **Pods** (what you use) | Pay for all **provisioned infrastructure** regardless of use |
| **Recommended for**       | Most production workloads            | When you need specific low-level control                     |

> Unless you require the specific configuration control of Standard, **Autopilot is recommended**.

---

## Autopilot — Benefits

### Production-Ready

- Google-managed and optimized GKE instance
- Creates clusters according to battle-tested, hardened best practices
- Defines the underlying machine type based on workloads → optimizes usage and cost
- Adapts to changing workloads automatically
- Deploy production-ready clusters faster (no cluster management overhead)

### Strong Security Posture

- Google secures cluster nodes and infrastructure
- Eliminates infrastructure security management tasks
- **Locks down nodes** → reduces the cluster's attack surface
- Reduces ongoing configuration mistakes

### Operational Efficiency

- Google monitors the entire cluster: control plane, worker nodes, and core Kubernetes system components
- Ensures Pods are always scheduled
- Keeps clusters up to date continuously
- Supports configurable **update windows** to minimize workload disruption

### Cost Efficiency

- Google is fully responsible for optimizing resource consumption
- You pay only for **Pods**, not nodes

---

## Autopilot — Restrictions

| Restriction                      | Detail                                                                                                  |
| -------------------------------- | ------------------------------------------------------------------------------------------------------- |
| **Managed service constraints**  | Config options more restrictive than Standard; has a pod-scheduling SLA                                 |
| **Node access**                  | Restricted access to node objects                                                                       |
| **SSH removed**                  | No SSH access to nodes                                                                                  |
| **Privilege escalation removed** | Not available                                                                                           |
| **Node affinity limitations**    | Limited node affinity and host access options                                                           |
| **QoS requirement**              | All Pods run with **Guaranteed class Quality of Service (QoS)** — requires a minor configuration change |

---

## Standard Mode

- Same functionality as Autopilot
- You are responsible for **configuration, management, and optimization** of the cluster
- Suitable when fine-grained control is a hard requirement
