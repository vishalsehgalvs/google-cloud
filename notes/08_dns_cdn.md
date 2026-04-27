# 🌍 Cloud DNS & CDN

## Google Public DNS (8.8.8.8)

- One of the most famous free Google services
- Provides public **Domain Name Service (DNS)** to the world
- DNS translates internet hostnames to IP addresses
- Google's DNS infrastructure is highly developed and globally available

---

## Cloud DNS

- Managed DNS service for Google Cloud applications
- Runs on the same infrastructure as Google
- **Low latency, high availability, cost-effective**
- DNS info is served from redundant locations worldwide
- **Programmable**: manage millions of DNS zones and records via Console, CLI, or API

---

## Edge Caching & Cloud CDN

- **Edge caching**: uses caching servers to store content closer to end users
- **Cloud CDN (Content Delivery Network)**:
  - Accelerates content delivery
  - Reduces network latency for users
  - Reduces load on your origin servers
  - Can save money
- Enable Cloud CDN with a single checkbox after setting up an Application Load Balancer
- Google Cloud supports other CDNs via the **CDN Interconnect partner program**
