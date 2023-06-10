<%-- 
    Document   : AddProduct
    Created on : 10 Jun 2023, 11:48:42 pm
    Author     : FarisHarr
--%>

<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="addprod" class="MiniCoop.com.AddProduct" scope="request"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>


        <%
            try {
                // Retrieve the form data from the request
                addprod.setProductcode(Integer.parseInt(request.getParameter("productcode")));
                addprod.setProductname(request.getParameter("productname"));
                addprod.setPrice(request.getParameter("price"));
                addprod.setQuantity(Integer.parseInt(request.getParameter("quantity")));


                // Prepare the SQL statement
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop", "root", "admin");
                PreparedStatement st = con.prepareStatement("INSERT INTO product (prod_ID, prod_Name, prod_Qty, prod_Price) VALUES (?, ?, ?, ?)");
                st.setInt(1, addprod.getProductcode());
                st.setString(2, addprod.getProductname());
                st.setInt(3, addprod.getQuantity());
                st.setString(4, addprod.getPrice());
                st.executeUpdate();

                // Execute the SQL statement
                

                // Close the database connection
                st.close();
                con.close();

                // Redirect back to the ManageProduct.jsp page
                response.sendRedirect("ManageProduct.jsp");

            } catch (Exception e) {
                e.printStackTrace();

            }
        %>
    </body>
</html>
