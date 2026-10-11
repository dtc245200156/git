package com.codegym.dao;

import com.codegym.model.User;

import java.sql.CallableStatement;
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
    private static final String SQL_INSERT_EMPLOYEE =
            "INSERT INTO Employee (name, salary, created_Date) VALUES (?, ?, ?)";
    private static final String SQL_UPDATE_EMPLOYEE =
            "UPDATE Employee SET salary=? WHERE name=?";
    private static final String SQL_CREATE_EMPLOYEE_TABLE =
            "CREATE TABLE Employee ("
                    + "id INT(11) AUTO_INCREMENT,"
                    + "name VARCHAR(100) NOT NULL,"
                    + "salary DECIMAL(15, 2) NOT NULL,"
                    + "created_Date TIMESTAMP,"
                    + "PRIMARY KEY (id)"
                    + ")";
    private static final String SQL_DROP_EMPLOYEE_TABLE = "DROP TABLE IF EXISTS Employee";

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


    /**
     * Thêm User và toàn bộ các quyền được chọn bằng một JDBC transaction.
     * Bất kỳ lỗi SQL nào sẽ rollback cả User lẫn các bản ghi user_permission.
     */
    @Override
    public void addUserTransaction(User user, int[] permissionIds) throws SQLException {
        String insertUserSql = "INSERT INTO users (name, email, country) VALUES (?, ?, ?)";
        String insertPermissionSql =
                "INSERT INTO user_permission (user_id, permission_id) VALUES (?, ?)";

        try (Connection connection = getConnection()) {
            boolean originalAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);

            try {
                int userId;
                try (PreparedStatement userStatement = connection.prepareStatement(
                        insertUserSql, java.sql.Statement.RETURN_GENERATED_KEYS)) {
                    userStatement.setString(1, user.getName());
                    userStatement.setString(2, user.getEmail());
                    userStatement.setString(3, user.getCountry());

                    int affectedRows = userStatement.executeUpdate();
                    if (affectedRows != 1) {
                        throw new SQLException("Không thể thêm User.");
                    }

                    try (ResultSet generatedKeys = userStatement.getGeneratedKeys()) {
                        if (!generatedKeys.next()) {
                            throw new SQLException("Không lấy được ID của User vừa tạo.");
                        }
                        userId = generatedKeys.getInt(1);
                    }
                }

                if (permissionIds != null && permissionIds.length > 0) {
                    try (PreparedStatement permissionStatement =
                                 connection.prepareStatement(insertPermissionSql)) {
                        for (int permissionId : permissionIds) {
                            permissionStatement.setInt(1, userId);
                            permissionStatement.setInt(2, permissionId);
                            permissionStatement.addBatch();
                        }
                        permissionStatement.executeBatch();
                    }
                }

                connection.commit();
            } catch (SQLException exception) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackException) {
                    exception.addSuppressed(rollbackException);
                }
                throw exception;
            } finally {
                try {
                    connection.setAutoCommit(originalAutoCommit);
                } catch (SQLException restoreException) {
                    // Connection sẽ được đóng khi thoát khỏi try-with-resources.
                }
            }
        }
    }


    /**
     * Demonstrates the default JDBC auto-commit behavior.
     *
     * Two Employee rows are inserted successfully. The UPDATE then fails
     * because parameter 1 (salary) is intentionally left unset. Since the
     * inserts have already been auto-committed, they remain in the table.
     */
    @Override
    public void insertUpdateWithoutTransaction() {
        try (Connection connection = getConnection()) {
            // Make the intended behavior explicit: each successful SQL statement
            // is committed automatically; this demo does not call commit/rollback.
            connection.setAutoCommit(true);

            // Keep DDL separate from prepared DML statements so the table can
            // be dropped/recreated before preparing statements against it.
            try (java.sql.Statement statement = connection.createStatement()) {
                statement.execute(SQL_DROP_EMPLOYEE_TABLE);
                statement.execute(SQL_CREATE_EMPLOYEE_TABLE);
            }

            // Auto-commit remains enabled: each successful INSERT is committed.
            try (PreparedStatement psInsert = connection.prepareStatement(SQL_INSERT_EMPLOYEE);
                 PreparedStatement psUpdate = connection.prepareStatement(SQL_UPDATE_EMPLOYEE)) {

                psInsert.setString(1, "Quynh");
                psInsert.setBigDecimal(2, new java.math.BigDecimal("10"));
                psInsert.setTimestamp(3, java.sql.Timestamp.valueOf(java.time.LocalDateTime.now()));
                psInsert.executeUpdate();

                psInsert.setString(1, "Ngan");
                psInsert.setBigDecimal(2, new java.math.BigDecimal("20"));
                psInsert.setTimestamp(3, java.sql.Timestamp.valueOf(java.time.LocalDateTime.now()));
                psInsert.executeUpdate();

                // INTENTIONALLY WRONG: the UPDATE's parameter 1 is not set.
                // The correct line would be psUpdate.setBigDecimal(1, new BigDecimal("999.99"));
                psUpdate.setBigDecimal(2, new java.math.BigDecimal("999.99"));
                psUpdate.setString(2, "Quynh");
                psUpdate.executeUpdate();
            }
        } catch (SQLException exception) {
            System.out.println("Đã bắt được lỗi trong quá trình thực thi SQL:");
            exception.printStackTrace();
            System.out.println("Các INSERT đã thành công trước đó vẫn còn do auto-commit đang bật.");
        }
    }

}