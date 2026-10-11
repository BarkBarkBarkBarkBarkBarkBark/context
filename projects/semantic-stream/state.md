# Semantic Neural Stream: Current State

Last checkpoint: 2026-10-03T18:39:59-0700 (collapsible layout and 10 kHz demo)
Verification: 160 combined tests passed in 4.93 s; two real 10 kHz noun TCP trials valid; hub validation passed (9 projects, 12 tasks). Actual PsychoPy presentation and mobile viewport unverified.
Current milestone: Laptop-friendly 10 kHz noun demo with live voltage directly above collapsible guess history.

## Known State And Evidence

New-round refinement (2026-10-03): app.py randomly chooses a valid noun excluding
the current target, rather than reapplying the selector value. Manual selection
has its own callback. Regression confirms target changes, concealment remains on,
feedback clears, and sample clock persists: 12 focused UI tests passed in 1.00 s.
Diagnostics clear; restarted app at 8082/9002, 10 kHz.

Concealment refinement (2026-10-03): app.py now hides both the preferred-object
selector and duplicate preferred-noun label. Checkbox remains accessible before
the selector. Conceal/reveal preserves the target and guess controls, covered by
tests/test_noun_display.py. Focused display suite: 12 passed in 0.99 s; diagnostics
clear. App restarted on 8082/9002 at 10 kHz to load the fix; fresh round.

Latest user refinement: trace above history; sections collapsible; optional ground
truth/detail/trials closed and no hidden-plot redraws. Web/headless --sample-rate
defaults to 10000 Hz with 200-sample/20 ms blocks; library Config() retains 30000.
Rate is a startup setting, requiring a new session. At 10 kHz, SI depolarization
has at least one sample and client high cutoff is capped to 4500 Hz. Focused tests:
36 waveform/client passed warning-free; 11 display passed including redraw gating.
Real isolated 10 kHz measured TCP client completed 2/2 valid trials, one zero reward.
Restarted live app on 8082/9002 at 10000 Hz, including the prior selector fix.
Desktop screenshot confirms nonblank trace above history; 2000 envelope points.
Mobile request again yielded actual 1380 px, not requested 390 px; still unverified.

Default model now uses things_model.py: row-aligned local THINGS GoogleNews wordvec,
300 dimensions, normalized, 1715 finite usable concepts and 139 excluded missing
vectors. No mixed MiniLM space or invented fallback. service.py provides preferred
selection, private round history, query-relative cosine neighbors, and delayed
unit-0 ground-truth counts. app.py has searchable noun selectors, word/fixed sentence
mode, feedback/history, neighbor selection, and existing plots/controls. All twelve
new stimuli.jsonl candidates resolved against real vectors; both launchers accept
--things-root. Target changes preserve stream time/refractory/tails and clear round.

Exact combined rerun: `.venv/bin/python -m pytest tests /Users/marco/Cursor_Folder/Cursor_Codespace/toolbox/tests -q`: 157 passed in 5.38 s. Changed module diagnostics clear. An isolated service plus independent adaptive_client.py completed 6/6 valid noun trials, signed measured rewards, application delay 0.228-0.385 ms; warmup-only smoke, not effectiveness evidence. Service stopped cleanly. Operator cosine and noisy truth counts remain outside TCP measured policy.

Noun demo launched at http://127.0.0.1:8082, TCP 9002 because older 8081/9001 ports were occupied. Browser showed THINGS ready and nonblank plots. Integrated page visibility was hidden and animation frames suspended, preventing reliable popup clicks/scripted rounds; do not claim automated live gameplay or mobile success. Prior selector improvement is now loaded after the user-requested layout/rate restart.

User authorized implementation. Added stream_simulator.py, semantic_model.py, service.py, app.py, adaptive_client.py, psychopy_experiment.py, stimuli.jsonl, tests, launch task, pinned direct requirements, README.md, and IMPLEMENTATION.md. Dedicated .venv uses Python 3.12.8; original neuron-env and semantic_neuron checkout preserved (git status --short reports no demo changes). Toolbox package is implemented and installed editably, not copied.

Historical MiniLM checkpoint: 137 passed in 4.41 s across source tests and toolbox/tests. Real MiniLM model loaded. Browser confirmed three nonblank plots and Submit/Enter/reset/pause/resume; hidden-tab Plotly resize defect repaired. Source module diagnostics clear. Export verified on disk: float32 (763200,1), 25.44 s, start 10800, four templates, 150 truth events within segment. These are earlier-engine checks, not current noun gameplay evidence.

Real TCP headless runs completed six and 40 valid trials. Forty-trial run includes 36 balanced warmup presentations plus four policy choices; application delay p95 0.946 ms, max 1.163 ms. This does not establish superiority over a random policy or visual presentation. Complete evidence/limits are in source IMPLEMENTATION.md.

Standard task remains Semantic Stream Web (8081/9001); current noun demo uses 8082/9002. Shared package: marco-neural-tools 0.1.0 in toolbox. No commits, pushes, or publishing. Documentation local-link checks passed; hub validation is recorded in updates after execution.

## Blockers

PsychoPy absent from stream .venv; installed Studio 2026.1.0 bundle did not expose a usable Python interpreter in inspection. Actual window/flip behavior needs a supported separate environment with measured-client dependencies/toolbox. Formal ten-minute simultaneous soak, multi-seed random comparison, final mobile viewport, browser download delivery, and full controller-session export remain unverified. Browser automation reverted to desktop width during final mobile checks; do not claim success. Current manual capture cannot start while controller owns session.

## Next Action

Read README.md and IMPLEMENTATION.md. In a visible browser at 8082, exercise section collapse/reopen and noun rounds at 10 kHz; verify delayed counts, neighbors, simple sentence mode, and target changes. For another rate restart with --sample-rate 30000; do not change sample rate mid-trial. Then establish a supported separate PsychoPy runtime and test noun presentation against TCP 9002. Follow remaining soak/effectiveness/export/mobile gates; do not rebuild tested simulator.

## Reopen

README.md, IMPLEMENTATION.md, things_model.py, app.py, service.py, tests/test_noun_game.py, tests/test_noun_display.py, stimuli.jsonl, psychopy_experiment.py, semantic_stream_plan.md; toolbox README.md and src/marco_neural_tools/.