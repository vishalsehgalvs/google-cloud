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
