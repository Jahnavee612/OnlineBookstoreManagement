<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Books - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>.navbar { background: linear-gradient(135deg, #1a1a2e, #16213e) !important; }</style>
</head>
<body class="bg-light">
    <nav class="navbar navbar-dark px-4 py-3">
        <span class="navbar-brand fw-bold">📚 BookStore Admin</span>
        <div>
            <a href="${pageContext.request.contextPath}/admin/addBook.jsp" class="btn btn-success me-2">➕ Add Book</a>
            <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-light">← Dashboard</a>
        </div>
    </nav>

    <div class="container mt-4">
        <h4 class="mb-4">📚 Manage Books</h4>
        <table class="table table-bordered bg-white">
            <thead class="table-dark">
                <tr>
                    <th>ID</th><th>Title</th><th>Author</th>
                    <th>Genre</th><th>Price</th><th>Stock</th><th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="book" items="${books}">
                    <tr>
                        <td>${book.id}</td>
                        <td>${book.title}</td>
                        <td>${book.author}</td>
                        <td>${book.genre}</td>
                        <td>₹${book.price}</td>
                        <td>${book.stock}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/books?action=edit&id=${book.id}" 
                               class="btn btn-sm btn-warning">✏️ Edit</a>
                            <a href="${pageContext.request.contextPath}/books?action=delete&id=${book.id}" 
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('Delete this book?')">🗑️ Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>