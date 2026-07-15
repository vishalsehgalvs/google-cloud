# Cloud Interconnect and Peering — Overview

## Connection Types

Google Cloud offers four Cloud Interconnect and Peering services, categorized by **connection type** and **network layer**:

| Service                | Dedicated or Shared | Layer              |
| ---------------------- | ------------------- | ------------------ |
| Direct Peering         | Dedicated           | Layer 3            |
| Carrier Peering        | Shared              | Layer 3            |
| Dedicated Interconnect | Dedicated           | Layer 2            |
| Partner Interconnect   | Shared              | Layer 2 or Layer 3 |

---

## Key Distinctions

### Dedicated vs. Shared

- **Dedicated** — direct physical connection to Google's network
- **Shared** — connection to Google's network through a partner

### Layer 2 vs. Layer 3

- **Layer 2** — uses a VLAN that pipes directly into your GCP environment; provides access to **internal IP addresses** (RFC 1918 space)
- **Layer 3** — provides access to **Google Workspace, YouTube, and Google Cloud APIs** using public IP addresses

---

## Where Cloud VPN Fits

- Cloud VPN uses the **public internet** but encrypts traffic and provides access to **internal IP addresses**
- This makes it a useful complement to **Direct Peering** and **Carrier Peering**, which are Layer 3 (public IP) only

## ACE Exam-Style Practice Questions

### Q1
For Cloud Interconnect Peering Overview, you need highly available hybrid connectivity with dynamic route exchange. What should you choose?

A. HA VPN with Cloud Router
B. Static routes only over one tunnel
C. Cloud NAT only
D. Cloud CDN

Answer: A
Trap: Dynamic routing and high availability requirements usually indicate HA VPN plus BGP.

### Q2
In a Cloud Interconnect Peering Overview design, multiple projects in one org need centralized networking administration. What is best?

A. Shared VPC
B. Separate isolated VPCs with no governance
C. One service account for every project owner
D. DNS forwarding only

Answer: A
Trap: Shared VPC centralizes subnet and firewall control across service projects.
