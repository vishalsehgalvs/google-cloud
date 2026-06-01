# Choosing the Right Load Balancer

## Decision by Traffic Type

| Traffic Type | Choose |
|---|---|
| HTTP(S) — flexible feature set | **Application Load Balancer** |
| TLS offload, TCP proxy, external LB to backends in multiple regions | **Proxy Network Load Balancer** |
| Preserve client source IP, avoid proxy overhead, UDP/ESP/ICMP protocols, expose client IP to apps | **Passthrough Network Load Balancer** |

---

## Further Narrowing by Scope and Direction

After choosing the traffic type, narrow down based on:

1. **External** (internet-facing) vs. **Internal** (within VPC)
2. **Global** backends vs. **Regional** backends

| Load Balancer | External / Internal | Global / Regional | Scheme |
|---|---|---|---|
| Global external Application LB | External | Global | MANAGED (GFE or Envoy) |
| Regional external Application LB | External | Regional | MANAGED (Envoy) |
| Classic Application LB | External | Global | MANAGED (GFE) |
| Regional internal Application LB | Internal | Regional | MANAGED (Envoy) |
| Cross-region internal Application LB | Internal | Global | MANAGED (Envoy) |
| Global external proxy Network LB | External | Global | MANAGED (GFE or Envoy) |
| Regional external proxy Network LB | External | Regional | MANAGED (Envoy) |
| Regional internal proxy Network LB | Internal | Regional | MANAGED (Envoy) |
| Cross-region internal proxy Network LB | Internal | Global | MANAGED (Envoy) |
| External passthrough Network LB | External | Regional | — |
| Internal passthrough Network LB | Internal | Regional | — |

---

## Key Concepts

- **Load-balancing scheme** — an attribute on the forwarding rule and backend service; indicates whether the LB handles internal or external traffic
- **MANAGED scheme** — load balancer is implemented as a managed service on **Google Front Ends (GFEs)** or **open-source Envoy proxy**; requests are routed to GFE or Envoy
- **Passthrough LBs** — not proxy-based; packets flow directly to backends with source/destination unchanged
