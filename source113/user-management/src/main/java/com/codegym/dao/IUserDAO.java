package com.codegym.dao;

import com.codegym.model.User;
import java.sql.SQLException;
import java.util.List;

/**
 * Hợp đồng truy cập dữ liệu User (DAO).
 * Bổ sung addUserTransaction để thêm User và các quyền trong một transaction.
 */
public interface IUserDAO {
    List<User> selectUsers(String country, String sortOrder) throws SQLException;

    User selectUserById(int id) throws SQLException;

    boolean insertUser(User user) throws SQLException;

    boolean updateUser(User user) throws SQLException;

    boolean deleteUser(int id) throws SQLException;

    User getUserById(int id) throws SQLException;

    void insertUserStore(User user) throws SQLException;

    /**
     * Thêm User và gán các permission được chọn trong cùng một transaction.
     * Nếu bất kỳ thao tác ghi nào thất bại, toàn bộ transaction sẽ rollback.
     */
    void addUserTransaction(User user, int[] permissionIds) throws SQLException;

    /**
     * Demonstrates JDBC auto-commit: inserts succeed before an intentionally
     * invalid UPDATE statement fails. This is a teaching/demo method only.
     */
    void insertUpdateWithoutTransaction() throws SQLException;

}