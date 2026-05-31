# Hybrid Connectivity and VPC Sharing — Module Summary

## Connectivity Services Covered

| Service | Type | Layer | SLA |
|---|---|---|---|
| Dedicated Interconnect | Dedicated | Layer 2 | Yes (99.9% or 99.99%) |
| Partner Interconnect | Shared | Layer 2 or 3 | Yes (99.9% or 99.99%) |
| Cloud VPN | Shared (public internet) | Layer 3 (encrypted) | Yes (99.9%) |
| Direct Peering | Dedicated | Layer 3 | No |
| Carrier Peering | Shared | Layer 3 | No |

## VPC Sharing Configurations Covered

| Configuration | Scope | Admin Model |
|---|---|---|
| Shared VPC | Within the same organization, across projects | Centralized |
| VPC Network Peering | Across projects or organizations | Decentralized |

---

## Key Takeaway

You might start with one connectivity service and migrate to another as requirements change or new colocation facilities open. Choose based on bandwidth needs, encryption requirements, proximity to Google PoPs or colocation facilities, and whether you need internal or public IP access.
