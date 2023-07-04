<%-- 
    Document   : EditProduct
    Created on : 13 Jun 2023, 1:40:11 am
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="CSS/ManageStaff.css">
        <title>JSP Page</title>
        
    </head>
    <body>
        <%
            String productId = request.getParameter("productId");
            if (productId != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop2", "root", "admin");
                    PreparedStatement st = con.prepareStatement("SELECT * FROM product WHERE prod_ID = ?");
                    st.setString(1, productId);
                    ResultSet rs = st.executeQuery();

                    if (rs.next()) {
                        productId = rs.getString("prod_ID");
                        String productName = rs.getString("prod_Name");
                        int quantity = rs.getInt("prod_Qty");
                        double price = rs.getDouble("prod_Price");
        %>
        <div class="popup-content">
            <h2>Edit Product <%=productName%></h2><br>
            <form action="UpdateProduct.jsp" method="POST">
                <label>Product ID</label>
                <input type="text" name="productId" value="<%= productId%>" readonly><br><br>
                <label>Product Name</label>
                <input type="text" name="productName" value="<%= productName%>"  placeholder="Product Name" required><br><br>
                <label>Product Quantity</label>
                <input type="number" name="quantity" value="<%= quantity%>" placeholder="Quantity" required><br><br>
                <label>Price</label>
                <input type="number" step="any" name="price" value="<%= price%>" placeholder="Price" required><br><br>
                <input class="update" type="submit" value="Update Product">
            </form>
        </div>
        <%
                    } else {
                        out.println("<p>Product not found.</p>");
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            } else {
                out.println("<p>Invalid product ID.</p>");
            }
        %>
    </body>
</html>
