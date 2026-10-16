# CSC versus MED oSort: project context and manual runbook

Project ID: `dhn-validation`. Imported into the context hub on 2026-10-16.
Start with [brief.md](brief.md), [state.md](state.md), and [tasks.jsonl](tasks.jsonl)
for the current handoff. The historical inspection notes below are preserved;
their test counts and empty-channel follow-up notes conflict and need source
verification. No sorting, curation, or analysis was rerun during this import.
Resolve source checkout locations locally; historical relative source links
below are not a portable location map.

Last inspected: 2026-10-09. This is a handoff for the researcher and future agents.
Existing scripts and saved artifacts were inspected; sorting and curation were
not rerun while writing this document. Commands below are procedures, not a
claim that a new run has completed.

## Current goal

Reproduce an explainable, paired CSC/MED oSort comparison for the PI, preserve
the uncurated baseline, manually curate each source using MATLAB, and compare
the retained units again without rerunning detection or overwriting history.

The attached context folder was empty. This document is the project reference.
There is already one end-to-end launcher: `osort_sorting/compare` runs MATLAB
sorting and then Python analysis. No new sorting implementation is necessary.
Manual curation is a deliberate pause between baseline and curated analysis.

## Start with these two MATLAB files

| Human-facing file | Edit here | Default behavior |
| --- | --- | --- |
| [main_sorting.m](../../../osort_sorting/main_sorting.m) | Recording/input paths, channels, threshold, workers, control runs, Python settings | DryRun=true prints settings only; set false to sort and optionally analyze |
| [main_curation.m](../../../osort_sorting/main_curation.m) | Existing run, two workbooks, channels, spreadsheet rows/columns, output directory | Execute=true, FiguresOnly=true currently refreshes existing curation figures; false applies workbook decisions into a fresh output |

These are short sectioned scripts. Sorting selects channels 265:272; curation
selects 266:272 and rows 20:26, excluding reference channel 265, at threshold 5. The sorting script uses
the fresh label `da-082-06-17_rerun_01`, not the retained baseline's name.
Only edit the main scripts for routine setup. Adjacent workflow helpers contain
execution plumbing and guards; the existing detailed implementations remain
available for debugging and compatibility:

```text
main_sorting.m
    -> run_sorting_workflow.m
        -> main_function_compare_medd.m (detailed sorting implementation)
        -> med_sorter_comparison.py (optional post-sort analysis)

main_curation.m
    -> run_curation_workflow.m
        -> main_function_curate_validation.m (merge, selection, export implementation)
        -> regenerate_curation_figures.m (saved final labels, no new sorting)
```

The sorting workflow sets every relevant OSORT_* option explicitly and restores
the caller's environment on return/error. Its dry run is a configuration preview,
not raw-input validation. Use InputOnly=true with DryRun=false for the actual
reader/provenance checks. New curation validates both spreadsheet plans and
the exact configured channel/threshold cohort before executing.

Blank selections with valid channel/threshold cells explicitly retain zero units.
Neither workbook is edited automatically. Nonempty expressions with trailing
commas remain invalid. FiguresOnly ignores workbook changes and reads saved final
MATs; set it false and use a fresh OutputRoot to apply a final merge pass.

The old `main_comparison_file.m` was restored to its pre-assistant-edit content,
including the user's channels 265:272 and rows 19:26. Do not use that legacy
subject-folder script for the paired workflow.

## The three entry points

These are lower-level/CLI alternatives to the two main scripts. You do not
need to run every helper in the ownership table below.

1. **Sort and compare raw data:** run `./compare` from a Linux terminal. It
    launches `main_function_compare_medd.m`, which calls
    `osort_validation_run_pipeline` -> `A00_osort_MemSeg` -> oSort. The custom
    `osort_read_input`/`osort_read_med` reader supplies MED waveforms. After MATLAB
    finishes, the launcher runs `med_sorter_comparison.py` to make tables/plots.
