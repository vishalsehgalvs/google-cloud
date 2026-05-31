# Application Load Balancing

## Overview

- Operates at **Layer 7** (application layer) of the OSI model
- Routes decisions based on **URL / HTTP content**
- Distributes HTTP and HTTPS traffic to backends on: Compute Engine, GKE, Cloud Storage, Cloud Run, and external backends (internet or hybrid connectivity)

---

## Deployment Modes

| Mode                  | Description                                                                                                                                 |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| **Global external**   | Uses Google Front Ends (GFEs) distributed globally; multi-region load balancing in Premium tier; directs traffic to closest healthy backend |
| **Regional external** | Uses open-source Envoy proxy; advanced traffic management                                                                                   |
| **Classic**           | Uses GFEs; older generation                                                                                                                 |
| **Internal**          | For internal traffic within a VPC (covered separately)                                                                                      |

- Global external and classic ALBs use **Google Front Ends (GFEs)**
- Global and regional external ALBs use **Envoy proxy** for advanced traffic management
- GFEs terminate HTTP(S) traffic as close as possible to users

---

## Architecture

```
Client
  │
  ▼
External Forwarding Rule  ← external IP address + port
  │
  ▼
Target HTTP(S) Proxy  ← evaluates request using URL map; handles SSL certificates
  │
  ▼
URL Map  ← routing decisions based on URL
  │
  ▼
Backend Service / Backend Bucket
  │  ├─ Health check
  │  ├─ Session affinity
  │  ├─ Timeout setting (default: 30s)
  │  └─ One or more Backends
  │
  ▼
Backend  ← instance group + balancing mode + capacity scaler
  │
  ▼
VM Instances
```

---

## Backend Service Details

| Setting               | Description                                                                                                       |
| --------------------- | ----------------------------------------------------------------------------------------------------------------- |
| **Health check**      | Polls instances at configured intervals; unhealthy instances stop receiving traffic until they recover            |
| **Routing algorithm** | Round-robin by default                                                                                            |
| **Session affinity**  | Override round-robin to send all requests from the same client to the same VM                                     |
| **Timeout**           | Fixed timeout (not idle) for the backend to respond; default **30 seconds** — increase for long-lived connections |

---

## Backend Details

| Component           | Description                                                                                                |
| ------------------- | ---------------------------------------------------------------------------------------------------------- |
| **Instance group**  | Managed (with or without autoscaling) or unmanaged                                                         |
| **Balancing mode**  | Determines when a backend is at full usage — based on **CPU utilization** or **requests per second (RPS)** |
| **Capacity scaler** | Additional multiplier on the balancing mode threshold                                                      |

### Balancing Mode + Capacity Example

- Target: instances operate at max 80% CPU → set balancing mode to **80% CPU**, capacity to **100%**
- To cut utilization in half → keep balancing mode at **80% CPU**, set capacity to **50%**

If all backends in a region are at full usage, requests are **automatically routed to the nearest region** that still has capacity.

> Changes to backend services take **several minutes** to propagate across the network.
