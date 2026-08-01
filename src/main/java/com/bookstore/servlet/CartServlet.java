package com.bookstore.servlet;

import com.bookstore.dao.BookDAO;
import com.bookstore.model.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        HttpSession session = request.getSession();

        if (session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        Map<Integer, Integer> cart =
            (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }

        if ("add".equals(action)) {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            cart.put(bookId, cart.getOrDefault(bookId, 0) + 1);
            session.setAttribute("cart", cart);
            response.sendRedirect(request.getContextPath() + "/books");

        } else if ("remove".equals(action)) {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            cart.remove(bookId);
            session.setAttribute("cart", cart);
            response.sendRedirect(request.getContextPath() + "/cart");

        } else if ("clear".equals(action)) {
            session.removeAttribute("cart");
            response.sendRedirect(request.getContextPath() + "/cart");

        } else {
            BookDAO bookDAO = new BookDAO();
            Map<Book, Integer> cartItems = new HashMap<>();
            double total = 0;

            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                Book book = bookDAO.getBookById(entry.getKey());
                if (book != null) {
                    cartItems.put(book, entry.getValue());
                    total += book.getPrice() * entry.getValue();
                }
            }

            request.setAttribute("cartItems", cartItems);
            request.setAttribute("total", total);
            request.getRequestDispatcher("/jsp/cart.jsp")
                   .forward(request, response);
        }
    }
}