2. **Curate existing sorts:** call `main_function_curate_validation` in MATLAB.
    It reads the independent CSC/MEDD workbooks, copies the baseline files, and
    calls `mergeClusters` followed by `defineUsableClusters_MinMax`. It writes
    retained-spike comparison files automatically, but does not run sorting or
    Python. Dry-run validation is the default.
3. **Compare without sorting again:** run `med_sorter_comparison.py` with an
    explicit `--combined-root`. Use the curator's `baseline_for_spikeinterface`
    and `combined_for_spikeinterface` to compare the same channels before and
    after manual curation. The curated export already applies `useNegative`.

`main_function_UW_practice.m` is the original subject-folder workflow and the
template for spreadsheet settings. It is NOT the entry point for paired
validation folders. `main_comparison_file.m` is also an older subject-based
workflow. You do not need either to curate the retained paired run.

## Naming convention

```text
validation_outputs/sorted_medd_csc_pair_<recording_name>/
     csc_<recording_name>_practice_cells_final.xlsx
     medd_<recording_name>_practice_cells_final.xlsx
     combined_for_spikeinterface/csc/sort/5/
     combined_for_spikeinterface/med/sort/5/
validation_outputs/curated_medd_csc_pair_<recording_name>/
    combined_for_spikeinterface/     retained-spike MAT files and paired manifest
    baseline_for_spikeinterface/     manifest pointing to original same-channel sorts
```

External workbook naming uses `medd_`; the internal oSort source directory and
dispatch name remain `med`. Do not rename the internal `med/` tree to `medd/`.
The current folder uses `da-082-06-17`; its two supplied workbooks use uppercase
`DA-082-06-17`. Workbook discovery matches case-insensitively without renaming
the user's files. New paired sorts use this folder convention without a
timestamp. Existing output is refused; use a new label (e.g. a recording name
with `_rerun_01`) or a separate output root for each rerun/control experiment.

## Locations and ownership

| Stage | Existing file | Role |
| --- | --- | --- |
| Workflow documentation | [oSort README](../../../osort_sorting/readme.md) | Input formats, outputs, commands |
| Readable sorting main | [main_sorting.m](../../../osort_sorting/main_sorting.m) | User settings and one workflow call; safe preview default |
| Readable curation main | [main_curation.m](../../../osort_sorting/main_curation.m) | User settings and one workflow call; currently figures-only refresh |
| Sorting execution helper | [run_sorting_workflow.m](../../../osort_sorting/run_sorting_workflow.m) | Scoped environment, existing sorting implementation, optional Python |
| Curation execution helper | [run_curation_workflow.m](../../../osort_sorting/run_curation_workflow.m) | Expected-channel/threshold guards, preflight, optional execution |
| Sorting + analysis launcher | [compare](../../../osort_sorting/compare) | Bash; MATLAB batch followed by Python |
| Paired MATLAB driver | [main_function_compare_medd.m](../../../osort_sorting/main_function_compare_medd.m) | Match channel numbers, validate inputs, sort each source, compare, consolidate |
| Per-source sorting job | [osort_validation_run_pipeline.m](../../../osort_sorting/codes/helpers/osort_validation_run_pipeline.m) | Isolated output, 512000-sample blocks, calls A00 wrapper |
| oSort configuration | [A00_osort_MemSeg.m](../../../osort_sorting/codes/A00_osort_MemSeg.m) | Detection/alignment settings, source dispatch, paths |
| Adapter hook | [processRaw.m](../../../osort_sorting/osort/osort-v4-rel/code/continuous/processRaw.m) | Calls custom reader before spike extraction |
| Reader dispatch | [osort_read_input.m](../../../osort_sorting/codes/osort_read_input.m) | Native CSC, MED, rounded CSC, MED-only modes |
| Paired MED adapter | [osort_read_med.m](../../../osort_sorting/codes/osort_read_med.m) | MED waveforms on CSC count scale and record clock |
| MED decoder | [osort_validation_read_med.m](../../../osort_sorting/codes/helpers/osort_validation_read_med.m) | Dark Horse read_MED, indices, units, contigua |
| Input gate | [osort_validation_compare_inputs.m](../../../osort_sorting/codes/helpers/osort_validation_compare_inputs.m) | UUID/channel/rate/count checks, timing and amplitude diagnostics |
| MATLAB comparison | [osort_validation_compare_results.m](../../../osort_sorting/codes/helpers/osort_validation_compare_results.m) | Timestamp matching and label-invariant partitions |
| Python analysis | [med_sorter_comparison.py](../../DHN_Validation/comp_fidelity/med_sorter_comparison.py) | SNR, splits/merges, SpikeInterface agreement, PI tables |
| MATLAB merges | [mergeClusters.m](../../../osort_sorting/osort/osort-v4-rel/code/osortTextUI/mergeClusters.m) | Merge two labels; modifies input file in place |
| MATLAB retained-unit selection | [defineUsableClusters_MinMax.m](../../../osort_sorting/codes/helpers/defineUsableClusters_MinMax.m) | Sets useNegative and writes final MAT |
| Excel curation wrapper | [A00_osort_merge_MemSeg.m](../../../osort_sorting/codes/A00_osort_merge_MemSeg.m) | Reads retained labels and merge expressions from spreadsheet |
| Paired Excel curation entry point | [main_function_curate_validation.m](../../../osort_sorting/main_function_curate_validation.m) | Separate CSC/MED spreadsheets, combined-layout inputs, dry-run validation and immutable baseline |
| MED-only alternative | [sort_medd.m](../../../osort_sorting/sort_medd.m) | MED waveforms with one CSC timing/header reference |

