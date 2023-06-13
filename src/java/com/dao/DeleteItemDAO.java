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

public class DeleteItemDAO {

    public void deleteItemFromCart(int itemIdToDelete) {
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");

            String url = "jdbc:mysql://localhost/minicoop2";
            String username = "root";
            String password = "admin";
            connection = DriverManager.getConnection(url, username, password);

            String deleteQuery = "DELETE FROM cart WHERE cart_ID = ? LIMIT 1";
            PreparedStatement deleteStatement = connection.prepareStatement(deleteQuery);
            deleteStatement.setInt(1, itemIdToDelete);
            deleteStatement.executeUpdate();

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
