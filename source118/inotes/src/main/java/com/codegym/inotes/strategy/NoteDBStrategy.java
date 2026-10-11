package com.codegym.inotes.strategy;

import com.codegym.inotes.model.Note;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * MySQL/JDBC persistence strategy.
 */
public class NoteDBStrategy implements NoteStrategy {
    private static final String DEFAULT_URL =
            "jdbc:mysql://localhost:3306/inotes_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8";

    private Connection getConnection() throws SQLException {
        String url = envOrDefault("INOTES_DB_URL", DEFAULT_URL);
        String user = envOrDefault("INOTES_DB_USER", "root");
        String password = envOrDefault("INOTES_DB_PASSWORD", "");
        return DriverManager.getConnection(url, user, password);
    }

    private String envOrDefault(String key, String fallback) {
        String value = System.getenv(key);
        return value == null ? fallback : value;
    }

    @Override
    public void save(Note note) throws SQLException {
        if (note.getId() <= 0) {
            String sql = "INSERT INTO notes(title, content, type_id) VALUES (?, ?, ?)";
            try (Connection connection = getConnection();
                 PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                bindNote(statement, note);
                if (statement.executeUpdate() != 1) {
                    throw new SQLException("Không thể lưu ghi chú.");
                }
                try (ResultSet keys = statement.getGeneratedKeys()) {
                    if (keys.next()) {
                        note.setId(keys.getInt(1));
                    } else {
                        throw new SQLException("Không lấy được ID của ghi chú mới.");
                    }
                }
            }
        } else {
            String sql = "UPDATE notes SET title = ?, content = ?, type_id = ? WHERE id = ?";
            try (Connection connection = getConnection();
                 PreparedStatement statement = connection.prepareStatement(sql)) {
                bindNote(statement, note);
                statement.setInt(4, note.getId());
                int affectedRows = statement.executeUpdate();
                if (affectedRows == 0) {
                    // MySQL may report zero changed rows when the submitted values
                    // are identical to existing values, so distinguish that from a missing ID.
                    try (PreparedStatement check = connection.prepareStatement(
                            "SELECT 1 FROM notes WHERE id = ?")) {
                        check.setInt(1, note.getId());
                        try (ResultSet existing = check.executeQuery()) {
                            if (!existing.next()) {
                                throw new SQLException("Không tìm thấy ghi chú có ID " + note.getId());
                            }
                        }
                    }
                }
            }
        }
    }

    private void bindNote(PreparedStatement statement, Note note) throws SQLException {
        statement.setString(1, note.getTitle());
        statement.setString(2, note.getContent());
        statement.setInt(3, note.getTypeId());
    }

    @Override
    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM notes WHERE id = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
        }
    }

    @Override
    public List<Note> findAll() throws SQLException {
        String sql = "SELECT n.id, n.title, n.content, n.type_id, t.name AS type_name "
                + "FROM notes n JOIN note_type t ON t.id = n.type_id ORDER BY n.id DESC";
        List<Note> notes = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                notes.add(mapRow(resultSet));
            }
        }
        return notes;
    }

    @Override
    public List<Note> search(String keyword) throws SQLException {
        String term = keyword == null ? "" : keyword.trim();
        if (term.isEmpty()) {
            return findAll();
        }

        String sql = "SELECT n.id, n.title, n.content, n.type_id, t.name AS type_name "
                + "FROM notes n JOIN note_type t ON t.id = n.type_id "
                + "WHERE LOWER(n.title) LIKE LOWER(?) OR LOWER(n.content) LIKE LOWER(?) "
                + "ORDER BY n.id DESC";
        List<Note> notes = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            String pattern = "%" + term + "%";
            statement.setString(1, pattern);
            statement.setString(2, pattern);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    notes.add(mapRow(resultSet));
                }
            }
        }
        return notes;
    }

    @Override
    public Note findById(int id) throws SQLException {
        String sql = "SELECT n.id, n.title, n.content, n.type_id, t.name AS type_name "
                + "FROM notes n JOIN note_type t ON t.id = n.type_id WHERE n.id = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next() ? mapRow(resultSet) : null;
            }
        }
    }

    private Note mapRow(ResultSet resultSet) throws SQLException {
        Note note = new Note(
                resultSet.getInt("id"),
                resultSet.getString("title"),
                resultSet.getString("content"),
                resultSet.getInt("type_id"));
        note.setTypeName(resultSet.getString("type_name"));
        return note;
    }

    @Override
    public String getName() {
        return "db";
    }
}