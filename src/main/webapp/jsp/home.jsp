<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Home - BookStore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .book-card { transition: transform 0.2s; border-radius: 10px; }
        .book-card:hover { transform: translateY(-5px); box-shadow: 0 5px 15px rgba(0,0,0,0.2); }
        .navbar { background: linear-gradient(135deg, #667eea, #764ba2) !important; }
    </style>
</head>
<body class="bg-light">
    <nav class="navbar navbar-dark px-4 py-3">
        <span class="navbar-brand fw-bold">📚 BookStore</span>
        <div class="d-flex align-items-center gap-3">
            <form action="${pageContext.request.contextPath}/books" method="get" class="d-flex">
                <input type="hidden" name="action" value="search"/>
                <input type="text" name="keyword" class="form-control me-2" placeholder="Search books..."/>
                <button type="submit" class="btn btn-light">🔍</button>
            </form>
            <a href="${pageContext.request.contextPath}/cart" class="btn btn-warning">🛒 Cart</a>
            <a href="${pageContext.request.contextPath}/orders?action=history" class="btn btn-light">📦 Orders</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">Logout</a>
        </div>
    </nav>

    <div class="container mt-4">
        <h4 class="mb-4">
            <c:choose>
                <c:when test="${not empty keyword}">
                    Search Results for: "${keyword}"
                </c:when>
                <c:otherwise>
                    All Books
                </c:otherwise>
            </c:choose>
        </h4>
        <div class="row">
            <c:forEach var="book" items="${books}">
                <div class="col-md-3 mb-4">
                    <div class="card book-card h-100">
                        <div class="card-body">
                            <h5 class="card-title">${book.title}</h5>
                            <p class="text-muted mb-1">✍️ ${book.author}</p>
                            <p class="text-muted mb-1">📂 ${book.genre}</p>
                            <p class="text-success fw-bold">₹${book.price}</p>
                            <p class="text-muted small">${book.description}</p>
                            <p class="small">Stock: ${book.stock}</p>
                        </div>
                        <div class="card-footer">
                            <c:choose>
                                <c:when test="${book.stock > 0}">
                                    <a href="${pageContext.request.contextPath}/cart?action=add&amp;bookId=${book.id}"
                                       class="btn btn-primary w-100">🛒 Add to Cart</a>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-secondary w-100" disabled>Out of Stock</button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>