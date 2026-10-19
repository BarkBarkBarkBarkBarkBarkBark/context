# Resumes and Letters: Current State

Last checkpoint: 2026-10-17T09:23:21-07:00
Verification: local source review, eight exact GitHub blob matches, catalog integrity checks; no runtime validation
Current milestone: Initial skill-to-project source evidence mapped, without application edits

## Known State

### User intent

- Primary outcome: find a neuroengineering job.
- Initial request: orient to existing materials and fill the normal shared
  context records. Completed without revising applications.
- Follow-up request: identify skills documented by context repositories and add
  relevant projects. The catalog now has an initial mapping; resume revision and
  readable Markdown documents remain later work.
- User approved `resumes-and-letters` as the hub ID and renaming the empty
  underscore-named context folder to satisfy hub validation.

### Observed local sources

- The active system uses `resume/data/base_resume.yaml`, role profiles, letter
  snippets, Jinja templates, and Python generators. Current profiles:
  `neuroengineering`, `data_analytics`, `clinical_research`, and `default`.
  The generators read YAML; no catalog reference was found in scripts/tests.
- The GitHub Actions workflow builds a letter and the neuroengineering HTML site
  under `resume/docs/`, then deploys Pages on pushes to main/master. Do not treat
  a local edit as a published change.
- The October 17 bundle in `documents/` contains a patch and mirrored proposed
  source files, experience inventory, role strategy, and drafts. Its
  `neural_data` and `acquisition_validation` profiles are absent from active role
  profiles. Do not apply the patch during orientation.
- Active YAML still describes an incoming/recently admitted Fall 2026 BME student.
  The bundled inventory describes September 2026 enrollment and newer acquisition,
  timing, and response-analysis work. These are differing saved records, not
  freshly confirmed facts about current enrollment or experiment outcomes.
- Historical Markdown/DOCX applications remain in `003 - CV - Resume/`.
  `markdown/operating_room_access.md` exists and is empty.

### Skills catalog snapshot

`neuroengineering_skills.json`, schema version 1.0.0, updated 2026-10-17:

| Record | Count |
| --- | --- |
| Skills / categories | 875 / 39 |
| Evidence records / sources | 20 / 16 |
| Requirements / example job postings / role families | 66 / 5 / 7 |
| Nonempty skill statements | 119 |
| `resume_include: true` / `recruiter_visible: true` | 70 / 23 |

Status counts: 748 not documented, 54 implemented, 18 reported, 32 prototype,
12 in progress, 6 planned, 3 exposure, 2 none. These are stored classifications,
not new independent certifications. Inclusion flags alone do not establish
resume/public-export eligibility.

The catalog retains all previous evidence and adds six source/evidence pairs
using the same record shapes. Each new evidence `project_id` is a registered hub
ID. Seven evidence records now have GitHub documents (15 entries total); eight
new files were retrieved at pinned commits, matched against the exact local blob,
and checked against canonical public repository metadata. The seven earlier
document entries were preserved, not rechecked.

### Source-reviewed project mappings

38 existing skill records gained project evidence: 29 previously undocumented
skills, two reported skills promoted to source-supported scope, and seven other
skills with additional evidence. No skill IDs were added; all resume/public
inclusion flags, proficiency fields and resume text were preserved.

