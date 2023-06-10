<%-- 
    Document   : deleteAllData
    Created on : 10 Jun 2023, 6:01:56 pm
    Author     : FarisHarr
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    // Establish the database connection
    Connection connection = null;
    try {
        // Load the JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Create a database connection
        String url = "jdbc:mysql://localhost/minicoop";
        String username = "root";
        String password = "admin";
        connection = DriverManager.getConnection(url, username, password);

        // Delete all data from the cart table
        String deleteQuery = "DELETE FROM cart";
        Statement deleteStatement = connection.createStatement();
        deleteStatement.executeUpdate(deleteQuery);

        // Close the database connection
        connection.close();

        // Print a success message
        out.println("All data in the cart table has been deleted successfully.");
    } catch (Exception e) {
        e.printStackTrace();
        // Print an error message
        out.println("Error deleting data from the cart table: " + e.getMessage());
    }
%>

