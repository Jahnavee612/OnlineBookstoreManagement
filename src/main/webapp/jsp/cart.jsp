<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cart - BookStore</title>
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
        <h3 class="mb-4">🛒 Your Cart</h3>
        <c:if test="${empty cartItems}">
            <div class="alert alert-info">
                Your cart is empty! <a href="${pageContext.request.contextPath}/books">Browse Books</a>
            </div>
        </c:if>
        <c:if test="${not empty cartItems}">
            <table class="table table-bordered bg-white">
                <thead class="table-dark">
                    <tr>
                        <th>Book</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="entry" items="${cartItems}">
                        <tr>
                            <td>${entry.key.title}</td>
                            <td>₹${entry.key.price}</td>
                            <td>${entry.value}</td>
                            <td>₹${entry.key.price * entry.value}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/cart?action=remove&bookId=${entry.key.id}" 
                                   class="btn btn-sm btn-danger">Remove</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="3" class="text-end fw-bold">Total:</td>
                        <td class="fw-bold text-success">₹${total}</td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>
            <div class="d-flex justify-content-between mt-3">
                <a href="${pageContext.request.contextPath}/cart?action=clear" 
                   class="btn btn-warning">Clear Cart</a>
                <a href="${pageContext.request.contextPath}/orders?action=place" 
                   class="btn btn-success">✅ Place Order</a>
            </div>
        </c:if>
    </div>
</body>
</html>