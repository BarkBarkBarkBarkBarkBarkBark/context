# Synthetic Streaming MVP

## Outcome

Per source readme.md: live synthetic signal streaming with interactive filtering and visualization.

## Documented Scope And Rules

producer_synth.py -> WebSocket server.py -> streamlit_app.py. Raw upstream signal stays separate from viewer processing. The relay forwards messages and may drop them when viewers lag; this is not a lossless transport guarantee. Streamlit is an inspection UI, not a hard real-time oscilloscope.

## Sources

Source checkout ID: `synth-mvp`. Entry points: readme.md and the three Python files above.

## Completion

Recover launch behavior and active objectives before choosing changes. Relationship to semantic-stream is a possible reference, not a dependency.