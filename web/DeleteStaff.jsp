<%-- 
    Document   : DeleteStaff
    Created on : 4 Jun 2023, 11:28:53 pm
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Delete Staff</title>
    </head>
    <body>
        <h1>Delete Staff</h1>

        <%
            String staffID = request.getParameter("id");

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop", "root", "admin");
                Statement st = con.createStatement();
                int rowsDeleted = st.executeUpdate("DELETE FROM staff WHERE id ='" + staffID + "'");

                if (rowsDeleted > 0) {
                    out.println("Staff deleted successfully.");
                } else {
                    out.println("Staff not found or couldn't be deleted.");
                }

                con.close();
            } catch (Exception e) {
                out.println("Error: " + e);
            }
        %>

        <%-- Forward to ManageStaff.jsp --%>
        <%
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/ManageStaff.jsp");
        %>
    </body>
</html>


