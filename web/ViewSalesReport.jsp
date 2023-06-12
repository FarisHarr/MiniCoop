<%-- 
    Document   : ViewSalesReport
    Created on : 9 Jun 2023, 6:01:25?pm
    Author     : FarisHarr
--%>

<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*, javax.sql.*" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Owner</title>
    <link rel="stylesheet" type="text/css" href="ViewSalesReport.css">
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>

<!-- Navigation Bar -->

<body>
    <header>
        <div class="main">
            <img class="logo" src="logoRe.png" alt="logo">
            <nav>
                <ul class="nav_links">
                    <li><a href="ManageStaff.jsp">Manage Staff</a></li>
                    <li><a href="ViewSalesReport.jsp">View Sales</a></li>
                    <li><a href="Feedback.jsp">Feedback</a></li>
                </ul>
            </nav>
        </div>
        <nav>
            <li class="dropdown">
                <a class="nav-link">Account</a>
                <ul class="dropdown-content">
                    <!-- <li><a href="OwnerProfile.html">Edit Information</a></li> -->
                    <li><a href="StartPage.html">Sign Out</a></li>
                </ul>
            </li>
            <!-- <a href="CustomerProfile.html"><img class="profilePic" src="profileImg.png" alt="profileImg"></a> -->
        </nav>
    </header>

    <!-- CONTENT START HERE -->
    <div class="top-content">
        <h2>View Sales Report</h2>
        <button onclick="refreshSalesReport()">Refresh</button>
    </div>
    <div class="table">
        <table id="salesTable">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <%
                  try {
                    // Establish the database connection
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop", "root", "admin");

                    // Execute the SQL query to retrieve sales data
                    String sql = "SELECT * FROM sales";
                    Statement statement = conn.createStatement();
                    ResultSet resultSet = statement.executeQuery(sql);

                    // Iterate through the resultSet and generate the table rows dynamically
                    while (resultSet.next()) {
                %>
                <tr>
<!--                    <td><%= resultSet.getString("sales_id") %></td>-->
                    <td><%= resultSet.getString("title") %></td>
                    <td><%= resultSet.getInt("quantity") %></td>
                    <td><%= resultSet.getDouble("price") %></td>
                    <td><%= resultSet.getInt("quantity") * resultSet.getDouble("price") %></td>
                </tr>
                <%
                    }

                    // Close the database resources
                    resultSet.close();
                    statement.close();
                    conn.close();
                  } catch (Exception e) {
                    e.printStackTrace();
                  }
                %>
            </tbody>
        </table>
    </div>

    <script>
        // Refresh sales report by reloading the page
        function refreshSalesReport() {
            location.reload();
        }
    </script>
 <jsp:include flush="true" page="Footer.jsp" />
</body>

</html>

