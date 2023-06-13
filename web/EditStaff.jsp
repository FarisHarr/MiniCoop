<%-- 
    Document   : EditStaff
    Created on : 4 Jun 2023, 11:28:40 pm
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Staff</title>
        <link rel="stylesheet" type="text/css" href="ManageStaff.css">
        <style>

            input.submit {
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
            
            input.cancel {
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

        <%
            String staffID = request.getParameter("staff_ID");
            String action = request.getParameter("action");

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop2", "root", "admin");
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM staff WHERE staff_ID ='" + staffID + "'");

                if (rs.next()) {
                    String staffName = rs.getString("staff_Name");
                    String email = rs.getString("staff_Email");
                    String phone = rs.getString("staff_Phone");
                    String role = rs.getString("staff_Role");
        %>
        <div class="popup-content">
            <form action="UpdateStaff.jsp" method="post">
                <h3>Update Staff</h3>
                <input type="hidden" name="id" value="<%= staffID%>">
                <br>
                <label for="staffName">Staff Name:</label>
                <input type="text" name="name" value="<%= staffName%>"><br>
                <br>
                <label for="email">Email:</label>
                <input type="email" name="email" value="<%= email%>"><br>
                <br>
                <label for="phone">Phone Number:</label>
                <input type="text" name="phone" value="<%= phone%>"><br>
                <br>
                <label for="role">Roles :</label>
                <select id="role" name="role">
                    <option value="Staff">Staff</option>
                    <option value="Store Manager">Store Manager</option>
                    <option value="Owner">Owner</option>
                </select>
                <br><br><br>
                <div class="submit-button">
                    <input class="submit" type="submit" value="Update">
                    <input class="cancel" type="button" value="Cancel" onclick="location.href = 'ManageStaff.jsp'">
                </div>
            </form>
        </div>
        <%
                } else {
                    out.println("Staff not found.");
                }

                con.close();
            } catch (Exception e) {
                out.println("Error: " + e);
            }
        %>

    </body>
</html>

