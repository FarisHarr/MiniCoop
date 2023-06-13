<%-- 
    Document   : proccessContatcUs
    Created on : 10 Jun 2023, 1:37:18 am
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page  language="java" %>
<%@page  import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contact Us Page</title>
    </head>
    <body>
        <jsp:useBean id="contact" class="com.model.ContactUs" scope="request"/>
        
        <%
            contact.setName(request.getParameter("name"));
            contact.setEmail(request.getParameter("email"));
            contact.setPhone(request.getParameter("phone"));
            contact.setMessage(request.getParameter("message"));
            
            int result;
            
            Class.forName("com.mysql.jdbc.Driver");
            
            String myURL = "jdbc:mysql://localhost/minicoop";
            Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");
            
            String sInsertQry = "INSERT INTO contactus(name, email, phone, message) VALUES (?, ?, ?, ?)";
            
            PreparedStatement myPS = myConnection.prepareStatement(sInsertQry);
            
            myPS.setString(1, contact.getName());
            myPS.setString(2, contact.getEmail());
            myPS.setString(3, contact.getPhone());
            myPS.setString(4, contact.getMessage());
            
            result = myPS.executeUpdate();
            
            myConnection.close();
            
            if(result > 0) {
                response.sendRedirect("homePage.html");
            } else {
                out.println("Registration failed. Please try again");
            }
         %>
    </body>
</html>
