# IAM — Module Summary

## What Was Covered

- IAM components: organizations, folders, projects, roles, members, service accounts
- Basic, predefined, and custom roles
- Policy inheritance and the principle of least privilege
- Deny policies, IAM conditions, and organization policies
- Organization Restrictions for preventing data exfiltration
- Best practices for groups, service accounts, and IAP

---

## Key Takeaways

- **Identity creation** (users, groups) is managed via **Google Workspace Admin** or **Cloud Identity** — usually by a separate admin from the Google Cloud administrator
- **Google Groups** bridge the gap: the Cloud admin assigns roles to groups; the Workspace admin manages who's in those groups
- **Service accounts** are highly flexible — they enable infrastructure-level access control, letting you scope permissions per VM or microservice without managing credentials manually

## ACE Exam-Style Practice Questions

### Q1
In a Iam Module Summary scenario, two answers seem technically possible. What tie-breaker should you apply first?

A. Pick the option with most manual steps
B. Pick the option with least privilege and least operational overhead that still meets requirements
C. Pick highest-cost option
D. Pick the oldest product

Answer: B
Trap: ACE-style scenarios reward secure, managed, requirement-fit decisions.

### Q2
For Iam Module Summary, what is the best way to reduce wrong answers in multi-choice questions?

A. Ignore scaling and security words
B. Identify trigger words, eliminate over-privileged choices, then choose the managed fit
C. Always pick Compute Engine
D. Always pick the shortest option

Answer: B
Trap: Structured elimination is more reliable than memorization alone.
