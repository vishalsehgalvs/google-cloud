# HA VPN Lab Walkthrough

## What You Build

Two VPCs connected via HA VPN to simulate a GCP-to-on-premises setup:

| VPC        | Subnets                        | Instances                              |
| ---------- | ------------------------------ | -------------------------------------- |
| `vpc-demo` | us-east1, us-central1 (custom) | One Compute Engine instance per region |
| `on-prem`  | us-central1                    | One Compute Engine instance            |

---

## Steps

1. Create **vpc-demo** (global VPC) with two custom subnets — one in `us-east1`, one in `us-central1`
2. Add a Compute Engine instance in each of those regions inside `vpc-demo`
3. Create **on-prem** VPC to simulate a customer's on-premises data center
4. Add a subnet in `us-central1` inside `on-prem` and a Compute Engine instance in that region
5. Create an **HA VPN gateway** and a **Cloud Router** in each VPC
6. Run **two tunnels** from each HA VPN gateway (required for 99.99% SLA)
7. Test the configuration to verify connectivity and the 99.99% SLA behavior
