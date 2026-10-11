# Semantic Neural Stream

## Outcome

Build a small local semantic population simulator recorded by one electrode, with SpikeInterface waveform/noise generation, raw TCP transport, measured adaptive text selection through PsychoPy, and a live web observer. Preserve the intracellular NEURON demonstration separately.

## Authoritative Source

Source workspace ID: `semantic-stream`. Read semantic_stream_plan.md for the revised scope, README.md for launch commands, and IMPLEMENTATION.md for observed evidence and outstanding gates. The local semantic_neuron/ checkout is confirmed and inspected. The revised user scope supersedes the original handoff's postponed TCP/PsychoPy/search requirements.

## Durable Rules From The Handoff

- First deliver simulator/TCP/web, then measured text adaptation and PsychoPy. Real acquisition, unit sorting, LLM generation, and multimodal search remain later work.
- Small readable Python implementation: ordinary functions, a few dataclasses, one concrete simulator; no speculative architecture or automatic fallback embeddings.
- Keep true events and semantic centers separate from future sorter inputs. Use absolute sample indices, persistent refractory state, and waveform-tail preservation.
- First release: four units, one electrode, 30 kHz, 20 ms blocks; NiceGUI/Plotly; supplied candidates and pooled detected-rate reward. Shared wire codec/client lives canonically in toolbox.
- Focus tests on timing, tails, reproducibility, semantic mapping, reset, and export. Never claim physiological validation or implemented sorting.

## Completion

Latest user scope: noun-centric THINGS wordvec space, selectable preferred object
for unit 0, private cosine warmer/colder game, and query-relative nearest-object
lookup. Fixed noun sentence wrappers use the same object vector, not full-sentence
inference. Other three units remain at baseline. The measured TCP policy remains
pooled-voltage based and never receives the preferred noun, similarities, or truth.
Use local dataset vectors in place; do not copy data/images into source or context.

Working local simulator/TCP/web and measured adaptive PsychoPy loop, focused tests, actual presentation/model/export checks, and measured performance/effectiveness evidence. IMPLEMENTATION.md distinguishes delivered slices from actual PsychoPy, mobile, download, soak, and effectiveness gaps.