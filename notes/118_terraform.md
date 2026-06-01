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
- **Declarative approach** — you specify _what_ you want; Terraform figures out _how_ to create it
- Deploys resources **in parallel** (unlike Cloud Shell which runs commands sequentially)
- Uses underlying GCP APIs; supports almost everything: instances, instance templates, VPC networks, firewall rules, VPN tunnels, Cloud Routers, load balancers, and more
- Already installed in **Cloud Shell**
- Works across multiple public and private clouds

### When to Use What

| Tool        | Best For                                               |
| ----------- | ------------------------------------------------------ |
| GCP Console | New to a service; prefer a UI                          |
| Cloud Shell | Comfortable with a service; quick CLI commands         |
| Terraform   | Repeatable, version-controlled infrastructure at scale |

---

## Terraform Language Structure

| Construct          | Description                                                                  |
| ------------------ | ---------------------------------------------------------------------------- |
| **Provider block** | Specifies the cloud provider (e.g., Google Cloud) and region                 |
| **Resource block** | Defines a GCP resource (e.g., Compute Engine VM, VPC network, firewall rule) |
| **Output block**   | Declares an output variable (e.g., an instance IP)                           |
| **Block**          | Represents an object; has zero or more labels and a body                     |
| **Argument**       | Assigns a value to a name inside a block                                     |
| **Expression**     | Represents a value that can be assigned to an identifier                     |

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

| Command           | Purpose                                                                                                         |
| ----------------- | --------------------------------------------------------------------------------------------------------------- |
| `terraform init`  | Initializes the configuration; downloads and installs the provider plugin (run in the same folder as `main.tf`) |
| `terraform plan`  | Shows what actions Terraform will take to reach the desired state — **no changes are made**                     |
| `terraform apply` | Creates or updates the infrastructure defined in the configuration files                                        |
| `terraform fmt`   | Rewrites configuration files into canonical format and style                                                    |

---

## Lab Walkthrough — Automating Infrastructure with Terraform

### What This Lab Covers

- Configure Cloud Shell with Terraform
- Create a VPC network and firewall rule using Terraform
- Build a reusable instance module
- Deploy two VM instances using that module
- Verify all resources in the GCP Console

---

### Step 1 — Verify Terraform in Cloud Shell

```bash
terraform version
```

- Terraform is pre-installed in Cloud Shell — no setup needed
- The lab works with version 12.2 or later

---

### Step 2 — Create the Provider File

Create a folder (e.g., `tf-infra`), open the Cloud Shell code editor, and create `provider.tf`:

```hcl
provider "google" {}
```

- This tells Terraform to use Google Cloud as the provider
- Run `terraform init` in the folder to download and initialize the Google provider plugin

---

### Step 3 — Create the VPC Network (`mynetwork.tf`)

```hcl
resource "google_compute_network" "mynetwork" {
  name                    = "mynetwork"
  auto_create_subnetworks = true
}
```

- `auto_create_subnetworks = true` → auto mode network; subnets are created in every region automatically

---

### Step 4 — Add the Firewall Rule (same file)

```hcl
resource "google_compute_firewall" "mynetwork_allow_http_ssh_rdp_icmp" {
  name    = "mynetwork-allow-http-ssh-rdp-icmp"
  network = google_compute_network.mynetwork.self_link

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "3389"]
  }

  allow {
    protocol = "icmp"
  }
}
```

- `network = google_compute_network.mynetwork.self_link` → **self-link reference**: Terraform creates the network first before the firewall rule (dependency ordering)
- Allows: SSH (22), HTTP (80), RDP (3389), and ICMP (ping)

---

### Step 5 — Create the Instance Module

Create a subfolder `instance/` inside `tf-infra/`, then create `instance/main.tf`:

```hcl
variable "instance_name" {}
variable "instance_zone" {}
variable "instance_type" {
  default = "e2-micro"
}
variable "instance_subnetwork" {}

resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  zone         = var.instance_zone
  machine_type = var.instance_type

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = var.instance_subnetwork
    access_config {}
  }
}
```

- Input variables (`instance_name`, `instance_zone`, `instance_subnetwork`) are passed in from the parent configuration
- `instance_type` has a default value of `e2-micro` — no need to pass it unless you want a different type
- `access_config {}` allocates an external (public) IP to the instance

---

### Step 6 — Use the Module in `mynetwork.tf`

Add two module blocks to `mynetwork.tf` to create two VM instances:

```hcl
module "mynet-us-vm" {
  source              = "./instance"
  instance_name       = "mynet-us-vm"
  instance_zone       = "us-central1-a"
  instance_subnetwork = google_compute_network.mynetwork.self_link
}

module "mynet-eu-vm" {
  source              = "./instance"
  instance_name       = "mynet-eu-vm"
  instance_zone       = "europe-west1-d"
  instance_subnetwork = google_compute_network.mynetwork.self_link
}
```

- Both modules reuse the same `instance/` module with different input variables
- `self_link` references ensure instances are created only after the network exists

---

### Step 7 — Format, Init, Plan, Apply

```bash
# Format all files into canonical style
terraform fmt

# Re-initialize to pick up the new module
terraform init

# Preview what will be created (no changes made)
terraform plan

# Apply the configuration — type "yes" when prompted
terraform apply
```

**Apply creates 4 resources in this order:**

1. `google_compute_network.mynetwork` (created first — others depend on it)
2. `google_compute_firewall.mynetwork_allow_http_ssh_rdp_icmp` (in parallel with VMs, after network)
3. `module.mynet-us-vm` (in parallel)
4. `module.mynet-eu-vm` (in parallel)

> Terraform prints a progress update every 10 seconds while resources are being created.

---

### Step 8 — Verify in the GCP Console

| Where to check     | What to look for                                            |
| ------------------ | ----------------------------------------------------------- |
| **VPC Network**    | `mynetwork` appears as an auto mode network                 |
| **Firewall Rules** | `mynetwork-allow-http-ssh-rdp-icmp` rule is listed          |
| **Compute Engine** | Two VM instances (`mynet-us-vm`, `mynet-eu-vm`) are running |

### Step 9 — Test Connectivity

SSH into one VM and ping the other:

```bash
ping -c 3 <internal-or-external-IP-of-other-VM>
```

- Works because both VMs are on the same network and the firewall rule allows ICMP traffic

---

### Key Takeaways

- Terraform **incremental execution plans** let you build infrastructure step-by-step as config evolves
- **Modules** allow you to reuse the same resource config for multiple resources, with input variables for customization
- **Self-link references** enforce dependency ordering — Terraform knows to create dependent resources first
- Resources with no dependencies are created **in parallel**, making deployments faster
- The configuration you build can serve as a **starting point for future deployments**
