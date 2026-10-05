package com.codegym.servlet;

import com.codegym.model.Calculator;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CalculatorServlet", urlPatterns = {"/calculate"})
public class CalculatorServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String firstOperandParam = request.getParameter("first-operand");
        String secondOperandParam = request.getParameter("second-operand");
        String operatorParam = request.getParameter("operator");

        try (PrintWriter writer = response.getWriter()) {
            double firstOperand = Double.parseDouble(firstOperandParam);
            double secondOperand = Double.parseDouble(secondOperandParam);
            char operator = operatorParam.charAt(0);

            writer.println("<!DOCTYPE html>");
            writer.println("<html lang='vi'>");
            writer.println("<head>");
            writer.println("<meta charset='UTF-8'>");
            writer.println("<meta name='viewport' content='width=device-width, initial-scale=1'>");
            writer.println("<title>Calculator Result</title>");
            writer.println("<style>");
            writer.println("body{font-family:Arial,sans-serif;background:#f8fafc;text-align:center;padding:80px 20px;color:#1e293b}");
            writer.println(".result{width:min(100%,560px);margin:auto;background:#fff;padding:36px;border-radius:12px;box-shadow:0 8px 24px rgba(0,0,0,.1)}");
            writer.println("h1{color:#1b2a7a}.equation{font-size:28px;margin:24px 0;color:#0f172a}");
            writer.println(".error{color:#c0392b;font-weight:bold;font-size:22px;margin:24px 0}");
            writer.println("a{display:inline-block;padding:10px 20px;background:#1b2a7a;color:#fff;text-decoration:none;border-radius:5px}");
            writer.println("</style>");
            writer.println("</head><body><main class='result'>");
            writer.println("<h1>Calculator Result</h1>");

            try {
                double result = Calculator.calculate(firstOperand, secondOperand, operator);
                writer.println("<div class='equation'>");
                writer.println(format(firstOperand) + " " + operator + " " + format(secondOperand)
                        + " = <strong>" + format(result) + "</strong>");
                writer.println("</div>");
            } catch (ArithmeticException | IllegalArgumentException ex) {
                writer.println("<div class='error'>Error: " + escapeHtml(ex.getMessage()) + "</div>");
            }

            writer.println("<a href='index.jsp'>Back to Calculator</a>");
            writer.println("</main></body></html>");
        } catch (Exception ex) {
            response.sendRedirect("index.jsp");
        }
    }

    private String format(double value) {
        if (value == Math.rint(value)) {
            return String.format("%.0f", value);
        }
        return String.format("%.4f", value).replaceAll("0+$", "").replaceAll("\\.$", "");
    }

    private String escapeHtml(String text) {
        if (text == null) {
            return "";
        }
        return text.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace(""", "&quot;")
                .replace("'", "&#39;");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }
}
