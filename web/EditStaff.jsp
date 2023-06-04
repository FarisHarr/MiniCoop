<%-- 
    Document   : EditStaff
    Created on : 4 Jun 2023, 11:28:40 pm
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Edit Staff</title>
</head>
<body>
  <h1>Edit Staff</h1>

  <%
    String staffID = request.getParameter("id");

    try {
      Class.forName("com.mysql.jdbc.Driver");
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop", "root", "admin");
      Statement st = con.createStatement();
      ResultSet rs = st.executeQuery("SELECT * FROM staff WHERE id ='" + staffID + "'");

      if (rs.next()) {
        String staffName = rs.getString("name");
        String email = rs.getString("email");
        String phone = rs.getString("phone");
        String role = rs.getString("role");

        %>
        <form action="ManageStaff.jsp" method="post">
          <input type="hidden" name="id" value="<%= staffID %>">
          <label for="staffName">Staff Name:</label>
          <input type="text" name="name" value="<%= staffName %>"><br>
          <label for="email">Email:</label>
          <input type="email" name="email" value="<%= email %>"><br>
          <label for="phone">Phone Number:</label>
          <input type="text" name="phone" value="<%= phone %>"><br>
          <label for="role">Role:</label>
          <input type="text" name="role" value="<%= role %>"><br>
          <input type="submit" value="Update">
        </form>
        <%
      } else {
        out.println("Staff not found.");
      }

      con.close();
    } catch (Exception e) {
      out.println("Error: " + e);
    }
  %>
</body>
</html>

