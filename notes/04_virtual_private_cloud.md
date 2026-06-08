# 🌐 Virtual Private Cloud (VPC) Networking

## What is a VPC?

A **Virtual Private Cloud (VPC)** is a secure, private cloud environment hosted inside a public cloud (like Google Cloud).

- You can run code, store data, host websites — anything you'd do in a private cloud.
- But it's hosted and managed by the public cloud provider.
- Best of both worlds: **public cloud scalability + private cloud data isolation**.

---

## What VPC Networks Do

VPC networks connect Google Cloud resources to each other and to the internet. Key capabilities:

- **Segment networks** — divide your network into logical pieces
- **Firewall rules** — restrict access to specific instances
- **Static routes** — forward traffic to specific destinations

---

## Key Feature: VPCs Are Global

> Most people expect networks to be regional — but Google VPCs are **global**.

| Concept    | What it means                                                              |
| ---------- | -------------------------------------------------------------------------- |
| **VPC**    | Global — one VPC can span the entire world                                 |
| **Subnet** | Regional — a segmented piece of the VPC, tied to a specific Google region  |
| **Zone**   | Sub-division of a region — subnets can span multiple zones within a region |

---

## Subnets

- A **subnet** is a segmented piece of the larger VPC network.
- Subnets are **regional** — you place them in a specific region (e.g. `us-east1`, `asia-east1`).
- A subnet can **span multiple zones** within that region.
- Resources in **different zones** can sit on the **same subnet**.
- You can **expand a subnet** by increasing its IP address range — existing VMs are not affected.

---

## Example

> VPC named `vpc1` with two subnets: one in `asia-east1`, one in `us-east1`.
> Three Compute Engine VMs are attached to the same subnet.
> Even though the VMs are in different zones, they're neighbors on the same subnet.

This design makes it easy to build layouts that are:

- **Resilient** — spread across zones, so one zone failing doesn't take everything down
- **Simple** — still one clean network layout, no complex cross-network routing needed

---

## gcloud Commands

```bash
# List all VPC networks
gcloud compute networks list

# Create a VPC network (custom mode)
gcloud compute networks create my-vpc --subnet-mode=custom

# List subnets
gcloud compute networks subnets list

# Create a subnet
gcloud compute networks subnets create my-subnet \
  --network=my-vpc --region=us-central1 --range=10.0.0.0/24

# Delete a network
gcloud compute networks delete my-vpc
```

---

## Private Google Access

Allows VM instances **without external IP addresses** to reach Google APIs and services (Cloud Storage, BigQuery, etc.) through Google's private network:

- Enabled per subnet: `--enable-private-ip-google-access`
- Without it, VMs with only internal IPs cannot call Google APIs
- Traffic never leaves Google's network

```bash
gcloud compute networks subnets update my-subnet \
  --region=us-central1 --enable-private-ip-google-access
```

---

## VPC Flow Logs

Captures **network flow metadata** (5-tuple: src IP, dst IP, src port, dst port, protocol) for traffic in/out of VMs:

- Enabled per subnet
- Logs sent to Cloud Logging — can be exported to BigQuery or Pub/Sub
- Use cases: network monitoring, security forensics, cost optimisation
- Sampling rate configurable (default 50%) to manage cost

```bash
gcloud compute networks subnets update my-subnet \
  --region=us-central1 --enable-flow-logs
```

---

## Shared VPC

Allows resources in **multiple projects** to use a single VPC network:

| Concept | Description |
|---|---|
| **Host project** | Owns the shared VPC network |
| **Service projects** | Use the shared network; cannot modify it |
| **Shared VPC Admin** | IAM role required to configure sharing (`roles/compute.xpnAdmin`) |

- Centralises network management and firewall rules
- Service project VMs communicate as if on the same network
- Billing stays per project

```bash
# Enable host project
gcloud compute shared-vpc enable HOST_PROJECT_ID

# Associate a service project
gcloud compute shared-vpc associated-projects add SERVICE_PROJECT_ID \
  --host-project=HOST_PROJECT_ID
```

---

## VPC Peering

Connects two VPC networks (same or different projects/organisations) so they can communicate privately:

- Traffic stays on Google's network — no external IPs needed
- **Not transitive** — if A peers with B and B peers with C, A cannot reach C
- Each side must create a peering connection independently
- Subnet CIDR ranges must not overlap

```bash
gcloud compute networks peerings create peer-a-to-b \
  --network=network-a \
  --peer-project=PROJECT_B \
  --peer-network=network-b
```

**Shared VPC vs VPC Peering:**

| | Shared VPC | VPC Peering |
|---|---|---|
| Admin model | Centralised (host project) | Decentralised (each side manages own) |
| Cross-org | No | Yes |
| Transitive routing | N/A | No |
| Use case | Internal multi-project workloads | Partner/separate org connectivity |

---

## VPC Service Controls

Creates a **security perimeter** around Google API services to prevent data exfiltration:

- Define which projects/services are inside the perimeter
- Requests crossing the perimeter boundary are denied by default
- Protects against: compromised credentials, insider threats, misconfigured buckets
- Works with Cloud Storage, BigQuery, Spanner, and many other APIs

---

## Secondary IP Ranges

Subnets can have **secondary IP ranges** — used by GKE for Pod and Service IPs:

```bash
gcloud compute networks subnets update my-subnet \
  --region=us-central1 \
  --add-secondary-ranges=pod-range=10.1.0.0/16,svc-range=10.2.0.0/20
```

- Primary range: VM primary interface IPs
- Secondary ranges: alias IPs for containers (GKE Pods) or additional interfaces
