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
