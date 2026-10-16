# DHN Validation

Project ID: `dhn-validation`.

## Outcome

Deliver an explainable paired CSC/MED oSort comparison for the PI, preserving
the uncurated baseline and comparing the same channel cohort again after
independent, documented manual curation.

## Scope And Non-Goals

Use the existing MATLAB sorting/curation workflow and Python analysis; do not
reimplement sorting or adapt the older subject-folder notebooks as the driver.
The next milestone is a source-verified handoff and a reproducible same-cohort
baseline/curated comparison. Reconstructing conversion provenance and rerunning
deleted controls are separate evidence gaps, not completed work.

## Durable Rules

- Preserve original sorts, workbooks, and prior curation revisions. New sorting
  labels and curation output roots must be fresh; never overwrite history.
- Curate CSC and MED independently using consistent quality criteria. Cluster
  IDs are source-specific; agreement alone is not a curation criterion.
- External workbook naming uses `medd_`; internal source directories use `med`.
- The paired adapter uses MED waveforms on CSC ADC-count scale and the CSC
  record clock. It is not independent MED-clock validation or proof of lossless
  conversion. Preserve fractional samples and record polarity/units explicitly.
- Use explicit analysis roots, verified sampling frequency, and equal timing
  tolerances. Compare identical channel cohorts before and after curation.
- Analyze retained-event exports, not unfiltered final MATs: the analysis loader
  does not apply `useNegative`. Preserve zero-retained channels explicitly.
- Merges change labels; rejections remove events; neither retimes retained
  spikes. Curated agreement has different denominators and does not prove fidelity.
- Keep recordings, subject identifiers, credentials, generated MATs, workbooks,
  and plots outside this hub. Do not copy additional sensitive provenance here.

## Sources And Entry Points

- [Detailed historical runbook](README.md): inspected 2026-10-09; imported
  2026-10-16, not independently revalidated. Existing recording references are
  historical; use the non-sensitive alias `retained-pair` in new hub records.
- Checkout key `dhn-validation` resolves to the analysis repository through
  the local ignored location map. Analysis entry point:
  `comp_fidelity/med_sorter_comparison.py`.
- Separate oSort checkout: `main_sorting.m` and `main_curation.m` are routine
  settings surfaces; `run_sorting_workflow.m` and `run_curation_workflow.m`
  supply execution guards. Resolve that checkout locally before use.
- Lower-level alternatives: `compare`, `main_function_compare_medd.m`,
  `main_function_curate_validation.m`, and `regenerate_curation_figures.m`.
- The historical runbook records a Python environment from `zlab-sorting`;
  this is not an established dependency on its Kilosort/AWS pipeline.

Source repository instructions and the current worktree govern implementation.
Historical runbook links and machine paths are not a portable checkout map.

## Completion

Retain input/configuration/code provenance, successful per-channel status,
independent workbook decisions and audit manifests, unchanged baseline evidence,
and explicit same-cohort baseline/curated tables and plots. Report detection,
purity, and sorter agreement separately with timing/coverage limitations and
the status of rounding controls. A README or synthetic test alone is not evidence
that an actual recording run completed.
