package com.codegym.inotes.controller;

import com.codegym.inotes.model.Note;
import com.codegym.inotes.service.NoteManagement;
import com.codegym.inotes.strategy.NoteDBStrategy;
import com.codegym.inotes.strategy.NoteFileStrategy;
import com.codegym.inotes.strategy.NoteStrategy;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;

/**
 * MVC controller for iNotes. The storage strategy is stored in the user's
 * session so different sessions can select different backends.
 */
@WebServlet(name = "NoteServlet", urlPatterns = {"/notes"})
public class NoteServlet extends HttpServlet {
    private static final String MANAGEMENT_KEY = "inotes.management";
    private static final String STORAGE_KEY = "inotes.storage";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        NoteManagement management = getManagement(request);
        applyRequestedStrategy(request, management);

        String action = valueOrEmpty(request.getParameter("action"));
        try {
            switch (action) {
                case "create" -> showForm(request, response, management, new Note(), false);
                case "edit" -> {
                    Note note = findNoteOr404(request, response, management);
                    if (note != null) {
                        showForm(request, response, management, note, true);
                    }
                }
                case "view" -> {
                    Note note = findNoteOr404(request, response, management);
                    if (note != null) {
                        request.setAttribute("note", note);
                        request.setAttribute("storage", management.getStorageMode());
                        request.getRequestDispatcher("/WEB-INF/views/detail.jsp").forward(request, response);
                    }
                }
                default -> showDashboard(request, response, management);
            }
        } catch (IllegalArgumentException exception) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, exception.getMessage());
        } catch (SQLException | IOException exception) {
            throw new ServletException("Không thể xử lý dữ liệu ghi chú.", exception);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        NoteManagement management = getManagement(request);
        applyRequestedStrategy(request, management);

        String action = valueOrEmpty(request.getParameter("action"));
        try {
            switch (action) {
                case "save" -> {
                    int id = parseOptionalId(request.getParameter("id"));
                    Note note = new Note();
                    note.setId(id);
                    note.setTitle(request.getParameter("title"));
                    note.setContent(request.getParameter("content"));
                    note.setTypeId(parseRequiredInt(request.getParameter("typeId"), "Phân loại"));

                    if (id <= 0) {
                        management.addNote(note.getTitle(), note.getContent(), note.getTypeId());
                        redirectWithMessage(request, response, management.getStorageMode(),
                                "Đã thêm ghi chú.");
                    } else {
                        management.saveNote(note);
                        redirectWithMessage(request, response, management.getStorageMode(),
                                "Đã cập nhật ghi chú.");
                    }
                }
                case "delete" -> {
                    int id = parseRequiredInt(request.getParameter("id"), "ID ghi chú");
                    boolean deleted = management.deleteNote(id);
                    String message = deleted ? "Đã xóa ghi chú." : "Không tìm thấy ghi chú cần xóa.";
                    redirectWithMessage(request, response, management.getStorageMode(), message);
                }
                default -> response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thao tác không hợp lệ.");
            }
        } catch (IllegalArgumentException exception) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, exception.getMessage());
        } catch (SQLException | IOException exception) {
            throw new ServletException("Không thể lưu thay đổi ghi chú.", exception);
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response,
                               NoteManagement management)
            throws SQLException, IOException, ServletException {
        String keyword = valueOrEmpty(request.getParameter("keyword")).trim();
        request.setAttribute("notes", management.searchNotes(keyword));
        request.setAttribute("keyword", keyword);
        request.setAttribute("types", management.getAvailableTypes());
        request.setAttribute("storage", management.getStorageMode());
        request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response,
                          NoteManagement management, Note note, boolean editing)
            throws ServletException, IOException {
        if (note.getId() == 0 && note.getTypeId() == 0) {
            note.setTypeId(1);
        }
        request.setAttribute("note", note);
        request.setAttribute("editing", editing);
        request.setAttribute("types", management.getAvailableTypes());
        request.setAttribute("storage", management.getStorageMode());
        request.getRequestDispatcher("/WEB-INF/views/form.jsp").forward(request, response);
    }

    private Note findNoteOr404(HttpServletRequest request, HttpServletResponse response,
                               NoteManagement management)
            throws SQLException, IOException {
        int id = parseRequiredInt(request.getParameter("id"), "ID ghi chú");
        Note note = management.findNoteById(id);
        if (note == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy ghi chú.");
            return null;
        }
        return note;
    }

    private NoteManagement getManagement(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Object value = session.getAttribute(MANAGEMENT_KEY);
        if (value instanceof NoteManagement management) {
            return management;
        }

        String initialMode = valueOrEmpty(System.getenv("INOTES_STORAGE"));
        NoteStrategy strategy = "file".equalsIgnoreCase(initialMode)
                ? new NoteFileStrategy()
                : new NoteDBStrategy();
        NoteManagement management = new NoteManagement(strategy);
        session.setAttribute(MANAGEMENT_KEY, management);
        session.setAttribute(STORAGE_KEY, strategy.getName());
        return management;
    }

    private void applyRequestedStrategy(HttpServletRequest request, NoteManagement management) {
        String requestedMode = valueOrEmpty(request.getParameter("storage")).trim();
        if (requestedMode.isEmpty()) {
            return;
        }
        if ("file".equalsIgnoreCase(requestedMode)) {
            management.setStrategy(new NoteFileStrategy());
        } else if ("db".equalsIgnoreCase(requestedMode)) {
            management.setStrategy(new NoteDBStrategy());
        } else {
            throw new IllegalArgumentException("Storage chỉ nhận db hoặc file.");
        }
        request.getSession().setAttribute(STORAGE_KEY, management.getStorageMode());
    }

    private int parseOptionalId(String value) {
        if (value == null || value.isBlank()) {
            return 0;
        }
        return parseRequiredInt(value, "ID ghi chú");
    }

    private int parseRequiredInt(String value, String label) {
        try {
            int parsed = Integer.parseInt(value);
            if (parsed < 1) {
                throw new NumberFormatException();
            }
            return parsed;
        } catch (NumberFormatException exception) {
            throw new IllegalArgumentException(label + " không hợp lệ.");
        }
    }

    private String valueOrEmpty(String value) {
        return value == null ? "" : value;
    }

    private void redirectWithMessage(HttpServletRequest request, HttpServletResponse response,
                                     String storage, String message) throws IOException {
        String encoded = URLEncoder.encode(message, StandardCharsets.UTF_8);
        response.sendRedirect(request.getContextPath() + "/notes?storage="
                + URLEncoder.encode(storage, StandardCharsets.UTF_8) + "&message=" + encoded);
    }
}