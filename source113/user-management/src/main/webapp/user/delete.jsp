<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Xóa User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5" style="max-width: 720px;">
    <div class="card card-body">
        <h1 class="h3 text-danger">Xác nhận xóa User</h1>
        <p>Bạn có chắc chắn muốn xóa người dùng sau?</p>
        <dl class="row">
            <dt class="col-sm-3">ID</dt><dd class="col-sm-9"><c:out value="${user.id}"/></dd>
            <dt class="col-sm-3">Name</dt><dd class="col-sm-9"><c:out value="${user.name}"/></dd>
            <dt class="col-sm-3">Email</dt><dd class="col-sm-9"><c:out value="${user.email}"/></dd>
            <dt class="col-sm-3">Country</dt><dd class="col-sm-9"><c:out value="${user.country}"/></dd>
        </dl>
        <form method="post" action="${pageContext.request.contextPath}/users" class="d-flex gap-2">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="id" value="<c:out value='${user.id}'/>">
            <button class="btn btn-danger" type="submit">Xóa User</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/users">Hủy</a>
        </form>
    </div>
</div>
</body>
</html>