package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DiscountServlet", urlPatterns = {"/display-discount"})
public class DiscountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String productDescription = request.getParameter("productDescription");

        try (PrintWriter out = response.getWriter()) {
            double listPrice = Double.parseDouble(request.getParameter("listPrice"));
            double discountPercent = Double.parseDouble(request.getParameter("discountPercent"));

            double discountAmount = listPrice * discountPercent * 0.01;
            double discountPrice = listPrice - discountAmount;

            out.println("<!DOCTYPE html>");
            out.println("<html lang='en'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1'>");
            out.println("<title>Discount Result</title>");
            out.println("<style>");
            out.println("*{box-sizing:border-box}");
            out.println("body{margin:0;padding:70px 20px;background:#f4f7fb;font-family:Arial,sans-serif;color:#1f2937}");
            out.println(".result{width:min(100%,600px);margin:auto;background:#fff;padding:35px;border-radius:12px;box-shadow:0 8px 24px rgba(0,0,0,.10)}");
            out.println("h1{text-align:center;color:#1b2a7a;margin-top:0}");
            out.println(".row{display:flex;justify-content:space-between;gap:20px;padding:12px 0;border-bottom:1px solid #e5e7eb}");
            out.println(".label{font-weight:bold;color:#475569}.value{text-align:right}");
            out.println(".total{margin-top:18px;font-size:22px;font-weight:bold;color:#15803d}");
            out.println(".actions{text-align:center;margin-top:28px}");
            out.println("a{display:inline-block;padding:11px 20px;background:#1b2a7a;color:#fff;text-decoration:none;border-radius:6px}");
            out.println("@media(max-width:480px){.row{flex-direction:column;gap:4px}.value{text-align:left}}");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<main class='result'>");
            out.println("<h1>Discount Result</h1>");

            out.println("<div class='row'><span class='label'>Product Description</span><span class='value'>"
                    + escapeHtml(productDescription) + "</span></div>");
            out.println("<div class='row'><span class='label'>List Price</span><span class='value'>"
                    + String.format("%.2f", listPrice) + "</span></div>");
            out.println("<div class='row'><span class='label'>Discount Percent</span><span class='value'>"
                    + String.format("%.2f%%", discountPercent) + "</span></div>");
            out.println("<div class='row'><span class='label'>Discount Amount</span><span class='value'>"
                    + String.format("%.2f", discountAmount) + "</span></div>");
            out.println("<div class='total'>Discount Price: " + String.format("%.2f", discountPrice) + "</div>");

            out.println("<div class='actions'><a href='index.jsp'>Back to Calculator</a></div>");
            out.println("</main>");
            out.println("</body>");
            out.println("</html>");

        } catch (NumberFormatException e) {
            try (PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html lang='en'><head><meta charset='UTF-8'><title>Input Error</title></head>");
                out.println("<body style='font-family:Arial;text-align:center;padding-top:100px;background:#f4f7fb;'>");
                out.println("<h2 style='color:#dc2626;'>Please enter valid numeric values.</h2>");
                out.println("<a href='index.jsp'>Back to Calculator</a>");
                out.println("</body></html>");
            }
        }
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
}