Working directory: `/home/dhn/Documents/osort_sorting`.
Python interpreter: `/home/dhn/Documents/development/zlab_sorting_script/.venv/bin/python`.
MATLAB executable was found at `/usr/local/bin/matlab`.
Dark Horse MATLAB reader: `/home/dhn/DHN/read_MED`, including `Resources`.

`DHN_Validation/primary_workbook.ipynb` and `osort_sorting/DA-082-comparison/compare.ipynb`
point to older CSC repeatability work; they are not the controlling paired-MED
pipeline. Do not assume their historical paths still exist.

## What was actually done to MED

The paired dataset is:

```text
/mnt/MED_Data_iSSD/Neural_Data/da-082-06-17-converted_pair/
    micros/                 original CSC<n>.ncs recordings
    micros.medd/            compressed MED session, CSC_<n>.ticd channels
    CSC2MED_rc.txt           existing conversion configuration
    micros_cs.csv           existing channel configuration
    DA082_connection_map.xlsx
```

These conversion files exist, but the exact historical converter command and
settings were not reconstructed. Do not regenerate MED or claim lossless
conversion without inspecting them and recording the actual invocation.
`converted_duo/` also exists on the data disk; do not choose data by run label.

The adapter does not export MED back into NCS. It reads a channel directly from
MED with `read_MED`, applies the metadata amplitude conversion factor, and
uses explicit polarity (default -1 for this acquisition). The paired adapter
then divides physical microvolts by `ADBitVolts * 1e6` to recover the original
oSort ADC-count scale, retaining fractional values. oSort preprocessing and
clustering then run through the same wrapper as CSC.

The paired path retains CSC record timestamps and mirrors the original CSC
loader's first-record skip. Timing differences and contiguum differences are
reported; MED samples may be concatenated to mirror CSC behavior. This is a
waveform/sorting comparison on a shared CSC clock, NOT an independent MED-clock
validation. Final-block exclusions also mean it is not every recorded sample.

MED-only mode is different: `osort_read_med_reference.m` uses physical units
and one CSC file for its header/record grid only, not CSC waveform samples.
For the PI's paired fidelity experiment, use `compare`, not `sort_medd`.

## Existing evidence to start from

All paths here are relative to `/home/dhn/Documents/osort_sorting/validation_outputs`.

