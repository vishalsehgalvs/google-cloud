# 🧪 Lab: Internal vs External IPs on a VM

## Lab Goal

This lab demonstrates three key behaviors in Google Cloud:

- Every VM needs an internal IP address
- External IP addresses are optional
- Ephemeral external IPs can change after stop/start

---

## Step 1: Create a VM and Open Networking Options

From **Compute Engine > VM instances**:

1. Click **Create Instance**
2. Expand **Management, security, networking, sole tenancy**
3. Open the **Networking** section
4. Edit the network interface (pencil icon)

This is where you choose internal and external IP behavior.

---

## Step 2: Choose Internal and External IP Settings

Inside the network interface settings, you can select:

- VPC network/subnet
- Internal IP option
- External IP option

### Internal IP options

You can use:

- **Ephemeral internal IP** (auto-assigned)
- **Custom internal IP** (manually choose within subnet range)
- **Reserved static internal IP** (keep the same internal IP long-term)

### External IP options

You can use:

- **Ephemeral external IP**
- **Reserved static external IP**
- **None** (no external access)

Important: External IP is optional. Internal IP is not.

---

## Step 3: Instance and Address Capacity Notes

In the walkthrough example, subnet size is **/20**, which gives a large address pool (roughly 4096 addresses).

But address range size is not the only limit. Also consider:

- Project/network quotas
- VM-per-network limits (example mentioned around 15,000 at recording time)
- Actual regional/zonal hardware capacity

So having IP space does not always guarantee unlimited VM creation.

---

## Step 4: Create the VM and Observe IPs

After creation, note both values in the VM list/details:

- Internal IP
- External IP

Expected behavior:

- Internal IP is from your subnet range
- External ephemeral IP is from Google's public pool

---

## Step 5: Stop the VM and Watch IP Changes

1. Select VM
2. Click **Stop**
3. Confirm stop action

During stop:

- Google Cloud allows time for graceful shutdown (for example, shutdown scripts)
- If scripts exceed timeout, a forced stop can occur

After VM is stopped:

- External ephemeral IP is released
- Internal IP usually remains associated with the VM

---

## Step 6: Start the VM Again

1. Click **Start**
2. Wait for instance to return to Running
3. Compare old vs new IP values

Typical result in this scenario:

- Internal IP stayed the same
- External IP changed (because it was ephemeral)

---

## What This Lab Proves

- Internal IP addresses are required for VM networking
- External IP addresses are optional for internet-facing access
- Ephemeral external IPs are not guaranteed to persist across stop/start
- If you need a stable public endpoint, reserve and attach a static external IP

---

## Key Takeaway

When designing VM connectivity:

- Use internal IPs for private communication
- Add external IP only when required
- Use static external IP for stable DNS/integration endpoints
- Expect ephemeral external IP to change after VM lifecycle events like stop/start
