# Hybrid Connectivity and VPC Sharing — Module Summary

## Connectivity Services Covered

| Service                | Type                     | Layer               | SLA                   |
| ---------------------- | ------------------------ | ------------------- | --------------------- |
| Dedicated Interconnect | Dedicated                | Layer 2             | Yes (99.9% or 99.99%) |
| Partner Interconnect   | Shared                   | Layer 2 or 3        | Yes (99.9% or 99.99%) |
| Cloud VPN              | Shared (public internet) | Layer 3 (encrypted) | Yes (99.9%)           |
| Direct Peering         | Dedicated                | Layer 3             | No                    |
| Carrier Peering        | Shared                   | Layer 3             | No                    |

## VPC Sharing Configurations Covered

| Configuration       | Scope                                         | Admin Model   |
| ------------------- | --------------------------------------------- | ------------- |
| Shared VPC          | Within the same organization, across projects | Centralized   |
| VPC Network Peering | Across projects or organizations              | Decentralized |

---

## Key Takeaway

You might start with one connectivity service and migrate to another as requirements change or new colocation facilities open. Choose based on bandwidth needs, encryption requirements, proximity to Google PoPs or colocation facilities, and whether you need internal or public IP access.

## ACE Exam-Style Practice Questions

### Q1
For Hybrid Connectivity Module Summary, you need highly available hybrid connectivity with dynamic route exchange. What should you choose?

A. HA VPN with Cloud Router
B. Static routes only over one tunnel
C. Cloud NAT only
D. Cloud CDN

Answer: A
Trap: Dynamic routing and high availability requirements usually indicate HA VPN plus BGP.

### Q2
In a Hybrid Connectivity Module Summary design, multiple projects in one org need centralized networking administration. What is best?

A. Shared VPC
B. Separate isolated VPCs with no governance
C. One service account for every project owner
D. DNS forwarding only

Answer: A
Trap: Shared VPC centralizes subnet and firewall control across service projects.