| Run | Observed artifacts / meaning |
| --- | --- |
| `sorted_medd_csc_pair_da-082-06-17` | The only retained run. CSC257-280; 24 CSC and 24 MED consolidated MAT files verified. PI figures/CSVs, per-channel folders, summary, and directory_validation.mat remain. Root channel_manifest.csv is absent. Two curation spreadsheets are in this run directory. |

All other oSort validation outputs were deleted by the researcher. They are no
longer available evidence. This folder is the renamed retained 24-channel run;
internal historical logs and MAT provenance may still contain its old name.
The combined CSV manifest was repaired on 2026-10-09 to use the current paths,
with all 48 paths verified. Its old path entries were preserved in
`combined_manifest_before_rename.csv`. No sorting MAT files were changed.

Main run output layout:

```text
sorted_medd_csc_pair_da-082-06-17/
    csc_DA-082-06-17_practice_cells_final.xlsx
    medd_DA-082-06-17_practice_cells_final.xlsx
    directory_validation.mat
    osort_comparison_summary.csv
    CSC257/                    repeated through CSC280
        validation.log
        input_validation.mat
        input_first_samples.csv
        csc/5/A_ss257_sorted_new.mat
        csc/figs/5/
        med/5/A_ss257_sorted_new.mat
        med/figs/5/
    combined_for_spikeinterface/
        combined_manifest.csv  Channel,CSCResult,MEDResult; absolute MAT paths
        csc/sort/5/A_ss257_sorted_new.mat
        med/sort/5/A_ss257_sorted_new.mat
        discrepancy_analysis/
            pi_summary_table.png
            pi_summary_table.csv
            discrepancy_summary.csv
            discrepancy_events.csv
            discrepancy_cluster_breakdown.csv
            label_overlap.csv
            sorter_comparison_matches.csv
            pct_matched_per_channel.png
            snr_by_match_status.png
            cluster_split_plots/
```

The saved table reports 559187 CSC events, 559100 MED events, 99.22% of CSC
events temporally matched, 92.7% mean channel cluster purity, and 0.87 reported
spike-weighted sorter agreement. These are uncurated results. Detection counts
include all loaded events; SpikeInterface units exclude noise label 99999999.
The overall SNR and purity rows average channel statistics, not all individual
spikes. The overall agreement weights channel agreement by all CSC event counts.
"Units Split" actually means purity below 0.9, not every multi-label split.

The separately saved rounding-control runs were deleted. Earlier inspection
reported exact rounded-CSC versus MED results on 257/258, but that standalone
CSV is no longer available. Rerun controls and retain their outputs before using
that result as evidence in the PI presentation. Do not infer it from this run.
The comparison permits one sample (31.25 us at 32 kHz) for CSC versus MED.

Existing code explains how these artifacts are produced, but an archived exact
command/code revision for the large run was not recovered. The CURRENT launcher
has automatic analysis; do not assume the historical run used this exact version.

## Run by hand: baseline

First record the input pair, chosen channels, MATLAB/Python versions, repository
revision and local diffs, polarity, sampling rate, and intended block coverage.
The alignment/threshold argument 5 selects mixed alignment and is also passed
as the extraction threshold in A00_osort_MemSeg. It is not simply a display label.

Use a fresh terminal or clear inherited OSORT_* settings: the launcher only sets
some flags when supplied, so stale environment variables can change a later run.
Do not run two launchers simultaneously: the shared log filename has second
resolution. Inspect channel statuses; exit success alone does not prove every
channel succeeded or that the two sources agreed.

```bash
cd /home/dhn/Documents/osort_sorting
unset OSORT_CHANNELS OSORT_THRESHOLD OSORT_WORKERS OSORT_MED_PASSWORD
unset OSORT_MED_POLARITY OSORT_OUTPUT_ROOT OSORT_RUN_LABEL
unset OSORT_ROUND OSORT_REDUNDANT OSORT_VALIDATION_INPUT_ONLY
CSC=/mnt/MED_Data_iSSD/Neural_Data/da-082-06-17-converted_pair/micros
MED=/mnt/MED_Data_iSSD/Neural_Data/da-082-06-17-converted_pair/micros.medd
PY=/home/dhn/Documents/development/zlab_sorting_script/.venv/bin/python

./compare "$CSC" "$MED" --channels 257,258 --input-only --label da-082-06-17_input_check
./compare "$CSC" "$MED" --channels 257,258 --round --redundant \
    --workers 2 --python "$PY" --label da-082-06-17_controls
./compare "$CSC" "$MED" --channels 257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280 \
    --workers 4 --python "$PY" --n-split-examples 3 --label da-082-06-17_rerun_01
```

