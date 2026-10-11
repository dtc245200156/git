-- PAYFLOW: QUERY TUNING DEMO (MySQL 8.x)
-- Run on a staging/test database with representative data whenever possible.
-- Do not drop/recreate Transactions in production: the scenario describes a large live table.

CREATE DATABASE IF NOT EXISTS payflow_db;
USE payflow_db;

-- 1. Create table only if this is a new training database.
-- On the existing PayFlow database, keep the existing five-million-row table.
CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(15,2),
    transaction_type VARCHAR(20), -- DEPOSIT, WITHDRAW, TRANSFER
    created_at DATETIME
) ENGINE=InnoDB;

-- ============================================================
-- A. LEGACY / NON-SARGABLE QUERY
-- Run/capture this EXPLAIN BEFORE creating idx_type_date if you
-- need a clean before/after comparison on an unindexed table.
-- Wrapping created_at in YEAR()/MONTH() prevents a direct range
-- lookup on created_at. Without a useful index, expect a table scan.
-- ============================================================
EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND YEAR(created_at) = 2026
  AND MONTH(created_at) = 6;

-- ============================================================
-- B. INDEX DESIGN
-- Equality predicate first, then date range predicate. This order
-- matches this query's predicates and lets MySQL use both key parts.
-- Run once; if the index already exists, skip this CREATE INDEX.
-- ============================================================
CREATE INDEX idx_type_date
    ON Transactions (transaction_type, created_at);

ANALYZE TABLE Transactions;

-- ============================================================
-- C. OPTIMIZED / SARGABLE QUERY
-- Half-open interval includes all June times and avoids including
-- midnight on July 1. No function is applied to created_at.
-- Expect idx_type_date and a range access when it is cost-effective;
-- actual EXPLAIN output depends on row counts and optimizer statistics.
-- ============================================================
EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at <  '2026-07-01 00:00:00';

-- The actual optimized result (do not prefix with EXPLAIN):
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at <  '2026-07-01 00:00:00';

-- Optional: on MySQL 8.0.18+, EXPLAIN ANALYZE executes the SELECT and
-- reports actual iterator timings/rows as well as plan information.
-- Use carefully on production-sized data; it really runs the query.
-- EXPLAIN ANALYZE
-- SELECT SUM(amount) AS total_deposit
-- FROM Transactions
-- WHERE transaction_type = 'DEPOSIT'
--   AND created_at >= '2026-06-01 00:00:00'
--   AND created_at <  '2026-07-01 00:00:00';

-- Note: SET profiling / SHOW PROFILE are deprecated in current MySQL 8.x.
-- Prefer EXPLAIN ANALYZE for actual statement execution details, or the
-- Performance Schema for workload-level monitoring.
