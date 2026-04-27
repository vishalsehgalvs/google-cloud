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

### Option 1: VPC Peering

- Establishes a **relationship between two VPCs** to exchange traffic.
- Works across projects.

### Option 2: Shared VPC

- Uses full **IAM controls** to manage who and what in one project can interact with a VPC in another.
- More control than peering — lets you define fine-grained access policies.
