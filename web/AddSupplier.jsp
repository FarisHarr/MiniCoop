<%-- 
    Document   : AddSupplier
    Created on : 29 Jun 2023, 10:37:22 pm
    Author     : FarisHarr
--%>

<%@ page import="com.model.AddSupplier" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.IOException" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="addsupp" class="com.model.AddSupplier" scope="request"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <%
            try {
                // Retrieve the form data from the request
//                addsupp.setSupplierID(Integer.parseInt(request.getParameter("supplierID")));
                addsupp.setSuppliername(request.getParameter("suppliername"));
                addsupp.setSupplieritems(request.getParameter("supplieritems"));
                addsupp.setSupplierphone(request.getParameter("supplierphone"));
                addsupp.setSupplierlocation(request.getParameter("supplierlocation"));


                // Prepare the SQL statement
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop2", "root", "admin");
                PreparedStatement st = con.prepareStatement("INSERT INTO supplier (supplier_Name, supplier_Items, supplier_Phone, supplier_Location) VALUES (?, ?, ?, ?)");
//                st.setInt(1, addsupp.getSupplierID());
                st.setString(1, addsupp.getSuppliername());
                st.setString(2, addsupp.getSupplieritems());
                st.setString(3, addsupp.getSupplierphone());
                st.setString(4, addsupp.getSupplierlocation());
                st.executeUpdate();     

                // Close the database connection
                st.close();
                con.close();

                // Redirect back to the ManageProduct.jsp page
                response.sendRedirect("ManageSupplier.jsp");

            } catch (Exception e) {
            out.println("Error: " + e.getMessage());
                e.printStackTrace();

            }
        %>
        
    </body>
</html>
