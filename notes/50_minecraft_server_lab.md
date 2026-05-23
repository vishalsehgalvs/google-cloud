# Lab: Minecraft Server on Compute Engine

## What This Lab Covers

- Create a customized VM and attach a high-speed SSD
- Reserve a static external IP address
- Install a headless Java runtime and Minecraft server
- Set up Cloud Storage backups with a cron job
- Automate startup and shutdown behavior using metadata scripts

---

## Task 1: Create the VM

- Name: `mc-server`
- Zone: `us-central1-a`
- **Access scopes**: set to "Set access for each API"; change **Storage** from Read Only to **Read Write** (allows the VM to write to Cloud Storage)

### Add a Data Disk

- Add a new disk named `minecraft-disk`
- Type: **SSD persistent disk**
- Size: **50 GB**
- Source: blank (no source image)
- Encryption: Google-managed key
- The disk is automatically attached to the VM on creation

### Networking

- Add a **network tag**: `minecraft-server` (used later to target a firewall rule)
- Edit the network interface: reserve a **static external IP address** so it doesn't change between restarts

---

## Task 2: Prepare the Data Disk

After SSH-ing into the VM:

1. Create a **mount point directory** for the data disk.
2. **Format** the disk.
3. **Mount** the disk to the directory.

> SSH works because the default network has a default firewall rule allowing TCP port 22.

---

## Task 3: Install and Run the Minecraft Server

1. Update the package repository.
2. Install **headless JRE** (no GUI — reduces resource usage, leaves more room for the Minecraft server).
3. Navigate to the mounted disk directory.
4. Download the **Minecraft server `.jar` file**.
5. Run the `.jar` once to initialize — it will fail and ask you to accept the EULA.
6. Edit `eula.txt` with nano: change `eula=false` to `eula=true`.
7. Install **`screen`** to run the server in a virtual terminal (so it keeps running after you disconnect).
8. Start the server using the `screen` command.
9. Once the server finishes loading (spawn area prepared), **detach** from the screen session: `Ctrl+A` then `Ctrl+D`.

---

## Task 4: Create a Firewall Rule for Client Traffic

- Navigate to **VPC Network → Firewall rules**.
- Create a new rule:
  - Name: `minecraft-rule`
  - Network: default
  - Target tags: `minecraft-server`
  - Source IP ranges: `0.0.0.0/0` (anywhere)
  - Protocol: TCP
  - Port: **25565** (default Minecraft port)

---

## Task 5: Verify the Server is Running

- Copy the **static external IP** from the VM instances page.
- Use a third-party Minecraft server status checker website to confirm the server is online.
  - Third-party tools may be unreliable — if one fails, try another.
- A successful check shows: server is up, current player count, and server version.

---

## Task 6: Set Up Cloud Storage Backups

### Create a Bucket from the VM

Since the VM has **Storage Read/Write** access, you can use `gsutil` directly from within the VM (just like Cloud Shell).

```bash
export BUCKET_NAME=<your-project-id>-minecraft-backup
gsutil mb gs://$BUCKET_NAME
```

### Create a Backup Script

- Navigate to the Minecraft home directory and create a script using nano.
- The script:
  1. Saves the current world state and **pauses auto-save** on the server.
  2. Copies the world data directory to a **timestamped folder** in the Cloud Storage bucket.
  3. **Resumes auto-save** after the backup completes.
- Make the script executable with `chmod`.
- Test by running the script manually and verifying the backup folder appears in the Cloud Storage bucket.

---

## Task 7: Automate Backups with Cron

```bash
sudo crontab -e
```

- Add a cron entry to run the backup script **every 4 hours**.
- Note: this generates ~300 backups per month — consider using **Cloud Storage Object Lifecycle Management** to automatically delete old backups or move them to a cheaper storage class.

---

## Task 8: Startup and Shutdown Scripts via Metadata

1. Stop the VM instance.
2. Click **Edit** on the instance and scroll to **Metadata**.
3. Add two metadata keys:
   - `startup-script-url` → URL of the startup script in Cloud Storage
   - `shutdown-script-url` → URL of the shutdown script in Cloud Storage
4. Save and restart the instance.
5. Once the startup script finishes, verify the Minecraft server is accessible again via the status checker.

> Scripts stored in Cloud Storage can be referenced by URL in metadata, keeping VM configuration clean and reusable.

---

## Key Takeaways

- These techniques (metadata scripts, cron automation, Cloud Storage integration) apply to any production server administration, not just gaming.
- Using a **static IP** prevents the address from changing on restart.
- **Headless JRE** reduces resource overhead for server workloads.
- **Cloud Storage Object Lifecycle Management** helps manage backup retention costs automatically.

---

## gcloud Commands

```bash
# Create the Minecraft server VM
gcloud compute instances create mc-server --zone=us-central1-a \
  --machine-type=e2-medium --tags=minecraft-server \
  --image-family=debian-11 --image-project=debian-cloud \
  --boot-disk-size=50GB

# Reserve a static external IP
gcloud compute addresses create mc-server-ip --region=us-central1

# Create a firewall rule for Minecraft (TCP 25565)
gcloud compute firewall-rules create allow-minecraft \
  --direction=INGRESS --action=ALLOW \
  --rules=tcp:25565 --target-tags=minecraft-server

# SSH into the VM
gcloud compute ssh mc-server --zone=us-central1-a
```
