# IAM + Billing + Security In 30 Seconds

This is one of the highest-yield sections for practitioner-level exams.

## IAM Essentials

Think in this order:

- Who: user, group, or service account.
- What: role permissions.
- Where: resource scope, usually project.

Core principles:

- Bind principals to roles through IAM policy.
- Policies inherit through the hierarchy.
- Least privilege is safer and usually expected in answers.

## Roles Simplified

- Basic roles are broad and risky.
- Predefined roles are preferred in most real scenarios.
- Custom roles are for specific permission sets not covered by predefined roles.

Exam-friendly rule:

- If predefined role fits, do not pick Owner or broad Editor.

## Service Accounts

- Service accounts represent applications and services.
- Never use personal user accounts for runtime workloads.
- Scope one service account per workload where possible.
- Keep permissions narrow and auditable.

## Billing and Cost Controls

- Billing account funds project usage.
- Budgets define spend targets.
- Alerts notify at threshold percentages.
- Reports reveal spend by project and service.
- Quotas prevent runaway usage and protect against mistakes.

Typical tested combo:

- Budget plus alert plus quota is stronger than budget alone.

## Security Defaults

- Identity controls first, network controls next.
- Encryption in transit and at rest should be assumed and validated.
- Logging and monitoring are mandatory for detection and audit.

## Fast Scenario Mapping

- Scenario: give developers limited storage access.
  Good answer: predefined storage role at project or bucket scope.

- Scenario: app on Cloud Run needs to read Pub/Sub.
  Good answer: service account with least required Pub/Sub role.

- Scenario: finance needs cost visibility before overrun.
  Good answer: billing budget and alerts, plus reporting dashboard.

## Common Traps

- Granting Owner when narrower access exists.
- Using personal credentials in production workloads.
- Ignoring budget alerts and quotas.
- Choosing manual security processes over managed policy controls.
