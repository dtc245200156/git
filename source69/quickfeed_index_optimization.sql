USE quickfeed_db;

-- ========================================================
-- 1. ĐO STORAGE TRƯỚC KHI TỐI ƯU
-- ========================================================
SHOW TABLE STATUS LIKE 'Posts';

SELECT
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_size_mb,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_size_mb,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS total_size_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'Posts';

SHOW INDEX FROM Posts;

-- ========================================================
-- 2. KẾ HOẠCH INDEX
-- Giữ lại: idx_user_id, idx_created_at
-- Xóa:     idx_content, idx_post_type, idx_is_visible
-- ========================================================
ALTER TABLE Posts DROP INDEX idx_content;
ALTER TABLE Posts DROP INDEX idx_post_type;
ALTER TABLE Posts DROP INDEX idx_is_visible;

-- ========================================================
-- 3. ĐO STORAGE SAU KHI TỐI ƯU
-- ========================================================
SHOW TABLE STATUS LIKE 'Posts';

SELECT
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_size_mb,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_size_mb,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS total_size_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'Posts';

SHOW INDEX FROM Posts;

-- ========================================================
-- 4. DÙNG ĐỂ GHI LOG TRƯỚC/SAU SAU KHI CHẠY SCRIPT
-- Sao chép hai kết quả index_size_mb vào report.md.
-- ========================================================
-- Không tự động điền số liệu vì dung lượng phụ thuộc dữ liệu thật.
