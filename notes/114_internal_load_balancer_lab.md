# Internal Load Balancer Lab Walkthrough

## What's Pre-Created
- A VPC network (`my-internal-app`) with two subnets (subnet A, subnet B)
- Firewall rules for ICMP, SSH, and RDP

---

## Task 1 — Create Firewall Rules

**Rule 1 — Allow HTTP:**
- Network: `my-internal-app`
- Target tag: `load-balancer-backend`
- Source IP ranges: `0.0.0.0/0`
- Protocol/port: TCP 80

**Rule 2 — Allow Health Check:**
- Network: `my-internal-app`
- Target tag: `load-balancer-backend`
- Source IP ranges: `130.211.0.0/22` and `35.191.0.0/16` (Google Cloud health checker ranges)
- Ports: allow all (or restrict to your health check port)

---

## Task 2 — Create Instance Templates

**Template 1 (subnet A):**
- Add startup script via metadata key `startup-script-url` pointing to the Cloud Storage bucket URL provided in the lab
- Networking: select `my-internal-app` network, subnet A, network tag: `load-balancer-backend`

**Template 2 (subnet B):**
- Copy template 1 → change subnet to subnet B

---

## Task 3 — Create Managed Instance Groups

**Instance Group 1:**
- Zone: `us-central1-a`
- Template: instance template 1
- Autoscaling: CPU target 80%, min 1, max 5, cool-down period 45 seconds

**Instance Group 2:**
- Zone: `us-central1-b`
- Template: instance template 2
- Same autoscaling settings

> After creation, each instance group will have one VM. Verify that group 1's VM is on subnet A and group 2's VM is on subnet B.

---

## Task 4 — Create a Utility VM

- Region: `us-central1`, zone: `us-central1-f` (or any zone in the same region)
- Machine type: small
- Network: `my-internal-app`, subnet A
- Internal IP: optionally set a custom ephemeral IP to match the lab diagram (e.g., `10.10.20.50`)

> Note: first two and last two IPs in any subnet are reserved, so usable IPs start at `.2`.

**Verify connectivity from utility VM:**
```bash
# SSH into utility VM, then curl each backend directly
curl 10.10.20.2   # instance group 1's VM
curl 10.10.30.2   # instance group 2's VM
```
Response shows the instance name, source IP, region, and zone — confirming direct connectivity.

---

## Task 5 — Create the Internal Load Balancer

**Navigation:** Network services → Load balancing → Create load balancer → TCP load balancing → Only between VMs (internal, regional)

**Backend configuration:**
- Region: `us-central1`
- Network: `my-internal-app`
- Backends: instance group 1 + instance group 2
- Health check: create new → name `my-internal-health-check`, protocol TCP, port 80

**Frontend configuration:**
- Subnet: subnet B
- Internal IP: reserve static → name `my-internal-advanced-ip`, custom address `10.10.30.5`
- Port: 80

Click **Create** and wait for the load balancer to be ready.

---

## Task 6 — Test the Load Balancer

SSH into the utility VM and curl the load balancer's internal IP:

```bash
curl 10.10.30.5
```

Run the command multiple times — you should see responses alternating between instance group 1 and instance group 2, confirming load balancing is working:

```
# Example output pattern across multiple curls:
# group 2, group 2, group 2, group 1, group 2, group 1 ...
```
