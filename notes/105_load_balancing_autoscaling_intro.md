# Load Balancing and Autoscaling — Module Intro

## Cloud Load Balancing Overview

- Distribute load-balanced compute resources across **single or multiple regions**
- All resources sit behind a **single anycast IP address**
- Scales up or down with **intelligent autoscaling**
- Can serve content as close as possible to users — handles **1 million+ queries per second**
- Fully **distributed, software-defined, managed service** — no physical load balancing infrastructure to manage

---

## Two Primary Load Balancer Types

| Type                          | OSI Layer             | Best For                                                  | Key Features                                                                |
| ----------------------------- | --------------------- | --------------------------------------------------------- | --------------------------------------------------------------------------- |
| **Application Load Balancer** | Layer 7 (Application) | HTTP(S) traffic requiring content-based routing           | SSL/TLS termination, session affinity, routing by headers/cookies/URL paths |
| **Network Load Balancer**     | Layer 4 (Network)     | TCP/UDP traffic requiring low latency and high throughput | TCP/UDP load balancing, health checks, IP/port-based routing                |

---

## What This Module Covers

- Different types of load balancers available in Google Cloud
- **Managed Instance Groups (MIGs)** and their autoscaling configurations
- How to choose the right load balancer for a given use case
- Two hands-on labs covering the features

## ACE Exam-Style Practice Questions

### Q1

Your internet-facing app needs URL path-based routing with managed TLS in a load balancing and autoscaling design. Which option is best?

A. External Application Load Balancer
B. Internal passthrough load balancer
C. Cloud NAT
D. Direct VM IP without load balancing

Answer: A
Trap: Host and path routing are Layer 7 capabilities provided by Application Load Balancing.

### Q2

Your managed instance group is at max replicas and each instance shows sustained 100% CPU during a traffic surge. What is the fastest first mitigation?

A. Change autoscaling metric to memory immediately
B. Increase the autoscaler upper limit, then investigate bottlenecks
C. Disable health checks
D. Restart all VMs manually

Answer: B
Trap: If autoscaling has hit the ceiling, raising max replicas is the quickest way to regain headroom.
