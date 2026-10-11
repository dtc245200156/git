package com.codegym.dao;

import com.codegym.model.User;
import java.sql.SQLException;
import java.util.List;

/**
 * Các thao tác CRUD và truy vấn danh sách User.
 * getUserById và insertUserStore sử dụng Stored Procedures trong MySQL.
 */
public interface IUserDAO {
    List<User> selectUsers(String country, String sortOrder) throws SQLException;

    User selectUserById(int id) throws SQLException;

    boolean insertUser(User user) throws SQLException;

    boolean updateUser(User user) throws SQLException;

    boolean deleteUser(int id) throws SQLException;

    /**
     * Tìm một User bằng stored procedure get_user_by_id.
     */
    User getUserById(int id) throws SQLException;

    /**
     * Thêm một User bằng stored procedure insert_user.
     */
    void insertUserStore(User user) throws SQLException;
}