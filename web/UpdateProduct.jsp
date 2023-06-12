<%-- 
    Document   : UpdateProduct
    Created on : 12 Jun 2023, 11:57:48 pm
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
            String productId = request.getParameter("productId");
            String productName = request.getParameter("productName");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double price = Double.parseDouble(request.getParameter("price"));

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop", "root", "admin");
                PreparedStatement st = con.prepareStatement("UPDATE product SET prod_ID=?, prod_Name=?, prod_Qty=?, prod_Price=? WHERE prod_ID=?");
                st.setString(1, productId);
                st.setString(2, productName);
                st.setInt(3, quantity);
                st.setDouble(4, price);
                st.setString(5, productId);
                int rowsAffected = st.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("ManageProduct.jsp"); // Redirect to ManageProduct.jsp
                } else {
                    out.println("<p>Failed to update the product.</p>");
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        %>
    </body>
</html>
