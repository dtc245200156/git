<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><c:out value="${editing ? 'Sửa sản phẩm' : 'Thêm sản phẩm'}"/> · Product Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f5f7fb; }
        .form-card { border: 0; border-radius: 1rem; box-shadow: 0 12px 35px rgba(27, 39, 70, .06); }
    </style>
</head>
<body>
<nav class="navbar bg-white border-bottom">
    <div class="container py-2"><a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/products">← Product Manager</a></div>
</nav>
<main class="container py-5" style="max-width: 800px;">
    <div class="mb-4">
        <div class="text-primary small text-uppercase fw-semibold mb-1">Thông tin kho hàng</div>
        <h1 class="display-6 fw-bold"><c:out value="${editing ? 'Cập nhật sản phẩm' : 'Thêm sản phẩm mới'}"/></h1>
        <p class="text-secondary">Nhập đầy đủ thông tin bên dưới rồi lưu thay đổi.</p>
    </div>
    <form class="card form-card" method="post" action="${pageContext.request.contextPath}/products">
        <div class="card-body p-4 p-md-5">
            <input type="hidden" name="action" value="${editing ? 'update' : 'create'}">
            <c:if test="${editing}"><input type="hidden" name="id" value="${product.id}"></c:if>

            <div class="mb-4">
                <label class="form-label fw-semibold" for="name">Tên sản phẩm <span class="text-danger">*</span></label>
                <input class="form-control form-control-lg" id="name" name="name" type="text" maxlength="150"
                       value="<c:out value='${product.name}'/>" placeholder="Ví dụ: Laptop" required autofocus>
            </div>
            <div class="row g-3 mb-4">
                <div class="col-md-7">
                    <label class="form-label fw-semibold" for="price">Giá (VNĐ) <span class="text-danger">*</span></label>
                    <input class="form-control form-control-lg" id="price" name="price" type="number"
                           min="0" step="0.01" value="<c:out value='${product.price == null ? "0.00" : product.price}'/>" required>
                </div>
                <div class="col-md-5">
                    <label class="form-label fw-semibold" for="quantity">Số lượng <span class="text-danger">*</span></label>
                    <input class="form-control form-control-lg" id="quantity" name="quantity" type="number"
                           min="0" step="1" value="<c:out value='${editing ? product.quantity : 0}'/>" required>
                </div>
            </div>
            <div class="alert alert-light border small text-secondary">
                Tên sản phẩm là bắt buộc. Giá và số lượng phải là số không âm.
            </div>
            <div class="d-flex flex-wrap justify-content-end gap-2">
                <a class="btn btn-outline-secondary btn-lg" href="${pageContext.request.contextPath}/products">Hủy bỏ</a>
                <button class="btn btn-primary btn-lg px-4" type="submit"><c:out value="${editing ? 'Lưu cập nhật' : 'Lưu sản phẩm'}"/></button>
            </div>
        </div>
    </form>
</main>
</body>
</html>