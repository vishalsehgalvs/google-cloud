# Shared VPC and VPC Network Peering

Two configurations for sharing VPC networks across GCP projects.

---

## Shared VPC

- Connects resources from **multiple projects** to a **common VPC network** so they communicate using internal IP addresses
- Designate one project as the **host project**; attach one or more **service projects** to it
- The VPC networks in the host project are called **Shared VPC networks**
- Eligible resources from service projects can use subnets in the Shared VPC network
- Lets org admins **delegate** instance-level responsibilities to Service Project Admins while maintaining **centralized control** over subnets, routes, and firewalls

### Terminology

| Term               | Meaning                                                   |
| ------------------ | --------------------------------------------------------- |
| Host project       | Project that owns the shared VPC network                  |
| Service project    | Project attached to the host project; uses host's subnets |
| Standalone project | Project that does not participate in Shared VPC at all    |
| Standalone VPC     | An unshared VPC in a standalone or service project        |

---

## VPC Network Peering

- Enables **private RFC 1918 connectivity** across two VPC networks — regardless of project or organization
- Each VPC network maintains its own **global firewall rules and routing tables**
- To establish peering: **both sides** must create a peering connection (Producer → Consumer AND Consumer → Producer); once both are created the session becomes **Active** and routes are exchanged
- VMs communicate using **internal IP addresses**
- Avoids the latency, security, and cost drawbacks of external IPs or VPNs
- **Decentralized** — each VPC remains under its own admin group

---

## Shared VPC vs. VPC Network Peering

| Scenario                                                                    | Use                                                         |
| --------------------------------------------------------------------------- | ----------------------------------------------------------- |
| Private communication between VPCs in **different organizations**           | VPC Network Peering (Shared VPC is org-only)                |
| Private communication between VPCs in the **same project**                  | VPC Network Peering (Shared VPC requires multiple projects) |
| Private communication between VPCs **across projects in the same org**      | Either — depends on admin model                             |
| **Centralized** network administration (single network policy)              | Shared VPC                                                  |
| **Decentralized** network administration (each team controls their own VPC) | VPC Network Peering                                         |

## ACE Exam-Style Practice Questions

### Q1

You need private connectivity between two VPCs owned by different organizations in a Shared VPC and peering design. Which option is correct?

A. Shared VPC
B. VPC Network Peering
C. Cloud NAT
D. Internal passthrough load balancer

Answer: B
Trap: Shared VPC is for projects within the same organization and centralized administration model.

### Q2

Your platform team wants centralized control of subnets, routes, and firewall policies for multiple projects in one organization. What should you use?

A. Shared VPC with host and service projects
B. Separate stand-alone VPC per project with no sharing
C. Public IP routing only
D. Cloud DNS private zones only

Answer: A
Trap: VPC peering enables connectivity, but does not provide centralized network administration.
