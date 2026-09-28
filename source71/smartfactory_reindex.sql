-- SMARTFACTORY - LEAN INDEX OPTIMIZATION
CREATE DATABASE IF NOT EXISTS smartfactory_db;
USE smartfactory_db;

-- ========================================================
-- 1. TẠO BẢNG VÀ MÔ PHỎNG LEGACY FAT INDEX
-- ========================================================
CREATE TABLE IF NOT EXISTS SensorLogs (
    log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sensor_id INT NOT NULL,
    recorded_at DATETIME NOT NULL,
    temperature DECIMAL(5,2),
    humidity DECIMAL(5,2),
    status VARCHAR(20)
);

-- Legacy covering index: phục vụ SELECT nhưng lưu quá nhiều cột.
CREATE INDEX idx_fat_covering
ON SensorLogs(sensor_id, recorded_at, temperature, humidity, status);

-- ========================================================
-- 2. ĐO STORAGE TRƯỚC KHI TỐI ƯU
-- ========================================================
SHOW TABLE STATUS LIKE 'SensorLogs';

SELECT
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_size_mb,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_size_mb,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS total_size_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'SensorLogs';

SHOW INDEX FROM SensorLogs;

-- ========================================================
-- 3. TRUY VẤN DASHBOARD VỚI FAT COVERING INDEX
-- ========================================================
EXPLAIN
SELECT temperature, humidity, status
FROM SensorLogs
WHERE sensor_id = 105
  AND recorded_at >= '2026-06-20';

-- ========================================================
-- 4. THAY THẾ FAT INDEX BẰNG LEAN INDEX
-- Chỉ giữ các cột phục vụ lọc trong WHERE.
-- ========================================================
ALTER TABLE SensorLogs DROP INDEX idx_fat_covering;

CREATE INDEX idx_lean_search
ON SensorLogs(sensor_id, recorded_at);

-- ========================================================
-- 5. ĐO STORAGE SAU KHI TỐI ƯU
-- ========================================================
SHOW TABLE STATUS LIKE 'SensorLogs';

SELECT
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_size_mb,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_size_mb,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS total_size_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'SensorLogs';

SHOW INDEX FROM SensorLogs;

-- ========================================================
-- 6. EXPLAIN SAU KHI DÙNG LEAN INDEX
-- Expected: key = idx_lean_search.
-- Extra không còn 'Using index' vì phải đọc các cột
-- temperature, humidity, status từ bảng gốc.
-- ========================================================
EXPLAIN
SELECT temperature, humidity, status
FROM SensorLogs
WHERE sensor_id = 105
  AND recorded_at >= '2026-06-20';

-- Gợi ý: với dữ liệu thực tế lớn, ghi lại INDEX_LENGTH
-- trước/sau vào index_tradeoff_report.md.
