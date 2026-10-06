<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Xóa sản phẩm</title>
<style>body{font-family:Arial;background:#f4f7fb;padding:80px 20px}.box{max-width:520px;margin:auto;background:white;padding:35px;border-radius:10px;text-align:center;box-shadow:0 6px 20px rgba(0,0,0,.1)}h1{color:#c0392b}.actions{margin-top:25px}button,.cancel{padding:10px 18px;border:0;border-radius:5px;text-decoration:none;cursor:pointer}.confirm{background:#c0392b;color:white}.cancel{background:#e2e8f0;color:#334155;margin-left:8px}</style></head>
<body><main class="box"><h1>Xác nhận xóa</h1><p>Bạn có chắc chắn muốn xóa sản phẩm?</p>
<p><strong><c:out value="${product.name}"/></strong><br>Nhà sản xuất: <c:out value="${product.manufacturer}"/><br>Giá: ${product.price}</p>
<form action="${pageContext.request.contextPath}/products?action=delete" method="POST"><input type="hidden" name="id" value="${product.id}">
<button class="confirm" type="submit">Đồng ý xóa</button><a class="cancel" href="${pageContext.request.contextPath}/products">Hủy</a></form>
</main></body></html>