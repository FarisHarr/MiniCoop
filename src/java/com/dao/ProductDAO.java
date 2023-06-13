/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao;
import java.sql.*;

/**
 *
 * @author FarisHarr
 */
public class ProductDAO {
    private static final String DB_URL = "jdbc:mysql://localhost/minicoop";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "admin";

    public static void deleteAllData() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            String deleteQuery = "DELETE FROM cart";
            Statement deleteStatement = connection.createStatement();
            deleteStatement.executeUpdate(deleteQuery);
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
