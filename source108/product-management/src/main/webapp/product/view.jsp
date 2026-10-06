<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Chi tiết sản phẩm</title>
<style>body{font-family:Arial;background:#f4f7fb;padding:60px 20px}.box{max-width:650px;margin:auto;background:white;padding:35px;border-radius:10px;box-shadow:0 6px 20px rgba(0,0,0,.1)}h1{color:#1b2a7a}.row{display:grid;grid-template-columns:180px 1fr;padding:12px 0;border-bottom:1px solid #e5e7eb}.label{font-weight:bold;color:#475569}.actions{margin-top:25px}.btn{padding:10px 18px;border-radius:5px;text-decoration:none}.edit{background:#2563eb;color:#fff}.back{background:#1b2a7a;color:#fff;margin-left:8px}@media(max-width:600px){.row{grid-template-columns:1fr;gap:5px}}</style></head>
<body><main class="box"><h1>Chi tiết sản phẩm</h1>
<div class="row"><span class="label">ID</span><span>${product.id}</span></div>
<div class="row"><span class="label">Tên sản phẩm</span><span><c:out value="${product.name}"/></span></div>
<div class="row"><span class="label">Giá sản phẩm</span><span>${product.price}</span></div>
<div class="row"><span class="label">Mô tả</span><span><c:out value="${product.description}"/></span></div>
<div class="row"><span class="label">Nhà sản xuất</span><span><c:out value="${product.manufacturer}"/></span></div>
<div class="actions"><a class="btn edit" href="${pageContext.request.contextPath}/products?action=edit&id=${product.id}">Sửa</a><a class="btn back" href="${pageContext.request.contextPath}/products">Quay lại</a></div>
</main></body></html>