<%-- 
    Document   : DeleteSupplier
    Created on : 29 Jun 2023, 10:37:13 pm
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Delete Supplier</title>

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
        <%-- Retrieve the supplier ID from the request parameter --%>
        <% String supplierID = request.getParameter("supplier_ID"); %>

        <%-- Check if the supplier ID is present --%>
        <% if (supplierID != null && !supplierID.isEmpty()) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop2", "root", "admin");
                    PreparedStatement pst = con.prepareStatement("SELECT * FROM supplier WHERE supplier_ID = ?");
                    pst.setString(1, supplierID);
                    ResultSet rs = pst.executeQuery();

                    if (rs.next()) {
                        String supplierName = rs.getString("supplier_Name");
                        String supplierItems = rs.getString("supplier_Items");
                        String supplierLocation = rs.getString("supplier_Location");
        %>
        <div class="popup-content">
            <h2>Delete Supplier</h2>
            <p><b>Are you sure you want to delete the following supplier?</b></p>
            <table>
                <tr>
                    <td>ID :</td>
                    <td><%= supplierID%></td>
                </tr>
                <tr>
                    <td>Name :</td>
                    <td><%= supplierName%></td>
                </tr>
                <tr>
                    <td>Items :</td>
                    <td><%= supplierItems%></td>
                </tr>
                <tr>
                    <td>Location :</td>
                    <td><%= supplierLocation%></td>
                </tr>
            </table>
            <form action="DeleteSupplier.jsp" method="post">
                <input type="hidden" name="supplier_ID" value="<%= supplierID%>">
                <input type="submit" name="action" value="Delete">
                <input type="submit" name="action" value="Cancel">
            </form>
        </div>
        <%
                    } else {
                        // Supplier not found
                        out.println("Supplier not found.");
                    }

                    // Close the database resources
                    rs.close();
                    pst.close();
                    con.close();
                } catch (Exception e) {
                    // Handle any exceptions and display an error message
                    out.println("Error: " + e.getMessage());
                    e.printStackTrace();
                }

            } else {
                // Invalid supplier ID
                out.println("Invalid supplier ID.");
            }
        %>


        <%-- Process the form submission --%>
        <% String action = request.getParameter("action");
            if (action != null && action.equals("Delete")) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop2", "root", "admin");
                    PreparedStatement pst = con.prepareStatement("DELETE FROM supplier WHERE supplier_ID = ?");
                    pst.setString(1, supplierID);
                    int rowsDeleted = pst.executeUpdate();

                    if (rowsDeleted > 0) {
                        out.println("Supplier deleted successfully.");
                        response.sendRedirect("ManageSupplier.jsp");
                    } else {
                        out.println("Supplier not found or couldn't be deleted.");
                    }

                    con.close();
                } catch (Exception e) {
                    out.println("Error: " + e);
                }
            } else if (action != null && action.equals("Cancel")) {
                // Redirect back to the previous page
                response.sendRedirect("ManageSupplier.jsp");
            }%>

        <script>
            function goBack() {
                // Redirect back to the previous page
                history.go(-1);
            }
        </script>
    </body>
</html>
