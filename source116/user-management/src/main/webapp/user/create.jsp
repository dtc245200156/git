<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5" style="max-width: 720px;">
    <h1 class="h2 mb-4">Thêm User</h1>
    <form class="card card-body gap-3" method="post" action="${pageContext.request.contextPath}/users">
        <input type="hidden" name="action" value="create">
        <div>
            <label class="form-label" for="name">Name *</label>
            <input class="form-control" id="name" name="name" maxlength="120" required>
        </div>
        <div>
            <label class="form-label" for="email">Email *</label>
            <input class="form-control" id="email" name="email" type="email" maxlength="220" required>
        </div>
        <div>
            <label class="form-label" for="country">Country</label>
            <input class="form-control" id="country" name="country" maxlength="120">
        </div>
        <fieldset class="border rounded p-3">
            <legend class="float-none w-auto px-2 fs-6">Quyền hạn (Permissions)</legend>
            <div class="d-flex flex-wrap gap-3">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="permissionAdd" name="permissions" value="1">
                    <label class="form-check-label" for="permissionAdd">Thêm (Add)</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="permissionEdit" name="permissions" value="2">
                    <label class="form-check-label" for="permissionEdit">Sửa (Edit)</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="permissionDelete" name="permissions" value="3">
                    <label class="form-check-label" for="permissionDelete">Xóa (Delete)</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="permissionView" name="permissions" value="4">
                    <label class="form-check-label" for="permissionView">Xem (View)</label>
                </div>
            </div>
        </fieldset>
        <div class="d-flex gap-2">
            <button class="btn btn-primary" type="submit">Lưu</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/users">Hủy</a>
        </div>
    </form>
</div>
</body>
</html>