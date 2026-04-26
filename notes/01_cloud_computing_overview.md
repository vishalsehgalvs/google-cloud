## ☁️ What is Cloud Computing?

**Definition (by NIST):** Cloud computing is just a smarter way to use tech — instead of owning hardware, you rent it over the internet.

---

### 5 Key Traits of Cloud Computing

1. **On-demand & self-service** — Need storage or computing power? Get it yourself through a website, no need to call anyone.

2. **Accessible from anywhere** — As long as you have internet, you can access your resources from any location.

3. **Shared resource pool** — The provider buys resources in bulk and shares them across many users → cheaper for everyone.

4. **Elastic (flexible)** — Need more? Scale up. Need less? Scale down. Fast.

5. **Pay only for what you use** — Stop using it, stop paying. No wasted money.

---

### How We Got Here — 3 Waves

| Wave                             | What it is                                 | Who manages it    |
| -------------------------------- | ------------------------------------------ | ----------------- |
| 1st — **Colocation**             | Rent space in someone else's data center   | You               |
| 2nd — **Virtualization**         | Virtual versions of servers/disks/etc.     | Still you         |
| 3rd — **Cloud (Google's model)** | Fully automated, containers, scales itself | The cloud does it |

---

### Google's Role

- Google found virtualization too slow for their pace → built a **container-based, fully automated** cloud.
- That's what **Google Cloud** is — the 3rd wave, available to everyone.

---

### The Big Idea

> Every company — no matter size or industry — will eventually compete through **technology → software → data**.
> That makes every company a **data company** in the future.

---

## 🧱 Cloud Service Models — IaaS, PaaS, Serverless & SaaS

### The 4 Models at a Glance

| Model          | What you get                        | You manage                    | Google Example                 |
| -------------- | ----------------------------------- | ----------------------------- | ------------------------------ |
| **IaaS**       | Raw compute, storage, network       | Everything on top of hardware | Compute Engine                 |
| **PaaS**       | Platform + runtime to run your code | Just your app logic           | App Engine                     |
| **Serverless** | Just write code, nothing else       | Nothing                       | Cloud Run, Cloud Run Functions |
| **SaaS**       | Ready-to-use application            | Nothing                       | Gmail, Google Docs, Drive      |

---

### IaaS — Infrastructure as a Service

- You get virtual machines, storage, and networking — basically a virtual data center.
- You still have to set up and manage the OS, runtime, etc.
- **Pay for what you allocate** (even if you don't use it all).
- Google example: **Compute Engine**

### PaaS — Platform as a Service

- You bring your code, the platform handles the infrastructure underneath.
- More focus on building features, less on managing servers.
- **Pay for what you actually use**.
- Google example: **App Engine**

### Serverless — No Infrastructure at All

- You just write code. No servers, no configs, no maintenance.
- Great for small, event-driven tasks or containerized apps.
- Google examples:
  - **Cloud Run** — run containerized apps, fully managed
  - **Cloud Run Functions** — run small pieces of code triggered by events, pay-as-you-go

### SaaS — Software as a Service

- A complete, ready-to-use app delivered over the internet.
- Nothing to install — you just open a browser and use it.
- Google examples: **Gmail, Google Docs, Google Drive** (all part of Google Workspace)

---

### The Shift Happening in the Industry

- Companies are moving toward **managed infrastructure & managed services**.
- Why? Less time spent on tech plumbing → more time on actual business goals.
- Result: faster, more reliable products for customers.

---

## 🌍 Google Cloud's Global Network & Infrastructure

### The Network

- Google Cloud runs on **Google's own private global network** — the largest of its kind.
- Built over many years with billions in investment.
- Designed for **highest throughput + lowest latency** for apps worldwide.
- Uses **100+ content caching nodes** globally — popular content is cached close to users so it loads faster.

---

### Where Google Cloud Lives — 7 Geographic Areas

North America · South America · Europe · Africa · Middle East · Asia · Australia

---

### Regions, Zones & Multi-Regions

| Level            | What it is                                  | Example                 |
| ---------------- | ------------------------------------------- | ----------------------- |
| **Region**       | An independent geographic area              | `europe-west2` (London) |
| **Zone**         | A deployment area inside a region           | `europe-west2-a`        |
| **Multi-Region** | Spans multiple regions for extra redundancy | Spanner, Cloud Storage  |

**Key points:**

- A region has **multiple zones** (e.g. London has 3 zones).
- Your resources (like VMs) run in a **specific zone** you choose.
- Spreading across **zones** = protects against zone failures.
- Spreading across **regions** = protects against regional disasters + brings apps closer to users.
- **Multi-region** = data replicated across zones in multiple regions → read from wherever is closest.

---

### Why This Matters

- **Availability** — if one zone/region goes down, others keep running.
- **Durability** — your data isn't lost even if hardware fails.
- **Latency** — serve users from the location nearest to them.

> Current regions & zones list: [cloud.google.com/about/locations](https://cloud.google.com/about/locations)

---

## 🌱 Google Cloud & Sustainability

### The Problem

- All those data centers worldwide use a lot of power — existing data centers consume roughly **2% of the world's electricity**.
- Google takes this seriously and works hard to run data centers as efficiently as possible.

### What Google Has Done

| Milestone                                        | Detail                                                                                                  |
| ------------------------------------------------ | ------------------------------------------------------------------------------------------------------- |
| **First** to achieve ISO 14001 certification     | A global standard for improving environmental performance — reducing waste, using resources efficiently |
| **First major company** to be carbon neutral     | Achieved in Google's founding decade                                                                    |
| **First company** to reach 100% renewable energy | Achieved in Google's second decade                                                                      |
| **Goal by 2030**                                 | First major company to operate completely carbon free                                                   |

### Cool Example — Hamina, Finland Data Center

- One of Google's most advanced and efficient data centers.
- Uses **sea water from the Bay of Finland** to cool servers — a first-of-its-kind cooling system that significantly cuts energy use.

### Why It Matters for You

- Running workloads on Google Cloud helps customers meet **their own environmental goals** too.
- You're not just saving money — you're also using greener infrastructure.

---

## 🔒 Google Cloud Security

### The Big Picture

- 9 Google services have **1 billion+ users each** — security is baked into everything.
- Security is built in **progressive layers**, from physical hardware all the way up to operations.

---

### The 6 Security Layers

#### 1. Hardware Infrastructure

| Feature                        | What it means                                                                                                        |
| ------------------------------ | -------------------------------------------------------------------------------------------------------------------- |
| **Custom hardware**            | Google designs its own server boards, networking gear, and security chips                                            |
| **Secure boot stack**          | Servers verify they're running the right software using cryptographic signatures on BIOS, bootloader, kernel, and OS |
| **Physical premises security** | Google builds its own data centers with multiple physical security layers — very few employees ever get access       |

#### 2. Service Deployment

- All communication between Google services uses **RPC (Remote Procedure Calls)**.
- This traffic is **automatically encrypted** between data centers.
- Google is rolling out hardware crypto accelerators to encrypt all RPC traffic inside data centers too.

#### 3. User Identity

- Google's login goes beyond just username + password.
- It **intelligently challenges** users based on risk signals (new device? unusual location?).
- Supports **U2F (Universal 2nd Factor)** — physical security keys for stronger login.

#### 4. Storage Services

- Most apps access storage indirectly through Google's storage services.
- Data is **encrypted at rest** using centrally managed keys.
- Hard drives and SSDs also have hardware-level encryption support.

#### 5. Internet Communication

- Services exposed to the internet go through **Google Front End (GFE)**.
  - GFE enforces TLS with proper certificates (X.509 from a CA) and perfect forward secrecy.
  - GFE also provides **DoS (Denial of Service) protection**.
- Google's massive infrastructure scale lets it simply absorb many DoS attacks.
- Multi-tier, multi-layer DoS protection adds further safety.

#### 6. Operational Security

| Feature                         | What it means                                                                                                                       |
| ------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| **Intrusion detection**         | Rules + machine intelligence alert security teams of threats; Red Team exercises test defenses                                      |
| **Insider risk reduction**      | Admin access is strictly limited and actively monitored                                                                             |
| **Employee U2F**                | All Google employees must use U2F security keys — protects against phishing                                                         |
| **Secure software development** | Central source control, two-party code review, security-safe libraries, and a public **Vulnerability Rewards Program** (bug bounty) |

> Learn more: [cloud.google.com/security/security-design](https://cloud.google.com/security/security-design)
