<%-- 
    Document   : DeleteCart
    Created on : 8 Jun 2023, 11:43:43 am
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
        
        //create a database connection
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop", "root", "admin");
        
        //retrieve the item ID to delete from the request parameters
        int itemIdToDelete = Integer.parseInt(request.getParameter("id"));
        
        //delete the item from the database
        String deleteQuery = "DELETE FROM cart WHERE id = ?";
        PreparedStatement deleteStatement = connection.prepareStatement(deleteQuery);
        deleteStatement.setInt(1, itemIdToDelete);
        deleteStatement.executeUpdate();
        
        //close the database connection
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>