The launcher prints the exact new run directory and writes a batch log under
`validation_outputs/logs`. Inspect `channel_manifest.csv`, per-channel logs,
`input_validation.mat`, and `sorter_comparison_matches.csv` (including error
rows) before accepting a run. Input-only still creates a MATLAB process pool;
it does not sort, and may create an empty combined directory.

To separate the two stages for explanation, add `--skip-analysis` to the sort
command, then run the existing Python script against the EXPLICIT new run:

```bash
RUN=/home/dhn/Documents/osort_sorting/validation_outputs/sorted_medd_csc_pair_da-082-06-17_rerun_01
"$PY" /home/dhn/Documents/development/DHN_Validation/comp_fidelity/med_sorter_comparison.py \
    --combined-root "$RUN/combined_for_spikeinterface" \
    --sampling-frequency 32000 --tolerance-samples 1 --n-split-examples 3 \
    --output-dir "$RUN/analysis_baseline"
```

Do not rely on the Python default "latest" directory. Read the actual sampling
frequency from input_validation.mat before using 32000. Reanalysis writes into
its output directory; use separate directories for baseline and curated results.

## Run by hand: MATLAB curation

### Preferred: two independent Excel spreadsheets

Use `main_function_curate_validation` instead of adapting the legacy subject
folder wrapper. This is a function-based MATLAB entry point: add the project
directory to the path, then supply the validation run (or its
`combined_for_spikeinterface` directory). The CSC and MEDD workbook paths are
optional: the recording-named files are discovered in the run directory.
Explicit workbook paths are still accepted as the second and third arguments.
It only curates existing results; it does not run spike detection or sorting.

Default spreadsheet settings match the practice workflow: sheet 1, rows 11:34,
channel column C (3), threshold column E (5), cluster-expression column F (6).
Use text format for cluster expressions. For example `128+130+140,150` merges
130 and 140 into 128, then retains 128 and 150. Numeric single-cluster cells
are also accepted. A fully blank row is skipped; channel/threshold are required
for other rows, but a blank cluster cell means retain zero units.
Each label must appear only once per channel/threshold selection. Only labels
in that source's `useNegative` list with actual spikes are allowed. A channel with
zero retained units stays in the paired manifest with empty exported arrays.
Semicolon-separated threshold/selection groups
are supported, e.g. `5;5.2` and `128,150;130`, only if both input files exist.

```matlab
addpath('/home/dhn/Documents/osort_sorting');
runRoot = '/home/dhn/Documents/osort_sorting/validation_outputs/sorted_medd_csc_pair_da-082-06-17';
options = struct();
options.CSC = struct('Sheet', 1, 'RowRange', 11:34, ...
    'ColumnChannel', 3, 'ColumnThresh', 5, 'ColumnClusterNumbers', 6);
options.MED = options.CSC;
options.OutputRoot = fullfile(fileparts(runRoot), 'curated_medd_csc_pair_da-082-06-17');
options.ComparisonThreshold = 5;
options.DryRun = true;
plan = main_function_curate_validation(runRoot, [], [], options);

options.DryRun = false;
manifest = main_function_curate_validation(runRoot, [], [], options);
curationRoot = options.OutputRoot;
```

