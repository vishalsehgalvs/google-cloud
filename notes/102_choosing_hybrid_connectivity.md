# Choosing the Right Hybrid Connectivity Option

## Interconnect vs. Peering

| Category         | Services                                                               | IP Access               | SLA |
| ---------------- | ---------------------------------------------------------------------- | ----------------------- | --- |
| **Interconnect** | Dedicated Interconnect, Partner Interconnect, Cross-Cloud Interconnect | RFC 1918 (internal IPs) | Yes |
| **Peering**      | Direct Peering, Carrier Peering                                        | Public IPs only         | No  |

---

## Decision Flow

### 1. Do you need access to Workspace, YouTube, or Google Cloud APIs?

- **Yes** → Use a **Peering** service
  - Can meet Google's Direct Peering requirements? → **Direct Peering**
  - Cannot meet requirements? → **Carrier Peering**

### 2. Do you need to connect GCP to another cloud provider?

- **Yes, high bandwidth + Google-managed routing** → **Cross-Cloud Interconnect**
- **Yes, no high bandwidth + want Google-managed encryption** → **Cloud VPN**

### 3. Do you want to extend your on-premises network to Google Cloud (Interconnect)?

**Can you meet Google at a colocation facility?**

**No →**

- Modest bandwidth, short-term/trial, need encryption → **Cloud VPN**
- Otherwise → **Partner Interconnect**
  - Need BGP peering → **L2 Partner Interconnect**
  - Don't need BGP peering → **L3 Partner Interconnect**

**Yes →** Consider **Dedicated Interconnect**, but switch to **Cloud VPN or Partner Interconnect** if:

- You cannot provide your own encryption for sensitive traffic
- 10 Gbps is more than you need
- You need access to multiple cloud services

After choosing an Interconnect option:

- **Want Google-managed encryption?** → Use **Cloud VPN over Interconnect**

---

## Quick Reference Summary

| Need                                                        | Best Option                       |
| ----------------------------------------------------------- | --------------------------------- |
| Access Google APIs / Workspace / YouTube                    | Direct Peering or Carrier Peering |
| Multi-cloud, high bandwidth, Google-managed routing         | Cross-Cloud Interconnect          |
| Multi-cloud, low bandwidth, Google-managed encryption       | Cloud VPN                         |
| Extend to GCP, no nearby colocation, modest bandwidth/trial | Cloud VPN                         |
| Extend to GCP, no nearby colocation, higher bandwidth       | Partner Interconnect              |
| Extend to GCP, colocation available, large bandwidth        | Dedicated Interconnect            |
| Any Interconnect + Google-managed encryption                | Cloud VPN over Interconnect       |
