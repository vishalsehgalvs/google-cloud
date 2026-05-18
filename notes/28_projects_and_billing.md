# 📁 Projects in Google Cloud

## Why Projects Matter

In Google Cloud, **projects are the main way resources are organized**.

A project acts like a container for:

- Virtual machines
- Networks
- Storage buckets
- Databases
- Permissions
- Billing usage

**Important rule:** resources can only be created and used inside a project.

This is how Google Cloud keeps related resources grouped together and isolated from other work.

---

## Projects and Billing

Projects are also how Google Cloud connects resource usage to a **billing account**.

That means:

- Your resources live inside a project
- The costs for those resources are tracked through that project
- The project is linked to a billing account

So projects are not just folders. They are the basic unit for:

- Organization
- Access control
- Quotas
- Billing

---

## Creating a Project in the Console

To create a project in the Google Cloud Console:

1. Click the **project selector** at the top of the Console
2. Click **New Project**
3. Enter a **project name**
4. Google Cloud automatically creates a **project ID**
5. Click **Create**

### Project Name vs Project ID

- **Project name**: human-friendly, not necessarily unique
- **Project ID**: unique across Google Cloud

So you might name a project:

- `My New Project`

But Google Cloud creates a unique project ID behind it.

---

## Watching Project Creation

After you create a project, the Console shows progress in the **notification pane**.

One thing to remember:

- A newly created project may not have every service ready immediately
- Some services can take a little time to become available

---

## Switching Between Projects in the Console

You can switch project context from the top of the Console.

Once you select a different project:

- The Console changes focus to that project
- Any resources you view or create will belong to that project

This is important because Google Cloud actions always happen **in the currently selected project**.

---

## Deleting a Project (Shutdown)

In the Console, deleting a project is usually shown as **shutting it down**.

When you shut down a project:

- Resource activity stops
- Billing for active usage stops over time
- The project is scheduled for deletion
- Google gives you a **30-day recovery window** in case you change your mind

To shut down a project, Google Cloud asks you to type the **project ID** as confirmation.

This helps prevent accidental deletion.

---

## Projects in Cloud Shell

You can also view and change your current project from **Cloud Shell** using the `gcloud` command.

### Check current configuration

```bash
gcloud config list
```

This shows your active configuration, including the currently selected project.

### Show just the project

```bash
gcloud config list | grep project
```

This is a quick way to see which project Cloud Shell is currently using.

---

## Console Project vs Cloud Shell Project

A useful thing to know:

- Changing the active project in the **Console** does not always automatically change Cloud Shell's current project
- Cloud Shell uses its own `gcloud` configuration

So it is possible for:

- The Console to be focused on one project
- Cloud Shell to still be focused on another project

Always check before running commands.

---

## Changing Projects in Cloud Shell

To switch Cloud Shell to another project:

```bash
gcloud config set project PROJECT_ID
```

Example:

```bash
gcloud config set project my-second-project-123
```

After that, verify the change:

```bash
gcloud config list | grep project
```

---

## Using Environment Variables for Easy Switching

You can store project IDs in variables to switch between them more easily.

Example:

```bash
PROJECT_ID1=my-first-project-123
PROJECT_ID2=my-second-project-456
```

Then switch using:

```bash
gcloud config set project $PROJECT_ID1
```

or:

```bash
gcloud config set project $PROJECT_ID2
```

This is useful when you move back and forth between multiple projects.

---

## What This Demo Shows

This walkthrough demonstrates that you can:

- Create projects
- Delete (shut down) projects
- Switch between projects in the Console
- Switch between projects in Cloud Shell
- Confirm which project your commands are targeting

---

## Key Takeaway

Projects are the **core organizer** in Google Cloud.

They control:

- Where resources live
- How resources are isolated
- Which billing account pays for usage
- What context your Console and Cloud Shell commands operate in

If you understand projects, you understand the foundation of how Google Cloud stays organized.
