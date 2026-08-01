<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Book - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>.navbar { background: linear-gradient(135deg, #1a1a2e, #16213e) !important; }</style>
</head>
<body class="bg-light">
    <nav class="navbar navbar-dark px-4 py-3">
        <span class="navbar-brand fw-bold">📚 BookStore Admin</span>
        <a href="${pageContext.request.contextPath}/books?action=manage" class="btn btn-light">← Back</a>
    </nav>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card p-4">
                    <h4 class="mb-4">✏️ Edit Book</h4>
                    <form action="${pageContext.request.contextPath}/books" method="post">
                        <input type="hidden" name="action" value="update"/>
                        <input type="hidden" name="id" value="${book.id}"/>
                        <div class="mb-3">
                            <label class="form-label">Title</label>
                            <input type="text" name="title" class="form-control" value="${book.title}" required/>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Author</label>
                            <input type="text" name="author" class="form-control" value="${book.author}" required/>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Genre</label>
                            <input type="text" name="genre" class="form-control" value="${book.genre}"/>
                        </div>
                        <div class="row">
                            <div class="col mb-3">
                                <label class="form-label">Price (₹)</label>
                                <input type="number" name="price" step="0.01" class="form-control" value="${book.price}" required/>
                            </div>
                            <div class="col mb-3">
                                <label class="form-label">Stock</label>
                                <input type="number" name="stock" class="form-control" value="${book.stock}" required/>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea name="description" class="form-control" rows="3">${book.description}</textarea>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Update Book</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>