<%-- 
    Document   : Sales
    Created on : 11 Jun 2023, 1:32:02 pm
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>

<%
//    String staffID = request.getParameter("id");
//    String staffName = request.getParameter("name");
//    String email = request.getParameter("email");
//    String phone = request.getParameter("phone");

    // Establish the database connection 
    Connection connection = null;
    try {
        // Load the JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Create a database connection
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop2", "root", "admin");

        // Retrieve the cart data from the request parameters
        int itemId = Integer.parseInt(request.getParameter("id"));
        double itemPrice = Double.parseDouble(request.getParameter("price"));
        String itemTitle = request.getParameter("title");

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
            String insertSalesQuery = "INSERT INTO sales (sales_ID, prod_Name, prod_Price, prod_Qty) VALUES (?, ?, ?, ?)";
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
%>
