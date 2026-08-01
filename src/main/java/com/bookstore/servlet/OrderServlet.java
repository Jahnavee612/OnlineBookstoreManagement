package com.bookstore.servlet;

import com.bookstore.dao.BookDAO;
import com.bookstore.dao.OrderDAO;
import com.bookstore.model.Book;
import com.bookstore.model.Order;
import com.bookstore.model.OrderItem;
import com.bookstore.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, 
                         HttpServletResponse response) 
                         throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("jsp/login.jsp");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();

        if ("history".equals(action)) {
            List<Order> orders = orderDAO.getOrdersByUser(user.getId());
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("jsp/orderHistory.jsp")
                   .forward(request, response);

        } else if ("place".equals(action)) {
            Map<Integer, Integer> cart = 
                (Map<Integer, Integer>) session.getAttribute("cart");

            if (cart == null || cart.isEmpty()) {
                response.sendRedirect("jsp/cart.jsp");
                return;
            }

            BookDAO bookDAO = new BookDAO();
            double total = 0;

            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                Book book = bookDAO.getBookById(entry.getKey());
                if (book != null) {
                    total += book.getPrice() * entry.getValue();
                }
            }

            Order order = new Order();
            order.setUserId(user.getId());
            order.setTotalAmount(total);
            order.setStatus("pending");

            int orderId = orderDAO.placeOrder(order);

            if (orderId != -1) {
                for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                    Book book = bookDAO.getBookById(entry.getKey());
                    OrderItem item = new OrderItem();
                    item.setOrderId(orderId);
                    item.setBookId(entry.getKey());
                    item.setQuantity(entry.getValue());
                    item.setPrice(book.getPrice());
                    orderDAO.addOrderItem(item);
                    bookDAO.updateStock(entry.getKey(), entry.getValue());
                }
                session.removeAttribute("cart");
                response.sendRedirect("jsp/orderSuccess.jsp");
            }

        } else if ("manage".equals(action) && 
                   "admin".equals(user.getRole())) {
            List<Order> orders = orderDAO.getAllOrders();
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("admin/manageOrders.jsp")
                   .forward(request, response);

        } else if ("updateStatus".equals(action) && 
                   "admin".equals(user.getRole())) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");
            orderDAO.updateOrderStatus(orderId, status);
            response.sendRedirect("orders?action=manage");
        }
    }
}