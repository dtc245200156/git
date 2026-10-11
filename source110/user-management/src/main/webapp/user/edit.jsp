<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cập nhật User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5" style="max-width: 720px;">
    <h1 class="h2 mb-4">Cập nhật User</h1>
    <form class="card card-body gap-3" method="post" action="${pageContext.request.contextPath}/users">
        <input type="hidden" name="action" value="edit">
        <input type="hidden" name="id" value="<c:out value='${user.id}'/>">
        <div>
            <label class="form-label" for="name">Name *</label>
            <input class="form-control" id="name" name="name" maxlength="120"
                   value="<c:out value='${user.name}'/>" required>
        </div>
        <div>
            <label class="form-label" for="email">Email *</label>
            <input class="form-control" id="email" name="email" type="email" maxlength="220"
                   value="<c:out value='${user.email}'/>" required>
        </div>
        <div>
            <label class="form-label" for="country">Country</label>
            <input class="form-control" id="country" name="country" maxlength="120"
                   value="<c:out value='${user.country}'/>">
        </div>
        <div class="d-flex gap-2">
            <button class="btn btn-primary" type="submit">Cập nhật</button>
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/users">Hủy</a>
        </div>
    </form>
</div>
</body>
</html>