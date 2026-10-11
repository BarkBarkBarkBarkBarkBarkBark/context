# Semantic Neural Stream: Updates

## 2026-10-03 | Specification Import

Read semantic-stream-development_pla.md and indexed its goal, constraints, and first milestone. No simulator implementation or validation was performed in this context-hub task.

## 2026-10-03 | Revised Plan Saved

Saved semantic_stream_plan.md in the source workspace at the user's request, documentation only. Confirmed local semantic_neuron demo; planned one electrode/four units, SpikeInterface rendering, independent TCP measurement, adaptive supplied-text PsychoPy client, and web observation. Shared toolbox transport remains proposed. Ruby Markdown check passed: 319 lines, nine required sections, balanced fences, six resolving local links. No implementation or runtime tests performed; implementation tasks unchanged. Hub commands passed: `ruby scripts/context.rb validate` (8 projects, 11 tasks) and `ruby tests/context_test.rb` (23 runs, 77 assertions, zero failures/errors/skips).

## 2026-10-03T18:01:42-0700 | Simulator and TCP Vertical Slice

Implemented SI population rendering, cached real embeddings, paced TCP/web service, shared toolbox codec/client, measured adaptive client, and PsychoPy script. Combined tests: 137 passed in 4.41 s; real MiniLM/browser controls exercised; 40/40 valid live headless trials, p95 apply delay 0.946 ms; 25.44 s NPZ/JSON export verified on disk. Demo checkout unchanged. Actual PsychoPy display and formal soak/effectiveness/mobile/download/full controller export gates outstanding; interactive task blocked, not done. Source README.md/IMPLEMENTATION.md contain exact evidence. Hub validation passed (9 projects, 12 tasks). Three stale real-portfolio count/status test assumptions initially failed; fixture-based dependency check and flexible project-count assertion repaired them. Final context suite: 23 runs, 78 assertions, zero failures/errors/skips.

## 2026-10-03T18:31:49-0700 | THINGS Noun Game

Implemented local aligned/normalized THINGS wordvec catalog (1715 usable, 139 missing), selectable preferred noun/unit 0, fixed noun wrappers, cosine temperature/exact-ID Found, query-relative neighbors, and delayed stochastic ground-truth counts. Updated twelve adaptive candidates and dataset-root CLI. Combined tests: 157 passed in 5.38 s; changed-module diagnostics clear; real isolated independent TCP client completed 6/6 valid noun trials (0.228-0.385 ms apply delays). Browser THINGS ready/nonblank plots on 8082/9002; scripted round blocked by hidden integrated page/rAF suppression, final selector source update awaits safe restart without clearing another client's round. Docs distinguish historical MiniLM evidence and current measured-versus-private-game boundaries. Overall task remains blocked on presentation and remaining acceptance gates. Hub validation passed: 9 projects, 12 tasks; context tests: 23 runs, 78 assertions, zero failures/errors/skips.

## 2026-10-03T18:39:59-0700 | Collapsible Layout And 10 kHz

User requested trace above history, collapsible sections, configurable lower rate,
and no need for ground-truth panel. Main sections now collapse; optional detail,
truth, trials start closed, with no hidden-plot redraws. Launchers use --sample-rate
(default 10000 Hz, 200-sample/20 ms blocks); library default remains 30000. Fixed SI
zero-length depolarization phase warning and lower-rate client filter Nyquist limit.
Focused tests: 36 waveform/client and 11 display passed. Two real isolated 10 kHz
TCP trials valid. Restarted app on 8082/9002 at 10 kHz including prior selector fix;
desktop trace nonblank, 2000 envelope points, correct section order. Mobile viewport
again reverted to desktop; no mobile claim. Final combined tests: 160 passed in
4.93 s; changed-module diagnostics clear. Hub validation passed: 9 projects,
12 tasks.

## 2026-10-03 | Conceal Preferred Object

Moved the conceal checkbox ahead of the preferred selector and bound both selector
and duplicate target label visibility to it. Target selection is retained across
conceal/reveal and guesses remain accessible. Focused UI tests: 12 passed in
0.99 s; changed files have no diagnostics. Restarted 10 kHz app on 8082/9002.

## 2026-10-03 | Random New Round

New round now selects a random valid noun excluding the current preferred object.
Manual selector changes remain explicit, with concealment preserved. Focused tests:
12 passed in 1.00 s including changed target, cleared feedback, preserved clock,
concealed selector, and manual selection. Diagnostics clear; restarted 10 kHz app
on 8082/9002. README documents the behavior.