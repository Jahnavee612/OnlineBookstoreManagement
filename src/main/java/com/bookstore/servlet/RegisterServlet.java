package com.bookstore.servlet;

import com.bookstore.dao.UserDAO;
import com.bookstore.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("=== REGISTER ATTEMPT ===");
        System.out.println("Name: " + fullName);
        System.out.println("Email: " + email);

        UserDAO userDAO = new UserDAO();

        if (userDAO.emailExists(email)) {
            request.setAttribute("error", "Email already registered!");
            request.getRequestDispatcher("/jsp/register.jsp")
                   .forward(request, response);
            return;
        }

        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole("customer");

        boolean success = userDAO.registerUser(user);
        System.out.println("Registration success: " + success);

        if (success) {
            response.sendRedirect(request.getContextPath() 
                + "/jsp/login.jsp?registered=true");
        } else {
            request.setAttribute("error", "Registration failed! Try again.");
            request.getRequestDispatcher("/jsp/register.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/register.jsp")
               .forward(request, response);
    }
}