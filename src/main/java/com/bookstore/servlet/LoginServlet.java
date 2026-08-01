package com.bookstore.servlet;

import com.bookstore.dao.UserDAO;
import com.bookstore.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("=== LOGIN ATTEMPT ===");
        System.out.println("Email: " + email);
        System.out.println("Password: " + password);

        UserDAO userDAO = new UserDAO();
        User user = userDAO.loginUser(email, password);

        System.out.println("User found: " + user);

        if (user != null) {
            System.out.println("Role: " + user.getRole());
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("role", user.getRole());

            if ("admin".equals(user.getRole())) {
                System.out.println("Redirecting to admin dashboard");
                response.sendRedirect(request.getContextPath() 
                    + "/admin/dashboard.jsp");
            } else {
                System.out.println("Redirecting to books");
                response.sendRedirect(request.getContextPath() 
                    + "/books");
            }
        } else {
            System.out.println("Login failed - user not found");
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("/jsp/login.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/login.jsp")
               .forward(request, response);
    }
}