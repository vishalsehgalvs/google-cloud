# Gemini Enterprise — Demo Walkthrough

## What This Demo Covers

- Create a Gemini Enterprise application
- Connect it to multiple data stores (Google Drive, Google Calendar, Cloud Storage)
- Explore pre-built agents (Idea Generation, Deep Research)
- Use NotebookLM to analyze and transform source content

---

## Step 1 — Create a Gemini Enterprise App

1. In the GCP Console, search for **Gemini Enterprise** and select it
2. On the homepage, click **Create your first app**
3. Give the app a name (e.g., `Symbol Foods Marketing Team`) and click **Create**

---

## Step 2 — Configure Identity

Before sharing the app with your workforce, you must configure identity:

1. Click **Setup identity**
2. Choose **Google Identity** as the identity provider
3. Click **Confirm Workforce Identity**

---

## Step 3 — Connect Data Stores

Navigate to **Connected data stores** → **New data store**

### Google Drive

- Select the **Google Drive** card
- Choose to sync all organization's shared drives
- Click **Continue**, give it a name (e.g., `Google Drive`), and click **Create**

### Google Calendar

- Select the **Google Calendar** card
- Give it a name (e.g., `Google Calendar`) and click **Create**

### Cloud Storage

- Select the **Cloud Storage** card
- **Data type**: Documents (for unstructured files like PDFs, HTML, TXT)
- **Sync frequency**: One time
- Click **Browse** → select your GCS bucket → **Select**
- Click **Continue**, give it a name (e.g., `Cloud Storage`), and click **Create**

> All three data stores are now connected to the app.

---

## Step 4 — Share and Use the App

- From the **Overview** page, copy the unique URL to share the app with your workforce
- Open the URL to access the Gemini Enterprise homepage

---

## Step 5 — Chat and Search

### Basic prompt

- Enter a prompt (e.g., _"Give me an update on our latest marketing data"_) and submit
- Gemini searches across internal and external sources and returns a context-aware response

### Multimodal prompt with enhanced settings

- Click **Enhance your conversation** to set search parameters:
  - Options include: generate videos with Veo, generate images with Nano Banana, or restrict to internal sources only
- Set to **search only internal sources**
- Enter a multimodal prompt (e.g., _"Summarize the customer sentiment pie chart"_)
- Gemini searches internal sources and generates a response based on the image content

---

## Step 6 — Pre-built Agents

### Idea Generation

- Go to **Idea Generation**
- Use case: a team of agents that plans, generates, and evaluates ideas on a topic
- Example prompt: _"Help me brainstorm a new marketing campaign for Gen-Z customers based on our latest products"_
- Gemini generates a marketing campaign plan → review it → click **Start session** to generate multiple ideas

### Deep Research

- Go to **Deep Research**
- Use case: in-depth analysis and comprehensive report generation on complex topics
- Example prompt: _"Research the latest marketing tips and tricks that food companies are using and generate a list of actionable steps our company can take to improve our current marketing strategy"_
- Gemini drafts a research plan → review and optionally modify it → click **Start research**
- Output: a comprehensive report + an audio summary

---

## Step 7 — NotebookLM

### What Is NotebookLM?

- A tool for uploading content from various sources and transforming it into dynamic formats

### Supported source types

- Google Docs
- Website URLs
- YouTube videos
- Copied text
- Files from your hard drive

### Steps

1. From the pinned section, select **NotebookLM**
2. Click **Create new notebook**
3. Upload your source files
4. Enter a prompt — e.g., _"What audience did the spring cookie promotion target?"_
   - Example response: _"Women aged 25 to 55 who are interested in baking and desserts in Oakland, California"_
5. Save useful responses as **notes** for easy access later

### Studio Tab

- Go to the **Studio** tab to transform source material into dynamic formats:
  - Audio overviews
  - Videos
  - Mind maps
  - Various report types
- Example: generate a **video overview** → output is a 5-minute video presentation titled _"Marketing by the Numbers"_
