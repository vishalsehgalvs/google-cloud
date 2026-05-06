# DNS, External Mapping, and Alias IP Ranges in Google Cloud

## External IP Is Not Visible Inside the VM

Even if a VM has an external IP, the guest operating system does not directly know that external address.

If you run a command like `ifconfig` inside the VM, you typically only see the internal IP.

Why:
- VPC transparently maps external IPs to internal IPs
- The VM communicates using its internal network identity
- External reachability is handled by Google Cloud networking, not by a second OS-level interface in the VM

---

## Internal DNS in Google Cloud

Google Cloud provides two internal DNS name styles:
- Zonal DNS
- Global (project-wide) DNS

Google generally recommends zonal DNS because it improves reliability by isolating DNS registration failures to individual zones.

---

## Internal Hostname and FQDN Behavior

Each instance has:
- A hostname (same as instance name)
- An internal FQDN

Internal DNS names resolve to internal IP addresses.

Important behavior:
- If an instance is deleted and recreated, its internal IP might change
- DNS name still tracks the instance identity
- Other resources should use DNS names when possible instead of hardcoded internal IPs

---

## Metadata Server as Local DNS Resolver

Each instance has a metadata server that also acts as its DNS resolver.

It handles:
- DNS queries for local network resources
- Forwarding of other queries to Google public DNS for internet name resolution

---

## External Address Resolution

Instances with external IPs can accept connections from outside the project.

Users can connect directly using the external IP.

However:
- Public DNS records are not automatically created for instance external IPs
- Admins must publish those DNS records themselves

You can host DNS zones on Google Cloud using Cloud DNS.

---

## Cloud DNS Overview

Cloud DNS is Google Cloud's managed authoritative DNS service.

What it provides:
- Scalable and reliable DNS zone hosting
- Domain-to-IP resolution (for example, mapping names to external IPs)
- API/CLI/UI management for records
- No need to run your own DNS server software

Cloud DNS uses Google's global Anycast name server network, which helps with:
- Low latency
- High availability
- Global redundancy

Google Cloud provides a 100% uptime SLA for domains configured in Cloud DNS.

---

## Why DNS Reliability Matters

If DNS lookup fails, applications and websites may appear down even if servers are healthy.

That is why managed, highly available DNS is a key part of production infrastructure.

---

## Alias IP Ranges

Alias IP ranges let you assign additional internal IP ranges to a VM network interface.

Use case:
- Multiple services on one VM
- Each service can use a different internal IP
- No need to create multiple NICs just to assign extra service IPs

Alias ranges are drawn from:
- The subnet's primary CIDR range
- Or secondary CIDR ranges

This is commonly useful for containerized workloads or multi-service VM patterns.

---

## Key Takeaway

- External IP mapping is handled by VPC and is transparent to the VM OS
- Internal DNS should be used for stable in-network addressing
- Cloud DNS is the managed way to publish and manage external DNS records
- Alias IP ranges let one VM represent multiple internal service endpoints cleanly
