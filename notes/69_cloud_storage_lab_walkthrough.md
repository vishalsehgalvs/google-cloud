# Cloud Storage — Lab Walkthrough

## Setup

```bash
# Set bucket name as environment variable for easy reuse
export BUCKET_NAME_1=<your-bucket-name>

# Download a sample file
curl <public-url>/setup.html -o setup.html
cp setup.html setup2.html
cp setup.html setup3.html
```

---

## Task 1 — Create a Bucket

- Create a bucket using your **Project ID** as the name (globally unique)
- Storage class: **Multi-regional**
- Access control: object-level and bucket-level permissions

---

## Task 2 — ACLs (Access Control Lists)

```bash
# Copy file to bucket
gsutil cp setup.html gs://$BUCKET_NAME_1/

# Get current ACL
gsutil acl get gs://$BUCKET_NAME_1/setup.html > acl.txt

# Set to private
gsutil acl set private gs://$BUCKET_NAME_1/setup.html

# Make publicly readable
gsutil acl ch -u AllUsers:R gs://$BUCKET_NAME_1/setup.html

# Copy file back from bucket
gsutil cp gs://$BUCKET_NAME_1/setup.html setup.html
```

---

## Task 3 — Customer-Supplied Encryption Keys (CSEK)

```bash
# Generate a base64-encoded AES-256 key
python3 -c "import base64, os; print(base64.encodebytes(os.urandom(32)).decode('utf-8').strip())"

# Create a boto config file
gsutil config -n

# Edit .boto to add encryption key
nano .boto
# Uncomment and set: encryption_key=<your-key>

# Upload encrypted files
gsutil cp setup2.html gs://$BUCKET_NAME_1/
gsutil cp setup3.html gs://$BUCKET_NAME_1/

# Rotate key: move old key to decryption_key1, add new encryption_key
# Then rewrite the object with the new key
gsutil rewrite -k gs://$BUCKET_NAME_1/setup2.html
```

> If you comment out the decryption key before downloading, you'll get a "no decryption key matches" error — by design.

---

## Task 4 — Object Lifecycle Management

```bash
# View current lifecycle policy
gsutil lifecycle get gs://$BUCKET_NAME_1

# Create lifecycle.json
cat > lifecycle.json << EOF
{
  "rule": [
    {
      "action": {"type": "Delete"},
      "condition": {"age": 31}
    }
  ]
}
EOF

# Apply the policy
gsutil lifecycle set lifecycle.json gs://$BUCKET_NAME_1
```

---

## Task 5 — Object Versioning

```bash
# Check versioning status
gsutil versioning get gs://$BUCKET_NAME_1

# Enable versioning
gsutil versioning set on gs://$BUCKET_NAME_1

# Create multiple versions by editing and re-uploading setup.html
nano setup.html   # delete some lines
gsutil cp setup.html gs://$BUCKET_NAME_1/
nano setup.html   # delete more lines
gsutil cp setup.html gs://$BUCKET_NAME_1/

# List all versions
gsutil ls -a gs://$BUCKET_NAME_1/setup.html

# Restore a specific version
export VERSION_NAME=<generation-number-url>
gsutil cp $VERSION_NAME recovery.txt
```

---

## Task 6 — Directory Synchronization

```bash
# Sync a local directory to the bucket
gsutil rsync -r ./firstlevel gs://$BUCKET_NAME_1/firstlevel
```

---

## Task 7 — Cross-Project Resource Sharing (IAM)

1. In **Project 2**: create a bucket, upload a file
2. Create a service account `cross-project-storage` with **Storage Object Viewer** role
3. Download the JSON key → rename to `credentials.json`
4. In **Project 1**: create a VM, SSH into it
5. Upload `credentials.json` to the VM, then:

```bash
# Authenticate as the service account
gcloud auth activate-service-account --key-file=credentials.json

# List objects in Project 2's bucket (now accessible)
gsutil ls gs://$BUCKET_NAME_2

# To allow writes, update the service account role to Storage Object Admin
# (done via IAM console in Project 2)
```

---

## Key Takeaways

| Feature        | What was demonstrated                                    |
| -------------- | -------------------------------------------------------- |
| ACLs           | Set private, then public per-object                      |
| CSEK           | Encrypt uploads; key rotation via `.boto`                |
| Lifecycle      | Auto-delete objects older than 31 days                   |
| Versioning     | Track file changes; restore old versions                 |
| Directory sync | `gsutil rsync` mirrors local dir to bucket               |
| Cross-project  | Service account + JSON key grants access across projects |

