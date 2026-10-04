package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ConverterServlet", urlPatterns = {"/convert"})
public class ConverterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            try {
                double rate = Double.parseDouble(request.getParameter("rate"));
                double usd = Double.parseDouble(request.getParameter("usd"));
                double vnd = rate * usd;

                out.println("<!DOCTYPE html>");
                out.println("<html lang='vi'>");
                out.println("<head>");
                out.println("<meta charset='UTF-8'>");
                out.println("<meta name='viewport' content='width=device-width, initial-scale=1'>");
                out.println("<title>Currency Result</title>");
                out.println("<style>");
                out.println("body{font-family:Arial,sans-serif;background:#f8fafc;text-align:center;padding-top:80px;color:#1e293b;}");
                out.println(".result{width:min(92%,500px);margin:auto;background:#fff;padding:35px;border-radius:12px;box-shadow:0 8px 24px rgba(0,0,0,.1);}");
                out.println("h2{color:#1b2a7a}.value{font-size:24px;color:#27ae60;font-weight:bold;margin:20px 0;}");
                out.println("a{display:inline-block;padding:10px 20px;background:#1b2a7a;color:#fff;text-decoration:none;border-radius:5px;}");
                out.println("</style>");
                out.println("</head>");
                out.println("<body>");
                out.println("<main class='result'>");
                out.println("<h2>KẾT QUẢ CHUYỂN ĐỔI</h2>");
                out.println("<p>Tỉ giá: " + rate + " VND/USD</p>");
                out.println("<p>Số tiền USD: " + usd + " USD</p>");
                out.println("<p class='value'>Thành tiền VNĐ: " + vnd + " VNĐ</p>");
                out.println("<a href='index.jsp'>Quay lại</a>");
                out.println("</main>");
                out.println("</body>");
                out.println("</html>");
            } catch (NumberFormatException e) {
                out.println("<!DOCTYPE html>");
                out.println("<html lang='vi'><head><meta charset='UTF-8'><title>Error</title></head>");
                out.println("<body style='font-family:Arial;text-align:center;padding-top:100px;'>");
                out.println("<h2 style='color:red;'>Lỗi: Vui lòng nhập số hợp lệ!</h2>");
                out.println("<a href='index.jsp'>Quay lại</a>");
                out.println("</body></html>");
            }
        }
    }
}
