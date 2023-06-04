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
    </head>
    <body>
        
        <!--Navigation Bar-->
    <body>
        <header>
            <div class="main">
                <img class="logo" src="logoRe.png" alt="logo">
                <nav>
                    <ul class="nav_links">
                        <li><a href="ManageStaff.jsp">Manage Staff</a></li>
                        <li><a href="ViewSalesReport.html">View Sales</a></li>
                    </ul>
                </nav>
            </div>
            <nav>
                <li class="dropdown">
                    <a class="nav-link">Account</a>
                    <ul class="dropdown-content">
                        <li><a href="OwnerProfile.html">Edit Information</a></li>
                        <li><a href="StartPage.html">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>
        
        <%
            String staffID = request.getParameter("id");

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop", "root", "admin");
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM staff WHERE id ='" + staffID + "'");

                if (rs.next()) {
                    String staffName = rs.getString("name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String role = rs.getString("role");

//        Edit Page
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
                <br><br>
                <input class="submit" type="submit" value="Update">
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

