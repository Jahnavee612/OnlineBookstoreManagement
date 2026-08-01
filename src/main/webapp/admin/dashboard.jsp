<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.bookstore.model.User"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - BookStore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>.navbar { background: linear-gradient(135deg, #1a1a2e, #16213e) !important; }
          .card { border-radius: 15px; transition: transform 0.2s; }
          .card:hover { transform: translateY(-5px); }</style>
</head>
<body class="bg-light">
    <%
        User user = (User) session.getAttribute("user");
        if(user == null || !user.getRole().equals("admin")) {
            response.sendRedirect("../jsp/login.jsp");
            return;
        }
    %>
    <nav class="navbar navbar-dark px-4 py-3">
        <span class="navbar-brand fw-bold">📚 BookStore Admin</span>
        <div>
            <span class="text-white me-3">👋 Welcome, <%= user.getFullName() %></span>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">Logout</a>
        </div>
    </nav>

    <div class="container mt-5">
        <h3 class="mb-4">Admin Dashboard</h3>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card text-white bg-primary p-4 text-center">
                    <h2>📚</h2>
                    <h5>Manage Books</h5>
                    <a href="${pageContext.request.contextPath}/books?action=manage" 
   class="btn btn-light mt-2">Go</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-success p-4 text-center">
                    <h2>📦</h2>
                    <h5>Manage Orders</h5>
                    <a href="${pageContext.request.contextPath}/orders?action=manage" 
   class="btn btn-light mt-2">Go</a>

                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-warning p-4 text-center">
                    <h2>➕</h2>
                    <h5>Add New Book</h5>
                    <a href="${pageContext.request.contextPath}/admin/addBook.jsp" 
   class="btn btn-light mt-2">Go</a>

                </div>
            </div>
        </div>
    </div>
</body>
</html>