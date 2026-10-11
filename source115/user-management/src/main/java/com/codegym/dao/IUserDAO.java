package com.codegym.dao;

import com.codegym.model.User;
import java.sql.SQLException;
import java.util.List;

/**
 * Hợp đồng truy cập dữ liệu User.
 * Các chức năng hiển thị danh sách, cập nhật và xóa được triển khai
 * bằng MySQL Stored Procedures trong UserDAO.
 */
public interface IUserDAO {
    List<User> selectUsers(String country, String sortOrder) throws SQLException;

    User selectUserById(int id) throws SQLException;

    boolean insertUser(User user) throws SQLException;

    boolean updateUser(User user) throws SQLException;

    boolean deleteUser(int id) throws SQLException;

    User getUserById(int id) throws SQLException;

    void insertUserStore(User user) throws SQLException;

    void addUserTransaction(User user, int[] permissionIds) throws SQLException;

    void insertUpdateWithoutTransaction() throws SQLException;

    void insertUpdateUseTransaction() throws SQLException;
}