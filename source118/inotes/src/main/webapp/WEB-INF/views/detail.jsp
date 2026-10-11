<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><c:out value="${note.title}"/> · iNotes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f6f8fb; }
        .note-body { white-space: pre-wrap; overflow-wrap: anywhere; min-height: 12rem; line-height: 1.75; }
    </style>
</head>
<body>
<nav class="navbar bg-white border-bottom">
    <div class="container py-2">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/notes?storage=${storage}">← iNotes</a>
        <span class="text-secondary small"><c:out value="${storage == 'file' ? 'File TXT' : 'MySQL Database'}"/></span>
    </div>
</nav>
<main class="container py-5" style="max-width: 850px;">
    <article class="card border-0 shadow-sm">
        <div class="card-body p-4 p-md-5">
            <div class="d-flex justify-content-between align-items-start gap-3 mb-3">
                <span class="badge rounded-pill text-bg-primary-subtle border border-primary-subtle text-primary-emphasis">
                    <c:out value="${note.typeName}"/>
                </span>
                <span class="text-secondary small">#<c:out value="${note.id}"/></span>
            </div>
            <h1 class="display-6 fw-bold mb-4"><c:out value="${note.title}"/></h1>
            <div class="note-body"><c:out value="${note.content}"/></div>
            <hr class="my-4">
            <div class="d-flex flex-wrap gap-2 justify-content-end">
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/notes?storage=${storage}">Quay lại danh sách</a>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/notes?action=edit&amp;id=${note.id}&amp;storage=${storage}">Sửa ghi chú</a>
            </div>
        </div>
    </article>
</main>
</body>
</html>