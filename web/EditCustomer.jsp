<%-- 
    Document   : EditCustomer
    Created on : 5 Jun 2023, 9:57:42 pm
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile</title>
        <link rel="stylesheet" type="text/css" href="ManageStaff.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    </head>

    <!-- Navigation Bar -->

    <body>
        <header>
            <div class="main">
                <img class="logo" src="logoRe.png" alt="logo">
                <nav>
                    <ul class="nav_links">
                        <li><a href="homePage.html">Home</a></li>
                        <li><a href="ProductPage.html">Product</a></li>
                        <li><a href="ManageContactUs.html">Contact Us</a></li>
                    </ul>
                </nav>
            </div>
            <nav>
                <li class="dropdown">
                    <a class="nav-link">Account</a>
                    <ul class="dropdown-content">
                        <li><a href="CustomerProfile.jsp">Edit Information</a></li>
                        <li><a href="StartPage.html">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>

        <%
            String customerID = (String) session.getAttribute("customerID");

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop2", "root", "admin");
                PreparedStatement ps = con.prepareStatement("SELECT * FROM customer WHERE cust_ID = ? ");
                ps.setString(1, customerID);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    String email = rs.getString("cust_Email");
                    String customerName = rs.getString("cust_Name");
                    String phone = rs.getString("cust_Phone");
        %>
        <!-- Page -->
        <div class="popup-content">
            <form action="UpdateCustomer.jsp" method="post">
                <h3>Update Staff</h3>
                <input type="hidden" name="id" value="<%= customerID %>">
                <br>
                <label for="Name"> Name:</label>
                <input type="text" name="name" value="<%= customerName%>"><br>
                <br>
                <label for="email">Email:</label>
                <input type="email" name="email" value="<%= email%>"><br>
                <br>
                <label for="phone">Phone Number:</label>
                <input type="text" name="phone" value="<%= phone%>"><br>
                <br><br>
                <input class="submit" type="submit" value="Update">
            </form>
        </div>

        <%
                } else {
                    out.println("Customer not found.");
                }

                rs.close();
                ps.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (Exception e) {
                out.println("Error: " + e);
            }
        %>


    </body>
</html>


