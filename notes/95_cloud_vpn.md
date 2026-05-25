# Cloud VPN

## Overview

Two types of Cloud VPN gateways:

| Type | SLA | Routing | Use Case |
|---|---|---|---|
| Classic VPN | 99.9% | Static or dynamic (BGP via Cloud Router) | Low-volume data connections |
| HA VPN | 99.99% | Dynamic (BGP) only | High availability production connections |

Both use **IPsec VPN tunnels** to encrypt traffic over the public internet between your on-premises network and a Google Cloud VPC.

> Cloud VPN does **not** support client VPN (dial-in from user laptops). It's site-to-site only.

---

## Classic VPN

- Regional resource with a regional external IP address
- Supports: site-to-site VPN, static routes, dynamic routes (BGP), IKEv1 and IKEv2
- **MTU limit**: on-premises VPN gateway MTU cannot exceed **1460 bytes** (due to encryption/encapsulation overhead)

### How It Works

```
GCP VPC (us-east1, us-west1)
        │
  Cloud VPN Gateway (regional external IP)
        │
   VPN Tunnel (encrypted)     ← must establish TWO tunnels for a connection
        │
  On-premises VPN Gateway (external IP — physical device or software)
        │
   On-premises network
```

- Two VPN tunnels required — each defines the connection from its own gateway's perspective
- Traffic only passes when **both tunnels are established**

---

## HA VPN

- High availability VPN with **99.99% SLA**
- Two external IP addresses automatically assigned (one per interface) from unique address pools
- **Each interface supports multiple tunnels**
- Requires **dynamic (BGP) routing** — static routes not supported
- Routing modes: **active/active** or **active/passive** (configured via route priorities)

### To Achieve 99.99% SLA
Must configure **2 or 4 tunnels** from the HA VPN gateway to the peer.

### Supported Topologies

| Topology | Details |
|---|---|
| HA VPN → two peer VPN devices (each with own IP) | `TWO_IPS_REDUNDANCY`; second device provides failover and maintenance window |
| HA VPN → one peer device with two IPs | Single device, two interfaces |
| HA VPN → one peer device with one IP | Single interface — does NOT provide 99.99% SLA |
| HA VPN → AWS virtual private gateway | 4 tunnels total (2 per AWS gateway per HA VPN interface); transit gateway supports ECMP routing |
| HA VPN ↔ HA VPN (two GCP VPCs) | Interface 0 → Interface 0; Interface 1 → Interface 1; provides 99.99% |

### AWS Configuration
- Components: HA VPN gateway (2 interfaces) + 2 AWS virtual private gateways + external VPN gateway resource in GCP
- 4 tunnels total: 2 from AWS gateway 1 → HA VPN interface 0, 2 from AWS gateway 2 → HA VPN interface 1
- Only **transit gateway** supports ECMP (equal-cost multipath) routing — distributes traffic equally across active tunnels

---

## Cloud Router and Dynamic Routing (BGP)

Cloud Router enables dynamic routes — no need to update tunnel configuration when subnets change.

### How BGP Works with Cloud VPN

```
GCP VPC (Test subnet, Prod subnet)
  └─ Cloud Router
        └─ BGP session over VPN tunnel
              └─ On-premises VPN gateway (must support BGP)
                    └─ On-premises network (29 subnets)
```

- Adding a new **Staging** subnet in GCP or a new on-premises subnet → automatically advertised via BGP
- Instances in new subnets can send/receive traffic immediately

### BGP Link-Local Addresses
- Each end of the VPN tunnel needs an additional IP for the BGP session
- Must use **link-local addresses**: `169.254.0.0/16`
- These are not part of either network's IP space — used exclusively for BGP

---

## gcloud Commands

```bash
# Create a Classic VPN gateway
gcloud compute vpn-gateways create my-vpn-gateway \
  --network=my-vpc \
  --region=us-central1

# Create an HA VPN gateway
gcloud compute vpn-gateways create my-ha-vpn \
  --network=my-vpc \
  --region=us-central1

# List VPN gateways
gcloud compute vpn-gateways list

# Create an external VPN gateway (peer/on-premises)
gcloud compute external-vpn-gateways create my-peer-gateway \
  --interfaces=0=203.0.113.1

# Create a VPN tunnel
gcloud compute vpn-tunnels create my-tunnel \
  --peer-address=203.0.113.1 \
  --shared-secret=my-secret \
  --target-vpn-gateway=my-vpn-gateway \
  --region=us-central1 \
  --ike-version=2

# Create a Cloud Router for BGP
gcloud compute routers create my-router \
  --network=my-vpc \
  --region=us-central1 \
  --asn=65001

# Add a BGP interface to Cloud Router (link-local IP)
gcloud compute routers add-interface my-router \
  --interface-name=my-bgp-interface \
  --vpn-tunnel=my-tunnel \
  --ip-address=169.254.0.1 \
  --mask-length=30 \
  --region=us-central1

# Add BGP peer to Cloud Router
gcloud compute routers add-bgp-peer my-router \
  --peer-name=my-bgp-peer \
  --interface=my-bgp-interface \
  --peer-ip-address=169.254.0.2 \
  --peer-asn=65002 \
  --region=us-central1

# List VPN tunnels
gcloud compute vpn-tunnels list
```
