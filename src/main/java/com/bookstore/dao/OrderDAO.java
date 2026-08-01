package com.bookstore.dao;

import com.bookstore.model.Order;
import com.bookstore.model.OrderItem;
import com.bookstore.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // Place New Order
    public int placeOrder(Order order) {
        String sql = "INSERT INTO orders (user_id, total_amount, status) VALUES (?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, order.getUserId());
            ps.setDouble(2, order.getTotalAmount());
            ps.setString(3, "pending");
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Add Order Items
    public boolean addOrderItem(OrderItem item) {
        String sql = "INSERT INTO order_items (order_id, book_id, quantity, price) VALUES (?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, item.getOrderId());
            ps.setInt(2, item.getBookId());
            ps.setInt(3, item.getQuantity());
            ps.setDouble(4, item.getPrice());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get Orders by User
    public List<Order> getOrdersByUser(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id=? ORDER BY order_date DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orders.add(new Order(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getDouble("total_amount"),
                    rs.getString("status"),
                    rs.getTimestamp("order_date")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Get All Orders (Admin)
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                orders.add(new Order(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getDouble("total_amount"),
                    rs.getString("status"),
                    rs.getTimestamp("order_date")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Get Items of an Order
    public List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT oi.*, b.title FROM order_items oi " +
                     "JOIN books b ON oi.book_id = b.id WHERE oi.order_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                items.add(new OrderItem(
                    rs.getInt("id"),
                    rs.getInt("order_id"),
                    rs.getInt("book_id"),
                    rs.getString("title"),
                    rs.getInt("quantity"),
                    rs.getDouble("price")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }

    // Update Order Status (Admin)
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}