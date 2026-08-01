<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Orders - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>.navbar { background: linear-gradient(135deg, #1a1a2e, #16213e) !important; }</style>
</head>
<body class="bg-light">
    <nav class="navbar navbar-dark px-4 py-3">
        <span class="navbar-brand fw-bold">📚 BookStore Admin</span>
        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-light">← Dashboard</a>
    </nav>

    <div class="container mt-4">
        <h4 class="mb-4">📦 Manage Orders</h4>
        <table class="table table-bordered bg-white">
            <thead class="table-dark">
                <tr>
                    <th>Order ID</th><th>User ID</th><th>Total</th>
                    <th>Status</th><th>Date</th><th>Update Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td>#${order.id}</td>
                        <td>${order.userId}</td>
                        <td>₹${order.totalAmount}</td>
                        <td>
                            <span class="badge 
                                ${order.status == 'pending' ? 'bg-warning text-dark' :
                                  order.status == 'confirmed' ? 'bg-primary' :
                                  order.status == 'delivered' ? 'bg-success' : 'bg-danger'}">
                                ${order.status}
                            </span>
                        </td>
                        <td>${order.orderDate}</td>
                        <td>
                            <form action="${pageContext.request.contextPath}/orders" method="get" class="d-flex gap-1">
                                <input type="hidden" name="action" value="updateStatus"/>
                                <input type="hidden" name="orderId" value="${order.id}"/>
                                <select name="status" class="form-select form-select-sm">
                                    <option value="pending">Pending</option>
                                    <option value="confirmed">Confirmed</option>
                                    <option value="delivered">Delivered</option>
                                    <option value="cancelled">Cancelled</option>
                                </select>
                                <button type="submit" class="btn btn-sm btn-primary">Update</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>