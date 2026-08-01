<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Placed - BookStore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>body { background: linear-gradient(135deg, #667eea, #764ba2); min-height: 100vh; }</style>
</head>
<body class="d-flex align-items-center justify-content-center">
    <div class="text-center text-white">
        <h1>🎉</h1>
        <h2>Order Placed Successfully!</h2>
        <p class="lead">Thank you for shopping at BookStore!</p>
        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/books" class="btn btn-light me-3">
                🏠 Continue Shopping
            </a>
            <a href="${pageContext.request.contextPath}/orders?action=history" class="btn btn-warning">
                📦 View My Orders
            </a>
        </div>
    </div>
</body>
</html>