Set each source's Sheet/RowRange/column settings independently if the workbooks
differ. Inspect `plan` before switching DryRun off. The script validates BOTH
workbooks before creating output and rejects an existing OutputRoot. Every new
revision must use a fresh output directory.
The default output is the sibling `curated_medd_csc_pair_<recording_name>`;
omit OutputRoot to use it. For a later revision, supply a new OutputRoot such
as `curated_medd_csc_pair_da-082-06-17_review_02`. ComparisonThreshold selects
one alignment for the Python export (default 5). Both workbooks must specify
the same nonempty channel set at that threshold; otherwise preflight fails.
Other threshold jobs may be curated, but are not included in that export.

Input files come from `<combinedRoot>/<source>/sort/<threshold>/`.
The new directory contains:

```text
curated_medd_csc_pair_da-082-06-17/
    csc_da-082-06-17_practice_cells_final.xlsx   snapshot of CSC decisions
    medd_da-082-06-17_practice_cells_final.xlsx  snapshot of MED decisions
    curation_plan.mat               source paths, spreadsheet rows, merges, settings
    curation_manifest.csv           FinalFile, ExportFile, Status, original/retained counts
    csc/sort/5/A_ss257_sorted_new.mat   working copy, merged in place
    csc/sort/5/*.merge_001.orig         backup before each merge
    csc/sort/final/A_ss257_Mix_sorted_new.mat
    csc/sort_figs/                     copied historical figures; may be stale
    med/sort/5/A_ss257_sorted_new.mat
    med/sort/final/A_ss257_Mix_sorted_new.mat
    med/sort_figs/
    regenerated_figures/review_<timestamp>/
        figure_manifest.csv          completed/no_retained_units/failed per source/channel
        csc/sort_figs/5/*.png         regenerated CL/CL_ALL/PCAALL/WAVES review figures
        med/sort_figs/5/*.png
    combined_for_spikeinterface/
        combined_manifest.csv       Channel, CSCResult, MEDResult; absolute export paths
        csc/sort/5/A_ss257_sorted_new.mat   retained events, merged labels
        med/sort/5/A_ss257_sorted_new.mat   retained events, merged labels
    baseline_for_spikeinterface/
        combined_manifest.csv       original MAT paths for the SAME channel cohort
```

The helper preserves rejected spikes in final arrays for audit. The separate
combined export contains ONLY useNegative events, applying one mask to waveform
rows, timestamps, and labels. Retained timestamps are not altered, merged labels
are preserved, and the original noise estimate is retained. The baseline
manifest references the immutable original sorts rather than copying them;
keep the baseline directory in place. The paired analysis manifests are written
only after all curation jobs finish. This script does NOT launch Python. If a runtime
error occurs after validation, the curation manifest marks the current job
failed and the error is rethrown; baseline files remain unchanged.

Twelve focused tests passed for readable workflow previews/channel guards, workbook-name discovery from
both run/combined directories (including mixed case), dry-run safety, independent CSC/MED
decisions, chained merges, baseline preservation, refusal to overwrite prior
curation, invalid/overlapping selections, filtered export arrays, paired cohorts,
and default curated output naming. The integration test ran the existing Python
analysis and SpikeInterface on synthetic baseline/curated exports, checking
counts, timing-match rates, finite agreement scores, and saved PI figures.
Coverage also includes one/both sources retaining no neurons, zero-row waveform
shapes, and realistic regenerated figures with unchanged saved final MAT data.
Actual recording sorting/curation has not been run automatically; a figures-only
refresh of the user's existing curated 266:272 results was completed for all 14
source/channel jobs. All final MAT SHA256 hashes were unchanged. Test command:

```matlab
results = runtests('/home/dhn/Documents/osort_sorting/codes/test_curate_validation.m');
assertSuccess(results);
```

### Alternative: direct interactive helpers

Curate CSC and MED independently with the same quality criteria, preferably
blinded to source. Cluster IDs are arbitrary across sources; never reuse CSC
cluster numbers as MED decisions. Record every merge/rejection and its reason.
Review waveform stability, refractory-period violations, isolation, and noise
using the available cluster figures and MATLAB tools, not agreement alone.

