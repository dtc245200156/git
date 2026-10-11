<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>iNotes Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f6f8fb; }
        .brand-mark { width: 2.5rem; height: 2.5rem; border-radius: .8rem; display: inline-grid; place-items: center; background: #dbeafe; color: #1d4ed8; font-weight: 800; }
        .note-content { max-width: 34rem; }
        .note-snippet { color: #657084; overflow-wrap: anywhere; }
        .toolbar { background: #fff; border: 1px solid #e7ebf2; border-radius: 1rem; }
    </style>
</head>
<body>
<nav class="navbar bg-white border-bottom">
    <div class="container py-2">
        <a class="navbar-brand d-flex align-items-center gap-2 fw-bold" href="${pageContext.request.contextPath}/notes">
            <span class="brand-mark">iN</span> iNotes
        </a>
        <span class="badge text-bg-light border">Strategy Pattern</span>
    </div>
</nav>

<main class="container py-5">
    <div class="d-flex flex-wrap justify-content-between align-items-end gap-3 mb-4">
        <div>
            <p class="text-primary text-uppercase small fw-semibold mb-1">Không gian ghi chú của bạn</p>
            <h1 class="display-6 fw-bold mb-1">Ghi chú</h1>
            <p class="text-secondary mb-0">Lưu ý tưởng, phân loại công việc và tìm lại điều quan trọng.</p>
        </div>
        <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/notes?action=create&amp;storage=${storage}">
            + Thêm mới
        </a>
    </div>

    <c:if test="${not empty param.message}">
        <div class="alert alert-success alert-dismissible fade show" role="status">
            <c:out value="${param.message}"/>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
        </div>
    </c:if>

    <form class="toolbar p-3 p-md-4 mb-4" method="get" action="${pageContext.request.contextPath}/notes">
        <div class="row g-3 align-items-end">
            <div class="col-lg-6">
                <label class="form-label fw-semibold" for="keyword">Tìm kiếm ghi chú</label>
                <input class="form-control form-control-lg" id="keyword" name="keyword"
                       type="search" placeholder="Tìm theo tiêu đề hoặc nội dung..."
                       value="<c:out value='${keyword}'/>">
            </div>
            <div class="col-sm-7 col-lg-3">
                <label class="form-label fw-semibold" for="storage">Nơi lưu trữ</label>
                <select class="form-select form-select-lg" id="storage" name="storage">
                    <option value="db" <c:if test="${storage == 'db'}">selected</c:if>>MySQL Database</option>
                    <option value="file" <c:if test="${storage == 'file'}">selected</c:if>>File TXT</option>
                </select>
            </div>
            <div class="col-sm-5 col-lg-3 d-flex gap-2">
                <button class="btn btn-dark btn-lg flex-grow-1" type="submit">Tìm kiếm</button>
                <a class="btn btn-outline-secondary btn-lg" href="${pageContext.request.contextPath}/notes?storage=${storage}">Xóa lọc</a>
            </div>
        </div>
        <div class="small text-secondary mt-3">
            Đang sử dụng: <strong><c:out value="${storage == 'file' ? 'File TXT' : 'MySQL Database'}"/></strong>.
            Chuyển nơi lưu trữ sẽ hiển thị dữ liệu của kho được chọn; hai kho không tự đồng bộ.
        </div>
    </form>

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="h5 fw-bold mb-0">Danh sách ghi chú</h2>
        <span class="text-secondary small"><c:out value="${notes.size()}"/> ghi chú</span>
    </div>

    <div class="card border-0 shadow-sm overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                <tr>
                    <th class="ps-4" style="width: 5rem;">#</th>
                    <th>Tiêu đề</th>
                    <th style="width: 11rem;">Phân loại</th>
                    <th class="text-end pe-4" style="width: 15rem;">Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty notes}">
                        <tr>
                            <td colspan="4" class="text-center py-5">
                                <div class="fs-1 mb-2">📝</div>
                                <h3 class="h6 fw-bold">Chưa tìm thấy ghi chú</h3>
                                <p class="text-secondary mb-3">Thêm ghi chú mới hoặc thay đổi từ khóa tìm kiếm.</p>
                                <a class="btn btn-primary" href="${pageContext.request.contextPath}/notes?action=create&amp;storage=${storage}">Tạo ghi chú đầu tiên</a>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="note" items="${notes}" varStatus="status">
                            <tr>
                                <td class="ps-4 text-secondary"><c:out value="${status.count}"/></td>
                                <td>
                                    <a class="fw-semibold text-decoration-none text-dark"
                                       href="${pageContext.request.contextPath}/notes?action=view&amp;id=${note.id}&amp;storage=${storage}">
                                        <c:out value="${note.title}"/>
                                    </a>
                                    <div class="small note-snippet note-content mt-1">
                                        <c:out value="${note.content}"/>
                                    </div>
                                </td>
                                <td>
                                    <span class="badge rounded-pill text-bg-primary-subtle border border-primary-subtle text-primary-emphasis">
                                        <c:out value="${note.typeName}"/>
                                    </span>
                                </td>
                                <td class="text-end pe-4 text-nowrap">
                                    <a class="btn btn-sm btn-outline-secondary"
                                       href="${pageContext.request.contextPath}/notes?action=view&amp;id=${note.id}&amp;storage=${storage}">Xem</a>
                                    <a class="btn btn-sm btn-outline-primary"
                                       href="${pageContext.request.contextPath}/notes?action=edit&amp;id=${note.id}&amp;storage=${storage}">Sửa</a>
                                    <form class="d-inline" method="post" action="${pageContext.request.contextPath}/notes"
                                          onsubmit="return confirm('Bạn có chắc muốn xóa ghi chú này?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${note.id}">
                                        <input type="hidden" name="storage" value="${storage}">
                                        <button class="btn btn-sm btn-outline-danger" type="submit">Xóa</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
    <footer class="text-center text-secondary small mt-4">iNotes · Strategy Pattern · MySQL / File</footer>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>