## ACE Exam-Style Practice Questions

### Q1
In a Cloud Storage Lab Walkthrough scenario, files are used continually by an analytics pipeline in one region. Which storage class is best for minimal cost and performance fit?

A. Standard in closest region
B. Nearline in closest region
C. Archive in dual-region
D. Coldline in dual-region

Answer: A
Trap: Continual access generally means Standard, while colder classes penalize frequent retrieval.

### Q2
Backup files older than 90 days must be removed automatically in a Cloud Storage Lab Walkthrough bucket. What should you do?

A. Manual deletion script only
B. Lifecycle rule in JSON with Delete action and Age condition 90
C. Rename old files to another prefix only
D. Disable object versioning

Answer: B
Trap: Lifecycle rules are the managed and auditable approach for retention cleanup.

<!-- ACE_DEEP_ENRICHMENT_START -->
## ACE Deep Enrichment

### Think Like a Google Engineer
- Primary optimization axis: Durability and access-pattern fit at the lowest lifecycle cost.
- Start with constraints first: SLO, security, compliance, latency, budget, and team operations capacity.
- Prefer managed services if they satisfy requirements with lower long-term operational toil.
- Minimize blast radius using environment isolation, least privilege, and failure-domain awareness.
- Design for day-2 operations: observability, rollback strategy, and quota or budget guardrails.

### Most Correct Option Filter (60 Seconds)
1. Eliminate options with broad access, single points of failure, or missing monitoring.
2. Confirm the option meets non-negotiables first: security and reliability requirements.
3. Compare remaining options on operational simplicity and long-term maintainability.
4. Use cost as an optimizer only after requirements and risk controls are satisfied.

### Weighted Decision Matrix
| Dimension | Weight | Strong Signal |
| --- | --- | --- |
| Security | 3 | Least privilege, secure defaults, no exposed blast radius |
| Reliability | 3 | Multi-zone or HA design, health checks, tested recovery path |
| Operability | 2 | Clear monitoring, alerting, rollout and rollback simplicity |
| Cost Efficiency | 2 | Right-sized resources, no waste, no reliability regression |
| Performance | 1 | Meets latency and throughput targets with headroom |

### Real-Life Scenario
A healthcare SaaS stores user documents, transactional data, and low-latency session state. They must balance cost, durability, and performance under compliance constraints.

### Worked Example
- Map each data type to the right storage service by access pattern and consistency needs.
- Use lifecycle policies for object storage to control long-term cost.
- Select database engines based on query shape, scale, and relational requirements.
- Back up critical datasets and validate restore runbooks regularly.

### Flowchart
```mermaid
flowchart TD
    A[Data Requirement] --> B{Object, Relational, or NoSQL?}
    B -->|Object| C[Cloud Storage + Lifecycle]
    B -->|Relational| D[Cloud SQL or AlloyDB]
    B -->|NoSQL| E[Firestore or Bigtable]
    C --> F{Access Frequency?}
    F -->|Hot| G[Standard Class]
    F -->|Cold| H[Nearline or Archive]
    D --> I[Backup and HA Strategy]
    E --> I
    G --> I
    H --> I
```

### Optimization Decision Flow
```mermaid
flowchart TD
    A[Read Requirement] --> B[Identify Hard Constraints]
    B --> C{Security and Reliability Met?}
    C -->|No| D[Reject Option]
    C -->|Yes| E[Score Operability and Cost]
    E --> F{Managed Service Meets Needs?}
    F -->|Yes| G[Prefer Managed Path]
    F -->|No| H[Use Custom Design with Guardrails]
    G --> I[Validate Observability and Rollback]
    H --> I
    I --> J[Pick Highest Weighted Score]
```

### Interaction Sequence
```mermaid
sequenceDiagram
    participant App
    participant Storage
    participant DB
    participant Backup
    App->>Storage: Upload object
    Storage-->>App: Return object path
    App->>DB: Write metadata record
    DB-->>App: Commit transaction
    DB->>Backup: Schedule snapshot
```

### Extra Exam Practice (10 Questions)
#### Q1
Scenario Focus: Cloud Storage — Lab Walkthrough
Your logs are rarely accessed after 90 days. What storage policy is best?

