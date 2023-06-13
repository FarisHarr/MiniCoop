/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao;

/**
 *
 * @author FarisHarr
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SaveDAO {

    public void saveItemToCartFromServlet(int itemId, double itemPrice, String itemTitle) {
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");

            String url = "jdbc:mysql://localhost/minicoop2";
            String username = "root";
            String password = "admin";
            connection = DriverManager.getConnection(url, username, password);

            String selectQuery = "SELECT * FROM cart WHERE cart_ID=?";
            PreparedStatement selectStatement = connection.prepareStatement(selectQuery);
            selectStatement.setInt(1, itemId);
            ResultSet resultSet = selectStatement.executeQuery();

            if (resultSet.next()) {
                // If the item already exists in the cart, update the quantity
                int currentQuantity = resultSet.getInt("prod_Qty");
                int newQuantity = currentQuantity + 1;

                String updateQuery = "UPDATE cart SET prod_Qty=? WHERE cart_ID=?";
                PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
                updateStatement.setInt(1, newQuantity);
                updateStatement.setInt(2, itemId);
                updateStatement.executeUpdate();
            } else {
                // If the item does not exist in the cart, insert a new row
                String insertQuery = "INSERT INTO cart (cart_ID, prod_Name, prod_Price, prod_Qty) VALUES (?, ?, ?, ?)";
                PreparedStatement insertStatement = connection.prepareStatement(insertQuery);
                insertStatement.setInt(1, itemId);
                insertStatement.setString(2, itemTitle);
                insertStatement.setDouble(3, itemPrice);
                insertStatement.setInt(4, 1); // Initialize quantity to 1 for a new item
                insertStatement.executeUpdate();
            }

            // Save the item data to the sales table
            String selectSalesQuery = "SELECT * FROM sales WHERE prod_ID=?";
            PreparedStatement selectSalesStatement = connection.prepareStatement(selectSalesQuery);
            selectSalesStatement.setInt(1, itemId);
            ResultSet salesResultSet = selectSalesStatement.executeQuery();

            if (salesResultSet.next()) {
                // If the item already exists in the sales table, update the quantity
                int currentSalesQuantity = salesResultSet.getInt("prod_Qty");
                int newSalesQuantity = currentSalesQuantity + 1;

                String updateSalesQuery = "UPDATE sales SET prod_Qty=? WHERE prod_ID=?";
                PreparedStatement updateSalesStatement = connection.prepareStatement(updateSalesQuery);
                updateSalesStatement.setInt(1, newSalesQuantity);
                updateSalesStatement.setInt(2, itemId);
                updateSalesStatement.executeUpdate();
            } else {
                // If the item does not exist in the sales table, insert a new row
                String insertSalesQuery = "INSERT INTO sales (prod_ID, prod_Name, prod_Price, prod_Qty) VALUES (?, ?, ?, ?)";
                PreparedStatement insertSalesStatement = connection.prepareStatement(insertSalesQuery);
                insertSalesStatement.setInt(1, itemId);
                insertSalesStatement.setString(2, itemTitle);
                insertSalesStatement.setDouble(3, itemPrice);
                insertSalesStatement.setInt(4, 1); // Initialize quantity to 1 for a new sale
                insertSalesStatement.executeUpdate();
            }

            // Close the database connection
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
