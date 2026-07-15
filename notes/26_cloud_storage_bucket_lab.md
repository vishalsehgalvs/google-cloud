# 📦 Lab: Creating Storage Buckets and Cloud Shell Persistence

## Lab Overview

This lab walks through creating Cloud Storage buckets using both the Console and Cloud Shell, uploading files, and setting up persistent configuration.

---

## Console vs Cloud Shell — They're Complementary

**Google Cloud Console:**

- Keeps track of your configuration context
- Uses APIs to determine what options are valid
- Great for repetitive, guided tasks
- Good for visual learners

**Cloud Shell:**

- Offers precise, detailed control
- Lets you script and automate activities
- Good for power users and automation
- Repeatable, scriptable workflows

**Bottom line:** Don't think of them as alternatives — think of them as **one flexible, powerful interface**. Use whichever makes sense for the task.

---

## Part 1: Creating a Bucket in the Console

1. Open the **Navigation menu** (three horizontal lines, top-left corner)
2. Scroll down to **Storage** → click **Browser**
3. Click **Create bucket**
4. Enter a **globally unique name** (tip: use your project ID to ensure uniqueness)
5. Leave default settings (or adjust storage class if needed)
6. Click **Create**

Your bucket now appears in the bucket list.

---

## Part 2: Creating a Bucket in Cloud Shell

1. Click **Activate Cloud Shell** button (top-right corner)
2. When prompted, start Cloud Shell
3. Use the `gsutil` command to create a bucket:

```bash
gsutil mb gs://YOUR-UNIQUE-BUCKET-NAME-shell
```

Replace `YOUR-UNIQUE-BUCKET-NAME` with a globally unique name.

**Tip:** You can append `-shell` to your project ID to make it unique.

If you go back to the Console, you'll see both buckets now exist.

---

## Part 3: Uploading and Copying Files

### Upload a File in Cloud Shell

1. Click the **three dots menu** in Cloud Shell
2. Select **Upload file**
3. Choose a file from your computer
4. Click **Open**

The file uploads to Cloud Shell's temporary storage.

### Copy File to Cloud Storage

Use `gsutil cp` to copy a file from Cloud Shell to your bucket:

```bash
gsutil cp MyFile.txt gs://YOUR-BUCKET-NAME/
```

You can verify the file arrived by navigating to the bucket in the Console.

---

## Part 4: Creating Persistent Configuration

Cloud Shell is temporary — it resets between sessions. But you can create configuration that persists.

### Set Environment Variables

List available regions:

```bash
gcloud compute regions list
```

Store a region in a variable:

```bash
REGION=us-central1
```

Verify it was stored:

```bash
echo $REGION
```

### Create a Configuration File

Create a folder:

```bash
mkdir infraclass
```

Create a config file and store variables in it:

```bash
echo "REGION=us-central1" >> infraclass/config
echo "PROJECT_ID=$(gcloud config get-value project)" >> infraclass/config
```

Verify it worked:

```bash
cat infraclass/config
```

---

## Part 5: Auto-load Configuration on Startup

Every time you open Cloud Shell, you have to manually load your config. To make it automatic:

1. Edit the `.profile` file (runs automatically when Cloud Shell starts):

```bash
nano ~/.profile
```

2. Add this line at the end:

```bash
source infraclass/config
```

3. Save and exit (Ctrl+O, Enter, Ctrl+X in nano)

4. Close and reopen Cloud Shell

5. Verify your variables are loaded:

```bash
echo $PROJECT_ID
```

Now your configuration loads automatically every time!

---

## Key Commands Reference

| Command                       | What it does               |
| ----------------------------- | -------------------------- |
| `gsutil mb gs://BUCKET-NAME`  | Make (create) a bucket     |
| `gsutil cp FILE gs://BUCKET/` | Copy file to bucket        |
| `gcloud compute regions list` | List available regions     |
| `echo $VARIABLE`              | Display a variable's value |
| `mkdir FOLDER`                | Create a directory         |
| `cat FILE`                    | View file contents         |
| `nano FILE`                   | Edit a file                |

---

## Key Takeaway

- Use the **Console** for learning and visual tasks
- Use **Cloud Shell** for automation and scripting
- Store configuration in files so it persists
- Edit `.profile` to auto-load config on startup
- You can combine both approaches for maximum flexibility

## ACE Exam-Style Practice Questions

### Q1
In a Cloud Storage Bucket Lab scenario, files are used continually by an analytics pipeline in one region. Which storage class is best for minimal cost and performance fit?

A. Standard in closest region
B. Nearline in closest region
C. Archive in dual-region
D. Coldline in dual-region

Answer: A
Trap: Continual access generally means Standard, while colder classes penalize frequent retrieval.

### Q2
Backup files older than 90 days must be removed automatically in a Cloud Storage Bucket Lab bucket. What should you do?

A. Manual deletion script only
B. Lifecycle rule in JSON with Delete action and Age condition 90
C. Rename old files to another prefix only
D. Disable object versioning

Answer: B
Trap: Lifecycle rules are the managed and auditable approach for retention cleanup.
