# IAM And Security Traps

## Trap 1: Owner/Editor/Viewer vs Predefined vs Custom Roles

The trap: Owner or Editor "would technically work" for almost any access requirement, which is exactly why they are usually the wrong answer.

- "give broad admin access because it's simpler" -> tempting but usually wrong; violates least privilege
- "grant access to only what's needed for one service" -> Predefined role
- "no predefined role matches exactly (e.g. start/stop VMs but not reconfigure)" -> Custom role

One-line rule: if a narrower predefined or custom role satisfies the requirement, Owner/Editor is the wrong answer even if it "would work."

## Trap 2: Cloud SQL Flags — availability-type vs replica-type vs secondary-zone vs master-instance-name

This is a direct trap from your practice session. Full breakdown:

- "automatic failover to standby in another zone during a zone outage" -> `--availability-type=REGIONAL`
- "specify whether a new instance is a read replica / cascading replica" -> `--replica-type`
- "choose which zone the standby lives in" -> `--secondary-zone` (only meaningful once availability-type is REGIONAL; it does not enable HA by itself)
- "specify which existing instance a replica should replicate from" -> `--master-instance-name`

Why `--secondary-zone` is a strong distractor:

- It sounds HA-related because it mentions "zone," but it only controls placement of the standby. It does not enable automatic failover. Without `--availability-type=REGIONAL`, this flag does not create a failover-capable setup at all.

Why `--replica-type` and `--master-instance-name` are distractors:

- Both relate to read replicas (read scaling), which is a completely different feature from HA failover of the primary instance.

One-line rule: "automatic failover on zone outage" -> `--availability-type=REGIONAL`. Anything about replicas -> `--replica-type` or `--master-instance-name`, not HA.

## Trap 3: Service Account vs User Account For Workloads

- "application or automated workload needs to call an API" -> Service Account
- "a human needs to log in and perform actions" -> User account (via IAM, ideally through a group)

One-line rule: if the actor is code/an app/a pipeline, it is a service account, never a personal user credential.

## Trap 4: Group-Based Access vs Individual Bindings

- "many users need the same access, and membership changes over time" -> assign role to a Google Group, manage membership separately
- "one-off, single-user exception" -> direct IAM binding (still avoid if possible)

One-line rule: scalable access management points to groups, not repeated individual bindings.

## Trap 5: Org Policies vs IAM Roles

- "prevent an action entirely regardless of role held (e.g., disable external IPs org-wide)" -> Organization Policy constraint
- "control who can do what" -> IAM role and policy binding

One-line rule: IAM answers "who can do this." Org Policy answers "is this allowed at all, for anyone."

## Trap 6: IAM Deny Policies vs Allow Policies

- Allow policies grant permissions and inherit down the hierarchy (union of parent + child).
- Deny policies explicitly block specific permissions for specific principals, and they override any allow policy, regardless of role.

One-line rule: if the question needs a hard block that cannot be bypassed by any granted role, the answer is a deny policy, not just removing a role.

## Quick Self-Test

1. Requirement: automatic failover for Cloud SQL primary during zone outage. Flag?
2. Requirement: read scaling by adding a replica. Flag?
3. Requirement: block a specific user from deleting resources no matter what role they get in the future. Feature?
4. Requirement: application needs to publish to Pub/Sub. Identity type?
