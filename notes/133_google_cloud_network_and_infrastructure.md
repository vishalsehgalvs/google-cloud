# Google Cloud Global Network and Infrastructure

## Google's Global Network

- Google's network carries an estimated **40% of the world's internet traffic** every day
- The **largest network of its kind** — billions of dollars invested over the years
- Designed for **highest possible throughput** and **lowest possible latency**
- Uses **100+ content caching nodes worldwide** — high-demand content is cached close to users so requests are served from the location with the quickest response time

---

## Geographic Locations

Google Cloud infrastructure spans **7 major geographic areas**:

- North America
- South America
- Europe
- Africa
- Middle East
- Asia
- Australia

> Choosing where to locate your application affects **availability**, **durability**, and **latency**.

---

## Regions and Zones

### Regions

- **Independent geographic areas** composed of zones
- Example: `europe-west2` (London) — currently has 3 zones

### Zones

- The area where Google Cloud **resources are actually deployed**
- Example: when you launch a Compute Engine VM, it runs in the zone you specify
- Deploying in multiple zones within a region provides **resource redundancy**

### Multi-Region Deployment

- Deploy resources across multiple regions to:
  - Bring applications **closer to users** around the world
  - Protect against failures affecting an **entire region** (e.g., natural disasters)

---

## Current Scale

| Metric  | Value |
| ------- | ----- |
| Zones   | 124   |
| Regions | 41    |

> Numbers are constantly growing. See the latest at [cloud.google.com/about/locations](https://cloud.google.com/about/locations).

## ACE Exam-Style Practice Questions

### Q1
In a Google Cloud Network And Infrastructure scenario, two answers seem technically possible. What tie-breaker should you apply first?

A. Pick the option with most manual steps
B. Pick the option with least privilege and least operational overhead that still meets requirements
C. Pick highest-cost option
D. Pick the oldest product

Answer: B
Trap: ACE-style scenarios reward secure, managed, requirement-fit decisions.

### Q2
For Google Cloud Network And Infrastructure, what is the best way to reduce wrong answers in multi-choice questions?

A. Ignore scaling and security words
B. Identify trigger words, eliminate over-privileged choices, then choose the managed fit
C. Always pick Compute Engine
D. Always pick the shortest option

Answer: B
Trap: Structured elimination is more reliable than memorization alone.
