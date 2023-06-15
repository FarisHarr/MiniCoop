<%-- 
    Document   : CustomerProfile
    Created on : 5 Jun 2023, 5:08:29 pm
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile</title>
        <link rel="stylesheet" type="text/css" href="CSS/CustomerProfile.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    </head>

    <!-- Navigation Bar -->

    <body>
        <header>
            <div class="main">
                <img class="logo" src="IMG/logoRe.png" alt="logo">
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
                        <li><a href="CustomerProfile.html">Edit Information</a></li>
                        <li><a href="StartPage.html">Sign Out</a></li>
                    </ul>
                </li>
                <!-- <a href="CustomerProfile.html"><img class="profilePic" src="profileImg.png" alt="profileImg"></a> -->
            </nav>
        </header>

        <%
//           HttpSession loginsession = request.getSession();
            String customerID = (String) session.getAttribute("customerID");

            if (customerID != null) {
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
        <div class="container">
            <div class="profile-left">
                <img src="IMG/profilePic.png" alt="profile picture" class="profile-picture">
                <br>
            </div>
            <div class="profile-right">
                <div class="title">
                    <h2>CUSTOMER PROFILE</h2>
                </div>
                <div class="profile-details">
                    <label for="Name">Name:</label>
                    <input type="text" name="name" value="<%= customerName%>" class="box">
                </div>
                <div class="profile-details">
                    <label for="email">Email:</label>
                    <input type="email" name="email" value="<%= email%>" class="box">
                </div>
                <div class="profile-details">
                    <label for="phone">Phone Number:</label>
                    <input type="text" name="phone" value="<%= phone%>" class="box">
                </div>
                <a href="EditCustomer.jsp?id=<%= customerID%>">
                    <button class="profile-update-button">Update</button>
                </a>
            </div>
        </div>

        <%
                    } else {
                        out.println("Customer not found.");
                    }

                    rs.close();
                    ps.close();
                    con.close();
                } catch (Exception e) {
                    out.println("Error: " + e);
                }
            } else {
                // If the session doesn't exist or customerID is not set, redirect to the login page
                response.sendRedirect("Login.jsp");
            }
        %>

    </body>
</html>