The existing Excel wrapper expects
`<pwd>/<subject_id>/A00_<subject_id>_cells_final.xlsx`, with configured row/column
ranges. Expressions `128,130,150` retain units and `128+130,150` merge 130 into
128 before retaining 128 and 150. Existing example main scripts use test row
ranges, not a complete paired curation plan. The wrapper also constructs the
merge base path as `[paths.basePath paths.patientID]` without a separator; do
not call it on these validation folders unchanged. Direct function calls below
avoid both layout assumptions and that path issue.

IMPORTANT: mergeClusters modifies the input MAT and moves it to a `.orig`
backup. Repeated merges should not depend on that one backup. Work on copies,
never on the immutable baseline or its consolidated MAT files. It does not
regenerate figures after merging. Retained selection writes a new final MAT
but leaves rejected spikes in the stored arrays: `useNegative` defines inclusion.

In MATLAB, stage one channel/source and use the text UI:

```matlab
projectRoot = '/home/dhn/Documents/osort_sorting';
addpath(genpath(fullfile(projectRoot, 'codes')));
addpath(genpath(fullfile(projectRoot, 'osort')));
runRoot = '/home/dhn/Documents/osort_sorting/validation_outputs/sorted_medd_csc_pair_da-082-06-17';
channel = 257;
sourceName = 'csc';
original = fullfile(runRoot, sprintf('CSC%d', channel), sourceName);
work = fullfile(runRoot, 'manual_curation', sprintf('CSC%d', channel), sourceName);
assert(~isfolder(work), 'Already staged: do not overwrite prior curation.');
mkdir(fullfile(work, 'sort'));
mkdir(fullfile(work, 'sort_figs'));
copyfile(fullfile(original, '5'), fullfile(work, 'sort', '5'));
copyfile(fullfile(original, 'figs', '5'), fullfile(work, 'sort_figs', '5'));

mergeClusters(work, 'sort', 'sort_figs', 'final');
defineUsableClusters_MinMax(work, 'sort', 'sort_figs', 'final');
```

At each prompt enter the channel, threshold 5, and actual inspected labels.
Skip mergeClusters when no merge is needed. Repeat staging and selection for
`sourceName = 'med'` and every channel included in the curated comparison.
For recorded noninteractive decisions, pass `[channel 5 target source]` to
mergeClusters and `[channel 5 retainedLabels]` to defineUsableClusters_MinMax.
Inspect their output and verify the final file exists; do not assume success.

Final file for mixed alignment:
`<work>/sort/final/A_ss257_Mix_sorted_new.mat`.
The final MAT records `useNegative` and `useNegativeExcluded`; labels after
merging are in `assignedNegative`. Zero-retained-unit channels need explicit
handling in analysis rather than silently dropping them from the study.

## Compare before and after manual curation

Both stages below are AFTER automatic sorting. "Before" means before manual
merges/rejections, not raw unsorted traces. No new detection/sorting is run.
The existing analysis script is unchanged: the new curator automatically
provides its required MAT fields and CSV manifest. Do not point it at unfiltered
`sort/final` files, because its loader does not inspect useNegative.

Run these commands after successful curation, using the sampling rate verified
for your recording (32000 Hz for the current session) and the same tolerance:

```bash
PY=/home/dhn/Documents/development/zlab_sorting_script/.venv/bin/python
ANALYSIS=/home/dhn/Documents/development/DHN_Validation/comp_fidelity/med_sorter_comparison.py
CURATED=/home/dhn/Documents/osort_sorting/validation_outputs/curated_medd_csc_pair_da-082-06-17

"$PY" "$ANALYSIS" --combined-root "$CURATED/baseline_for_spikeinterface" \
    --output-dir "$CURATED/analysis_baseline" --sampling-frequency 32000 \
    --tolerance-samples 1 --n-split-examples 3

"$PY" "$ANALYSIS" --combined-root "$CURATED/combined_for_spikeinterface" \
    --output-dir "$CURATED/analysis_curated" --sampling-frequency 32000 \
    --tolerance-samples 1 --n-split-examples 3
```

