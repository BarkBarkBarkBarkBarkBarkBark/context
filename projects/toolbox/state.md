# Toolbox: Current State

Last checkpoint: 2026-10-03T18:01:42-0700.
Verification: tested protocol and editable package installation.
Current milestone: Shared wire contract used by semantic-stream.

## Evidence

marco-neural-tools 0.1.0 implemented in src/marco_neural_tools with SampleChunk, frame encode/sync+async read, and StreamClient. Dedicated 90 protocol tests passed; included in combined 137 passed in 4.41 s. Editable installation into semantic-stream .venv succeeded. Independent source/client live run completed 40 valid trials. Toolbox is a folder, not an initialized Git repository; no git initialization or publishing performed.

## Next Action and Reopen

Preserve public contract when installing into the supported PsychoPy environment. Reopen README.md, pyproject.toml, protocol.py, client.py, and tests/test_protocol.py. No protocol change currently needed; semantic-stream actual presentation is the outstanding integration gate.