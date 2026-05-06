# 📈 Lab: Expanding a Custom Subnet in Google Cloud

## Lab Goal

This lab shows how to expand a **custom subnet** when you run out of internal IP addresses.

Key outcome:
- You can increase subnet IP range size **without shutting down running workloads**.

---

## Starting Point

You begin with a custom subnet using a **/29** CIDR range.

### What /29 means
A `/29` subnet has **8 total IP addresses**.

In Google Cloud, **4 addresses are reserved**, so only **4 usable addresses** are left for VM instances.

That means once 4 VMs are running, the subnet has no free internal IPs left.

---

## Step 1: Confirm IP Exhaustion

1. Open Compute Engine VM instances in the Console
2. Verify that 4 VM instances already exist in the subnet
3. Start creating a 5th VM in the same subnet

Expected result:
- VM creation fails
- Error indicates subnet IP space is exhausted

You can also watch this in the notification panel during creation.

---

## Step 2: Expand the Subnet

After the failure, expand the subnet range.

Two ways to navigate there:
- Through VPC Network settings
- Or from VM network interface details (for example, by clicking NIC/subnet links)

Then:
1. Open the subnet
2. Click Edit
3. Change subnet mask from `/29` to `/23`
4. Save changes

A `/23` subnet supports far more addresses (enough for hundreds of instances).

---

## Step 3: Retry VM Creation

Once subnet update is complete:
1. Use Retry from the failed VM creation flow (or create the VM again)
2. Wait for staging and provisioning
3. Confirm the new VM gets an internal IP

Expected result:
- VM 5 is created successfully
- Internal IP allocation works because subnet now has enough free space

---

## Why This Matters

This lab demonstrates an important operational benefit:

- Existing VMs keep running during subnet expansion
- No shutdown required
- No workload downtime required

So when subnet capacity is exhausted, you can scale networking capacity live.

---

## Practical Rules to Remember

1. Plan subnet sizes based on expected growth.
2. Small subnets like `/29` are useful for testing but exhaust quickly.
3. Expansion is safer than emergency redesign.
4. Subnet expansion is one-way for size growth in practice: design carefully before large changes.

---

## Quick Example Math

- `/29` => 8 total IPs
- 4 reserved by Google Cloud
- 4 usable for VMs

If you already have 4 VMs, a 5th VM in the same subnet fails until the subnet is expanded.

---

## Key Takeaway

Subnet IP exhaustion is common in small test ranges.

Google Cloud lets you fix it quickly by expanding the custom subnet range, and you can do this **without stopping existing VM workloads**.