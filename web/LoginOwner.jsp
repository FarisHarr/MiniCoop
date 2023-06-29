<%-- 
    Document   : LoginOwner
    Created on : 29 Jun 2023, 9:00:05?pm
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
        <link rel="stylesheet" type="text/css" href="CSS/LoginStaff.css">
        <title>Login</title>
    </head>
    <body>
        <div class="container">
            <div class="side">
                <img src="IMG/logoRe.png" alt="">
            </div>
            <form action="" class="form" method="POST">
                <h2>LOG IN</h2>
                <h4>For Owner </h4>
                <input type="text" id="email" name="email" class="box" placeholder="Enter Email">
                <input type="password" id="password" name="password" class="box" placeholder="Enter Password">
                <input type="submit" class="login" value="LOGIN">
                <br>

                <%
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");

                    if (email != null && password != null) {
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            String myURL = "jdbc:mysql://localhost/minicoop2";
                            Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");

                            String sSelectQry = "SELECT * FROM staff WHERE staff_Email = ? AND staff_Password = ? ";
                            PreparedStatement myPS = myConnection.prepareStatement(sSelectQry);
                            myPS.setString(1, email);
                            myPS.setString(2, password);
                            ResultSet resultSet = myPS.executeQuery();

                            if (resultSet.next()) {
                                session.setAttribute("staffID", resultSet.getString("staff_ID"));
                                response.sendRedirect("ManageStaff.jsp");
                            } else {
                                // User not found, display error message
                                out.println("<span style='color: white;'>Invalid email or password. Please try again.</span>");
                            }

                            myConnection.close();
                        } catch (ClassNotFoundException | SQLException e) {
                            e.printStackTrace();
                            out.println("<span style='color: red;'>An error occurred. Please try again later.");
                        }
                    }
                %>
            </form>
        </div>
    </body>
</html>
