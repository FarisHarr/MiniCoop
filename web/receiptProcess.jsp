<%-- 
    Document   : receiptProcess
    Created on : 4 Jul 2023, 2:35:28 am
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
         try {
                 // Retrieve the necessary parameter values from the request
                 String customerID = (String) session.getAttribute("customerID");
                 int numItems = Integer.parseInt(request.getParameter("numItems"));

                 Class.forName("com.mysql.jdbc.Driver");
                 String databaseURL = "jdbc:mysql://localhost:3306/minicoop2";
                 String username = "root";
                 String password = "admin";
                 Connection connection = DriverManager.getConnection(databaseURL, username, password);

                 // Construct the SQL INSERT statement
                 String insertQuery = "INSERT INTO receipt (cust_ID, prod_Name, prod_Qty, Price) VALUES (?, ?, ?, ?)";

                 // Create a PreparedStatement with the insertQuery
                 PreparedStatement statement = connection.prepareStatement(insertQuery);

                 // Iterate over the items and insert each item into the database
                 for (int i = 0; i < numItems; i++) {
                     String prodName = request.getParameter("prodName_" + i);
                     int prodQty = Integer.parseInt(request.getParameter("prodQty_" + i));
                     double prodPrice = Double.parseDouble(request.getParameter("prodPrice_" + i));

                     // Set the parameter values in the PreparedStatement
                     statement.setString(1, customerID);
                     statement.setString(2, prodName);
                     statement.setInt(3, prodQty);
                     statement.setDouble(4, prodPrice);

                     // Execute the INSERT statement
                     statement.executeUpdate();
                 }

                 // Close the PreparedStatement and database connection
                 statement.close();
                 connection.close();

                 // Redirect to Success.html
                 response.sendRedirect("Success.html");
             } catch (Exception e) {
                 e.printStackTrace();
             }
        %>

    </body>
</html>
