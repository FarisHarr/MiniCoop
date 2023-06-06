<%-- 
    Document   : EditCustomer
    Created on : 5 Jun 2023, 9:57:42 pm
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Edit Customer</title>
        <link rel="stylesheet" type="text/css" href="CustomerProfile.css">
    </head>

    <body>
        <!-- Navigation Bar -->
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
                <!-- <a href="CustomerProfile.html"><img class="profilePic" src="profileImg.png" alt="profileImg"></a> -->
            </nav>
        </header>
        <%
            String customerID = request.getParameter("id");
            Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop", "root", "admin");
            Statement stat = connect.createStatement();
            ResultSet res = stat.executeQuery("SELECT * FROM customer WHERE id = '" + customerID + "'");

            if (res.next()) {
                String customerName = res.getString("username");
                String email = res.getString("email");
                String phone = res.getString("phone");

                //        Edit Page
        %>
        <!-- Page -->
        <div class="container">
            <div class="profile-left">
                <img src="profilePic.png" alt="profile picture" class="profile-picture">
                <br>
                <p>Aliff Najmi</p>
            </div>
            <div class="profile-right">
                <div class="title">
                    <h2>CUSTOMER PROFILE</h2>
                </div>
                <form action="UpdateCustomer.jsp" method="post">
                    <div class="profile-details">
                        <label class="profile-label">Name:</label>
                        <input type="text" name="username" class="box" value="<%= request.getParameter("username")%>">
                    </div>
                    <div class="profile-details">
                        <label class="profile-label">Email:</label>
                        <input type="text" name="email" class="box" value="<%= request.getParameter("email")%>">
                    </div>
                    <div class="profile-details">
                        <label class="profile-label">Phone Number:</label>
                        <input type="text" name="phone" class="box" value="<%= request.getParameter("phone")%>">
                    </div>
                    <button type="submit" class="profile-update-button">Update</button>
                </form>
            </div>
        </div>
        <%
            } else {
                out.println("Customer not found.");
            }
            connect.close();
        %>
    </body>

</html>


