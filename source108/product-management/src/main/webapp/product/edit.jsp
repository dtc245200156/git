<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Cập nhật sản phẩm</title>
<style>body{font-family:Arial;background:#f4f7fb;padding:50px 20px}.box{max-width:560px;margin:auto;background:white;padding:30px;border-radius:10px;box-shadow:0 6px 20px rgba(0,0,0,.1)}h1{color:#1b2a7a}.field{margin-bottom:16px}label{display:block;font-weight:bold;margin-bottom:6px}input,textarea{width:100%;padding:10px;border:1px solid #cbd5e1;border-radius:5px}textarea{min-height:110px}button,.back{padding:10px 18px;border:0;border-radius:5px;text-decoration:none}.save{background:#2563eb;color:white}.back{background:#e2e8f0;color:#334155;margin-left:8px}</style></head>
<body><main class="box"><h1>Cập nhật sản phẩm</h1>
<form action="${pageContext.request.contextPath}/products?action=edit" method="POST">
<input type="hidden" name="id" value="${product.id}">
<div class="field"><label>Tên sản phẩm</label><input name="name" type="text" value="${product.name}" required></div>
<div class="field"><label>Giá sản phẩm</label><input name="price" type="number" min="0" step="0.01" value="${product.price}" required></div>
<div class="field"><label>Mô tả</label><textarea name="description" required>${product.description}</textarea></div>
<div class="field"><label>Nhà sản xuất</label><input name="manufacturer" type="text" value="${product.manufacturer}" required></div>
<button class="save" type="submit">Cập nhật</button><a class="back" href="${pageContext.request.contextPath}/products">Hủy</a>
</form></main></body></html>