<%-- 
    Document   : UpdateCustomer
    Created on : 5 Jun 2023, 9:41:53 pm
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Customer</title>
    </head>
    <body>
        <h1>Update Customer</h1>

        <% 
            String customerID = request.getParameter("id");
            String name = request.getParameter("username");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop", "root", "admin");
                Statement st = con.createStatement();
                int rowsUpdated = st.executeUpdate("UPDATE customer SET username = '" + name + "', email = '" + email + "', phone = '" + phone + "' WHERE id ='" + customerID + "'");

                if (rowsUpdated > 0) {
                    out.println("Customer updated successfully.");
                } else {
                    out.println("Customer not found or couldn't be updated.");
                }

                con.close();
            } catch (Exception e) {
                out.println("Error: " + e);
            }
        %>

        <%-- Forward to CustomerProfile.jsp or any other appropriate page --%>
        <%-- Replace "CustomerProfile.jsp" with the desired destination page --%>
        <%
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/CustomerProfile.jsp");
        %>
    </body>
</html>
