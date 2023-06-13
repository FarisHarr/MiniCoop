<%-- 
    Document   : DeleteProduct
    Created on : 11 Jun 2023, 15:29:54
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Product</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap');

            body {
                background-color:aliceblue;
            }

            h2,p{
                text-align: center;
            }

            header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-sizing: border-box;
                padding: auto;
                height: 65px;
                background-color: #24252a;
            }

            .popup-content {
                background-color: #fefefe;
                margin: 8% auto;
                padding: 20px;
                border: 3px solid #24252a;
                width: 40%;
            }

            .popup-content label {
                display: inline-block;
                width: 250px;
            }

            table {
                display: flex;
                justify-content: center;
            }

            form{
                display: flex;
                justify-content: center;
            }

            input{
                display: flex;
                justify-content: center;
                width: 80px;
                height: 25px;
                padding: 5px;
                border-radius: 5px;
                border: 1px solid #24252a;
                background-color: #4CAF50;
                cursor: pointer;
                margin: 20px;

            }
        </style>
    </head>
    <body>

        <%
            String productId = request.getParameter("productId");

            if (productId != null && !productId.isEmpty()) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop2", "root", "admin");
                    PreparedStatement retrieve = con.prepareStatement("SELECT * FROM product WHERE prod_ID = ?");
                    retrieve.setString(1, productId);
                    ResultSet rs = retrieve.executeQuery();

                    //display product details
                    if (rs.next()) {


        %>

        <div class="popup-content">
            <h2>Delete <%=rs.getString("prod_Name")%> ?</h2>
            <p><b>Are you sure you want to delete the following product?</b></p>
            <table>
                <tr>
                    <td>Product ID :</td>
                    <td><%= productId%></td>
                </tr>
                <tr>
                    <td>Product Name :</td>
                    <td><%= rs.getString("prod_Name")%></td>
                </tr>
                <tr>
                    <td>Product Quantity :</td>
                    <td><%= rs.getString("prod_Qty")%></td>
                </tr>
                <tr>
                    <td>Product Price :</td>
                    <td><%= rs.getString("prod_Price")%></td>
                </tr>
            </table>
            <form action="DeleteProduct.jsp" method="post">
                <input type="hidden" name="id" value="<%= productId%>">
                <input type="submit" name="action" value="Delete">
                <input type="submit" name="action" value="Cancel">
            </form>


            <%
                        } else {
                            out.print("Product not found");
                        }
                    } catch (Exception e) {
                        // Handle any exceptions and send an error response
                        e.printStackTrace();
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    }
                } else {
                    out.println("Invalid ID");
                }
            %>

            <%
                //retrieve from the form value
                String action = request.getParameter("action");
                productId = request.getParameter("id");

                //make statement for delete from database
                if (action != null && action.equals("Delete")) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop2", "root", "admin");
                        PreparedStatement deleteStatement = con.prepareStatement("DELETE FROM product WHERE prod_ID = ?");
                        deleteStatement.setString(1, productId);
                        int delrs = deleteStatement.executeUpdate();

                        if (delrs > 0) {
                            out.println("Product deleted successfully.");
                            response.sendRedirect("ManageProduct.jsp");
                        } else {
                            out.println(productId);
                            out.println("Product not found or couldn't be deleted.");
                        }

                        con.close();
                    } catch (Exception e) {
                        out.println("Error: " + e);
                    }
                } else if (action != null && action.equals("Cancel")) {
                    // Redirect back to the previous page
                    response.sendRedirect("ManageProduct.jsp");
                }
            %>
    </body>
</html>
