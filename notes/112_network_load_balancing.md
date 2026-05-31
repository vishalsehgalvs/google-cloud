# Network Load Balancing

## Overview

- **Layer 4** load balancers that handle TCP, UDP, or other IP protocol traffic
- Can be **single-region or multi-region**
- Two types: **Proxy** or **Passthrough**

| Choose | When |
|---|---|
| **Proxy NLB** | You need a reverse proxy with advanced traffic controls; backends on-premises or in other clouds |
| **Passthrough NLB** | You need to preserve the client's source IP, prefer direct server return (DSR), or need to handle multiple IP protocols (TCP, UDP, ESP, GRE, ICMP, ICMPv6) |

---

## Proxy Network Load Balancers

- Layer 4 **reverse proxy** — traffic is **terminated at the load balancer**, then a new connection is forwarded to the closest available backend via TCP
- For **TCP traffic only** (with or without SSL) — use an Application Load Balancer for HTTP(S)
- Can be deployed **externally or internally**
- Built on **Google Front Ends (GFEs)** or **Envoy proxies**
- Deployment modes: **global, regional, or classic**

### Target TCP Proxy vs Target SSL Proxy

| Proxy Type | Traffic Handling |
|---|---|
| **Target TCP proxy** | TCP traffic; traffic between proxy and backend can use SSL or TCP (SSL recommended) |
| **Target SSL proxy** | SSL/TLS traffic; terminates SSL at the load balancer layer; backend traffic via SSL or TCP (SSL recommended) |

**Both work the same way:** traffic terminates at the global proxy layer → new connection to closest backend (e.g., Boston user → `us-east`, Iowa user → `us-central`, subject to capacity).

---

## Passthrough Network Load Balancers

- Layer 4 **regional** load balancers — distribute traffic to backends in the **same region**
- Implemented using **Andromeda virtual networking** and **Google Maglev**
- **Not a proxy** — packets are passed through with source/destination IP, protocol, and ports **unchanged**
- Connections terminate at the **backend VMs**, not at the load balancer
- Responses go **directly from backends to clients** — this is called **Direct Server Return (DSR)**
- Can be deployed **externally or internally**

### External Passthrough NLB

- Built on **Maglev**
- Accepts traffic from anywhere on the internet (regardless of Network Service Tier)
- Also accepts traffic from GCP VMs with external IPs, or VMs using Cloud NAT / instance-based NAT
- Backends configured via **backend service** (recommended for new deployments) or **target pool** (legacy)

### Backend Service-Based (Recommended)

Supports:
- IPv4 and IPv6
- Multiple protocols: TCP, UDP, ESP, GRE, ICMP, ICMPv6
- Managed and unmanaged instance group backends
- Zonal NEG backends with `GCE_VM_IP` endpoints
- Fine-grained traffic distribution controls and failover policies
- Non-legacy health checks (TCP, SSL, HTTP, HTTPS, HTTP/2)

### Target Pool (Legacy)

- Defines a group of instances that receive traffic from forwarding rules
- Load balancer picks an instance using a **hash of source IP:port + destination IP:port**
- Only supports **TCP and UDP** forwarding rules
- Limits:
  - Up to **50 target pools** per project
  - Each target pool can have **only one health check**
  - All instances must be in the **same region**

> You can migrate an existing target pool-based NLB to use a backend service instead.