A. Use lifecycle rules to transition objects to colder storage classes after 90 days.
B. Keep everything in the most expensive hot class forever.
C. Use local disk snapshots as the only backup strategy.
D. Pick a database only by familiarity and ignore access patterns.

Answer: A
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q2
Scenario Focus: Cloud Storage — Lab Walkthrough
A workload requires relational transactions and managed operations. Which database is best?

A. Use local disk snapshots as the only backup strategy.
B. Use Cloud SQL or AlloyDB for managed relational workloads with transaction support.
C. Pick a database only by familiarity and ignore access patterns.
D. Store transactional records only in object storage.

Answer: B
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q3
Scenario Focus: Cloud Storage — Lab Walkthrough
Which practice improves durability and recovery posture most?

A. Pick a database only by familiarity and ignore access patterns.
B. Store transactional records only in object storage.
C. Enable backups with tested restore procedures and clear recovery objectives.
D. Skip restore drills because backups are assumed valid.

Answer: C
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q4
Scenario Focus: Cloud Storage — Lab Walkthrough
A key-value workload needs very high scale and low latency. Which service fits?

A. Store transactional records only in object storage.
B. Skip restore drills because backups are assumed valid.
C. Keep everything in the most expensive hot class forever.
D. Use Bigtable for high-throughput low-latency wide-column workloads.

Answer: D
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q5
Scenario Focus: Cloud Storage — Lab Walkthrough
How should you choose a storage class on the exam?

A. Choose based on access frequency, retention period, and retrieval latency requirements.
B. Skip restore drills because backups are assumed valid.
C. Keep everything in the most expensive hot class forever.
D. Use local disk snapshots as the only backup strategy.

Answer: A
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q6
Scenario Focus: Cloud Storage — Lab Walkthrough
Two designs both satisfy the happy path for Cloud Storage — Lab Walkthrough. Which choice is most correct?

A. Keep everything in the most expensive hot class forever.
B. Choose the option that preserves reliability and security while reducing operational burden.
C. Use local disk snapshots as the only backup strategy.
D. Pick a database only by familiarity and ignore access patterns.

Answer: B
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q7
Scenario Focus: Cloud Storage — Lab Walkthrough
What should you validate first before choosing an architecture for Cloud Storage — Lab Walkthrough?

A. Use local disk snapshots as the only backup strategy.
B. Pick a database only by familiarity and ignore access patterns.
C. Validate SLO fit, blast radius, and least-privilege controls before comparing convenience.
D. Store transactional records only in object storage.

Answer: C
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q8
Scenario Focus: Cloud Storage — Lab Walkthrough
A proposal lowers cost but increases failure risk. What is the best decision?

A. Pick a database only by familiarity and ignore access patterns.
B. Store transactional records only in object storage.
C. Skip restore drills because backups are assumed valid.
D. Reject it unless reliability and recovery objectives remain within required targets.

Answer: D
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q9
Scenario Focus: Cloud Storage — Lab Walkthrough
Which option best reflects optimization for Durability and access-pattern fit at the lowest lifecycle cost?

A. Select the design that best meets Durability and access-pattern fit at the lowest lifecycle cost while keeping constraints balanced.
B. Store transactional records only in object storage.
C. Skip restore drills because backups are assumed valid.
D. Keep everything in the most expensive hot class forever.

Answer: A
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

#### Q10
Scenario Focus: Cloud Storage — Lab Walkthrough
How should you evaluate a design that needs frequent manual interventions?

A. Skip restore drills because backups are assumed valid.
B. Treat it as high risk and prefer automation-friendly designs with observability and rollback.
C. Keep everything in the most expensive hot class forever.
D. Use local disk snapshots as the only backup strategy.

Answer: B
Why the other options are weaker: They typically ignore at least one hard constraint such as security, reliability, cost efficiency, or operational simplicity.
Google-engineer check: Reconfirm SLO fit, blast radius, and day-2 maintainability before finalizing.

### Quick Commands
```bash
gcloud storage ls --project=PROJECT_ID
gcloud sql instances list --project=PROJECT_ID
gcloud firestore databases list --project=PROJECT_ID
gcloud bigtable instances list --project=PROJECT_ID
```

### Fast Recall
- Data service choice is a pattern-matching question.
- Lifecycle rules are a common cost optimization lever.
- Backup without restore validation is not a complete strategy.
<!-- ACE_DEEP_ENRICHMENT_END -->