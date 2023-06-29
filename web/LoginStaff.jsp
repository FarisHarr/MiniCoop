<%-- 
    Document   : LoginStaff
    Created on : 3 Jun 2023, 3:37:55?pm
    Author     : FarisHarr
--%>

<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/LoginStaff.css">
        <title>Login Page</title>
    </head>
    <body>
        <div class="container">
            <div class="side">
                <img src="IMG/logoRe.png" alt="">
            </div>
            <form action="" class="form" method="POST">
                <h2>LOG IN</h2>
                <h4>For Employee </h4>
                <div class="radio-group">
                    <input type="radio" id="staff" name="user-type" value="staff">
                    <label for="staff">Staff</label>
                    <input type="radio" id="manager" name="user-type" value="manager">
                    <label for="staff">Manager</label>
<!--                    <input type="radio" id="owner" name="user-type" value="owner">
                    <label for="owner">Owner</label>-->
                </div>
                <input type="text" id="email" name="email" class="box" placeholder="Enter Email">
                <input type="password" id="password" name="password" class="box" placeholder="Enter Password">
                <input type="submit" class="login" value="LOGIN">
                <br>
                
                 <%-- Java code to handle form submission --%>
        <%
            if (request.getMethod().equals("POST")) {
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String userType = request.getParameter("user-type");

                if (email != null && password != null && userType != null) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        String myURL = "jdbc:mysql://localhost/minicoop2";
                        Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");

                        String sSelectQry = "SELECT * FROM staff WHERE staff_Email = ? AND staff_Password = ? AND staff_Role = ?";
                        PreparedStatement myPS = myConnection.prepareStatement(sSelectQry);
                        myPS.setString(1, email);
                        myPS.setString(2, password);
                        myPS.setString(3, userType);
                        ResultSet resultSet = myPS.executeQuery();

                        if (resultSet.next()) {
                            if (userType.equals("staff")) {
                                // Redirect to staff page
                                response.sendRedirect("ManagePayment.jsp");
                            } else if (userType.equals("manager")) {
                                // Redirect to owner page
                                response.sendRedirect("ManageStock.html");
                            } 
//                            else if (userType.equals("owner")) {
//                                // Redirect to owner page
//                                response.sendRedirect("ManageStaff.jsp");
//                            }
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
            }
        %>
            </form>
        </div>
     
    </body>
</html>


