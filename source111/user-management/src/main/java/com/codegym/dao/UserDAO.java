package com.codegym.dao;

import com.codegym.model.User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO truy cập MySQL bằng JDBC.
 *
 * Có thể cấu hình kết nối bằng các biến môi trường DB_URL, DB_USER và DB_PASSWORD.
 * Giá trị mặc định hướng đến MySQL cục bộ với database demo.
 */
public class UserDAO implements IUserDAO {
    private static final String DEFAULT_URL =
            "jdbc:mysql://localhost:3306/demo?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8";

    private final String jdbcUrl = envOrDefault("DB_URL", DEFAULT_URL);
    private final String dbUser = envOrDefault("DB_USER", "root");
    private final String dbPassword = envOrDefault("DB_PASSWORD", "");

    private static String envOrDefault(String key, String fallback) {
        String value = System.getenv(key);
        return value == null ? fallback : value;
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
    }

    /**
     * Tìm kiếm country theo chuỗi con và sắp xếp tên tăng/giảm dần.
     * Sort direction chỉ được nhận ASC hoặc DESC để tránh chèn SQL tùy ý.
     */
    @Override
    public List<User> selectUsers(String country, String sortOrder) throws SQLException {
        String normalizedCountry = country == null ? "" : country.trim();
        String direction = "desc".equalsIgnoreCase(sortOrder) ? "DESC" : "ASC";

        StringBuilder sql = new StringBuilder(
                "SELECT id, name, email, country FROM users");
        if (!normalizedCountry.isEmpty()) {
            sql.append(" WHERE country LIKE ?");
        }
        sql.append(" ORDER BY name ").append(direction).append(", id ASC");

        List<User> users = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql.toString())) {
            if (!normalizedCountry.isEmpty()) {
                statement.setString(1, "%" + normalizedCountry + "%");
            }
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    users.add(mapRow(resultSet));
                }
            }
        }
        return users;
    }

    @Override
    public User selectUserById(int id) throws SQLException {
        String sql = "SELECT id, name, email, country FROM users WHERE id = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next() ? mapRow(resultSet) : null;
            }
        }
    }

    @Override
    public boolean insertUser(User user) throws SQLException {
        String sql = "INSERT INTO users (name, email, country) VALUES (?, ?, ?)";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            bindUser(statement, user);
            return statement.executeUpdate() > 0;
        }
    }

    @Override
    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE users SET name = ?, email = ?, country = ? WHERE id = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            bindUser(statement, user);
            statement.setInt(4, user.getId());
            return statement.executeUpdate() > 0;
        }
    }

    @Override
    public boolean deleteUser(int id) throws SQLException {
        String sql = "DELETE FROM users WHERE id = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
        }
    }

    private void bindUser(PreparedStatement statement, User user) throws SQLException {
        statement.setString(1, user.getName());
        statement.setString(2, user.getEmail());
        statement.setString(3, user.getCountry());
    }

    private User mapRow(ResultSet resultSet) throws SQLException {
        return new User(
                resultSet.getInt("id"),
                resultSet.getString("name"),
                resultSet.getString("email"),
                resultSet.getString("country")
        );
    }

    /**
     * Gọi stored procedure get_user_by_id để lấy User theo ID.
     */
    @Override
    public User getUserById(int id) throws SQLException {
        String sql = "{CALL get_user_by_id(?)}";
        try (Connection connection = getConnection();
             CallableStatement callableStatement = connection.prepareCall(sql)) {
            callableStatement.setInt(1, id);
            try (ResultSet resultSet = callableStatement.executeQuery()) {
                if (resultSet.next()) {
                    return new User(
                            id,
                            resultSet.getString("name"),
                            resultSet.getString("email"),
                            resultSet.getString("country")
                    );
                }
                return null;
            }
        }
    }

    /**
     * Gọi stored procedure insert_user để thêm User mới.
     */
    @Override
    public void insertUserStore(User user) throws SQLException {
        String sql = "{CALL insert_user(?, ?, ?)}";
        try (Connection connection = getConnection();
             CallableStatement callableStatement = connection.prepareCall(sql)) {
            callableStatement.setString(1, user.getName());
            callableStatement.setString(2, user.getEmail());
            callableStatement.setString(3, user.getCountry());
            callableStatement.executeUpdate();
        }
    }

}