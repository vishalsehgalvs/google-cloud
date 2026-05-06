# 🧭 IP Addresses in Google Cloud

## Why IP Addresses Matter

After understanding networks and subnets, the next key concept is IP addressing.

In Google Cloud, a VM can have:
- An **internal IP address**
- An **external IP address** (optional)

---

## Internal IP Address

Every VM gets an internal IP address.

### How it is assigned
- Assigned automatically through **DHCP** inside the VPC network
- Used for private communication between resources

### Who gets internal IPs
Not just Compute Engine VMs. Services built on VMs also depend on internal IPs.

Examples include:
- App Engine (in underlying infrastructure context)
- Google Kubernetes Engine (GKE) components

---

## Internal DNS and VM Names

When you create a VM, Google Cloud registers its name in an internal DNS service.

That DNS service:
- Maps VM names to internal IP addresses
- Works within the same network scope

### Important DNS scope rule
Internal DNS is scoped to the **network**.

That means:
- A VM can resolve names of hosts in the same network
- It cannot resolve host names from VMs in a different network (by default network-scoped behavior)

---

## External IP Address (Optional)

A VM may also have an external IP if it needs to be reachable from outside Google Cloud.

Use external IPs for:
- Public-facing services
- Remote access from outside the VPC
- Internet-facing workloads

If a VM is not externally facing, it may not need one.

---

## Ephemeral vs Static External IPs

Google Cloud offers two main external IP options:

### Ephemeral external IP
- Assigned from a pool automatically
- Typically attached during VM lifecycle
- Can change when resource is recreated/restarted in some scenarios

### Static external IP
- Reserved for your project
- Stays fixed until you release it
- Useful when you need stable endpoints (DNS records, allowlists, integrations)

---

## Pricing Note for Static IPs

If you reserve a static external IP but do **not** attach it to a resource:
- Google Cloud charges a higher rate for that unused reserved IP

In short:
- **In-use IPs** are cheaper than **reserved-but-unused static IPs**

So reserve static IPs intentionally and avoid leaving them idle.

---

## Bring Your Own Public IPs (BYOIP)

Google Cloud can also use your own publicly routable IP prefixes as external addresses.

To be eligible, you must bring:
- A public IP block of **/24 or larger**

This is useful when organizations want to keep consistent public IP ownership and internet advertisement.

---

## Quick Comparison

| Type | Required? | Scope | Typical Use |
|---|---|---|---|
| Internal IP | Yes (for VMs) | Private VPC communication | Service-to-service traffic |
| External IP (Ephemeral) | Optional | Internet reachable | Temporary/public access |
| External IP (Static) | Optional | Internet reachable | Stable endpoint and DNS |

---

## Key Takeaway

In Google Cloud:
- Internal IPs are default and power private communication
- External IPs are optional and used for public access
- Internal DNS resolves names within the same network
- Static IPs are best for stable endpoints, but unused reserved static IPs cost more
- You can even bring your own /24+ public prefix when needed
