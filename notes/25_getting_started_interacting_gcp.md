# 💻 Getting Started — Interacting with Google Cloud

## What This Module Covers

This module teaches you **how to actually use Google Cloud** — the tools and methods to interact with it.

By the end, you'll be familiar with all the ways to manage Google Cloud resources.

---

## Four Main Ways to Interact with Google Cloud

Google Cloud gives you multiple interfaces to get the job done. Pick whichever fits your style.

---

## 1) Google Cloud Console (Web UI)

The **graphical, web-based interface** for Google Cloud.

**Access:** console.cloud.google.com

**What you can do:**

- View your VMs, databases, storage, and all resources
- Click through menus to create and configure resources
- View dashboards and monitoring
- Point-and-click management

**Good for:** visual learners, learning, quick tasks, exploring Google Cloud.

### Understanding Console Navigation

Lab instructions often say: _"On the Navigation menu, click Compute Engine > VM instances."_

Here's how to follow that:

1. Click the **three horizontal lines icon** (≡) in the Console — this is the Navigation menu
2. A menu opens showing all Google Cloud products
3. **Hover over** "Compute Engine" to see a submenu
4. **Click** "VM instances"

You'll get comfortable with this as you do more labs.

---

## 2) Cloud Shell & Google Cloud CLI

### Cloud Shell

A **browser-based terminal** built right into the Google Cloud Console.

**What it is:**

- A temporary Linux virtual machine
- 5 GB of persistent disk storage (your files stay between sessions)
- Has the Google Cloud CLI (`gcloud`) pre-installed
- Free to use

Access it directly from the Console — no setup needed.

### Google Cloud CLI (gcloud)

A **command-line tool** for managing Google Cloud resources.

**Example commands:**

- `gcloud compute instances list` — list all your VMs
- `gcloud storage buckets create my-bucket` — create a storage bucket
- Works in Cloud Shell or any terminal on your computer

Lab instructions will sometimes say: "Copy and paste this command into Cloud Shell." You'll either use Cloud Shell in the Console or an SSH terminal — just copy and paste the command (sometimes you'll need to modify it, like for globally unique bucket names).

**Good for:** automation, scripting, power users, reproducible workflows.

---

## 3) APIs & Client Libraries

For programmers who want to build custom tools or integrate Google Cloud into applications.

### App APIs

- Access Google Cloud services from your code
- Optimized for languages like Python, Node.js, Java, Go, etc.
- Good for: building applications that use Google Cloud services

### Admin APIs

- Manage and automate resource creation/deletion
- Good for: building custom automation tools and scripts

**Example:** Write a program that automatically creates VMs when certain conditions are met.

---

## 4) Cloud Mobile App

Manage Google Cloud from your **Android or iOS device** on the go.

**What you can do:**

- Start, stop, and SSH into Compute Engine instances
- View logs from instances
- Create custom graphs for metrics (CPU, network, requests/sec, errors)
- Set up alerts and notifications
- View billing info and get budget alerts
- Incident management

**Download:** Google Play Store or App Store

**Good for:** quick management, monitoring on mobile, getting alerts while away.

---

## Cloud Marketplace

Google Cloud Marketplace offers pre-built solutions you can deploy in seconds — from any interface.

Instead of:

- Manually creating VMs
- Installing software
- Configuring networking
- Setting up storage

You just click "Deploy" on a pre-configured solution, and Google Cloud handles all the setup for you.

Examples:

- WordPress
- Jenkins
- Popular databases
- Open-source apps

---

## Projects

A **Project** is how Google Cloud organizes everything.

Think of it as a container that holds:

- All your resources (VMs, networks, databases, etc.)
- Billing information
- IAM permissions
- Quotas and limits

One Google Cloud account can have many projects, and projects are isolated from each other.

---

## Choosing Your Interface

| Task                   | Best Interface           |
| ---------------------- | ------------------------ |
| Learning/exploring     | Console (GUI)            |
| Quick one-off commands | Cloud Shell              |
| Automation/scripting   | Cloud Shell + gcloud CLI |
| Building custom tools  | APIs/Client libraries    |
| Mobile management      | Cloud Mobile App         |

---

## Key Takeaway

You're not locked into one way — use whichever tool makes sense for what you're doing:

- **Console** for visual, point-and-click management
- **Cloud Shell/gcloud CLI** for command-line automation
- **APIs** for custom applications
- **Mobile app** for on-the-go management
- **Cloud Marketplace** for instant pre-built solutions
- **Projects** to organize everything
