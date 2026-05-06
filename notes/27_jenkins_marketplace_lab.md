# 🔁 Lab: Launching Jenkins from Google Cloud Marketplace

## Lab Overview

In this lab, you launched a full **continuous integration (CI)** solution in just a few minutes using **Google Cloud Marketplace**.

You also proved that:
- You could access **Jenkins through its web UI**
- You had **admin-level control** by connecting to the VM over SSH
- You could **stop and restart** the Jenkins service manually

This lab also quietly used several Google Cloud concepts that the course covers later, such as:
- Creating and assigning a network IP address
- Provisioning a virtual machine
- Installing software automatically on that VM
- Passing setup information during deployment

---

## Why Marketplace is Useful

Google Cloud Marketplace lets you deploy complex software quickly without manually doing all the setup yourself.

Instead of manually:
- Creating a VM
- Installing Jenkins
- Opening firewall ports
- Configuring software dependencies

You pick a ready-made solution and Google Cloud handles most of the setup for you.

---

## Part 1: Find Jenkins in Marketplace

1. Open the **Navigation menu** in the Google Cloud Console
2. Click **Marketplace**
3. Search for **Jenkins Certified by Bitnami**
4. Open the listing

Before deploying, you can review:
- What software is included
- Which operating system it uses
- Pricing details
- Whether there are extra usage fees

In this example, the main cost comes from the VM itself.

---

## Part 2: Launch Jenkins on Compute Engine

1. Click **Launch on Compute Engine**
2. Review or change deployment settings such as:
- Deployment name
- Zone
- Machine type
- Other VM-related settings
3. Accept the **Terms of Service**
4. Click **Deploy**

At this point, Google Cloud starts building the environment for you.

---

## Part 3: What Google Cloud Builds Behind the Scenes

Once deployment starts, you move into the deployment view.

Here you can see that Google Cloud is creating:
- A **VM instance**
- **Firewall rules** for ports **80** and **443**
- Software configuration steps
- Deployment configuration files

This is useful because it shows that Marketplace is not "magic". It is automating the same underlying infrastructure tasks you could do manually.

---

## Part 4: Wait for Jenkins to Finish Starting

Even after the VM is running, Jenkins itself may still need a little time to finish starting.

Once ready, the deployment page shows useful details such as:
- Admin username
- Temporary password
- A **Visit the site** link

Clicking **Visit the site** opens Jenkins using the VM's external IP address.

At first, Jenkins may still show that it is starting. That is normal.

---

## Part 5: Log In to Jenkins

1. Copy the provided **admin username** and **temporary password**
2. Open the Jenkins page
3. Sign in
4. Follow the setup wizard
5. Install the suggested plugins
6. Finish the initial setup

After that, Jenkins is ready to use.

---

## Part 6: Recommended Next Steps After Deployment

Marketplace also suggests some follow-up improvements.

Examples:
- Change the **temporary password**
- Assign a **static external IP address**

Why use a static IP?
Because if the external IP changes later, your Jenkins URL changes too. A static IP helps if you want stable access or want to attach DNS to it.

---

## Part 7: Administer Jenkins Through SSH

You can also manage Jenkins directly from the VM.

1. Go back to the deployment or VM page in the Console
2. Click **SSH** for the Jenkins VM
3. This opens a terminal session into the machine

From there, you can run commands from the lab to manage the Jenkins service.

This proves that even though Marketplace automates the setup, you still have low-level access when needed.

---

## Part 8: Stop and Restart Jenkins

In the lab, you stopped the Jenkins services from the SSH session.

After stopping them:
- Refreshing the Jenkins page shows that the service is down

Then you restarted the service from the terminal.

After a few refreshes:
- Jenkins comes back online
- The UI becomes available again

This confirms that you have real administrative control over the software running on the VM.

---

## What This Lab Really Demonstrates

This lab is not just about Jenkins.
It demonstrates how Google Cloud can quickly provision and configure a working solution using multiple services together.

You used:
- **Marketplace** to deploy the solution
- **Compute Engine** to host Jenkins
- **Firewall rules** to allow web traffic
- **External IP addressing** to reach the service
- **SSH** for administration

---

## Key Takeaway

Google Cloud Marketplace helps you launch complete solutions very quickly, but you still keep administrative control.

In this lab, you:
- Deployed Jenkins in minutes
- Logged into the Jenkins UI
- Used SSH to manage the VM
- Stopped and restarted the Jenkins service
- Saw how Google Cloud automates infrastructure setup behind the scenes
