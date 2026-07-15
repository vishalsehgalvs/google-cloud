# Load Balancing and Autoscaling — Module Summary

## Topics Covered

| Topic | Notes |
|---|---|
| Managed Instance Groups (MIGs) | Instance templates, autoscaling, auto-healing, regional vs zonal |
| MIG autoscaling and health checks | CPU/RPS/metric/queue/schedule policies, health check criteria, stateful IPs |
| Application Load Balancing | Layer 7, global/regional/classic modes, backend services, session affinity, URL maps |
| ALB examples | Cross-region load balancing, content-based routing |
| ALB — HTTPS, backend buckets, NEGs | SSL certs, QUIC, Cloud Storage backends, NEG types |
| Cloud CDN | Edge caching, cache hit/miss, cache modes |
| Network Load Balancing | Layer 4, proxy vs passthrough, target pools, Maglev/Andromeda |
| Internal Load Balancing | Internal ALB, internal passthrough NLB, internal proxy NLB, 3-tier architecture |
| Choosing a load balancer | Decision by traffic type, external vs internal, global vs regional |

---

## Key Takeaways

- Use **Application Load Balancer** for HTTP(S) traffic with content-based or cross-region routing
- Use **proxy Network Load Balancer** for TCP/TLS offload or multi-region external backends
- Use **passthrough Network Load Balancer** to preserve client IPs or handle UDP/ICMP/ESP
- Combine an **external ALB** (internet-facing) with an **internal NLB** (app tier) to build secure 3-tier web services where backend tiers are never exposed publicly

## ACE Exam-Style Practice Questions

### Q1
A Load Balancing Module Summary requirement needs host and path-based routing for internet users with managed TLS. Which option is best?

A. External Application Load Balancer
B. Internal passthrough load balancer
C. Cloud NAT
D. Direct VM IP without load balancing

Answer: A
Trap: URL map and host routing are Layer 7 capabilities.

### Q2
In a Load Balancing Module Summary case, you must preserve original client IP and handle UDP. Which option should you pick?

A. Application Load Balancer
B. Passthrough Network Load Balancer
C. Cloud CDN only
D. Cloud DNS private zone

Answer: B
Trap: Client-IP preservation and UDP are Layer 4 passthrough patterns.
