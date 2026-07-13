# Exam Trap Patterns

This folder exists for one purpose: stop losing points to "trick questions" where two answers look plausible but only one exactly matches the phrasing.

This is different from your other two folders:

- `practitioner_super_crisp/` = fast recall of what each service does
- `practitioner_deep_dive_path/` = full conceptual mastery
- `exam_trap_patterns/` (this folder) = how to read the question wording and avoid the near-miss wrong answer

## Why This Folder Exists

Real pattern from your practice: questions rarely test "do you know BigQuery exists." They test "can you tell BigQuery apart from Cloud SQL, Spanner, and Firestore when the question gives you one specific signal word."

Every file here is built the same way:

1. The trap — two or more answers that look correct
2. The signal word(s) in the question that decide it
3. Why the right answer wins
4. Why each wrong answer is wrong
5. A one-line rule you can recite in 2 seconds

## Files In This Folder

- `01_keyword_to_answer_master_index.md` — fastest lookup, read this first and most often
- `02_storage_and_database_traps.md`
- `03_compute_and_mig_traps.md`
- `04_networking_and_load_balancer_traps.md`
- `05_iam_and_security_traps.md`
- `06_data_pipeline_and_bigquery_traps.md`
- `07_cost_and_billing_traps.md`
- `08_gaps_not_in_original_notes.md` — topics that came up in practice questions but were missing or thin in your 150 notes
- `09_official_practice_quiz_analysis.md` — question-by-question analysis of a full 38-question ACE-style practice quiz, with every new gap it revealed

## How To Use This Folder

1. Every day: read `01_keyword_to_answer_master_index.md` once, out loud if possible.
2. When you get a question wrong in practice: find the matching trap file, read the exact section, add the missed keyword to your own memory.
3. Night before exam: read `08_gaps_not_in_original_notes.md` since those are the least reinforced topics.

## The Meta-Rule Behind Every Trap

Google exam questions are usually not asking "which service can technically do this."
Most of these services overlap. They are asking "which service is the intended/expected fit given the exact word used."

So the fix is not learning more services. The fix is learning to spot the deciding word.
