# 🔧 VPC Features

## Routing Tables

- VPCs have **built-in routing tables** — no router to provision or manage.
- Used to forward traffic:
  - Between instances on the **same network**
  - Across **subnetworks**
  - Between **Google Cloud zones**
- No external IP address needed for any of this.

---

## Firewall

- VPCs include a **global distributed firewall** — no setup required.
- Controls both **incoming (ingress)** and **outgoing (egress)** traffic.

### Network Tags

A convenient way to apply firewall rules without tracking IP addresses:

1. Tag your VMs (e.g. tag all web servers with `"WEB"`)
2. Write a firewall rule targeting that tag (e.g. allow traffic on ports 80 and 443 to any VM tagged `"WEB"`)
3. The rule applies to those VMs regardless of their IP address.

---

## Connecting VPCs Across Projects

VPCs belong to a Google Cloud project — but sometimes VPCs in different projects need to talk to each other.

### Option 1: VPC Network Peering

Allows **private connectivity** between two VPC networks regardless of whether they belong to the same project or the same organization. Traffic stays on Google's private network — no public IPs or VPNs needed.

#### When to use it

- Your organization has **multiple network administrative domains**
- You want to **peer with another organization** (e.g. offer SaaS services privately, or connect networks after a merger/acquisition)

#### Advantages over external IPs / VPNs

| Benefit             | Detail                                                                            |
| ------------------- | --------------------------------------------------------------------------------- |
| **Lower latency**   | Private networking is faster than routing over public IPs                         |
| **Better security** | Services are never exposed to the public internet                                 |
| **Lower cost**      | Peered networks use internal IPs, saving on Google Cloud egress bandwidth charges |

> Regular network pricing still applies to all traffic — only the egress bandwidth savings are specific to peering.

#### How it works

- Both sides must **each create a peering connection** pointing at the other network — it is not one-sided
- Works across projects and across organizations

### Option 2: Shared VPC

- Uses full **IAM controls** to manage who and what in one project can interact with a VPC in another.
- More control than peering — lets you define fine-grained access policies.

---

## gcloud Commands

```bash
# List firewall rules
gcloud compute firewall-rules list

# Create a firewall rule targeting a network tag
gcloud compute firewall-rules create allow-http \
  --network=my-vpc --allow=tcp:80 --target-tags=web-server

# Delete a firewall rule
gcloud compute firewall-rules delete allow-http

# Create VPC peering
gcloud compute networks peerings create my-peering \
  --network=my-vpc --peer-project=OTHER_PROJECT --peer-network=other-vpc
```
