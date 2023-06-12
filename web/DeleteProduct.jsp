<%-- 
    Document   : DeleteProduct
    Created on : 11 Jun 2023, 15:29:54
    Author     : Lenovo
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
            String productId = request.getParameter("productId");

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop", "root", "admin");

                // Delete the product with the given product ID
                PreparedStatement deleteStatement = con.prepareStatement("DELETE FROM product WHERE prod_ID = ?");
                deleteStatement.setString(1, productId);
                deleteStatement.executeUpdate();

                // Close the database connection
                con.close();

                // Send a success response
                response.setStatus(HttpServletResponse.SC_OK);
            } catch (Exception e) {
                // Handle any exceptions and send an error response
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        %>
    </body>
</html>