Compare `analysis_baseline/pi_summary_table.csv` and
`analysis_curated/pi_summary_table.csv` side-by-side. Both also contain per-channel
timing counts, cluster purity/split information, unit agreement scores, SNR
plots, and PI table images. The curation manifest reports original event counts,
retained event counts, and retained unit counts for every job. Baseline results
include the original loaded events; curated results include retained events
only, so denominators change. An improvement in agreement after rejecting
units is not independent evidence of lossless compression or restored spikes.
Merging changes labels; rejecting units removes events. Neither operation
retimes a retained spike. Report that distinction when discussing timing changes.
Blank selections retain no neurons. Empty channels remain included in comparison
counts; undefined percentages/agreement are NaN. They are marked explicitly in
the figure manifest instead of generating misleading neuron figures.

RegenerateFigures defaults true for new curation. The figures-only helper writes
new timestamped review directories without modifying MATs, old figures, workbook
snapshots, or exports. Review WAVES has wrapped cluster/count titles, three pairs
per row, and a recording/source heading. For a final merge, revise the original
source-specific workbooks, preserve previous desired merges in their expressions,
set FiguresOnly=false, and use a new OutputRoot such as
`curated_medd_csc_pair_da-082-06-17_final`; keep RunRoot at the original sorted run.

Figure regeneration now uses a process-based `parfor` across source/channel jobs.
Set `settings.FigureWorkers` in the main script (default 4); the detailed curator
uses `options.FigureWorkers`, and direct helper calls accept a second worker-count
argument. Existing process pools are reused with bounded concurrency; thread
pools are rejected because graphics require process workers. Figure creation is
explicitly invisible, exports do not raise windows, and each job cleans up its
own figures while restoring worker graphics defaults. The focused plotting test
audits creation visibility on multiple workers and preserves a client figure.

The completed readable review set is
`validation_outputs/curated_medd_csc_pair_da-082-06-17/regenerated_figures/review_20261009_145405_641/`
under the oSort project, with separate `csc/sort_figs/5/` and `med/sort_figs/5/`
directories. The PNGs were visually checked for wrapped cluster IDs/counts and
visible black traces; all 14 jobs completed. Earlier review folders are superseded.

## PI explanation and next actions

1. Explain conversion and units separately from the shared sorting algorithm.
2. Show input provenance and timing limitations, then uncurated paired results.
3. Show rounded-CSC controls on the tested channels; avoid a lossless claim.
4. Present documented independent curation and compare retained units again.
5. State that detection agreement, cluster purity, ARI, and Jaccard-style sorter
   agreement measure different things. High detection matching is not identical
   clustering, and improved curated agreement alone is not proof of fidelity.

A notebook is optional: the current Bash launcher already consolidates MATLAB
and Python. Start with this runbook and one/two-channel validation. A future
notebook can display the explicit commands, manifests, curation audit, and
before/after plots without reimplementing oSort or automatically making manual
decisions. Empty retained sets need a dedicated tested analysis path before a
full curated study that includes such channels.

## Notes for future agents

- Verified: ten workflow/curation tests pass, including synthetic end-to-end baseline
    and curated Python/SpikeInterface analysis. No actual recording curation was
    executed. Documentation links and Bash examples are checked separately.
- Do not overwrite baseline sorts, existing local changes, or manual decisions.
- During this inspection `compare` already had local modifications, and
  `DA081-05-22/` was untracked. Neither was changed by this documentation task.
- `rg` is unavailable in this environment; use grep/find or workspace tools.
- Use explicit `Delimiter`, `','` when reading CSV manifests with MATLAB:
    automatic delimiter inference misread the renamed run's combined manifest.
- Python conclusions here come from inspected source, saved artifacts, and an
    explicit CLI startup check, not an editor-selected interpreter or Pylance analysis.
- Read this reference and the owning driver/adapter before exploring notebooks.
- Record actual run versions and commands; historical artifact names are not
  sufficient provenance. Historical completed outputs remain useful baselines.