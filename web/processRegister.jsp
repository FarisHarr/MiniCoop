<%-- 
    Document   : processRegister
    Created on : 25 May 2023, 6:58:27 pm
    Author     : FarisHarr
--%>

<%@page import="java.sql.DriverManager"%>
<%@page  language="java" %>
<%@page  import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
    </head>
    <body>
        <jsp:useBean id="customer" class="MiniCoop.com.Register" scope="request"/>

        <%
            customer.setName(request.getParameter("name"));
            customer.setEmail(request.getParameter("email"));
            customer.setPassword(request.getParameter("password"));
            customer.setPhone(request.getParameter("phone"));

            int result;

            Class.forName("com.mysql.jdbc.Driver");

            String myURL = "jdbc:mysql://localhost/minicoop";
            Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");

            String sInsertQry = "INSERT INTO customer(username, email, password, phone) VALUES (?,?,?,?) ";

            PreparedStatement myPS = myConnection.prepareStatement(sInsertQry);

            myPS.setString(1, customer.getName());
            myPS.setString(2, customer.getEmail());
            myPS.setString(3, customer.getPassword());
            myPS.setString(4, customer.getPhone());

            result = myPS.executeUpdate();

            myConnection.close();

            if (result > 0) {
                response.sendRedirect("Login.jsp"); // Redirect to login page
                request.getRequestDispatcher("CustomerProfile.jsp");
            } else {
                out.println("Registration failed. Please try again."); // Display error message
            }
        %>
    </body>
</html>