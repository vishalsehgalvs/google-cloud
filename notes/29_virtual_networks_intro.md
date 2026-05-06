# 🌐 Virtual Networks in Google Cloud

## What This Module Covers

This module introduces **virtual networking** in Google Cloud.

Google Cloud networking is not built like a traditional hardware network. Instead, it uses a **software-defined network** running on Google's global fiber infrastructure.

That gives Google Cloud one of the largest and fastest networks in the world.

---

## Think in Services, Not Hardware

A useful mindset in Google Cloud is this:

**Think of resources as services, not as physical hardware.**

That makes it easier to understand:
- What networking options exist
- How they behave
- Why they are flexible and scalable

---

## What is VPC?

**VPC (Virtual Private Cloud)** is Google's managed networking service for your cloud resources.

It is the main way you connect resources like:
- Virtual machines
- Databases
- Load balancers
- Other cloud services

A VPC lets you define how your resources communicate with each other and with the outside world.

---

## Core Networking Building Blocks

This module breaks networking into the main parts you need to understand:

- **Projects** — the top-level container that owns resources
- **Networks** — the overall private network space
- **Subnetworks** — smaller regional parts of a network
- **IP addresses** — identities for resources on a network
- **Routes** — rules for where traffic goes
- **Firewall rules** — rules for what traffic is allowed or blocked
- **Network pricing** — how traffic and networking choices affect cost

These are the basic pieces of Google Cloud networking.

---

## Hands-On Network Lab

In the lab for this module, you will:
- Create different types of networks
- Explore how those networks relate to one another
- See how Google Cloud networking is structured in practice

This is important because networking concepts become much clearer once you build and inspect them yourself.

---

## Common Network Designs

After learning the building blocks, the module moves into **common network design patterns**.

That means you will not just learn what each piece does, but also how they are combined in real-world architectures.

---

## Google Cloud's Global Network Structure

At a high level, Google Cloud consists of:
- **Regions**
- **Points of Presence (PoPs)**
- **A global private network**
- **Cloud services**

All of these work together to deliver Google Cloud networking worldwide.

---

## Regions

A **region** is a specific geographic location where you run resources.

Examples:
- `us-central1`
- `europe-west1`
- `asia-south1`

Regions usually contain multiple **zones**.

### Zones
A **zone** is an isolated location inside a region.

For example, the `us-central1` region includes zones such as:
- `us-central1-a`
- `us-central1-b`
- `us-central1-c`
- `us-central1-f`

Most regions have three zones, but some regions can differ.

---

## Points of Presence (PoPs)

**PoPs** are where Google's network connects to the public internet.

You can think of them as Google's edge connection points.

Why they matter:
- They bring Google traffic closer to internet users and peers
- They reduce latency
- They can reduce costs
- They improve user experience

---

## The Global Private Network

Google Cloud regions and PoPs are connected by Google's **global private fiber network**.

This network includes:
- High-speed fiber optic cables
- Long-distance backbone connections
- Submarine cable investments

This is one reason Google Cloud networking is fast and globally scalable.

---

## Why This Matters

Because Google Cloud has a global private network:
- Services can communicate efficiently across regions
- Google can control traffic more directly
- Performance is often better than relying only on the public internet

This network is a major part of what makes Google Cloud different from a traditional on-premises setup.

---

## Key Takeaway

Google Cloud networking starts with **VPC** and is built on top of Google's global software-defined network.

To understand networking in Google Cloud, you need to understand:
- Projects
- Networks
- Subnets
- IP addresses
- Routes
- Firewall rules
- Regions, zones, and PoPs

Once you understand those pieces, the rest of Google Cloud networking becomes much easier to follow.