| Hub project / catalog evidence ID | Reviewed implementation | Evidence boundary |
| --- | --- | --- |
| `zlab-sorting` / `zlab_sorting_source` | Intan RHD loading, ProbeInterface geometry, filtering/whitening, Kilosort4 invocation, analyzer waveforms/PCA, saved curation decisions, Zarr export. | Canonical public repo is [zlab_sorting_script](https://github.com/BarkBarkBarkBarkBarkBarkBark/zlab_sorting_script), formerly `sorting_script`; commit `ebdd2ea8b5a20b9815b5c11a2b1cdca3b80c34d6`. Wrapper calls do not match the module's sorting/analysis function names; do not claim a working full plugin. |
| `realtime-sorter-mvp` / `realtime_detector_source` | Stateful SOS filtering, per-channel normalization, refractory threshold detector, Kafka events. | Pinned worker only, commit `0138fe7332b6334766de9526485c5484f2413d8c`; local producer changes excluded. Gap markers are skipped; no loss-recovery or end-to-end latency claim. |
| `synth-mvp` / `synth_stream_source` | Seeded synthetic producer, async WebSocket relay, Streamlit/Plotly bandpass viewer. | Canonical public repo is [RTS-mvp](https://github.com/BarkBarkBarkBarkBarkBarkBark/RTS-mvp), formerly `Real-Time-Signal-Streaming-Visualization-MVP-`; commit `86995ec4fea9cab1dd909b5df38a9ad06764aa39`. Queue drops, clipped producer tails and unverified buffer wrapping prevent lossless/correct-continuity claims. |
| `hosaka-context` / `hosaka_delivery_source` | Multi-stage Docker build and installer/image-test-gated GitHub Actions promotion. | Public commit `03cda0236617ef3a1733e9ae55ef631333c61345`; no build, deployment or CI run performed. General software-delivery evidence only. |
| `toolbox` / `toolbox_protocol_source` | Bounded binary/JSON protocol, sync/async reads, TCP client, setuptools package and parameterized protocol fixtures. | Local-only folder, not a Git repository. File SHA256 snapshots are in the catalog source note; no fabricated public links or passing-test claim. |
| `semantic-stream` / `semantic_stream_source` | SpikeInterface synthetic voltage/truth, persistent waveform tails and refractory state, seeded simulation, MAD-based detector, gap rejection, cosine-neighbor lookup and regression/integration fixtures. | Local-only workspace, distinct from `semantic_neuron`. File SHA256 snapshots recorded; tests/live trials not rerun. No biological, decoder, physical-onset or clinical validation. |

Implementation scope was reviewed, not individual authorship/proficiency. Confirm
personal contributions and inclusion choices before generating new public claims.
Unverified C++ collections and historical DHN result summaries were not promoted
into new skills merely because filenames or context descriptions suggest them.

## Last Meaningful Action And Validation

- Reviewed source implementations in the six projects above and selected test
  bodies. Retrieved all eight new public evidence files through `gh api`,
  verified canonical visibility with `gh repo view`, and matched Git blob hashes.
  Local-only evidence has SHA256 snapshots rather than invented GitHub anchors.
- Bulk-updated 38 skill records and added six source/evidence pairs. Validation
  against the pre-edit catalog confirmed no unrelated section/skill changes,
  no lost prior evidence/documents, unchanged inclusion/proficiency/resume fields,
  and preserved non-reported skill statements.
- Ruby checks passed for skill category/status/evidence, evidence source,
  requirement evidence, role-family category/skill and posting source/skill
  references. All updated document objects contain the template's required keys;
  eight new public documents have 40-character revision anchors. `git diff
  --check` passed. This is not full schema validation: the schema remains absent.
- Runtime tests, resume builds, CI/deployment, employer availability, experimental
  results and historical pass-count claims were not rerun. No application code,
  resume YAML, letters, OR-access document or website output was changed.
- Hub validation passed: `Valid: 12 projects, 30 tasks`. The project task query
  shows the completed mapping and remaining contribution/schema reviews.
  All six new evidence project IDs resolve to the registry and all 14 local
  context-document links resolve. Final catalog checks also passed after removing
  whitespace introduced by the bulk formatter.

## Blockers And Open Questions

- Catalog `$schema` points to `./neuroengineering_skills.schema.json`, which is
  absent locally. A schema-backed validation contract is not yet available.
- Catalog source `profile_inventory` points to
  `resume/career/experience_inventory.md`, absent in the active tree; its saved
  counterpart is in the update bundle. Resolve intentionally, not by silently
  pretending the proposed source is installed.
- Many personal experience records remain reports without public project
  documents. Public evidence has improved for four projects, but local
  semantic-stream/toolbox still need authorized publication if recruiter links
  are desired. Permission, exact contribution and reproducibility remain checks
  before public export.
- Worktree already contains deleted `projects_context/` entries and untracked
  `documents/`, `markdown/`, and the catalog. Preserve these changes; no commit,
  push, publication, or patch application was requested.
- Hub files are not guaranteed to load automatically in the source workspace.
  Start future sessions explicitly at the hub's `AGENTS.md` and this brief/state;
  no new source-workspace discovery instructions were installed.

## Next Action

The requested initial source mapping is complete. Next, review the six new
evidence records and the 38 linked skills with Marco: confirm personal
contributions and decide which, if any, merit resume/public inclusion. Keep
existing flags unchanged until that review. Acceptance: selected skills have
explicit contribution/scope and inclusion decisions, and local-only projects
have an explicit publication decision rather than fabricated public links.
Resolve the missing schema/inventory path before implementing an exporter.

## Reopen

- [Project brief](brief.md) and [task queue](tasks.jsonl).
- [Skills catalog](../../../resumes_and_letters/neuroengineering_skills.json).
- [Bundled experience inventory](../../../resumes_and_letters/documents/neuroengineering-update-2026-10-17/changed_files/resume/career/experience_inventory.md).
