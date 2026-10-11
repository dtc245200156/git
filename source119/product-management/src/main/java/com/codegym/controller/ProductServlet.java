package com.codegym.controller;

import com.codegym.dao.ProductDAO;
import com.codegym.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

/** MVC controller for listing, creating, updating and deleting products. */
@WebServlet(name = "ProductServlet", urlPatterns = {"/products"})
public class ProductServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = valueOrEmpty(request.getParameter("action"));
        try {
            if ("create".equals(action)) {
                request.setAttribute("product", new Product());
                request.setAttribute("editing", false);
                request.getRequestDispatcher("/WEB-INF/views/product-form.jsp").forward(request, response);
            } else if ("edit".equals(action)) {
                Product product = productDAO.findById(parseId(request.getParameter("id")));
                if (product == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy sản phẩm.");
                    return;
                }
                request.setAttribute("product", product);
                request.setAttribute("editing", true);
                request.getRequestDispatcher("/WEB-INF/views/product-form.jsp").forward(request, response);
            } else {
                request.setAttribute("products", productDAO.findAll());
                HttpSession session = request.getSession();
                request.setAttribute("flashMessage", session.getAttribute("flashMessage"));
                request.setAttribute("flashType", session.getAttribute("flashType"));
                session.removeAttribute("flashMessage");
                session.removeAttribute("flashType");
                request.getRequestDispatcher("/WEB-INF/views/product-list.jsp").forward(request, response);
            }
        } catch (IllegalArgumentException exception) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, exception.getMessage());
        } catch (SQLException exception) {
            throw new ServletException("Không thể truy cập dữ liệu sản phẩm. Hãy kiểm tra cấu hình MySQL.", exception);
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
                    Product product = readProduct(request);
                    productDAO.insert(product);
                    flash(request, "Đã thêm sản phẩm thành công.", "success");
                    redirectToList(request, response);
                }
                case "update" -> {
                    int id = parseId(request.getParameter("id"));
                    Product product = readProduct(request);
                    product.setId(id);
                    if (!productDAO.update(product)) {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy sản phẩm cần cập nhật.");
                        return;
                    }
                    flash(request, "Đã cập nhật sản phẩm thành công.", "success");
                    redirectToList(request, response);
                }
                case "delete" -> {
                    int id = parseId(request.getParameter("id"));
                    if (productDAO.delete(id)) {
                        flash(request, "Đã xóa sản phẩm.", "success");
                    } else {
                        flash(request, "Sản phẩm không tồn tại hoặc đã được xóa.", "warning");
                    }
                    redirectToList(request, response);
                }
                default -> response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thao tác không hợp lệ.");
            }
        } catch (IllegalArgumentException exception) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, exception.getMessage());
        } catch (SQLException exception) {
            throw new ServletException("Không thể lưu thay đổi sản phẩm.", exception);
        }
    }

    private Product readProduct(HttpServletRequest request) {
        String name = valueOrEmpty(request.getParameter("name")).trim();
        if (name.isEmpty()) {
            throw new IllegalArgumentException("Tên sản phẩm không được để trống.");
        }
        if (name.length() > 150) {
            throw new IllegalArgumentException("Tên sản phẩm tối đa 150 ký tự.");
        }

        BigDecimal price;
        try {
            price = new BigDecimal(valueOrEmpty(request.getParameter("price")).trim());
        } catch (NumberFormatException exception) {
            throw new IllegalArgumentException("Giá sản phẩm không hợp lệ.");
        }
        if (price.compareTo(BigDecimal.ZERO) < 0 || price.scale() > 2) {
            throw new IllegalArgumentException("Giá phải không âm và tối đa 2 chữ số thập phân.");
        }
        if (price.precision() > 12) {
            throw new IllegalArgumentException("Giá sản phẩm vượt quá giới hạn cho phép.");
        }

        int quantity;
        try {
            quantity = Integer.parseInt(valueOrEmpty(request.getParameter("quantity")).trim());
        } catch (NumberFormatException exception) {
            throw new IllegalArgumentException("Số lượng phải là số nguyên hợp lệ.");
        }
        if (quantity < 0) {
            throw new IllegalArgumentException("Số lượng không được âm.");
        }
        return new Product(name, price, quantity);
    }

    private int parseId(String value) {
        try {
            int id = Integer.parseInt(value);
            if (id < 1) {
                throw new NumberFormatException();
            }
            return id;
        } catch (NumberFormatException exception) {
            throw new IllegalArgumentException("ID sản phẩm không hợp lệ.");
        }
    }

    private String valueOrEmpty(String value) {
        return value == null ? "" : value;
    }

    private void flash(HttpServletRequest request, String message, String type) {
        request.getSession().setAttribute("flashMessage", message);
        request.getSession().setAttribute("flashType", type);
    }

    private void redirectToList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() + "/products");
    }
}