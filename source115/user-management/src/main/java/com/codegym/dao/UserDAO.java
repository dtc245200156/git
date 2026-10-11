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
                    + ") ENGINE=InnoDB";
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
    /**
     * Hiển thị/tìm kiếm danh sách User thông qua stored procedure get_all_users.
     */
    @Override
    public List<User> selectUsers(String country, String sortOrder) throws SQLException {
        String sql = "{CALL get_all_users(?, ?)}";
        String normalizedCountry = country == null ? "" : country.trim();
        String normalizedSortOrder = "desc".equalsIgnoreCase(sortOrder) ? "desc" : "asc";
        List<User> users = new ArrayList<>();

        try (Connection connection = getConnection();
             CallableStatement callableStatement = connection.prepareCall(sql)) {
            callableStatement.setString(1, normalizedCountry);
            callableStatement.setString(2, normalizedSortOrder);
            try (ResultSet resultSet = callableStatement.executeQuery()) {
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

    /**
     * Cập nhật thông tin User bằng stored procedure update_user.
     */
    @Override
    public boolean updateUser(User user) throws SQLException {
        String sql = "{CALL update_user(?, ?, ?, ?)}";
        try (Connection connection = getConnection();
             CallableStatement callableStatement = connection.prepareCall(sql)) {
            callableStatement.setInt(1, user.getId());
            callableStatement.setString(2, user.getName());
            callableStatement.setString(3, user.getEmail());
            callableStatement.setString(4, user.getCountry());
            return callableStatement.executeUpdate() > 0;
        }
    }

    /**
     * Xóa User bằng stored procedure delete_user.
     */
    @Override
    public boolean deleteUser(int id) throws SQLException {
        String sql = "{CALL delete_user(?)}";
        try (Connection connection = getConnection();
             CallableStatement callableStatement = connection.prepareCall(sql)) {
            callableStatement.setInt(1, id);
            return callableStatement.executeUpdate() > 0;
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


    /**
     * Demonstrates all-or-nothing behavior with a JDBC transaction.
     * The UPDATE intentionally leaves parameter 1 unset for the first test.
     * To run the success case, change setBigDecimal(2, ...) to setBigDecimal(1, ...).
     */
    @Override
    public void insertUpdateUseTransaction() throws SQLException {
        try (Connection connection = getConnection()) {
            // DDL is done before the transaction begins; MySQL DDL implicitly commits.
            try (java.sql.Statement statement = connection.createStatement()) {
                statement.execute(SQL_DROP_EMPLOYEE_TABLE);
                statement.execute(SQL_CREATE_EMPLOYEE_TABLE);
            }

            boolean originalAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);

            try {
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

                    // INTENTIONALLY WRONG for the first run: UPDATE parameter 1 is not set.
                    // To test a successful transaction, use setBigDecimal(1, new BigDecimal("999.99")).
                    psUpdate.setBigDecimal(2, new java.math.BigDecimal("999.99"));
                    psUpdate.setString(2, "Quynh");
                    psUpdate.executeUpdate();
                }

                // This line is reached only if every SQL statement succeeds.
                connection.commit();
                System.out.println("Transaction committed successfully.");
            } catch (SQLException exception) {
                try {
                    connection.rollback();
                    System.out.println("Lỗi SQL; transaction đã rollback.");
                } catch (SQLException rollbackException) {
                    exception.addSuppressed(rollbackException);
                }
                throw exception;
            } finally {
                try {
                    connection.setAutoCommit(originalAutoCommit);
                } catch (SQLException restoreException) {
                    // The connection will be closed by try-with-resources.
                }
            }
        }
    }

}