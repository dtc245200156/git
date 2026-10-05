<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%@ page import="com.codegym.Customer" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách khách hàng - JSTL</title>
    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f3f6fa;
            color: #1f2937;
        }

        .page {
            width: min(1100px, 92%);
            margin: 50px auto;
        }

        h1 {
            margin-bottom: 8px;
            text-align: center;
            color: #1b2a7a;
        }

        .subtitle {
            margin: 0 0 28px;
            text-align: center;
            color: #64748b;
        }

        .customer-list {
            display: grid;
            gap: 16px;
        }

        .customer-card {
            display: grid;
            grid-template-columns: 90px 1fr;
            gap: 18px;
            align-items: center;
            padding: 18px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(15, 23, 42, .08);
        }

        .customer-card img {
            width: 90px;
            height: 90px;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid #e2e8f0;
        }

        .customer-card h2 {
            margin: 0 0 8px;
            color: #1b2a7a;
            font-size: 22px;
        }

        .customer-card p {
            margin: 5px 0;
            color: #475569;
        }

        .label {
            font-weight: bold;
            color: #334155;
        }

        .empty {
            padding: 24px;
            text-align: center;
            background: #fff;
            border-radius: 10px;
            color: #64748b;
        }

        @media (max-width: 575px) {
            .page {
                margin: 30px auto;
            }

            .customer-card {
                grid-template-columns: 1fr;
                text-align: center;
            }

            .customer-card img {
                margin: 0 auto;
            }
        }
    </style>
</head>
<body>
<%
    List<Customer> customers = Arrays.asList(
        new Customer(
            "Nguyễn Văn An",
            "1985-03-12",
            "Hà Nội",
            "https://i.pravatar.cc/180?img=12"
        ),
        new Customer(
            "Trần Thị Bình",
            "1990-07-25",
            "Hải Phòng",
            "https://i.pravatar.cc/180?img=32"
        ),
        new Customer(
            "Lê Hoàng Nam",
            "1988-11-08",
            "Đà Nẵng",
            "https://i.pravatar.cc/180?img=56"
        ),
        new Customer(
            "Phạm Minh Châu",
            "1993-01-19",
            "Thành phố Hồ Chí Minh",
            "https://i.pravatar.cc/180?img=47"
        ),
        new Customer(
            "Đỗ Thu Hà",
            "1996-09-03",
            "Thái Nguyên",
            "https://i.pravatar.cc/180?img=49"
        )
    );

    request.setAttribute("customers", customers);
%>

<main class="page">
    <h1>Danh sách khách hàng</h1>
    <p class="subtitle">Hiển thị dữ liệu bằng JSTL trong JSP</p>

    <section class="customer-list">
        <c:choose>
            <c:when test="${not empty customers}">
                <c:forEach var="customer" items="${customers}">
                    <article class="customer-card">
                        <img src="<c:out value='${customer.image}'/>"
                             alt="Ảnh khách hàng">
                        <div>
                            <h2><c:out value="${customer.name}"/></h2>
                            <p>
                                <span class="label">Ngày sinh:</span>
                                <c:out value="${customer.dateOfBirth}"/>
                            </p>
                            <p>
                                <span class="label">Địa chỉ:</span>
                                <c:out value="${customer.address}"/>
                            </p>
                        </div>
                    </article>
                </c:forEach>
            </c:when>

            <c:otherwise>
                <div class="empty">Chưa có khách hàng nào.</div>
            </c:otherwise>
        </c:choose>
    </section>
</main>
</body>
</html>