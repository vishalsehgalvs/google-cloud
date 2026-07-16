# Full Coverage Map (00 to 148)

This map documents how every source note is covered in the refactor pack.

## Coverage Summary

- notes folder: 148 files (01 to 148)
- exam_trap_patterns folder: 11 files (00 to 10)
- high_probability folder: 2 files
- practitioner_super_crisp folder: 9 files

Total covered source files: 170

## Target File Mapping - notes/01..148

### 01_foundations_projects_billing.md

- notes/01-03
- notes/24-25
- notes/28
- notes/78-82
- notes/134-136

### 02_iam_access_security.md

- notes/51-62
- notes/96-97

### 03_networking_hybrid_lb.md

- notes/04
- notes/06-09
- notes/29-40
- notes/95
- notes/98-116
- notes/133

### 04_compute_gke_serverless.md

- notes/05
- notes/18-22
- notes/41-50
- notes/105-107
- notes/128-132
- notes/137-148

### 05_storage_databases.md

- notes/10-17
- notes/63-77

### 06_data_pipeline_bigquery.md

- notes/120-126

### 07_operations_observability_cost.md

- notes/83-94
- notes/117-119
- notes/127

### Appendix Compression (still covered)

- notes/23 (AI prompt topic, low ACE weight)
- notes/26-27 (labs and walkthrough pattern)

## Mapping - exam_trap_patterns/00..10

- exam_trap_patterns/00_start_here.md -> 00_READ_ME_FIRST.md
- exam_trap_patterns/01_keyword_to_answer_master_index.md -> 08_pinpoint_traps.md
- exam_trap_patterns/02_storage_and_database_traps.md -> 05_storage_databases.md and 08_pinpoint_traps.md
- exam_trap_patterns/03_compute_and_mig_traps.md -> 04_compute_gke_serverless.md and 08_pinpoint_traps.md
- exam_trap_patterns/04_networking_and_load_balancer_traps.md -> 03_networking_hybrid_lb.md and 08_pinpoint_traps.md
- exam_trap_patterns/05_iam_and_security_traps.md -> 02_iam_access_security.md and 08_pinpoint_traps.md
- exam_trap_patterns/06_data_pipeline_and_bigquery_traps.md -> 06_data_pipeline_bigquery.md and 08_pinpoint_traps.md
- exam_trap_patterns/07_cost_and_billing_traps.md -> 01_foundations_projects_billing.md, 07_operations_observability_cost.md, and 08_pinpoint_traps.md
- exam_trap_patterns/08_gaps_not_in_original_notes.md -> 08_pinpoint_traps.md and 09_real_world_scenarios.md
- exam_trap_patterns/09_official_practice_quiz_analysis.md -> 09_real_world_scenarios.md
- exam_trap_patterns/10_official_practice_quiz_2_analysis.md -> 09_real_world_scenarios.md

## Mapping - high_probability

- high_probability/00_ultra_crisp_essentials.md -> all domain files (01-07) and 08_pinpoint_traps.md
- high_probability/README.md -> 00_READ_ME_FIRST.md flow and usage model

## Mapping - practitioner_super_crisp

- practitioner_super_crisp/00_start_here.md -> 00_READ_ME_FIRST.md
- practitioner_super_crisp/01_must_know_one_page.md -> 01-07 domain summaries
- practitioner_super_crisp/02_service_choice_in_30_seconds.md -> service decision sections in 03-06
- practitioner_super_crisp/03_iam_billing_security_in_30_seconds.md -> 01 and 02
- practitioner_super_crisp/04_common_question_patterns.md -> 09_real_world_scenarios.md
- practitioner_super_crisp/05_last_day_revision.md -> 08_pinpoint_traps.md
- practitioner_super_crisp/06_ace_add_on_if_needed.md -> cross-domain notes in 08 and 09
- practitioner_super_crisp/07_master_standalone_revision_sheet.md -> 00 and 08
- practitioner_super_crisp/08_coverage_confidence_map.md -> self-check method in 09

## Verification Checklist

- All notes from 01 to 148 are mapped.
- All exam_trap_patterns files from 00 to 10 are mapped.
- All high_probability and practitioner_super_crisp seed files are mapped.
- Refactor outputs contain concise notes, scenario drills, trap matrix, and command blocks.
