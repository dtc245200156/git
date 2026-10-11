package com.codegym.dao;

import com.codegym.model.User;
import java.sql.SQLException;
import java.util.List;

/**
 * Các thao tác CRUD và truy vấn danh sách User.
 */
public interface IUserDAO {
    List<User> selectUsers(String country, String sortOrder) throws SQLException;

    User selectUserById(int id) throws SQLException;

    boolean insertUser(User user) throws SQLException;

    boolean updateUser(User user) throws SQLException;

    boolean deleteUser(int id) throws SQLException;
}