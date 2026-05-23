# 💰 Network Pricing in Google Cloud

## Overview

Understanding when you're charged for network traffic is important for cost management in Google Cloud. Different traffic types have different pricing rules.

## Ingress Traffic (Coming In)

**Free** — Traffic coming into Google Cloud is not charged.

**Exception:** If you have a resource like a Load Balancer actively processing the ingress traffic, you pay for that service (but not for the ingress itself).

## Egress Traffic (Going Out)

Responses to requests count as egress and **are charged**.

### Free Egress Scenarios

| Scenario                                                   | Cost    |
| ---------------------------------------------------------- | ------- |
| Same zone egress (via internal IP)                         | ✅ Free |
| Traffic to Google products (YouTube, Maps, Drive, Gmail)   | ✅ Free |
| Traffic to another Google Cloud service in the same region | ✅ Free |

### Charged Egress Scenarios

| Scenario                                 | Cost       |
| ---------------------------------------- | ---------- |
| Between zones in the same region         | ❌ Charged |
| Same zone egress via external IP address | ❌ Charged |
| Between different regions                | ❌ Charged |

**Why external IP costs more in same zone:** Google Cloud cannot determine a VM's zone from its external IP address, so traffic through an external IP is treated as if it's going between zones.

## External IP Address Pricing

You pay for both static and ephemeral external IPs when they're assigned to a resource.

### IP Address Costs

| IP Type                                           | Cost                           |
| ------------------------------------------------- | ------------------------------ |
| Static IP in use                                  | Standard charge                |
| Ephemeral IP in use                               | Standard charge                |
| Static IP **not** assigned to any resource (idle) | Higher charge                  |
| External IP on preemptible VMs                    | Lower charge than standard VMs |

**Key insight:** Unused static IPs cost more than in-use IPs, so release IPs you're not actively using.

## Cost Estimation: Pricing Calculator

### What It Is

A web-based tool that helps you estimate costs for Google Cloud resources.

### How to Use It

1. Specify your expected resource usage:
   - Instance type (e.g., `n1-standard-4`)
   - Region (e.g., `us-central1`)
   - Monthly egress traffic volumes (e.g., 100 GB to Americas)

2. The calculator returns a total estimated cost

3. You can:
   - Adjust currency and time frame (monthly, yearly, etc.)
   - Email the estimate to yourself
   - Save to a unique URL for future reference

### Example

Specify `n1-standard-2` instance in `us-central1` with 100 GB monthly egress to Americas and EMEA → Get total monthly cost estimate.

## Key Takeaways

- ✅ **Ingress is free** (unless processed by a load balancer)
- ❌ **Egress is usually charged** (except to Google services or same-zone same-region via internal IP)
- 💡 **Use internal IPs** to avoid inter-zone charges within a region
- 💡 **Release unused static IPs** to avoid overpaying
- 🧮 **Use the pricing calculator** before deploying to estimate costs
- ⚠️ **Pricing changes** — Always check official Google Cloud pricing documentation for current rates

---

## gcloud Commands

```bash
# List reserved IP addresses (unused ones still cost money)
gcloud compute addresses list

# Describe a project's billing account
gcloud billing projects describe PROJECT_ID

# List billing accounts
gcloud billing accounts list
```
