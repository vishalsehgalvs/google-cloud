# Terraform and Infrastructure as Code

## Infrastructure as Code (IaC)

- Enables **quick provisioning and removal** of infrastructure on demand
- Can be integrated into a **CI/CD pipeline** for continuous deployment
- Infrastructure complexity is managed in code — changes are in one place
- Dev/test environments can easily **replicate production** and be deleted when not needed
- Google Cloud supports: **Terraform**, Chef, Puppet, Ansible, Packer

---

## Terraform Overview

- Provisions GCP resources — VMs, containers, storage, networking — using **declarative configuration files**
- Written in **HashiCorp Configuration Language (HCL)**: concise, human-readable blocks, arguments, and expressions
- **Declarative approach** — you specify *what* you want; Terraform figures out *how* to create it
- Deploys resources **in parallel** (unlike Cloud Shell which runs commands sequentially)
- Uses underlying GCP APIs; supports almost everything: instances, instance templates, VPC networks, firewall rules, VPN tunnels, Cloud Routers, load balancers, and more
- Already installed in **Cloud Shell**
- Works across multiple public and private clouds

### When to Use What

| Tool | Best For |
|---|---|
| GCP Console | New to a service; prefer a UI |
| Cloud Shell | Comfortable with a service; quick CLI commands |
| Terraform | Repeatable, version-controlled infrastructure at scale |

---

## Terraform Language Structure

| Construct | Description |
|---|---|
| **Provider block** | Specifies the cloud provider (e.g., Google Cloud) and region |
| **Resource block** | Defines a GCP resource (e.g., Compute Engine VM, VPC network, firewall rule) |
| **Output block** | Declares an output variable (e.g., an instance IP) |
| **Block** | Represents an object; has zero or more labels and a body |
| **Argument** | Assigns a value to a name inside a block |
| **Expression** | Represents a value that can be assigned to an identifier |

Configurations can span **multiple files and directories**; resources can be abstracted into **reusable modules**.

---

## Example — `main.tf` for Auto Mode Network with HTTP Firewall Rule

```hcl
provider "google" {
  region = "us-central1"
}

resource "google_compute_network" "my_network" {
  name                    = "my-auto-network"
  auto_create_subnetworks = true
  mtu                     = 1460
}

resource "google_compute_firewall" "http_firewall" {
  name    = "allow-http"
  network = google_compute_network.my_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }
}

output "instance_ip" {
  value = google_compute_instance.my_vm.network_interface[0].access_config[0].nat_ip
}
```

---

## Core Terraform Commands

| Command | Purpose |
|---|---|
| `terraform init` | Initializes the configuration; downloads and installs the provider plugin (run in the same folder as `main.tf`) |
| `terraform plan` | Shows what actions Terraform will take to reach the desired state — **no changes are made** |
| `terraform apply` | Creates or updates the infrastructure defined in the configuration files |
