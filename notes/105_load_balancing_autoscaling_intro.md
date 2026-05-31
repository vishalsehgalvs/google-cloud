# Load Balancing and Autoscaling — Module Intro

## Cloud Load Balancing Overview

- Distribute load-balanced compute resources across **single or multiple regions**
- All resources sit behind a **single anycast IP address**
- Scales up or down with **intelligent autoscaling**
- Can serve content as close as possible to users — handles **1 million+ queries per second**
- Fully **distributed, software-defined, managed service** — no physical load balancing infrastructure to manage

---

## Two Primary Load Balancer Types

| Type | OSI Layer | Best For | Key Features |
|---|---|---|---|
| **Application Load Balancer** | Layer 7 (Application) | HTTP(S) traffic requiring content-based routing | SSL/TLS termination, session affinity, routing by headers/cookies/URL paths |
| **Network Load Balancer** | Layer 4 (Network) | TCP/UDP traffic requiring low latency and high throughput | TCP/UDP load balancing, health checks, IP/port-based routing |

---

## What This Module Covers

- Different types of load balancers available in Google Cloud
- **Managed Instance Groups (MIGs)** and their autoscaling configurations
- How to choose the right load balancer for a given use case
- Two hands-on labs covering the features
