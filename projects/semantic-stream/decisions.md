# Semantic Neural Stream: Decisions

## 2026-10-03 | Revised Release Scope and Ownership

User's updated scope supersedes the original postponement of TCP, PsychoPy, and adaptive text screening. First target is pooled detected electrode activity from supplied texts, on one electrode/four units. Keep hidden preferences/truth outside client inputs. Source semantic_stream_plan.md records the agreed design.

Keep the original NEURON demo and neuron-env intact. New stream .venv is isolated; source now calls real SI waveform/noise APIs and real MiniLM without fallback. Shared wire codec/client lives canonically in toolbox and is installed editably; no prototype module or broker was imported wholesale.

Actual PsychoPy stays in a separately supported runtime because it is absent from the verified stream environment. A mocked frontend and headless measured loop are not visual-presentation evidence. Keep the overall task blocked until actual presentation and remaining acceptance checks are exercised.

## 2026-10-03 | THINGS Noun Space Supersedes Sentence Default

Latest user scope selects a preferred object and searches standard nouns by cosine.
Use only the local THINGS GoogleNews wordvec space (300 dimensions), normalized
and ID-aligned; exclude missing/nonfinite vectors without fallback. Keep legacy
MiniLM code separate and not loaded by the default service. Fixed noun sentence
wrappers deliberately retain the noun vector rather than implying sentence NLP.

Tune unit 0 to the chosen noun and leave other units at baseline. Game temperature
uses deterministic signed cosine versus the previous guess; Found requires exact
concept identity. Unit-0 response counts are stochastic simulator truth, visibly
labelled, not detector estimates. Query-relative neighbor hints do not consult the
preferred target. Independent TCP adaptive selection continues to use only pooled
measured voltage; private game state never crosses that protocol boundary.