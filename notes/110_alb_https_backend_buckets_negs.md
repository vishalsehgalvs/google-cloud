# Application Load Balancer — HTTPS, Backend Buckets, and NEGs

## HTTPS Load Balancing

HTTPS ALB has the same structure as HTTP but with these differences:

- Uses a **target HTTPS proxy** instead of a target HTTP proxy
- Requires **at least one signed SSL certificate** installed on the target HTTPS proxy
- Client SSL sessions **terminate at the load balancer**
- Supports the **QUIC** transport layer protocol

### QUIC Protocol

- Faster client connection initiation
- Eliminates head-of-line blocking in multiplexed streams
- Supports connection migration when a client's IP address changes

### SSL Certificates

- At least one SSL certificate required; up to **15 SSL certificates** per target proxy
- Each certificate requires creating an **SSL certificate resource** first
- SSL certificate resources are used only with load balancing proxies (target HTTPS proxy, target SSL proxy)

---

## Backend Buckets

Allows you to use **Cloud Storage buckets** as backends for an Application Load Balancer.

- The URL map directs traffic to either a **backend service** (dynamic content) or a **backend bucket** (static content)

### Common Use Case

| Traffic                        | Destination                    |
| ------------------------------ | ------------------------------ |
| Dynamic content (data, API)    | Backend service                |
| Static content (images, files) | Backend bucket (Cloud Storage) |

### Example

- Requests to `/love-to-fetch/*` → Cloud Storage bucket in `europe-north`
- All other requests → Cloud Storage bucket in `us-east`

---

## Network Endpoint Groups (NEGs)

A **NEG** is a configuration object that specifies a group of backend endpoints or services.

Common use cases:

- Deploying services in **containers**
- Distributing traffic at a **granular level** to applications on backend instances
- Can be used as backends for some load balancers and with **Traffic Director**

### NEG Types

| Type                        | Description                                                                                                  |
| --------------------------- | ------------------------------------------------------------------------------------------------------------ |
| **Zonal NEG**               | One or more endpoints (Compute Engine VMs or services on VMs); specified by IP or IP:port                    |
| **Internet NEG**            | Single endpoint **hosted outside Google Cloud**; specified by FQDN:port or IP:port                           |
| **Hybrid connectivity NEG** | Points to Traffic Director services running **outside Google Cloud**                                         |
| **Serverless NEG**          | Points to **Cloud Run, App Engine, or Cloud Run Functions** in the same region; contains no actual endpoints |
