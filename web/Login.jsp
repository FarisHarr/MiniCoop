<%-- 
    Document   : Login
    Created on : 3 Jun 2023, 1:51:32?pm
    Author     : FarisHarr
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>

<%@ page language="java" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="Login.css">
        <title>Login</title>
    </head>
    <body>
        <div class="container">
            <div class="side">
                <img src="logoRe.png" alt="">
            </div>
            <form action="" class="form" method="POST">
                <h2>LOG IN</h2>
                <input type="email" name="email" class="box" placeholder="Enter Email" required>
                <input type="password" name="password" class="box" placeholder="Enter Password" required>
                <input type="submit" value="LOG IN" id="submit">
                <br>
                <%--
                    Add the following code to handle the login logic and set the session
                --%>
                <%
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");

                    if (email != null && password != null) {
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            String myURL = "jdbc:mysql://localhost/minicoop2";
                            Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");

                            String sSelectQry = "SELECT * FROM customer WHERE cust_Email = ? AND cust_Password = ?";
                            PreparedStatement myPS = myConnection.prepareStatement(sSelectQry);
                            myPS.setString(1, email);
                            myPS.setString(2, password);
                            ResultSet resultSet = myPS.executeQuery();

                            if (resultSet.next()) {
                                // User found, set session and redirect to home page
                                HttpSession loginsession = request.getSession();
                                session.setAttribute("customerID", resultSet.getString("cust_ID"));
                                response.sendRedirect("homePage.html");
                            } else {
                                // User not found, display error message
                                out.println("<span style='color: white;'>Invalid email or password. Please try again.</span>");
                            }

                            myConnection.close();
                        } catch (ClassNotFoundException | SQLException e) {
                            e.printStackTrace();
                            out.println("An error occurred. Please try again later.");
                        }
                    }
                %>

                <a href="ForgotPassword.html">Forgot Password?</a>
                <br>
                <p>Don't have an account? <a href="Register.html">Register Here</a></p>
                <br>
            </form>
        </div>
    </body>
</html>


