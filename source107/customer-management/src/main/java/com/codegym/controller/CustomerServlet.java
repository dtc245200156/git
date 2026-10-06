package com.codegym.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Controller trung tâm cho các thao tác quản lý khách hàng.
 * Khung Servlet chỉ khai báo endpoint và chữ ký doGet/doPost.
 */
@WebServlet(name = "CustomerServlet", urlPatterns = {"/customers"})
public class CustomerServlet extends HttpServlet {

    /**
     * Xử lý các request GET.
     * TODO: Học viên triển khai điều hướng list/create/edit/delete/view.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * Xử lý các request POST.
     * TODO: Học viên triển khai create/edit/delete.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}