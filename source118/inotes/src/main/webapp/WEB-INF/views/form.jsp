<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><c:out value="${editing ? 'Sửa ghi chú' : 'Thêm ghi chú'}"/> · iNotes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f6f8fb; }
        .editor-card { border: 0; border-radius: 1.25rem; }
    </style>
</head>
<body>
<nav class="navbar bg-white border-bottom">
    <div class="container py-2">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/notes?storage=${storage}">← iNotes</a>
        <span class="text-secondary small">Đang lưu vào: <c:out value="${storage == 'file' ? 'File TXT' : 'MySQL'}"/></span>
    </div>
</nav>
<main class="container py-5" style="max-width: 850px;">
    <div class="mb-4">
        <p class="text-primary text-uppercase small fw-semibold mb-1">Ghi chú của bạn</p>
        <h1 class="display-6 fw-bold"><c:out value="${editing ? 'Chỉnh sửa ghi chú' : 'Tạo ghi chú mới'}"/></h1>
        <p class="text-secondary">Ghi lại ý tưởng, phân loại và lưu để dễ dàng tìm kiếm sau này.</p>
    </div>
    <form class="card editor-card shadow-sm" method="post" action="${pageContext.request.contextPath}/notes">
        <div class="card-body p-4 p-md-5">
            <input type="hidden" name="action" value="save">
            <input type="hidden" name="id" value="${note.id}">
            <input type="hidden" name="storage" value="${storage}">

            <div class="mb-4">
                <label class="form-label fw-semibold" for="title">Tiêu đề <span class="text-danger">*</span></label>
                <input class="form-control form-control-lg" id="title" name="title" maxlength="255"
                       required autofocus placeholder="Ví dụ: Họp giao ban đầu tuần"
                       value="<c:out value='${note.title}'/>">
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold" for="typeId">Phân loại</label>
                <select class="form-select form-select-lg" id="typeId" name="typeId" required>
                    <c:forEach var="type" items="${types}">
                        <option value="${type.id}" <c:if test="${note.typeId == type.id}">selected</c:if>>
                            <c:out value="${type.name}"/>
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold" for="content">Nội dung</label>
                <textarea class="form-control" id="content" name="content" rows="9"
                          placeholder="Viết nội dung ghi chú ở đây..."><c:out value="${note.content}"/></textarea>
            </div>

            <div class="d-flex flex-wrap gap-2 justify-content-end">
                <a class="btn btn-outline-secondary btn-lg" href="${pageContext.request.contextPath}/notes?storage=${storage}">Hủy bỏ</a>
                <button class="btn btn-primary btn-lg px-4" type="submit">Lưu ghi chú</button>
            </div>
        </div>
    </form>
</main>
</body>
</html>