# DHN Validation: Decisions

## dhn-validation:D001 | 2026-10-16 | Accepted

- Decision: use `dhn-validation` as the stable project ID and folder in the
  existing context repository; preserve the supplied README as a historical
  detailed runbook alongside the hub's standard records.
- Why: the user confirmed this repository as the target; the hub requires
  kebab-case IDs and matching project folders. The original underscore folder
  had only the supplied README and was not yet registered.
- Alternatives: creating a separate hub in the empty agent_context directory
  would duplicate context; discarding the detailed README would lose provenance.
- Revisit when: the source project changes identity or the researcher replaces
  the historical runbook with a verified current reference.
- Supersedes: none.

## dhn-validation:D002 | 2026-10-16 | Accepted

- Decision: carry forward the runbook's immutable-baseline, independent-curation,
  explicit same-cohort export workflow without claiming new execution.
- Why: the supplied evidence distinguishes automatic baseline sorting, manual
  workbook decisions, figures-only refresh, and retained-event analysis.
  Conflating them would misstate both scientific evidence and task completion.
- Alternatives: infer completed curation/analysis from existing figure notes,
  or treat improved agreement as proof of lossless conversion; neither is supported.
- Revisit when: source inspection or new retained artifacts supersede the
  historical claims. Record exact commands/results and preserve prior revisions.
- Supersedes: none.
