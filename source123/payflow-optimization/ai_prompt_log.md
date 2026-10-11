# AI Prompt Log — PayFlow Query Tuning

## 1. Why can YEAR(created_at) and MONTH(created_at) prevent index range access?
**Prompt:** In MySQL, if I add an index to a datetime column but filter it with `YEAR(created_at) = 2026`, why may the index not be used efficiently?

**Summary:** The condition transforms the indexed column before comparison, so the optimizer usually cannot seek directly to a B-tree interval for the original datetime values. Express the month as a half-open range instead: `created_at >= '2026-06-01' AND created_at < '2026-07-01'`.

## 2. Does composite-index column order matter?
**Prompt:** For an index on `(transaction_type, created_at)`, why is the order important?

**Summary:** A composite B-tree index follows its leftmost prefix. This query has equality on `transaction_type` and a range on `created_at`, so `(transaction_type, created_at)` matches the filter pattern and can use both parts. Validate selectivity and real plans because the optimizer may choose another access method for some data distributions.

## 3. How should EXPLAIN fields be read?
**Prompt:** Explain `type`, `possible_keys`, `key`, `rows`, and `Extra`.

**Summary:** `type` describes table access (`ALL` is a full scan; `range` reads index intervals). `possible_keys` lists candidate indexes, `key` identifies the chosen index, `rows` is an estimate of rows examined, and `Extra` gives additional plan details such as index condition or filtering. Compare before/after on representative data; a lower estimate is not itself a measured execution time.

## 4. How can actual execution time be measured?
**Prompt:** Is `SET profiling = 1` still preferred, or is there a better way?

**Summary:** In current MySQL 8.x documentation, statement profiling is deprecated. For supported SELECT statements, `EXPLAIN ANALYZE` executes the query and reports actual iterator time/rows; use carefully on a large production table. Performance Schema is appropriate for broader workload monitoring.

## 5. What are the trade-offs of adding indexes?
**Prompt:** What risk comes from adding many indexes to a table that receives frequent INSERT/UPDATE/DELETE operations?

**Summary:** Each index consumes disk and memory and must be maintained when indexed values or rows change, increasing write work. Add indexes for demonstrated workloads, review plans, and remove redundant/unused indexes only after operational validation.
