<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
        <div>
            <h1 class="h2 mb-1">Quản lý User</h1>
            <p class="text-secondary mb-0">Tìm kiếm theo quốc gia và sắp xếp theo tên.</p>
        </div>
        <div class="d-flex flex-wrap gap-2">
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/users?action=create">+ Thêm User</a>
            <a class="btn btn-outline-warning"
               href="${pageContext.request.contextPath}/users?action=test-without-tran"
               onclick="return confirm('Demo sẽ xóa và tạo lại bảng Employee để kiểm thử. Tiếp tục?')">
                Chạy demo auto-commit
            </a>
            <a class="btn btn-outline-success"
               href="${pageContext.request.contextPath}/users?action=test-use-tran"
               onclick="return confirm('Demo transaction sẽ xóa và tạo lại bảng Employee để kiểm thử. Tiếp tục?')">
                Chạy demo transaction
            </a>
        </div>
    </div>

    <c:if test="${not empty param.message}">
        <div class="alert alert-success" role="status"><c:out value="${param.message}"/></div>
    </c:if>

    <form class="card card-body mb-4" method="get" action="${pageContext.request.contextPath}/users">
        <div class="row g-3 align-items-end">
            <div class="col-md-6">
                <label class="form-label" for="country">Tìm kiếm theo country</label>
                <input class="form-control" id="country" name="country" type="text"
                       placeholder="Ví dụ: Viet Nam"
                       value="<c:out value='${country}'/>">
            </div>
            <div class="col-md-3">
                <label class="form-label" for="sortOrder">Sắp xếp theo name</label>
                <select class="form-select" id="sortOrder" name="sortOrder">
                    <option value="asc" <c:if test="${sortOrder == 'asc'}">selected</c:if>>A → Z</option>
                    <option value="desc" <c:if test="${sortOrder == 'desc'}">selected</c:if>>Z → A</option>
                </select>
            </div>
            <div class="col-md-3 d-flex gap-2">
                <button class="btn btn-success flex-grow-1" type="submit">Áp dụng</button>
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/users">Xóa lọc</a>
            </div>
        </div>
    </form>

    <div class="card shadow-sm">
        <div class="table-responsive">
            <table class="table table-striped table-hover align-middle mb-0">
                <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Country</th>
                    <th class="text-end">Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty users}">
                        <tr><td colspan="5" class="text-center text-secondary py-4">Không tìm thấy User phù hợp.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td><c:out value="${user.id}"/></td>
                                <td><c:out value="${user.name}"/></td>
                                <td><c:out value="${user.email}"/></td>
                                <td><c:out value="${user.country}"/></td>
                                <td class="text-end text-nowrap">
                                    <a class="btn btn-sm btn-outline-primary"
                                       href="${pageContext.request.contextPath}/users?action=edit&amp;id=${user.id}">Sửa</a>
                                    <a class="btn btn-sm btn-outline-danger"
                                       href="${pageContext.request.contextPath}/users?action=delete&amp;id=${user.id}">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>