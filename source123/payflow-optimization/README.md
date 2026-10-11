# PayFlow — MySQL EXPLAIN & Index Optimization

Submission files:
- `payflow_optimized.sql` — table definition for a new lab database, legacy EXPLAIN, composite index, optimized EXPLAIN, and optimized SUM query.
- `explain_analysis.md` — concise before/after plan analysis (under 200 words).
- `ai_prompt_log.md` — technical JOIN/index/SARGable/EXPLAIN discussion log.

## How to run
1. Open `payflow_optimized.sql` in MySQL Workbench connected to a test/staging database.
2. If the existing `Transactions` table holds real data, do not drop it. The script uses `CREATE TABLE IF NOT EXISTS` to avoid replacing it.
3. Run the first EXPLAIN and record its output before adding the index; then run `CREATE INDEX`, `ANALYZE TABLE`, and the second EXPLAIN.
4. Compare `type`, `possible_keys`, `key`, `rows`, and `Extra`.

Important notes:
- The script's sample reporting interval is June 2026, matching the assignment's example.
- `CREATE INDEX` is intended to run once; skip it on reruns if `idx_type_date` already exists. To reproduce a baseline scan, capture the legacy EXPLAIN on a test copy before creating the index.
- Exact EXPLAIN estimates depend on data and statistics. No actual five-million-row execution plan or timing is fabricated here. Test with representative data to substantiate the comparison.
- Indexing can reduce read work, but it adds storage and maintenance cost for INSERT/UPDATE/DELETE workloads.
