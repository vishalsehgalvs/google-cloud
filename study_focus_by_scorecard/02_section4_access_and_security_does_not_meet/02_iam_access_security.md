# Domain 2 - IAM, Access, Security

## Must Know

- IAM model: principal + role + resource
- Prefer predefined least-privilege role before custom role
- Assign roles to groups for people
- Use service accounts for apps and automation
- Deny policy overrides allow policy

## Decision Signals

- "workload needs access" -> service account
- "temporary elevated access" -> IAM Condition with expiration
- "cross-project data access" -> grant role to external service account
- "hard org-wide restriction" -> Organization Policy
- "broad role works but too much" -> choose narrow predefined role

## Pinpoint Traps

- Owner and Editor are usually distractors in exam scenarios.
- Default Compute Engine service account is shared by many VMs.
- set-iam-policy can overwrite existing policy if used carelessly.
- Service account keys in code are almost always wrong.

## Scenario Example 1

- Trigger words: one VM should read one bucket only
- Best answer: dedicated service account + bucket-level storage role
- Why not default SA: blast radius across many VMs
- Why not project Editor: excessive permissions

```bash
gcloud iam service-accounts create app-reader \
  --display-name="App Reader"

gcloud storage buckets add-iam-policy-binding gs://orders-docs \
  --member=serviceAccount:app-reader@PROJECT_ID.iam.gserviceaccount.com \
  --role=roles/storage.objectViewer
```

## Scenario Example 2

- Trigger words: emergency admin access for 24 hours only
- Best answer: add role binding with IAM Condition expiry
- Why not permanent role: manual cleanup risk
- Why not Owner: least-privilege violation

```bash
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member=user:oncall@example.com \
  --role=roles/compute.admin \
  --condition=expression="request.time < timestamp('2026-07-16T00:00:00Z')",title=temp_admin,description=oncall_window
```

## Scenario Example 3

- Trigger words: partner team needs read access to your dataset
- Best answer: partner keeps their own service account, you grant dataset role
- Why not create partner identity in your project: ownership mismatch
- Why not share personal credential: audit and security failure

```bash
# Example project-level binding pattern
gcloud projects add-iam-policy-binding DATA_PROJECT_ID \
  --member=serviceAccount:partner-sa@partner-project.iam.gserviceaccount.com \
  --role=roles/bigquery.dataViewer
```

## Security Baseline

- Secret Manager for secrets
- Cloud KMS for key management
- VPC Service Controls for API perimeter
- Cloud Audit Logs for governance evidence

## One-Line Rules

- If a broad role "works", it is often the wrong answer.
- Human identity and workload identity must stay separate.
- Temporary admin access should be time-bound by policy condition.
