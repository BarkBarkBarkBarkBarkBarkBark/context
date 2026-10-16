# DHN Validation: Current State

Last checkpoint: 2026-10-16T12:44:00-06:00
Verification: documentation import only; source code, data, and historical test claims not revalidated
Current milestone: verify the retained paired workflow before final manual curation and same-cohort analysis

## Known State

The [runbook](README.md) was read in full and registered in this hub. Facts below
are attributed to its 2026-10-09 inspection, not newly observed artifacts:

- One retained 24-channel baseline covers channels 257:280, with 24 CSC and
  24 MED consolidated MATs. Other saved validation/control runs were deleted.
  The renamed combined manifest was repaired with 48 paths checked; the root
  channel manifest is absent. Baseline MATs reportedly remained unchanged.
- Saved uncurated results: 559187 CSC events, 559100 MED events, 99.22% CSC
  timing matches, 92.7% mean channel purity, and 0.87 reported spike-weighted
  sorter agreement. These are not curated or newly reproduced results.
- Readable sorting defaults: preview only, channels 265:272, threshold 5,
  fresh rerun label. Curation settings: channels 266:272, spreadsheet rows
  20:26, threshold 5, `Execute=true`, `FiguresOnly=true`. Channel 265 is excluded
  as a reference channel. Recheck these settings before executing anything.
- A figures-only refresh of existing curated results reportedly completed all
  14 source/channel jobs with unchanged final MAT SHA256 hashes. This does not
  establish that a new recording curation or baseline/curated analysis ran.
- Figure refresh reads saved labels and ignores workbook edits. To apply a
  final workbook merge pass, retain the original sorted run as input, disable
  figures-only mode, and select a fresh output root.

## Last Meaningful Action And Validation

Preserved the detailed README, normalized its folder to `dhn-validation`, and
created brief/state/tasks/updates/decisions records plus registry/index discovery.
The user confirmed the existing context repository is the intended target;
the separate empty agent_context directory was left alone.

Documentation validation is recorded in [updates.md](updates.md). No MATLAB,
Python, sorting, curation, conversion, or artifact integrity checks were run.

## Blockers And Unknowns

- The runbook reports both twelve and ten passing tests. It describes tested
  empty-channel handling but later calls that path unfinished. Verify current
  tests/source before deciding whether implementation work is needed.
- Historical converter invocation and the retained run's exact command/code
  revision were not recovered. Do not infer lossless conversion.
- Deleted rounded-CSC controls are not available evidence; rerun and retain
  fresh controls before citing them in a PI presentation.
- Current source worktree, local environments, workbook decisions, final-merge
  status, and paired analysis artifacts have not been inspected in this import.
- The historical note that `rg` was unavailable is not a current tool guarantee.
- Ruby is unavailable locally, so the required hub validator could not run.
  Fallback structural checks passed; rerun the standard validator when Ruby
  is available.

## Next Action

Execute task `dhn-validation:verify-current-workflow`: resolve both source
checkouts locally, read their instructions/status, then inspect `main_sorting.m`,
`main_curation.m`, and `codes/test_curate_validation.m` in the oSort checkout.
Confirm the active run/workbook/output references without copying identifiers
into this hub. Run the documented focused MATLAB test:

```matlab
results = runtests('codes/test_curate_validation.m');
assertSuccess(results);
```

Record the actual count/result, especially zero-retained-channel and filtered
export coverage, or the exact environment blocker. Do not launch sorting or
apply workbook decisions as part of this verification.

## Reopen

- [Brief](brief.md), [tasks](tasks.jsonl), and [historical runbook](README.md).
- oSort checkout: `main_curation.m`, `main_sorting.m`,
  `codes/test_curate_validation.m`.
- Analysis checkout: `comp_fidelity/med_sorter_comparison.py`.
