<%-- 
    Document   : ManageSupplier
    Created on : 29 Jun 2023, 10:01:50?pm
    Author     : FarisHarr
--%>

<%@page import="java.sql.*" %>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- header -->
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manager</title>
        <link rel="stylesheet" type="text/css" href="CSS/ManageProduct.css">
    </head>

    <!-- Navigation Bar -->

    <body>
        <header>
            <div class="main">
                <img class="logo" src="IMG/logoRe.png" alt="logo">
                <nav>
                    <ul class="nav_links">
                        <li><a href="ManageProduct.jsp">Manage Product</a></li>
                        <li><a href="ManageSupplier.jsp">Manage Supplier</a></li>
                        <li><a href="Feedback.jsp">Feedback</a></li>
                    </ul>
                </nav>
            </div>
            <nav>
                <li class="dropdown">
                    <a class="nav-link">Account</a>
                    <ul class="dropdown-content">
                        <li><a href="StartPage.html">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>


        <h2>Manage Supplier</h2>

        <button class="register-product-button" onclick="showPopup()">Add Supplier</button>

        <div class="popup">
            <div class="popup-content">
                <span class="close" onclick="hidePopup()">&times;</span>
                <h3>Add Supplier</h3>
                <form id="addSupplierForm" action="AddSupplier.jsp" method="POST">
                    <input type="text" name="suppliercode" placeholder="Supplier Code" required><br><br>
                    <input type="text" name="suppliername" placeholder="Supplier Name" required><br><br>
                    <input type="text" name="supplieritems" placeholder="Supplier Items" required><br><br>
                    <input type="text" name="supplierlocation" placeholder="Supplier Location" required><br><br>
                    <input class="add" type="submit" value="Add Supplier"/>
                </form>
            </div>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Supplier ID</th>
                    <th>Supplier Name</th>
                    <th>Supplier Items</th>
                    <th>Location</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        ResultSet rs;
                        PreparedStatement st;
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop2", "root", "admin");

                        st = con.prepareStatement("SELECT * FROM supplier");
                        rs = st.executeQuery();

                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("supplier_ID")%></td>
                    <td><%= rs.getString("supplier_Name")%></td>
                    <td><%= rs.getString("supplier_Items")%></td>
                    <td><%= rs.getString("supplier_Location")%></td>
                    <td>

                        <button class="delete2" onclick="location.href = 'DeleteSupplier.jsp?supplierId=<%= rs.getString("supplier_ID")%>'">Delete</button>
<!--                    <button class="delete" onclick="location.href = 'DeleteSupplier.jsp?supplierId=<%= rs.getString("supplier_ID")%>'">
  <img src="IMG/deleteicon.png" alt="Delete Icon"> Delete-->
                    </td>
                </tr>
                <%
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>

        <script>
            function showPopup() {
                document.querySelector(".popup").style.display = "block";
            }

            function hidePopup() {
                document.querySelector(".popup").style.display = "none";
            }

            function addSupplier(event) {
                event.preventDefault(); // Prevent form submission

                // Get form data
                const form = document.getElementById("addSupplierForm");
                const supplierName = form.elements["supplierName"].value;
                const supplierItems = form.elements["supplierItems"].value;
                const supplierLocation = form.elements["supplierLocation"].value;

                // Create XMLHttpRequest object
                const xhr = new XMLHttpRequest();

                // Configure the request
                xhr.open("POST", "AddSupplier.jsp", true);

                // Set the request header
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                // Define the callback function
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            // Request was successful, handle the response if needed
                            // Reload the table or perform any other necessary actions
                            location.reload();
                        } else {
                            // Request failed, handle the error
                            console.error("Error: " + xhr.status);
                        }
                    }
                };

                // Send the request
                xhr.send("suppliercode=" + encodeURIComponent(supplierCode) + "&supplierName=" + encodeURIComponent(supplierName));
            }
        </script>


        <jsp:include flush="true" page="Footer.jsp" />
    </body> 
</html>
