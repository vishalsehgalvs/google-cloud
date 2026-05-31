# Cloud Interconnect — Dedicated, Partner, and Cross-Cloud

## Dedicated Interconnect

- **Direct physical connection** between your on-premises network and Google's network
- More cost-effective than buying extra public internet bandwidth for large data transfers
- Requires provisioning a **cross connect** between the Google network and your router at a **common colocation facility**
- BGP session configured between **Cloud Router** and your on-premises router to exchange routes
- SLA options: **99.9% or 99.99%** uptime (depends on redundancy configuration)
- Your network must physically meet Google's network at a [supported colocation facility](https://cloud.google.com/interconnect/docs/concepts/colocation-facilities)

---

## Partner Interconnect

- Connectivity between your on-premises network and VPC through a **supported service provider**
- Use when: your data center can't reach a Dedicated Interconnect colocation facility, or your bandwidth needs don't justify Dedicated Interconnect
- Service providers have existing physical connections to Google's network
- You establish a BGP session between your Cloud Router and on-premises router via the provider's network
- SLA options: **99.9% or 99.99%** uptime between Google and the service provider
- Full list of providers: [Partner Interconnect service providers](https://cloud.google.com/interconnect/docs/concepts/service-providers)

---

## Cross-Cloud Interconnect

- **Dedicated physical connection** between Google Cloud and another cloud service provider
- Lets you peer your GCP VPC with networks hosted by supported providers
- Supported providers: **AWS, Microsoft Azure, Oracle Cloud Infrastructure, Alibaba Cloud**
- Benefits: reduced complexity, site-to-site data transfer, encryption, multi-cloud strategy support
- Available in two sizes: **10 Gbps or 100 Gbps**
- Process: choose supported locations → purchase primary + redundant ports from Google → purchase primary + redundant ports from the other provider
- Google supports the connection **up to the other provider's network boundary** — does not guarantee uptime beyond that point

---

## Interconnect Options Comparison

| Option | Capacity | Requirement | Best For |
|---|---|---|---|
| Cloud VPN | 1.5–3 Gbps per tunnel (scalable with multiple tunnels) | VPN device on-premises | Low cost, lower bandwidth, experimentation/migration |
| Dedicated Interconnect | 10 Gbps or 100 Gbps per link (up to 8×10 Gbps or 2×100 Gbps links) | Connection at Google colocation facility | Enterprise-grade, high throughput |
| Partner Interconnect | 50 Mbps – 50 Gbps per connection | Depends on service provider | No nearby colocation facility; moderate bandwidth |
| Cross-Cloud Interconnect | 10 Gbps or 100 Gbps | Supported multi-cloud location | Connecting to another cloud provider |

> **Note on Cloud VPN capacity:** 1.5 Gbps applies to traffic over the public internet; 3 Gbps applies to traffic over a direct peering link.

---

## Choosing the Right Option

- **Cloud VPN** — lower cost, lower bandwidth, or migrating/experimenting
- **Dedicated or Partner Interconnect** — enterprise-grade, higher throughput
- **Cross-Cloud Interconnect** — connecting to another cloud service provider
- Google recommends **Cloud Interconnect over Direct Peering or Carrier Peering** in most cases
