# Networking And Load Balancer Traps

## Trap 1: Network Service Tier — Standard vs Premium

This concept is thin in your original notes, so it is a high-risk gap. See `08_gaps_not_in_original_notes.md` for the full explanation.

Quick version:

- "traffic stays within one region / cost-sensitive / no global reach needed" -> Standard Tier
- "multi-region or global performance over Google's backbone network" -> Premium Tier

One-line rule: single region + cost focus -> Standard Tier. Global reach + performance -> Premium Tier.

## Trap 2: Choosing The Frontend Load Balancer For A Web App

The trap: a generic "load balancer" answer and a "TCP/UDP Network Load Balancer" answer both sound plausible for a web frontend, but neither is the best fit versus an HTTPS-aware option.

- "web-facing frontend, needs security, SSL/TLS, content-based routing" -> External HTTPS (Application) Load Balancer
- "internal-only traffic between app tiers in the same VPC" -> Regional Internal Load Balancer

Why a plain TCP/UDP Network Load Balancer usually loses to HTTPS LB for web frontends:

- It does not terminate SSL/TLS at the edge the same way, and it lacks Layer 7 features like URL-based routing.
- HTTPS LB supports Google-managed SSL certificates and is purpose-built for HTTP(S) web traffic.

Full worked example from practice:

- Requirement: secure, low-cost, single-region (Minneapolis, us-central1), web tier plus backend tier.
- Correct pattern: Standard Tier (since everything is single-region, no need for Premium) + External HTTPS Load Balancer as frontend + Regional Internal Load Balancer between web tier and backend.
- Why not Premium tier pass-through LB: unnecessary cost, no multi-region requirement stated.
- Why not TCP/UDP LB as frontend: skips HTTP(S)-aware features and SSL offload that a web app benefits from.
- Why not proxied SSL LB (Layer 4) as frontend: still lacks HTTP-specific content-based routing that HTTPS LB provides.

One-line rule: "Traffic confined to one region + cost sensitivity" -> Standard Tier. "Web-facing HTTP(S) needing security" -> External HTTPS LB. "Internal-only backend traffic" -> Internal LB.

## Trap 3: Application Load Balancer vs Network Load Balancer vs Passthrough NLB

- HTTP(S) traffic, flexible routing rules -> Application Load Balancer (Layer 7)
- TLS offload / TCP proxy / backends across multiple regions -> Proxy Network Load Balancer (Layer 4, proxy-based)
- must preserve client source IP, or need UDP/ESP/ICMP support -> Passthrough Network Load Balancer (Layer 4, not a proxy)

One-line rule: HTTP-aware routing needed -> Application Load Balancer. Need raw IP preservation or non-HTTP protocol -> Passthrough NLB. Need TLS offload across regions without HTTP awareness -> Proxy NLB.

## Trap 4: Global vs Regional Load Balancer

- "backends distributed across multiple regions, route to closest" -> Global
- "all clients and backends confined to one region / regional compliance" -> Regional

One-line rule: if compliance or "must stay in this region" language appears, choose Regional even if Global is technically also available.

## Trap 5: Egress Cost Traps

- Same zone via internal IP -> free
- Same zone via external IP -> charged (Google cannot detect zone from external IP, treated as inter-zone)
- Between zones in same region -> charged
- Between regions -> charged
- To Google products (YouTube, Maps, Gmail, Drive) -> free
- Ingress -> free, unless a load balancer resource is actively processing it (you pay for the LB itself, not the ingress)

One-line rule: "use internal IP within the same zone" is the only guaranteed free egress path between your own resources.

## Trap 6: Cloud NAT vs External IP

- "private VMs need outbound internet access, no inbound access allowed" -> Cloud NAT
- "VM needs to be reachable directly from the internet" -> External IP (only if truly required)

One-line rule: Cloud NAT is one-way out. It never allows unsolicited inbound connections.

## Quick Self-Test

1. All resources are in us-central1, traffic never leaves the region. Which network tier minimizes cost?
2. Web app needs SSL termination and URL-based routing. Which load balancer?
3. Backend needs to see the real client IP and uses UDP. Which load balancer type?
4. VM needs outbound internet only, must stay unreachable from outside. Which feature?
