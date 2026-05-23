# Cloud Storage — Choosing a Storage Class and Autoclass

## Storage Class Decision Tree (by access frequency)

```
How often will you read the data?
├── Less than once a year      → Archive
├── Less than once per 90 days → Coldline
├── Less than once per 30 days → Nearline
└── More frequently            → Standard
```

## Location Type Decision Tree

| Choose           | When                                                                                               |
| ---------------- | -------------------------------------------------------------------------------------------------- |
| **Region**       | Data consumers (e.g. analytics pipelines) are in the same region — optimize latency and bandwidth  |
| **Dual-region**  | Want regional performance + higher availability from geo-redundancy                                |
| **Multi-region** | Serving users outside Google's network across large geographic areas, or need maximum availability |

---

## Autoclass — For Unknown or Variable Access Patterns

Use **Autoclass** when access patterns are unpredictable or mixed.

### How it works

- All objects start in **Standard** storage regardless of what class was specified
- Objects not accessed are **automatically moved to colder classes** (lower storage cost)
- Objects that are accessed are **automatically moved back to Standard** (optimized for future reads)

### Benefits when Autoclass is enabled

- **No early deletion charges**
- **No retrieval charges**
- **No charges for storage class transitions**

> Autoclass simplifies cost optimization without requiring manual lifecycle rules.
