<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Danh sách sản phẩm</title>
<style>
body{font-family:Arial,sans-serif;background:#f4f7fb;margin:0;padding:35px}.container{max-width:1200px;margin:auto}
h1{color:#1b2a7a}.toolbar{display:flex;gap:10px;flex-wrap:wrap;margin:20px 0}.search{display:flex;gap:8px;flex:1;min-width:250px}
input{padding:10px;border:1px solid #cbd5e1;border-radius:5px}.search input{flex:1}.btn{padding:10px 15px;border-radius:5px;text-decoration:none;border:0;cursor:pointer}
.primary{background:#1b2a7a;color:#fff}.success{background:#27ae60;color:#fff}.danger{color:#c0392b}.link{color:#2563eb;text-decoration:none;margin-right:10px}
table{width:100%;border-collapse:collapse;background:#fff;box-shadow:0 4px 14px rgba(0,0,0,.08)}th,td{padding:12px;border-bottom:1px solid #e5e7eb;text-align:left}
th{background:#1b2a7a;color:white}.empty{padding:30px;background:white;text-align:center}
@media(max-width:700px){table{display:block;overflow:auto}.toolbar,.search{flex-direction:column}}
</style></head>
<body>
<main class="container">
<h1>Quản lý sản phẩm</h1>
<div class="toolbar">
<form class="search" action="${pageContext.request.contextPath}/products" method="GET">
<input type="hidden" name="action" value="search">
<input type="text" name="keyword" value="<c:out value='${keyword}'/>" placeholder="Tìm kiếm theo tên">
<button class="btn primary" type="submit">Tìm kiếm</button>
</form>
<a class="btn success" href="${pageContext.request.contextPath}/products?action=create">+ Thêm sản phẩm</a>
<a class="btn" href="${pageContext.request.contextPath}/products">Xem tất cả</a>
</div>

<c:if test="${not empty keyword}">
<p>Kết quả tìm kiếm cho: <strong><c:out value="${keyword}"/></strong></p>
</c:if>

<c:choose>
<c:when test="${not empty products}">
<table>
<thead><tr><th>ID</th><th>Tên sản phẩm</th><th>Giá</th><th>Mô tả</th><th>Nhà sản xuất</th><th>Thao tác</th></tr></thead>
<tbody>
<c:forEach var="product" items="${products}">
<tr>
<td>${product.id}</td>
<td><a class="link" href="${pageContext.request.contextPath}/products?action=view&id=${product.id}"><c:out value="${product.name}"/></a></td>
<td><strong>${product.price}</strong></td>
<td><c:out value="${product.description}"/></td>
<td><c:out value="${product.manufacturer}"/></td>
<td>
<a class="link" href="${pageContext.request.contextPath}/products?action=edit&id=${product.id}">Sửa</a>
<a class="link danger" href="${pageContext.request.contextPath}/products?action=delete&id=${product.id}">Xóa</a>
</td>
</tr>
</c:forEach>
</tbody></table>
</c:when>
<c:otherwise><div class="empty">Không tìm thấy sản phẩm.</div></c:otherwise>
</c:choose>
</main>
</body></html>