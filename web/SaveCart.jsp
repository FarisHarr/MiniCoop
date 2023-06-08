<%-- 
    Document   : saveCart
    Created on : 8 Jun 2023, 11:43:00 am
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>

<%
    //establish the database connection 
    Connection connection = null;
    try {
        //load the JDBC driver
        Class.forName("com.mysql.jdbc.Driver");
        
        // create a database connection

        connection = DriverManager.getConnection("jdbc:mysql://localhost/minicoop", "root", "admin");
        
        //retrieve the cart data from the request parameters
        int itemId = Integer.parseInt(request.getParameter("id"));
        double itemPrice = Double.parseDouble(request.getParameter("price"));
        String itemTitle = request.getParameter("title");
        
        //save the item data to the database
        String insertQuery = "INSERT INTO cart (id, title, price) VALUES (?, ?, ?)";
        PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);
        preparedStatement.setInt(1, itemId);
        preparedStatement.setString(2, itemTitle);
        preparedStatement.setDouble(3, itemPrice);
        preparedStatement.executeUpdate();
        
        //close the database connection
        connection.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
%>
