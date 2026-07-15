# Domain 3 - Networking, Hybrid Connectivity, Load Balancing

## Must Know

- VPC is global, subnets are regional
- Firewall rules are stateful
- Shared VPC centralizes networking across projects in one org
- VPC Peering is direct network-to-network, non-transitive
- Cloud NAT is outbound internet for private VMs
- Private Google Access is private access to Google APIs

## Decision Signals

- "private VM needs internet updates" -> Cloud NAT
- "private VM needs Google APIs" -> Private Google Access
- "multi-project centralized network control" -> Shared VPC
- "cross-org private connectivity" -> VPC Peering or VPN/Interconnect
- "HTTP path routing" -> Application Load Balancer with URL map
- "preserve client IP or UDP" -> Passthrough Network Load Balancer
- "high-throughput private on-prem" -> Interconnect
- "high availability VPN with dynamic routing" -> HA VPN + Cloud Router

## Pinpoint Traps

- Private Google Access does not provide full internet egress.
- Cloud NAT does not permit inbound internet to private VMs.
- Shared VPC and Monitoring Workspace solve different problems.
- Root domain uses A record, not CNAME.

## Scenario Example 1

- Trigger words: no external IP, outbound updates, call GCS APIs
- Best answer: Cloud NAT + Private Google Access
- Why not external IP per VM: larger attack surface
- Why not VPN to internet: wrong primitive for this use case

```bash
gcloud compute networks create prod-vpc --subnet-mode=custom

gcloud compute networks subnets create app-subnet \
  --network=prod-vpc \
  --range=10.10.0.0/20 \
  --region=us-central1

gcloud compute routers create nat-router \
  --network=prod-vpc \
  --region=us-central1

gcloud compute routers nats create nat-config \
  --router=nat-router \
  --region=us-central1 \
  --nat-all-subnet-ip-ranges \
  --auto-allocate-nat-external-ips

gcloud compute networks subnets update app-subnet \
  --region=us-central1 \
  --enable-private-ip-google-access
```

## Scenario Example 2

- Trigger words: global web traffic, host/path routing, managed TLS
- Best answer: External Application Load Balancer + URL map
- Why not passthrough NLB: no Layer 7 path routing
- Why not direct VM DNS: no global traffic engineering

```bash
# Typical implementation path in Console or IaC:
# 1) Create backend service
# 2) Create URL map with host and path rules
# 3) Create HTTPS target proxy and forwarding rule
# 4) Point DNS A record to global LB IP
```

## Scenario Example 3

- Trigger words: on-prem to GCP, highly available, dynamic route exchange
- Best answer: HA VPN with Cloud Router (BGP)
- Why not Classic VPN only: weaker HA model
- Why not static routes only: operationally brittle at scale

```bash
# Core resources for HA VPN are created in sequence:
# 1) Cloud Router
# 2) HA VPN gateway
# 3) VPN tunnels with BGP sessions
```

## Quick Choice Table

- Application-aware web routing -> Application Load Balancer
- Internal-only service routing -> Internal load balancer
- Client IP preservation and non-HTTP -> Passthrough NLB
- Private hybrid with very high bandwidth -> Interconnect
- Private hybrid with faster setup -> HA VPN

## One-Line Rules

- NAT and Private Google Access are complementary, not interchangeable.
- If question says path-based web routing, you are in ALB territory.
- Shared VPC is for centralized network control, not observability.
