package com.codegym.controller;

import com.codegym.model.Product;
import com.codegym.service.ProductService;
import com.codegym.service.ProductServiceImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ProductServlet", urlPatterns = {"/products"})
public class ProductServlet extends HttpServlet {
    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isBlank()) action = "list";

        switch (action) {
            case "create" -> forward(request, response, "/product/create.jsp");
            case "edit" -> showProductForm(request, response, "/product/edit.jsp");
            case "delete" -> showProductForm(request, response, "/product/delete.jsp");
            case "view" -> showProductForm(request, response, "/product/view.jsp");
            case "search" -> {
                String keyword = request.getParameter("keyword");
                request.setAttribute("keyword", keyword == null ? "" : keyword);
                request.setAttribute("products", productService.searchByName(keyword));
                forward(request, response, "/product/list.jsp");
            }
            default -> {
                request.setAttribute("products", productService.findAll());
                forward(request, response, "/product/list.jsp");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            switch (action == null ? "" : action) {
                case "create" -> createProduct(request, response);
                case "edit" -> updateProduct(request, response);
                case "delete" -> deleteProduct(request, response);
                default -> response.sendRedirect(request.getContextPath() + "/products");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/error-404.jsp");
        }
    }

    private void showProductForm(HttpServletRequest request, HttpServletResponse response, String view)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/error-404.jsp");
            return;
        }

        try {
            Product product = productService.findById(Integer.parseInt(idParam));
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/error-404.jsp");
                return;
            }
            request.setAttribute("product", product);
            forward(request, response, view);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/error-404.jsp");
        }
    }

    private void createProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = new Product(
                id,
                request.getParameter("name"),
                Double.parseDouble(request.getParameter("price")),
                request.getParameter("description"),
                request.getParameter("manufacturer")
        );
        productService.save(product);
        response.sendRedirect(request.getContextPath() + "/products");
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = new Product(
                id,
                request.getParameter("name"),
                Double.parseDouble(request.getParameter("price")),
                request.getParameter("description"),
                request.getParameter("manufacturer")
        );
        if (productService.findById(id) == null) {
            response.sendRedirect(request.getContextPath() + "/error-404.jsp");
            return;
        }
        productService.update(id, product);
        response.sendRedirect(request.getContextPath() + "/products?action=view&id=" + id);
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        productService.remove(id);
        response.sendRedirect(request.getContextPath() + "/products");
    }

    private void forward(HttpServletRequest request, HttpServletResponse response, String path)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
        dispatcher.forward(request, response);
    }
}