package com.codegym.controller;

import com.codegym.dao.IUserDAO;
import com.codegym.dao.UserDAO;
import com.codegym.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;

/**
 * Controller điều phối các thao tác quản lý User và hiển thị JSP.
 */
@WebServlet(name = "UserServlet", urlPatterns = {"/users"})
public class UserServlet extends HttpServlet {
    private final IUserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = valueOrEmpty(request.getParameter("action"));

        try {
            if ("create".equals(action)) {
                request.getRequestDispatcher("/user/create.jsp").forward(request, response);
            } else if ("edit".equals(action)) {
                showExistingUser(request, response, "/user/edit.jsp");
            } else if ("delete".equals(action)) {
                showExistingUser(request, response, "/user/delete.jsp");
            } else if (action.isEmpty() || "list".equals(action)) {
                showUserList(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action không hợp lệ.");
            }
        } catch (IllegalArgumentException exception) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, exception.getMessage());
        } catch (SQLException exception) {
            throw new ServletException("Không thể truy vấn dữ liệu User.", exception);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = valueOrEmpty(request.getParameter("action"));

        try {
            switch (action) {
                case "create" -> {
                    userDAO.insertUserStore(readUser(request));
                    redirectWithMessage(request, response, "Đã thêm User.");
                }
                case "edit" -> {
                    User user = readUser(request);
                    user.setId(parseId(request.getParameter("id")));
                    if (userDAO.updateUser(user)) {
                        redirectWithMessage(request, response, "Đã cập nhật User.");
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy User.");
                    }
                }
                case "delete" -> {
                    int id = parseId(request.getParameter("id"));
                    if (userDAO.deleteUser(id)) {
                        redirectWithMessage(request, response, "Đã xóa User.");
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy User.");
                    }
                }
                default -> response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST, "Action không hợp lệ.");
            }
        } catch (IllegalArgumentException exception) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, exception.getMessage());
        } catch (SQLException exception) {
            throw new ServletException("Không thể cập nhật dữ liệu User.", exception);
        }
    }

    private void showUserList(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String country = valueOrEmpty(request.getParameter("country"));
        String sortOrder = "desc".equalsIgnoreCase(request.getParameter("sortOrder"))
                ? "desc" : "asc";

        request.setAttribute("country", country);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("users", userDAO.selectUsers(country, sortOrder));
        request.getRequestDispatcher("/user/list.jsp").forward(request, response);
    }

    private void showExistingUser(HttpServletRequest request, HttpServletResponse response, String view)
            throws SQLException, ServletException, IOException {
        int id = parseId(request.getParameter("id"));
        User user = userDAO.getUserById(id);
        if (user == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy User.");
            return;
        }
        request.setAttribute("user", user);
        request.getRequestDispatcher(view).forward(request, response);
    }

    private User readUser(HttpServletRequest request) {
        String name = valueOrEmpty(request.getParameter("name")).trim();
        String email = valueOrEmpty(request.getParameter("email")).trim();
        String country = valueOrEmpty(request.getParameter("country")).trim();

        if (name.isEmpty() || email.isEmpty()) {
            throw new IllegalArgumentException("Name và Email không được để trống.");
        }
        return new User(name, email, country);
    }

    private int parseId(String value) {
        try {
            int id = Integer.parseInt(value);
            if (id <= 0) {
                throw new NumberFormatException("ID must be positive");
            }
            return id;
        } catch (NumberFormatException exception) {
            throw new IllegalArgumentException("ID không hợp lệ.");
        }
    }

    private String valueOrEmpty(String value) {
        return value == null ? "" : value;
    }

    private void redirectWithMessage(HttpServletRequest request, HttpServletResponse response, String message)
            throws IOException {
        String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8);
        response.sendRedirect(request.getContextPath() + "/users?message=" + encodedMessage);
    }
}