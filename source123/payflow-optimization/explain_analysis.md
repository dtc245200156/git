# EXPLAIN Analysis — PayFlow

The legacy condition applies `YEAR()` and `MONTH()` to `created_at`, so the date predicate is non-SARGable and cannot directly use a B-tree range on that column. On an unindexed table, the expected access type is `ALL`, with `rows` estimating a scan approaching the table size. The revised index is `(transaction_type, created_at)`: MySQL can match the equality on transaction type and then seek the date interval. The SARGable half-open range (`>= 2026-06-01` and `< 2026-07-01`) should allow `range` access and show `idx_type_date` in `key` when the optimizer judges it cheaper.

`rows` is an optimizer estimate, not a guaranteed actual count. The exact `type`, `key`, `Extra`, and estimated rows must be captured from the target database with representative data; this package does not claim to have measured a five-million-row table. An index reduces reads but adds storage and write-maintenance cost.
