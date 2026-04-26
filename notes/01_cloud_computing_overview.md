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
