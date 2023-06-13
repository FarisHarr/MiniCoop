<%-- 
    Document   : UpdateStaff
    Created on : 5 Jun 2023, 12:37:24 am
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Staff</title>
    </head>
    <body>
        <h1>Update Staff</h1>

        <%
            String staffID = request.getParameter("id");
            String staffName = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String role = request.getParameter("role");

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop2", "root", "admin");
                Statement st = con.createStatement();
                int rowsUpdated = st.executeUpdate("UPDATE staff SET staff_Name = '" + staffName + "', staff_Email = '" + email + "', staff_Phone = '" + phone + "', "
                + "staff_Role = '" + role + "' WHERE staff_ID ='" + staffID + "'");

                if (rowsUpdated > 0) {
                    out.println("Staff updated successfully.");
                } else {
                    out.println("Staff not found or couldn't be updated.");
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
