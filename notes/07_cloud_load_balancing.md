# ⚖️ Cloud Load Balancing

## What is Load Balancing?

A **load balancer** distributes user traffic across multiple instances of an application.

- Spreads the load → reduces risk of performance issues.
- Cloud Load Balancing is **fully distributed, software-defined, and managed** — no VMs to manage yourself.
- No scaling or managing of the load balancers needed.
- **No pre-warming required** — handles sudden traffic spikes automatically (e.g. a game launch).

### What traffic it supports

- HTTP / HTTPS
- TCP and SSL
- UDP

### Key capabilities

- **Cross-region load balancing** — spreads traffic across multiple regions.
- **Automatic multi-region failover** — gradually shifts traffic away from unhealthy backends.
- Reacts quickly to changes in: users, traffic, network conditions, and backend health.

---

## Types of Load Balancers

Google Cloud load balancers are classified by which **OSI layer** they operate at.

---

### Application Load Balancers (Layer 7 — Application Layer)

- Handle **HTTP and HTTPS** traffic.
- Ideal for web apps needing advanced features:
  - **Content-based routing** — route traffic based on URL, headers, etc.
  - **SSL/TLS termination**
- Operate as **reverse proxies** — incoming traffic hits the load balancer, which then forwards to backends based on your rules.
- Available for both **external** (internet-facing) and **internal** applications.

---

### Network Load Balancers (Layer 4 — Transport Layer)

- Handle **TCP, UDP, and other IP protocols**.
- Two sub-types:

| Type                                  | How it works                                                                       | Best for                                                           |
| ------------------------------------- | ---------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| **Proxy Network Load Balancer**       | Acts as a reverse proxy — terminates client connections, opens new ones to backend | Advanced traffic management; backends on-premises or multi-cloud   |
| **Passthrough Network Load Balancer** | Does NOT modify or terminate connections — forwards traffic directly to backend    | Apps needing direct server return or a wider range of IP protocols |

> Key difference: Passthrough preserves the **original source IP address**; Proxy does not.

---

## gcloud Commands

```bash
# List forwarding rules (entry point for load balancers)
gcloud compute forwarding-rules list

# List backend services
gcloud compute backend-services list --global

# List health checks
gcloud compute health-checks list

# List URL maps (for Application Load Balancers)
gcloud compute url-maps list
```

## ACE Exam-Style Practice Questions

### Q1
A Cloud Load Balancing requirement needs host and path-based routing for internet users with managed TLS. Which option is best?

A. External Application Load Balancer
B. Internal passthrough load balancer
C. Cloud NAT
D. Direct VM IP without load balancing

Answer: A
Trap: URL map and host routing are Layer 7 capabilities.

### Q2
In a Cloud Load Balancing case, you must preserve original client IP and handle UDP. Which option should you pick?

A. Application Load Balancer
B. Passthrough Network Load Balancer
C. Cloud CDN only
D. Cloud DNS private zone

Answer: B
Trap: Client-IP preservation and UDP are Layer 4 passthrough patterns.
