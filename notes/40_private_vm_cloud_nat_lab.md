# Lab: Private VM, Cloud IAP, Private Google Access, and Cloud NAT (Easy Version)

## What you did in this lab

You learned how to make a VM that is private (no public IP), connect to it safely, and let it reach the internet and Google services in a secure way.

---

## 1. Create a Private VM (No External IP)

- Made a new VPC network called `privatenet` with a custom subnet.
- Created a firewall rule to allow SSH, but only from Cloud IAP (not from anywhere on the internet).
- Made a VM called `vm-internal` in this network, with **no external IP**.

**Result:**

- You can’t SSH to this VM directly from the internet.
- The VM is private and safe from outside attacks.

---

## 2. Connect to the Private VM Using Cloud IAP

- Used Cloud IAP (Identity-Aware Proxy) to open a secure tunnel and SSH into the VM from Cloud Shell.
- No need for a “bastion” host or public IP.

**Result:**

- You can manage your private VM safely, even though it has no public IP.

---

## 3. Test Access to Google APIs (Private Google Access)

- Tried to use the VM to access Google Cloud Storage (copy a file to a bucket).
- At first, it didn’t work because “Private Google Access” was OFF for the subnet.
- Turned ON Private Google Access for the subnet.
- Now the VM could reach Google APIs and services, even with no public IP.

**Result:**

- Private VMs can use Google services if Private Google Access is enabled.

---

## 4. Test Internet Access (Cloud NAT)

- Tried to update the VM (e.g., `apt-get update`).
- Didn’t work, because the VM had no public IP and no Cloud NAT.
- Set up a Cloud NAT gateway for the network.
- Waited a few minutes for it to start working.
- Tried again, and now the VM could reach the internet for updates and downloads.

**Result:**

- Cloud NAT lets private VMs reach the internet for outbound connections (updates, patches, etc.), but nobody can reach in from the outside.

---

## 5. Key Points

- **Private VMs** (no external IP) are safer from attacks.
- **Cloud IAP** lets you connect to private VMs without a public IP.
- **Private Google Access** lets private VMs use Google APIs/services.
- **Cloud NAT** lets private VMs reach the internet for updates, but blocks outside access.
- You can control who can use Cloud IAP by giving them the right roles in IAM.

---

## 🗝️ Takeaway

You can build secure, private cloud servers that are still easy to manage and keep up-to-date—no need to expose them to the public internet!

---

## gcloud Commands

```bash
# SSH into a private VM via Cloud IAP (no external IP needed)
gcloud compute ssh my-vm --zone=us-central1-a --tunnel-through-iap

# Enable Private Google Access on a subnet
gcloud compute networks subnets update my-subnet \
  --region=us-central1 --enable-private-ip-google-access

# Create a Cloud Router
gcloud compute routers create my-router \
  --network=my-vpc --region=us-central1

# Create a Cloud NAT gateway
gcloud compute routers nats create my-nat \
  --router=my-router --region=us-central1 \
  --auto-allocate-nat-external-ips --nat-all-subnet-ip-ranges
```
