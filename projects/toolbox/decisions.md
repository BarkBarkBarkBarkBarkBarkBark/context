# Toolbox: Decisions

## 2026-10-03 | Narrow Shared Package

Own only the actually shared SampleChunk contract, frame codec and concrete TCP client initially. Keep semantics, SI rendering, display and experiment policy in semantic-stream. Existing prototypes remain references, not dependencies. Avoid broad migration or framework abstractions.