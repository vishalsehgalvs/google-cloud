# Internal Load Balancing

## Internal Application Load Balancers

- **Envoy proxy-based, regional, Layer 7** load balancers
- Run and scale HTTP application traffic behind an **internal IP address**
- Backends in one region; can be made globally accessible from any Google Cloud region
- Optimizes traffic distribution within your VPC or networks connected to your VPC

### Deployment Modes

| Mode | Description |
|---|---|
| **Regional internal** | All clients and backends must be in a specified region; useful for regional compliance; rich HTTP(S) traffic control; auto-allocates Envoy proxies |
| **Cross-region internal** | Multi-region; routes traffic to the globally distributed closest backend; supports failover across regions for high availability |

---

## Internal Passthrough Network Load Balancer

- **Regional, private, Layer 4** load balancer — not a proxy
- Supports: TCP, UDP, ICMP, ICMPv6, SCTP, ESP, AH, GRE (useful for ports not supported by other LBs)
- Only accessible via **internal IP addresses** of VMs in the same region
- All traffic stays within the VPC network and region → **lower latency**, simpler configuration

### How It Differs from a Traditional Proxy LB

| Traditional Proxy Model | Google Cloud Internal Passthrough NLB |
|---|---|
| Client → Load Balancer (terminates connection) → Backend (new connection) — two separate TCP connections | Client → Backend directly via Andromeda; load balancing is built into the network virtualization stack — one connection |

- Built on **Andromeda** (Google's network virtualization stack)
- Software-defined, fully distributed — **not device- or VM-based**

---

## Internal Proxy Network Load Balancers

- **Envoy proxy-based + Andromeda**, Layer 4, TCP traffic
- Load balances traffic **within your VPC** or connected networks
- Accessible only to clients in the same VPC or networks connected to your VPC
- Terminates TCP at the Envoy proxy → opens a second TCP connection to the backend (GCP, on-premises, or other clouds)

### Deployment Modes

| Mode | Description |
|---|---|
| **Regional internal** | All clients and backends in a specified region; regional compliance support |
| **Cross-region internal** | Multi-region; routes to closest backend; failover across regions |

---

## 3-Tier Web Architecture Example

A common internal load balancing use case — none of the backend tiers are exposed to the internet:

```
Users (San Francisco, Iowa, Singapore, ...)
        │
External Application Load Balancer (single global IP)
        │
Web tier backends: us-west1, us-central1, asia-east1
        │
Internal Network Load Balancer (per region)
        │
App tier backends: us-west1-a, us-central1-b, asia-east1-b
        │
Database tier (per zone)
```

- **External ALB** handles public traffic
- **Internal NLB** connects the web tier to the app tier — not exposed externally
- **Database tier** is also never exposed externally
- Benefits: simplified security, reduced network pricing

## ACE Exam-Style Practice Questions

### Q1
A Internal Load Balancing requirement needs host and path-based routing for internet users with managed TLS. Which option is best?

A. External Application Load Balancer
B. Internal passthrough load balancer
C. Cloud NAT
D. Direct VM IP without load balancing

Answer: A
Trap: URL map and host routing are Layer 7 capabilities.

### Q2
In a Internal Load Balancing case, you must preserve original client IP and handle UDP. Which option should you pick?

A. Application Load Balancer
B. Passthrough Network Load Balancer
C. Cloud CDN only
D. Cloud DNS private zone

Answer: B
Trap: Client-IP preservation and UDP are Layer 4 passthrough patterns.
