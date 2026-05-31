# Cloud Peering — Direct Peering and Carrier Peering

Peering services are used when you need access to **Google and Google Cloud properties** via public IP addresses.

---

## Direct Peering

- Establishes a **direct peering connection** between your business network and Google's network
- Exchange internet traffic at one of Google's **Edge Points of Presence (PoPs)**
- Uses **BGP route exchange** between Google and the peering entity
- Gives access to **all Google services** including the full suite of Google Cloud products
- **No SLA** (unlike Dedicated Interconnect)
- Requires satisfying Google's peering requirements
- **Capacity:** 10 Gbps per link
- **Requirement:** connection at a Google Cloud Edge PoP

### Google Edge PoPs

- Present on **90+ Internet exchanges** and **100+ interconnection facilities** worldwide
- Details available via Google's PeeringDB entries

---

## Carrier Peering

- Used when you need access to Google public infrastructure but **cannot satisfy Google's Direct Peering requirements**, or are not near a PoP
- Connect via a **Carrier Peering partner** (service provider)
- Work directly with your service provider to establish the connection and understand their requirements
- **No SLA**
- **Capacity and requirements** vary by service provider

---

## Peering Options Comparison

| Option          | Access                          | Capacity           | SLA  | Requirement                     |
| --------------- | ------------------------------- | ------------------ | ---- | ------------------------------- |
| Direct Peering  | All Google services (public IP) | 10 Gbps per link   | None | Connection at a Google Edge PoP |
| Carrier Peering | All Google services (public IP) | Varies by provider | None | Depends on service provider     |

> Both peering options provide **public IP address** access only. For internal IP access, use Cloud VPN or Cloud Interconnect instead.
