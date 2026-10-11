# Toolbox

## Outcome

Maintain one tested shared implementation of the neural sample wire contract and TCP client. First package: marco-neural-tools, import marco_neural_tools; no semantic model, GUI, or acquisition SDK dependencies.

## Sources and Rules

Source checkout ID: toolbox. README.md and src/marco_neural_tools/protocol.py/client.py own public APIs. Preserve protocol validation and sample-major float32 microvolt conventions. Shared callers install normally/editably, not via copied code or sys.path patches.

## Completion

Package metadata, public codec/client, bounded-framing tests, and documented actual consumers. New utilities require a concrete second consumer; do not bulk migrate old prototypes.