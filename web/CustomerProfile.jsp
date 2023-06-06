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
        <link rel="stylesheet" type="text/css" href="CustomerProfile.css">
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
                        <li><a href="CustomerProfile.html">Edit Information</a></li>
                        <li><a href="StartPage.html">Sign Out</a></li>
                    </ul>
                </li>
                <!-- <a href="CustomerProfile.html"><img class="profilePic" src="profileImg.png" alt="profileImg"></a> -->
            </nav>
        </header>

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
                <div class="profile-details">
                    <label class="profile-label">Name : </label>
                    <input type="text" id="usernamename" class="box">
                </div>
                <div class="profile-details">
                    <label class="profile-label">Email:</label>
                    <input type="text" id="email" class="box">
                </div>
                <div class="profile-details">
                    <label class="profile-label">Phone Number:</label>
                    <input type="text" id="phone" class="box">
                </div>
                <a href="EditCustomer.jsp?id=<%= request.getParameter("id")%>">
                    <button class="profile-update-button">Update</button>
                </a>

            </div>
        </div>

        <script>
            <%-- Fetch customer information from the database --%>
            <%@ page import="java.util.*" %>
            <%@ page import="com.mysql.jdbc.*" %>
            <%@ page import="java.sql.*" %>
            <%-- Fetch customer information from the database --%>
            <%
                String customerID = "1"; // Assuming the customer ID is hardcoded for now, replace it with appropriate logic
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop", "root", "admin");
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("SELECT * FROM customer WHERE id ='" + customerID + "'");

                    if (rs.next()) {
                        String customerName = rs.getString("name");
                        String email = rs.getString("email");
                        String address = rs.getString("address");
                        String phone = rs.getString("phone");
            %>
            document.getElementById("profile-name").value = "<%= customerName%>";
            document.getElementById("profile-email").value = "<%= email%>";
            document.getElementById("profile-address").value = "<%= address%>";
            document.getElementById("profile-phone").value = "<%= phone%>";
            <%
                    } else {
                        out.println("Customer not found.");
                    }

                    rs.close();
                    st.close();
                    con.close();
                } catch (Exception e) {
                    out.println("Error: " + e);
                }
            %>
        </script>
    </body>
</html>
