<%-- 
    Document   : saveCart
    Created on : 8 Jun 2023, 11:43:00 am
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>

<%
    // Establish the database connection 
    Connection connection = null;
    try {
        // Load the JDBC driver
        Class.forName("com.mysql.jdbc.Driver");
        
        // Create a database connection
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop", "root", "admin");
        
        // Retrieve the cart data from the request parameters
        int itemId = Integer.parseInt(request.getParameter("id"));
        double itemPrice = Double.parseDouble(request.getParameter("price"));
        String itemTitle = request.getParameter("title");
        
        // Save the item data to the cart table
        String selectQuery = "SELECT * FROM cart WHERE id=?";
        PreparedStatement selectStatement = connection.prepareStatement(selectQuery);
        selectStatement.setInt(1, itemId);
        ResultSet resultSet = selectStatement.executeQuery();
        
        if (resultSet.next()) {
            // If the item already exists in the cart, update the quantity
            int currentQuantity = resultSet.getInt("quantity");
            int newQuantity = currentQuantity + 1;
            
            String updateQuery = "UPDATE cart SET quantity=? WHERE id=?";
            PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
            updateStatement.setInt(1, newQuantity);
            updateStatement.setInt(2, itemId);
            updateStatement.executeUpdate();
        } else {
            // If the item does not exist in the cart, insert a new row
            String insertQuery = "INSERT INTO cart (id, title, price, quantity) VALUES (?, ?, ?, ?)";
            PreparedStatement insertStatement = connection.prepareStatement(insertQuery);
            insertStatement.setInt(1, itemId);
            insertStatement.setString(2, itemTitle);
            insertStatement.setDouble(3, itemPrice);
            insertStatement.setInt(4, 1); // Initialize quantity to 1 for a new item
            insertStatement.executeUpdate();
        }
        

        // Close the database connection
        connection.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
%>