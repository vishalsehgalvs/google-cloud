# 🖥️ Ways to Access Google Cloud

There are **4 ways** to interact with Google Cloud:

---

## 1. Google Cloud Console (GUI)

A web-based graphical interface — the easiest way to get started.

- Find, manage, and monitor your resources.
- Check health of services.
- Set budgets and spending controls.
- Search for resources quickly.
- Connect to VMs via **SSH directly in the browser**.

> Go to: [console.cloud.google.com](https://console.cloud.google.com)

---

## 2. Google Cloud SDK & Cloud Shell (Command Line)

### Google Cloud SDK

A set of tools you install locally to manage Google Cloud from your terminal.

| Tool           | What it does                                         |
| -------------- | ---------------------------------------------------- |
| **gcloud CLI** | Main command-line tool for all Google Cloud services |
| **bq**         | Command-line tool for BigQuery                       |

- All tools live under the `bin` directory after installation.

### Cloud Shell

A browser-based terminal — no installation needed.

- Runs on a **Debian-based VM** with a **persistent 5 GB home directory**.
- `gcloud` and other SDK tools are **always pre-installed, up to date, and authenticated**.
- Great for quick tasks without setting up anything locally.

---

## 3. APIs (for developers)

Google Cloud services expose APIs so your code can control them programmatically.

- **Google APIs Explorer** (in the Console) — browse available APIs and versions, try them interactively.
- **Client Libraries** — pre-built libraries so you don't have to write API calls from scratch.

Supported languages:
`Java` · `Python` · `PHP` · `C#` · `Go` · `Node.js` · `Ruby` · `C++`

---

## 4. Google Cloud App (Mobile)

A mobile app for managing Google Cloud on the go.

**What you can do:**

- Start/stop **Compute Engine** instances, SSH into them, view logs.
- Start/stop **Cloud SQL** instances.
- Manage **App Engine** apps — view errors, roll back deployments, change traffic splitting.
- View **billing info** and get alerts for over-budget projects.
- Set up **custom graphs** for CPU usage, network usage, requests/second, server errors.
- Handle **alerts and incidents**.

> Download: [cloud.google.com/app](https://cloud.google.com/app)

## ACE Exam-Style Practice Questions

### Q1
In a Accessing Google Cloud scenario, two answers seem technically possible. What tie-breaker should you apply first?

A. Pick the option with most manual steps
B. Pick the option with least privilege and least operational overhead that still meets requirements
C. Pick highest-cost option
D. Pick the oldest product

Answer: B
Trap: ACE-style scenarios reward secure, managed, requirement-fit decisions.

### Q2
For Accessing Google Cloud, what is the best way to reduce wrong answers in multi-choice questions?

A. Ignore scaling and security words
B. Identify trigger words, eliminate over-privileged choices, then choose the managed fit
C. Always pick Compute Engine
D. Always pick the shortest option

Answer: B
Trap: Structured elimination is more reliable than memorization alone.
