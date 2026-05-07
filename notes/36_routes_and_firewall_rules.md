# 🛣️ Routes and Firewall Rules in Google Cloud

## What This Section Covers

After understanding networks, subnets, and IPs, the next layer is how traffic actually flows.

That involves:
- **Routes** — decide where packets go
- **Firewall rules** — decide whether packets are allowed

---

## Routes

A **route** is an instruction that tells Google Cloud how to deliver packets to a destination IP address.

Every network automatically includes default routes that:
- Allow instances on the same network to communicate with each other (even across subnets)
- Allow instances to send traffic to destinations outside the network (to the internet)

---

## Creating Additional Routes

You can create custom routes that override the default behavior.

However, **just creating a route is not enough**.

For traffic to actually flow:
1. A matching route must exist (tells where to send the packet)
2. A matching firewall rule must allow it (approves the traffic)

Both conditions are required.

---

## Default Firewall Behavior

The **default network** comes pre-configured with firewall rules that allow:
- All instances in the network to talk to each other
- Some basic protocols

But **manually created networks** do NOT have these rules by default.

If you create a custom network, you must create firewall rules yourself to allow communication between instances.

---

## How Routes Work

Routes are evaluated based on **destination IP address**.

Each route may apply to:
- A specific instance (using instance tags)
- All instances in the network (if no tags specified)

When a packet leaves a VM:
1. Google Cloud checks the VM's routing table
2. Finds a matching route based on destination IP
3. Uses that route to determine the next hop

---

## The Virtual Router

At the core of each VPC network is a **virtual router**.

Think of it as:
- A logical router that every VM connects to
- Every packet leaving a VM goes through this router first
- The router consults the routing table to decide where to send the packet

This massively scalable virtual architecture allows:
- Thousands of VMs in one network
- Consistent routing behavior
- Centralized routing policy

---

## Firewall Rules

**Firewall rules** protect VMs from unapproved connections.

They apply to:
- Inbound connections (**ingress**)
- Outbound connections (**egress**)

A VPC network acts as a **distributed firewall** between:
- Instances and external networks
- Individual instances within the same network

So firewall rules can restrict communication even between VMs on the same subnet.

---

## Firewall Rules Are Stateful

An important property: **firewall rules are stateful**.

That means:
- If a connection is allowed from source A to destination B, the return traffic is also allowed
- You do not need separate rules for each direction once a session starts
- Bidirectional communication happens automatically for established connections

---

## What Happens if All Rules Are Deleted

If all firewall rules in a network are removed:
- There is an implied **"Deny all" ingress** rule (blocks incoming)
- There is an implied **"Allow all" egress** rule (allows outgoing)

This safe default prevents accidental misconfiguration from leaving instances wide open.

---

## Firewall Rule Components

Every firewall rule has:

### 1) Direction
- **Ingress** — incoming connections to the instance
- **Egress** — outgoing connections from the instance

### 2) Source or Destination
- **Ingress rules** match by source IP CIDR range
- **Egress rules** match by destination IP CIDR range

### 3) Protocol and Port
Rules can specify:
- Specific protocols (TCP, UDP, ICMP, etc.)
- Specific ports
- All protocols
- All ports

### 4) Action
- **Allow** — permit matching traffic
- **Deny** — block matching traffic

### 5) Priority
Rules are evaluated in priority order.

The first matching rule is applied, and later rules do not override it.

Lower priority number = evaluated first.

### 6) Target Assignment
By default, rules apply to all instances in the network.

But you can limit rules to specific instances using **tags**.

---

## Egress Firewall Rules

**Egress** rules control outbound connections from VMs.

### Egress Allow Rules
Permit specific outbound connections based on:
- Destination IP range
- Protocol
- Port

### Egress Deny Rules
Block specific outbound connections to:
- External hosts (prevent data exfiltration)
- Specific Google Cloud IP ranges (prevent internal misconfiguration)

Example use case:
- Prevent a VM from connecting to suspicious external IPs
- Prevent a VM in one subnet from connecting to a database VM in another subnet (enforce microservice boundaries)

---

## Ingress Firewall Rules

**Ingress** rules control incoming connections to VMs.

### Ingress Allow Rules
Permit specific inbound connections based on:
- Source IP range
- Protocol
- Port

### Ingress Deny Rules
Block specific inbound connections from:
- External networks (prevent unauthorized external access)
- Specific Google Cloud IP ranges (prevent internal unauthorized access)

Example use case:
- Allow external web traffic to port 443 (HTTPS) only
- Block a VM from receiving connections from untrusted internal networks

---

## Firewall Rule Design

When designing firewall rules:
- Use source/destination CIDR ranges to be specific
- Use tags to apply rules to certain instances only
- Combine with routes to enforce network topology
- Remember stateful behavior means you only need allow rules in one direction
- Set appropriate priorities to avoid conflicts

---

## Key Takeaway

Routes and firewall rules work together:
- **Routes** determine where packets go
- **Firewall rules** determine if packets are allowed

Both are required for traffic to flow successfully.

Understanding this two-layer approach helps you design secure, controlled networks in Google Cloud.