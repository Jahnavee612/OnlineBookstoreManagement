<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders - BookStore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>.navbar { background: linear-gradient(135deg, #667eea, #764ba2) !important; }</style>
</head>
<body class="bg-light">
    <nav class="navbar navbar-dark px-4 py-3">
        <span class="navbar-brand fw-bold">📚 BookStore</span>
        <div>
            <a href="${pageContext.request.contextPath}/books" class="btn btn-light me-2">🏠 Home</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">Logout</a>
        </div>
    </nav>

    <div class="container mt-4">
        <h3 class="mb-4">📦 My Orders</h3>
        <c:if test="${empty orders}">
            <div class="alert alert-info">No orders yet! 
                <a href="${pageContext.request.contextPath}/books">Start Shopping</a>
            </div>
        </c:if>
        <c:if test="${not empty orders}">
            <table class="table table-bordered bg-white">
                <thead class="table-dark">
                    <tr>
                        <th>Order ID</th>
                        <th>Total Amount</th>
                        <th>Status</th>
                        <th>Order Date</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>#${order.id}</td>
                            <td>₹${order.totalAmount}</td>
                            <td>
                                <span class="badge 
                                    ${order.status == 'pending' ? 'bg-warning' : 
                                      order.status == 'confirmed' ? 'bg-primary' :
                                      order.status == 'delivered' ? 'bg-success' : 'bg-danger'}">
                                    ${order.status}
                                </span>
                            </td>
                            <td>${order.orderDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</body>
</html>