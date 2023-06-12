<%-- 
    Document   : ManageProduct
    Created on : 10 Jun 2023, 11:47:54?pm
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
        <title>Staff</title>
        <link rel="stylesheet" type="text/css" href="ManageProduct.css">
    </head>

    <!-- Navigation Bar -->

    <body>
        <header>
            <div class="main">
                <img class="logo" src="logoRe.png" alt="logo">
                <nav>
                    <ul class="nav_links">
                        <li><a href="ManagePayment.jsp">Manage Payment</a></li>
                        <li><a href="ManageProduct.jsp">Manage Product</a></li>
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


        <h2>Manage Product</h2>

        <button class="register-product-button" onclick="showPopup()">Add Product</button>

        <div class="popup">
            <div class="popup-content">
                <span class="close" onclick="hidePopup()">&times;</span>
                <h3>Add Product</h3>
                <form id="addProductForm" action="AddProduct.jsp" method="POST">
                    <input type="text" name="productcode" placeholder="Product Code" required><br><br>
                    <input type="text" name="productname" placeholder="Product Name" required><br><br>
                    <input type="number" name="quantity" placeholder="Quantity" required><br><br>
                    <input type="number" step="any" name="price" placeholder="Price"><br><br>
                    <input type="submit" value="Add Product"/>
                </form>
            </div>

        </div>

        <table>
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Action</th>
                </tr>
            <thead>

            <tbody>
                <%
                    try {
                        ResultSet rs;
                        PreparedStatement st;
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop", "root", "admin");

                        st = con.prepareStatement("SELECT * FROM product");
                        rs = st.executeQuery();

                        while (rs.next()) {
                %>
                <tr>
                    <td><%=rs.getString("prod_ID")%></td>
                    <td><%=rs.getString("prod_Name")%></td>
                    <td><%=rs.getInt("prod_Qty")%></td>
                    <td><%=rs.getDouble("prod_Price")%></td>
                    <td>
                        <button onclick="location.href = 'EditProduct.jsp?productId=<%= rs.getString("prod_ID")%>'">Update</button>
                        <button onclick="deleteProduct('<%= rs.getString("prod_ID")%>')">Delete</button>
                    </td>
                </tr>
                <%
                        }

                    } catch (Exception e) {

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



            function addProduct(event) {
                event.preventDefault(); // Prevent form submission

                // Get form data
                const form = document.getElementById("addProductForm");
                const productCode = form.elements["productcode"].value;
                const productName = form.elements["productname"].value;
                const price = form.elements["price"].value;
                const qty = form.elements["quantity"].value;

                // Create XMLHttpRequest object
                const xhr = new XMLHttpRequest();

                // Configure the request
                xhr.open("POST", "AddProduct.jsp", true);

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
                xhr.send("productcode=" + encodeURIComponent(productCode) + "&price=" + encodeURIComponent(price));
            }



            function deleteProduct(productId) {
                // Create XMLHttpRequest object
                const xhr = new XMLHttpRequest();

                // Configure the request
                xhr.open("POST", "DeleteProduct.jsp", true);

                // Set the request header
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                // Define the callback function
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            // Request was successful, navigate back to ManageProduct.jsp
                            window.location.href = "ManageProduct.jsp";
                        } else {
                            // Request failed, handle the error
                            console.error("Error: " + xhr.status);
                        }
                    }
                };


                // Send the request
                xhr.send("productId=" + encodeURIComponent(productId));
            }
        </script>
        
        <jsp:include flush="true" page="Footer.jsp" />
    </body>
</html>