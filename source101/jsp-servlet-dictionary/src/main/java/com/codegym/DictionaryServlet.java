package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DictionaryServlet", urlPatterns = {"/translate"})
public class DictionaryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        Map<String, String> dictionary = new HashMap<>();
        dictionary.put("hello", "Xin chào");
        dictionary.put("how", "Thế nào");
        dictionary.put("book", "Quyển sách");
        dictionary.put("computer", "Máy tính");
        dictionary.put("student", "Sinh viên");
        dictionary.put("school", "Trường học");
        dictionary.put("teacher", "Giáo viên");
        dictionary.put("friend", "Bạn bè");

        String searchWord = request.getParameter("word");
        String normalizedWord = searchWord == null ? "" : searchWord.trim().toLowerCase();
        String result = dictionary.get(normalizedWord);

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang='vi'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1'>");
            out.println("<title>Kết quả tra cứu</title>");
            out.println("<style>");
            out.println("*{box-sizing:border-box}");
            out.println("body{font-family:Arial,sans-serif;background:#f8fafc;color:#1e293b;text-align:center;padding:80px 20px}");
            out.println(".result{width:min(92%,560px);margin:auto;background:#fff;padding:36px;border-radius:12px;box-shadow:0 8px 24px rgba(0,0,0,.1)}");
            out.println("h1{color:#1b2a7a;font-size:28px}.meaning{color:#27ae60;font-size:24px;font-weight:bold;margin:20px 0}");
            out.println(".not-found{color:#dc2626;font-size:22px;font-weight:bold;margin:20px 0}");
            out.println("a{display:inline-block;margin-top:12px;padding:10px 20px;background:#1b2a7a;color:#fff;text-decoration:none;border-radius:5px}");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<main class='result'>");
            out.println("<h1>Kết quả tra cứu từ điển</h1>");

            if (!normalizedWord.isEmpty() && result != null) {
                out.println("<p>Từ khóa: <strong>" + escapeHtml(searchWord.trim()) + "</strong></p>");
                out.println("<p class='meaning'>Nghĩa tiếng Việt: " + escapeHtml(result) + "</p>");
            } else if (!normalizedWord.isEmpty()) {
                out.println("<p class='not-found'>Không tìm thấy từ: " + escapeHtml(searchWord.trim()) + "</p>");
            } else {
                out.println("<p class='not-found'>Vui lòng nhập từ khóa hợp lệ!</p>");
            }

            out.println("<a href='index.jsp'>Quay lại</a>");
            out.println("</main>");
            out.println("</body>");
            out.println("</html>");
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