# 🧩 VPC Objects Overview

## What is VPC in Google Cloud?

**VPC (Virtual Private Cloud)** is Google's managed networking system for your cloud resources.

With a VPC, you can:

- Provision Google Cloud resources
- Connect resources to each other
- Isolate resources from each other
- Define detailed networking policies
- Control connectivity between Google Cloud, on-premises, and other public clouds

In simple terms, VPC is the main networking layer for your Google Cloud environment.

---

## VPC is a Set of Networking Objects

VPC is not just one thing. It is a collection of Google-managed networking objects that work together.

This module introduces the main ones at a high level.

---

## 1) Projects

A **project** is the top-level container for Google Cloud resources.

That means:

- Every service you use belongs to a project
- Networks also belong to projects
- Resources are created and managed inside projects

So before you even think about networking, you need to know which project owns the network.

---

## 2) Networks

A **network** is the overall private networking space for your resources.

In Google Cloud, networks come in **three flavors**:

### Default network

A built-in network Google Cloud often provides automatically.

Good for:

- Quick testing
- Simple learning environments

But for real-world production work, teams often avoid relying on the default setup.

### Auto mode network

Google Cloud automatically creates one subnet per region for you.

Good for:

- Fast setup
- Simpler starting point

Tradeoff:

- Less control over how subnet ranges are designed

### Custom mode network

You create your own subnets manually.

Good for:

- Production environments
- Better planning
- More control over IP ranges and layout

This is usually the preferred option for serious network design.

---

## 3) Subnetworks

**Subnetworks** let you divide and separate your environment into smaller pieces.

Why this matters:

- You can organize workloads better
- You can separate environments like dev, test, and prod
- You can control IP ranges more carefully

A subnet belongs to a **region**, even though the VPC itself is global.

---

## 4) Regions and Zones

**Regions** and **zones** represent Google's data center locations.

### Region

A region is a geographic area where you run resources.

### Zone

A zone is an isolated location inside a region.

Why they matter:

- Help with high availability
- Help with resilience
- Support continuous data protection

By placing resources across zones, you reduce the chance that one failure takes down everything.

---

## 5) IP Addresses

VPC provides **internal and external IP addresses**.

### Internal IP addresses

Used for communication between resources inside Google Cloud.

### External IP addresses

Used when resources need to be reached from the internet.

Google Cloud also gives you granular control over IP ranges, which helps when designing networks cleanly and avoiding conflicts.

---

## 6) Virtual Machines from a Networking Perspective

In this module, virtual machines are looked at mainly from the networking side.

That means focusing on questions like:

- Which network is the VM attached to?
- Which subnet is it using?
- What internal IP does it have?
- Does it have an external IP?
- Which firewall rules apply to it?

So the VM is not just a compute resource. It is also a network participant.

---

## 7) Routes

**Routes** tell traffic where to go.

They define the path packets should take to reach a destination.

Without routes, your resources would not know how to reach:

- Other resources in the network
- Other networks
- The internet

---

## 8) Firewall Rules

**Firewall rules** control what traffic is allowed or denied.

They help you define:

- Who can connect to a resource
- Which ports are open
- Which protocols are allowed
- Whether traffic should be inbound or outbound

This is one of the main tools for controlling security at the network level.

---

## Why All of This Matters

When you work with Google Cloud networking, you are really working with a set of connected building blocks:

- Project owns the network
- Network contains subnetworks
- Subnetworks provide IP ranges
- VMs use those IPs
- Routes move traffic
- Firewall rules secure traffic

Once you see how these parts fit together, VPC becomes much easier to understand.

---

## Key Takeaway

VPC is Google's managed networking foundation.

At a high level, the main objects are:

- Projects
- Networks
- Subnetworks
- Regions and zones
- IP addresses
- Virtual machines
- Routes
- Firewall rules

These are the core pieces you need to understand before going deeper into Google Cloud networking.

---

## gcloud Commands

```bash
# List VPC networks
gcloud compute networks list

# Describe a specific network
gcloud compute networks describe NETWORK_NAME

# List subnets filtered by region
gcloud compute networks subnets list --filter="region:us-central1"

# List firewall rules
gcloud compute firewall-rules list
```
