# Realtime Sorter MVP

## Outcome

Per source README.md: demonstrate sub-second detection from a synthetic 128-channel acquisition stream.

## Documented Architecture And Rules

Synthetic Python producer -> Kafka raw_chunks -> Flink buffering/reordering -> Kafka ordered_chunks -> NumPy DSP -> detected_events. Flink does not own DSP; processing stays NumPy-native. These are documented intentions, not verified runtime results.

## Sources

Source checkout ID: `realtime-sorter-mvp`. Entry points: README.md, python/producer.py, python/worker_detect.py, docker-compose.yml.

## Completion

Reconcile actual implementation with the README, then verify one end-to-end run using the project's supported environment. Do not start containers merely to inventory context.