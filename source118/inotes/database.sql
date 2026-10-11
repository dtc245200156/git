CREATE DATABASE IF NOT EXISTS inotes_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE inotes_db;

CREATE TABLE IF NOT EXISTS note_type (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    PRIMARY KEY (id),
    UNIQUE KEY uk_note_type_name (name)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS notes (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    type_id INT NOT NULL,
    PRIMARY KEY (id),
    KEY idx_notes_type_id (type_id),
    CONSTRAINT fk_notes_note_type
        FOREIGN KEY (type_id) REFERENCES note_type(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

INSERT INTO note_type (id, name, description) VALUES
    (1, 'Cá nhân', 'Ghi chú cá nhân'),
    (2, 'Công việc', 'Công việc, cuộc họp và việc cần làm'),
    (3, 'Học tập', 'Bài học, tài liệu và nội dung ôn tập')
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    description = VALUES(description);

INSERT INTO notes (title, content, type_id)
SELECT 'Họp giao ban đầu tuần',
       'Chuẩn bị tiến độ dự án, các vướng mắc và việc cần xử lý.',
       2
WHERE NOT EXISTS (
    SELECT 1 FROM notes WHERE title = 'Họp giao ban đầu tuần'
);

INSERT INTO notes (title, content, type_id)
SELECT 'Ôn tập Design Pattern',
       'Ôn lại Strategy Pattern và cách tách phần lưu trữ dữ liệu khỏi business logic.',
       3
WHERE NOT EXISTS (
    SELECT 1 FROM notes WHERE title = 'Ôn tập Design Pattern'
);
