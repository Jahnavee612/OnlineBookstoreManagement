package com.bookstore.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/bookstore_db";
    private static final String USER = "root";
    private static final String PASSWORD = "India@123";

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Database Connected Successfully!");
        } catch (Exception e) {
            System.out.println("❌ Connection Failed: " + e.getMessage());
        }
        return con;
    }

    public static void main(String[] args) {
        getConnection();
    }
}