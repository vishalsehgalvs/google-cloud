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
