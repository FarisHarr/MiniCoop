<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Owner</title>
        <link rel="stylesheet" type="text/css" href="ManageStaff.css">
    </head>

    <body>
        <header>
            <div class="main">
                <img class="logo" src="logoRe.png" alt="logo">
                <nav>
                    <ul class="nav_links">
                        <li><a href="ManageStaff.jsp">Manage Staff</a></li>
                        <li><a href="ViewSalesReport.html">View Sales</a></li>
                    </ul>
                </nav>
            </div>
            <nav>
                <li class="dropdown">
                    <a class="nav-link">Account</a>
                    <ul class="dropdown-content">
                        <li><a href="OwnerProfile.html">Edit Information</a></li>
                        <li><a href="StartPage.html">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>

        <div class="top-content">
            <h2>Manage Staff</h2>
            <div class="search-container">
                <form class="search-bar">
                    <input type="search" placeholder="Search..." />
                    <button type="submit">
                        <img src="search (1).png" alt="searchlogo" />
                    </button>
                </form>
            </div>
            <button class="register-product-button" onclick="showPopup()">Register Staff</button>
        </div>

        <div class="popup" id="popup">
            <div class="popup-content">
                <span class="close" onclick="hidePopup()">&times;</span>
                <h3>Register Staff</h3>
                <br><br>
                <form action="RegisterStaff.jsp" method="POST">
                    <label for="email">Email :</label>
                    <input type="email" id="email" name="email" required>
                    <br><br>
                    <label for="password">Password :</label>
                    <input type="text" id="password" name="password" required>
                    <br><br>
                    <label for="name">Name :</label>
                    <input type="text" id="name" name="name" required>
                    <br><br>
                    <label for="phone">Phone Number :</label>
                    <input type="text" id="phone" name="phone" required>
                    <br><br>
                    <label for="role">Roles :</label>
                    <select id="role" name="role">
                        <option value="Staff">Staff</option>
                        <option value="Store Manager">Store Manager</option>
                        <option value="Owner">Owner</option>
                    </select>
                    <br><br>
                    <input class="submit" type="submit" value="Save">
                </form>
            </div>
        </div>

        <div class="table">
            <table id="table">
                <thead>
                    <tr>
                        <th>Staff ID</th>
                        <th>Staff Name</th>
                        <th>Email</th>
                        <th>Phone Number</th>
                        <th>Role</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop", "root", "admin");
                            Statement st = con.createStatement();
                            ResultSet rs = st.executeQuery("SELECT * FROM staff");

                            while (rs.next()) {
                                String staffID = rs.getString("id");
                                String staffName = rs.getString("name");
                                String email = rs.getString("email");
                                String phone = rs.getString("phone");
                                String role = rs.getString("role");

                                out.println("<tr>");
                                out.println("<td>" + staffID + "</td>");
                                out.println("<td>" + staffName + "</td>");
                                out.println("<td>" + email + "</td>");
                                out.println("<td>" + phone + "</td>");
                                out.println("<td>" + role + "</td>");
                                out.println("<td><a href='EditStaff.jsp?id=" + staffID + "'>Edit</a></td>");
                                out.println("<td><a href='DeleteStaff.jsp?id=" + staffID + "'>Delete</a></td>");
                                out.println("</tr>");
                            }

                            con.close();
                        } catch (Exception e) {
                            out.println("Error: " + e);
                        }
                    %>
                </tbody>
            </table>
        </div>

        <script>
            function showPopup() {
                document.getElementById("popup").style.display = "block";
            }

            function hidePopup() {
                document.getElementById("popup").style.display = "none";
            }
        </script>
    </body>

</html>
