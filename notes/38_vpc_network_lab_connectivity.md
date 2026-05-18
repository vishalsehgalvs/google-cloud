# Lab Notes: VPC Networks, VM Creation, and Connectivity Testing

## What this lab teaches

This lab shows three practical ideas:

1. You cannot create VM instances without at least one VPC network.
2. Auto mode VPCs are quick for learning, but custom mode VPCs are better for production control.
3. Different VPC networks are isolated by default, so internal IP communication across networks does not work unless you connect them (for example with VPC Peering or VPN).

---

## Part 1: Explore and remove the default network

### What you saw

- Most projects start with a default VPC network (unless org policy blocks it).
- That default network already has:
  - subnets in many regions
  - routes (including default route to internet)
  - firewall rules (ICMP, SSH, RDP, and internal allow rules)

### What you did

- Deleted default firewall rules.
- Deleted the default VPC network.
- Confirmed related routes disappeared.

### Important result

After removing all VPC networks, VM creation fails because VM instances must attach to a network.

---

## Part 2: Create an auto mode VPC and test same-network connectivity

### Network created

- VPC name: mynetwork
- Subnet mode: Auto

Auto mode automatically creates regional subnets and assigns preset IP ranges.

### VM instances created

- mynet-us-vm (us-central1-c)
- mynet-eu-vm (europe-west1-c)

### What you validated

- Both VMs received internal IPs from their subnet ranges.
- Internal ping between these two VMs worked, even though they are in different regions.

Why it worked:

- They are in the same VPC network.
- Firewall rules allowed internal communication.

### DNS takeaway

You can use VM names (internal DNS) instead of internal IPs. This is useful because internal IPs can change.

---

## Part 3: Convert auto mode to custom mode

### What you changed

- Edited mynetwork and changed subnet mode from Auto to Custom.

### Why this matters

- Auto mode is convenient but broad.
- Custom mode gives better control of subnet design, IP planning, and production architecture.

---

## Part 4: Create two more custom VPC networks

You created additional networks using both methods:

- Console method: managementnet
- gcloud command line method: privatenet

For custom mode networks, you must define subnets manually (name, region, CIDR range).

---

## Part 5: Add firewall rules

You created ingress firewall rules (for ICMP, SSH, RDP) for the new networks.

### Main idea

Firewall rules are network-specific. A rule in one VPC does not automatically apply to another VPC.

---

## Part 6: Create VMs in these new networks

After creating new VM instances in the added VPCs, you tested network behavior using both external and internal IP addresses.

---

## Connectivity results explained

### External IP ping across different VPCs

- Worked.

Reason:

- You allowed needed traffic with firewall rules.
- External IP traffic goes through public routing, not private same-VPC routing.

### Internal IP ping across different VPCs

- Failed.

Reason:

- VPC networks are isolated private domains by default.
- Internal addresses are reachable only within the same VPC unless you configure a connection.

---

## How to connect internal IPs across VPCs

You need an explicit inter-network setup, such as:

- VPC Peering
- Cloud VPN
- Other private connectivity designs

Without that, internal traffic between different VPC networks is blocked by architecture.

---

## Useful command patterns seen in this lab

### Create a custom VPC

```bash
gcloud compute networks create NETWORK_NAME --subnet-mode=custom
```

### Create a subnet

```bash
gcloud compute networks subnets create SUBNET_NAME \
  --network=NETWORK_NAME \
  --region=REGION \
  --range=CIDR_RANGE
```

### Create firewall rule

```bash
gcloud compute firewall-rules create RULE_NAME \
  --network=NETWORK_NAME \
  --direction=INGRESS \
  --action=ALLOW \
  --rules=tcp:22,tcp:3389,icmp \
  --source-ranges=0.0.0.0/0
```

### Create VM with minimum required inputs

```bash
gcloud compute instances create VM_NAME \
  --zone=ZONE \
  --machine-type=e2-micro \
  --subnet=SUBNET_NAME
```

---

## Final takeaway

- No VPC network = no VM creation.
- Same VPC usually means internal communication can work (if firewall allows it).
- Different VPCs are isolated by default for internal traffic.
- External ping can still work across VPCs if firewall rules allow it.
- For production, custom mode VPCs are preferred because they give you tighter control.
