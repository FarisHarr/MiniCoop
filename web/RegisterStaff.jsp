<%-- 
    Document   : RegisterStaff
    Created on : 3 Jun 2023, 2:24:36 pm
    Author     : FarisHarr
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
    </head>
    <body>
        <jsp:useBean id="staff" class="MiniCoop.com.RegisterStaff" scope="request"/>
        
        <% 
            staff.setEmail(request.getParameter("email"));
            staff.setPassword(request.getParameter("password"));
            staff.setName(request.getParameter("name"));
            staff.setPhone(request.getParameter("phone"));
            staff.setRole(request.getParameter("role"));
            
            int result ;
            
            Class.forName("com.mysql.jdbc.Driver");
            
            String myURL = "jdbc:mysql://localhost/minicoop";
            Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");
            
            String sInsertQry = "INSERT INTO staff(email, password, name, phone, role) VALUES (?,?,?,?,?) ";
            
            PreparedStatement myPS = myConnection.prepareStatement(sInsertQry);
            
            myPS.setString(1, staff.getEmail());
            myPS.setString(2, staff.getPassword());
            myPS.setString(3, staff.getName());
            myPS.setString(4, staff.getPhone());
            myPS.setString(5, staff.getRole());
            
            result = myPS.executeUpdate();
            
            myPS.close();
            myConnection.close();
            
            if (result > 0) {
                response.sendRedirect("LoginStaff.html"); // Redirect to login page
            } else {
                out.println("Registration failed. Please try again."); // Display error message
            }
        %>
    </body>
</html>
