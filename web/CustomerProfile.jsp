<%-- 
    Document   : CustomerProfile
    Created on : 5 Jun 2023, 5:08:29 pm
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
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
                        <li><a href="CustomerProfile.jsp">Edit Information</a></li>
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
            </div>
            <div class="profile-right">
                <div class="title">
                    <h2>CUSTOMER PROFILE</h2>
                </div>
                <%
                    String username = request.getParameter("username");
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost/minicoop", "root", "admin");
                        if (!cn.isClosed()) {
                            if (username != null) {
                                String newUsername = request.getParameter("newUsername");
                                String email = request.getParameter("email");
                                String phone = request.getParameter("phone");

                                PreparedStatement updatePs = cn.prepareStatement("UPDATE customer SET username=?, email=?, phone=? WHERE username=?");
                                updatePs.setString(1, newUsername);
                                updatePs.setString(2, email);
                                updatePs.setString(3, phone);
                                updatePs.setString(4, username);
                                updatePs.executeUpdate();

                                // Redirect to a success page or display a success message
                                response.sendRedirect("success.jsp");

                                updatePs.close();
                            } else {
                                PreparedStatement selectPs = cn.prepareStatement("SELECT * FROM customer WHERE username=?");
                                selectPs.setString(1, username);
                                ResultSet rs = selectPs.executeQuery();

                                if (rs.next()) {
                %>

                <div class="profile-details">
                    <label class="profile-label">Username :</label>
                    <input type="text" name="newUsername" value="<%= rs.getString("username")%>">
                </div>
                <div class="profile-details">
                    <label class="profile-label">Email:</label>
                    <input type="email" name="email" value="<%= rs.getString("email")%>">
                </div>
                <div class="profile-details">
                    <label class="profile-label">Phone Number:</label>
                    <input type="text" name="phone" value="<%= rs.getString("phone")%>">
                </div>
                <form method="post" action="">
                    <input type="hidden" name="username" value="<%= rs.getString("username")%>">
                    <input type="submit" value="Update" class="submit">
                </form>

                <%
                                } else {
                                    out.println("RECORD NOT EXIST!");
                                }
                                rs.close();
                                selectPs.close();
                            }
                        }
                        cn.close();
                    } catch (Exception e) {
                        out.println("The error is: " + e.getMessage());
                    }
                %>


                <input type="submit" value="Update" class="submit">


                <!--<p class="profile-update-button"><a href="CustomerController?action=edit">Update</a></p>-->
            </div>
        </div>
    </body>
</html>
