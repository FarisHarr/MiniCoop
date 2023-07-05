<%-- 
    Document   : CustomerInfo
    Created on : 29 Jun 2023, 9:42:40?pm
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
        <title>Staff</title>
        <link rel="stylesheet" type="text/css" href="CSS/ViewSalesReport.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <style>

            footer {
                background-color: #24252a;
                height: 70px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            p {
                color: white;
            }

        </style>
    </head>

    <!-- Navigation Bar -->

    <body>
        <header>
            <div class="main">
                <img class="logo" src="IMG/logoRe.png" alt="logo">
                <nav>
                    <ul class="nav_links">
                        <li><a href="ManagePayment.jsp ">Manage Payment</a></li>
                        <li><a href="CustomerInfo.jsp">Customer Information</a></li>
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
            <h2>Customer Information</h2>
            <button onclick="refreshSalesReport()">Refresh</button>
        </div>
        <div class="table2">
            <table id="salesTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            // Establish the database connection
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop2", "root", "admin");

                            // Execute the SQL query to retrieve sales data
                            String sql = "SELECT * FROM customer";
                            Statement statement = conn.createStatement();
                            ResultSet resultSet = statement.executeQuery(sql);

                            // Iterate through the resultSet and generate the table rows dynamically
                            while (resultSet.next()) {
                    %>
                    <tr>

                        <td><%= resultSet.getString("cust_ID")%></td>
                        <td><%= resultSet.getString("cust_Name")%></td>
                        <td><%= resultSet.getString("cust_Email")%></td>
                        <td><%= resultSet.getString("cust_Phone")%></td>

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
    </body>
    <footer>
        <p>&copy; MiniCoop 2023</p>
    </footer>
</html>
