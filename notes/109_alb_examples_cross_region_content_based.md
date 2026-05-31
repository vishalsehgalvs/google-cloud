# Application Load Balancer — Examples

## Example 1: Global Load Balancing (Cross-Region)

**Setup:**

- Single global IP address
- One backend service with two backends:
  - `us-central1-a` — managed instance group
  - `europe-west1-d` — managed instance group

**How traffic flows:**

1. Global forwarding rule directs incoming requests to the **target HTTP proxy**
2. Proxy checks the **URL map** to determine the appropriate backend service
3. Load balancing service determines the **approximate origin** of the request from the source IP
4. Request is forwarded to the **closest backend with available capacity**
   - North America user → `us-central1-a` MIG
   - EMEA user → `europe-west1-d` MIG
5. If multiple users hit the same region, requests are **distributed evenly** across available instances

### Cross-Region Load Balancing

If a region has **no healthy instances or no available capacity**, the load balancer forwards traffic to the **next closest region with capacity**.

> Example: If `europe-west1-d` is at capacity or all instances are unhealthy, EMEA traffic is forwarded to `us-central1-a`.

---

## Example 2: Content-Based Load Balancing

**Setup:**

- Single global IP address
- Two separate backend services: **web-service** and **video-service**
- URL map routes traffic based on the URL path

**How traffic is split:**

| URL Path        | Backend               |
| --------------- | --------------------- |
| `/video`        | video-service backend |
| Everything else | web-service backend   |

The URL map inspects the request URL header and routes accordingly — all behind a single global IP.
