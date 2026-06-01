# Google Cloud Marketplace

## What Is Cloud Marketplace?

- Lets you **quickly deploy functional software packages** that run on Google Cloud
- Offers **production-grade solutions** from third-party vendors
- Vendor deployment configurations are based on **Terraform** under the hood

---

## Key Features

- **Unified billing** — Marketplace solutions are billed together with all your other Google Cloud services in the same project
- **Bring Your Own License (BYOL)** — if you already have a license for a third-party service, you may be able to use a BYOL solution instead of paying through Marketplace
- **Scalable** — deploy a package now and scale it later when your application needs more capacity
- **Google-maintained images** — Google updates the base images to fix critical issues and vulnerabilities; however, updates do not apply to software you've already deployed
- **Partner support** — you can get direct access to support from the vendor/partner

---

## How It Works

1. Browse Marketplace for the solution you need (e.g., databases, security tools, developer tools)
2. Click **Launch** — Marketplace pre-fills the deployment configuration
3. Customize as needed and deploy
4. The solution runs on your GCP infrastructure and is billed to your project

---

## When to Use Marketplace

| Scenario                                                        | Why Marketplace                        |
| --------------------------------------------------------------- | -------------------------------------- |
| Need a known third-party stack (e.g., Jenkins, WordPress, LAMP) | Pre-configured, ready to deploy        |
| Want managed billing in one place                               | All charges roll up to your GCP bill   |
| Already have a software license                                 | Use BYOL to avoid double-paying        |
| Need vendor support                                             | Direct partner support access included |

---

## Demo Walkthrough — Deploying a LAMP Stack

### What Is a LAMP Stack?

| Letter | Component          |
| ------ | ------------------ |
| **L**  | Linux              |
| **A**  | Apache HTTP Server |
| **M**  | MySQL              |
| **P**  | PHP                |

---

### Steps

1. **Navigate to Marketplace** — go to the navigation menu → **Marketplace**
2. **Search** for "LAMP stack" — multiple providers will appear; each provider offers their own configuration of the same stack
3. **Select a solution** — click a result to see the configuration page, which shows:
   - Package contents (OS, Apache, PHP, MySQL)
   - Usage fee (if any — billed together with GCP services)
   - Instance billing details (e.g., N1 standard-1 with persistent disk and sustained use discount)
4. **Click Launch on Compute Engine** — opens a VM configuration page where you can:
   - Change the machine type (larger, smaller, custom)
   - See that the **HTTP firewall rule (TCP 80)** is pre-configured for Apache
   - Adjust networking options
   - Enable optional add-ons (e.g., phpMyAdmin)
   - Enable **Cloud Logging and Monitoring** (Stackdriver)
5. **Click Deploy** — GCP redirects to **Deployment Manager**, which shows:
   - The full deployment configuration and all imported files
   - A generated **VM instance** and **admin password**
   - The HTTP firewall rule (TCP 80) being applied

> Marketplace solutions are pre-built **Deployment Manager configurations** — you don't need to write them yourself.

---

### After Deployment

Once the instance is running, the Deployment Manager page shows:

- **Site address** — visit the deployed LAMP site directly
- **Admin username and password**
- **SSH link** to the instance
- **Next steps** suggested by the vendor, such as:
  - Enable HTTPS traffic
  - Change the admin password
  - Assign a static external IP (default is ephemeral)
  - Learn more about installed software

The instance also appears in **Compute Engine → VM Instances** like any other VM.
