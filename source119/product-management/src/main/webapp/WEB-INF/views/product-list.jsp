<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f5f7fb; }
        .brand-icon { display: inline-grid; place-items: center; width: 2.5rem; height: 2.5rem; border-radius: .8rem; color: #fff; background: #2251cc; font-weight: 800; }
        .page-card { border: 0; border-radius: 1rem; box-shadow: 0 12px 35px rgba(27, 39, 70, .06); }
        .amount { font-variant-numeric: tabular-nums; white-space: nowrap; }
    </style>
</head>
<body>
<nav class="navbar bg-white border-bottom">
    <div class="container py-2">
        <a class="navbar-brand fw-bold d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/products">
            <span class="brand-icon">P</span> Product Manager
        </a>
        <span class="text-secondary small">Final Exam · JSP &amp; Servlet</span>
    </div>
</nav>
<main class="container py-5">
    <div class="d-flex flex-wrap justify-content-between align-items-end gap-3 mb-4">
        <div>
            <div class="text-primary small text-uppercase fw-semibold mb-1">Quản trị kho hàng</div>
            <h1 class="display-6 fw-bold mb-1">Danh sách sản phẩm</h1>
            <p class="text-secondary mb-0">Xem và quản lý tên, giá bán và số lượng sản phẩm.</p>
        </div>
        <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/products?action=create">+ Thêm sản phẩm</a>
    </div>

    <c:if test="${not empty flashMessage}">
        <div class="alert alert-${flashType} alert-dismissible fade show" role="status">
            <c:out value="${flashMessage}"/>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
        </div>
    </c:if>

    <div class="card page-card overflow-hidden">
        <div class="d-flex flex-wrap justify-content-between align-items-center p-3 p-md-4 border-bottom gap-2">
            <div>
                <h2 class="h5 fw-bold mb-1">Kho sản phẩm</h2>
                <p class="text-secondary small mb-0">Tổng số: <strong><c:out value="${products.size()}"/></strong> sản phẩm</p>
            </div>
            <span class="badge text-bg-light border text-secondary">MySQL · JDBC</span>
        </div>
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                <tr>
                    <th class="ps-4" style="width: 6rem;">ID</th>
                    <th>Tên sản phẩm</th>
                    <th style="width: 15rem;">Giá</th>
                    <th style="width: 10rem;">Số lượng</th>
                    <th class="text-end pe-4" style="width: 13rem;">Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty products}">
                        <tr><td colspan="5" class="text-center py-5">
                            <div class="fs-1 mb-2">📦</div>
                            <h3 class="h6 fw-bold">Chưa có sản phẩm</h3>
                            <p class="text-secondary">Thêm sản phẩm đầu tiên để bắt đầu quản lý kho.</p>
                            <a class="btn btn-primary" href="${pageContext.request.contextPath}/products?action=create">Thêm sản phẩm</a>
                        </td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="product" items="${products}">
                            <tr>
                                <td class="ps-4 text-secondary">#<c:out value="${product.id}"/></td>
                                <td><div class="fw-semibold"><c:out value="${product.name}"/></div></td>
                                <td class="amount"><c:out value="${product.price}"/> ₫</td>
                                <td><span class="badge rounded-pill text-bg-light border text-dark"><c:out value="${product.quantity}"/></span></td>
                                <td class="text-end pe-4 text-nowrap">
                                    <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/products?action=edit&amp;id=${product.id}">Sửa</a>
                                    <form class="d-inline" method="post" action="${pageContext.request.contextPath}/products"
                                          onsubmit="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${product.id}">
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
        <div class="border-top px-4 py-3 text-secondary small">Dữ liệu được đọc trực tiếp từ cơ sở dữ liệu thông qua JDBC.</div>
    </div>
    <footer class="text-center text-secondary small mt-4">Product Manager · Java Servlet · JSP · MySQL</footer>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>