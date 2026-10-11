# Zlab Sorting

## Outcome

Per source readme.md: produce a curated SpikeInterface analyzer, usually clean_analyzer.zarr, from Intan .rhd recordings using AWS compute, Kilosort4, and curation tools.

## Scope And Rules

Run sorting and analyzer preparation before curation. Keep recordings, patient identifiers, AWS credentials, and generated analyzers outside this hub. Track non-sensitive artifact references only.

## Sources

Source checkout ID: `zlab-sorting`. Entry points: readme.md, wrapper.py, notebooks/, custom_probes/, docs/.

## Completion

Confirm the active dataset via a non-sensitive alias, environment, current analyzer stage, and the next quality/curation check. Do not launch AWS compute without user authorization.