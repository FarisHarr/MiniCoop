/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao;

import java.sql.*;
import java.util.*;

/**
 *
 * @author FarisHarr
 */
public class CartDAO {

    public List<CartItem> getCartItems() throws ClassNotFoundException {
        List<CartItem> cartItems = new ArrayList<>();
        Connection connection = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");

            String url = "jdbc:mysql://localhost/minicoop2";
            String username = "root";
            String password = "admin";
            connection = DriverManager.getConnection(url, username, password);

            String query = "SELECT prod_Name, prod_Price, prod_Qty FROM cart";
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            // Iterate over the result set and create CartItem objects
            while (resultSet.next()) {
                String prodName = resultSet.getString("prod_Name");
                double prodPrice = resultSet.getDouble("prod_Price");
                int prodQty = resultSet.getInt("prod_Qty");

                CartItem cartItem = new CartItem(prodName, prodPrice, prodQty);
                cartItems.add(cartItem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cartItems;
    }

    public static class CartItem {

        private String prodName;
        private double prodPrice;
        private int prodQty;

        public CartItem(String prodName, double prodPrice, int prodQty) {
            this.prodName = prodName;
            this.prodPrice = prodPrice;
            this.prodQty = prodQty;
        }

        public String getProdName() {
            return prodName;
        }

        public double getProdPrice() {
            return prodPrice;
        }

        public int getProdQty() {
            return prodQty;
        }
    }
}
