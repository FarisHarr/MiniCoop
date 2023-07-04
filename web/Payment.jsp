<%-- 
    Document   : Payment
    Created on : 4 Jul 2023, 1:11:09 am
    Author     : FarisHarr
--%>

<%@page import="com.dao.CartDAO.CartItem"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.dao.CartDAO"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- header -->
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Payment</title>
        <link rel="stylesheet" type="text/css" href="CSS/Payment.css">

        <style>

            footer {
                background-color: #24252a;
                height: 70px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-top: 30px;
            }

            p1 {
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
                        <li><a href="homePage.html">Home</a></li>
                        <li><a href="ProductPage.html">Product</a></li>
                        <li><a href="ManageContactUs.html">Contact Us</a></li>
                    </ul>
                </nav>
            </div>
            <nav>
                <li class="dropdown">
                    <a class="nav-link">Account</a>
                    <ul class="dropdown-content">
                        <li><a href="CustomerProfile.jsp">Edit Information</a></li>
                        <li><a href="StartPage.html">Sign Out</a></li>
                    </ul>
                </li>
                <!-- <a href="CustomerProfile.html"><img class="profilePic" src="profileImg.png" alt="profileImg"></a> -->
            </nav>
        </header>

        <!-- content -->
        <h2>Payment</h2><br>

        <div class='container'>
            <div class='window'>
                <div class='order-info'>
                    <div class='order-info-content'>
                        <h2>Order Summary</h2>
                        <div class='line'></div>
                        <table class='order-table'>
                            <tbody>
                                <%
                                    String customerID = (String) session.getAttribute("customerID");

                                    // Instantiate the CartDataRetriever class and invoke the getCartItems method
                                    CartDAO cartDataRetriever = new CartDAO();
                                    List<CartItem> cartItems = cartDataRetriever.getCartItems();

                                    double totalPrice = 0.0;

                                    // Iterate over the cartItems and display the data
                                    for (CartItem cartItem : cartItems) {
                                        double itemPrice = cartItem.getProdPrice();
                                        int itemQuantity = cartItem.getProdQty();
                                        double itemTotalPrice = itemPrice * itemQuantity;
                                        totalPrice += itemTotalPrice;
                                %>
                            <div>
                                <h3>Item: <%= cartItem.getProdName()%></h3>
                                <p>Price: $<%= cartItem.getProdPrice()%></p>
                                <p>Quantity: <%= cartItem.getProdQty()%></p>
                                <p>Total Price: $<%= itemTotalPrice%></p>
                            </div>
                            <% }%>

                            <h2>Total Price: $<%= totalPrice%></h2>
                            </tbody>

                        </table>
                    </div>
                </div>
                <div class='payment'>
                    <div class='payment-content'>
                        <div class='half-input-table'>
                            <p>ONLINE TRANSFER</p>
                            <img src="IMG/accountNumber.jpg" width="1000" height="1000">
                            <p>QR CODE</p>
                            <img src="IMG/QrcodE.jpg" alt="QrCode">
                        </div>

                        <br>
                        Please submit your receipt here:
                        <input type="file" class='input-field' name="receiptFile" required>

                        <form action="receiptProcess.jsp" method="post">
                            <%
                                int i = 0;
                                for (CartItem cartItem : cartItems) {
                                    String prodName = cartItem.getProdName();
                                    int prodQty = cartItem.getProdQty();
                                    double prodPrice = cartItem.getProdPrice();
                            %>
                            <input type="hidden" name="prodName_<%= i%>" value="<%= prodName%>">
                            <input type="hidden" name="prodQty_<%= i%>" value="<%= prodQty%>">
                            <input type="hidden" name="prodPrice_<%= i%>" value="<%= prodPrice%>">
                            <% i++;
                                }%>
                            <input type="hidden" name="numItems" value="<%= i%>">
                            <button type="submit" class="pay-btn">Checkout</button>
                        </form>



                    </div>
                </div>
            </div>
        </div>
        <br>
    </body>
    <footer>
        <p1>&copy; MiniCoop 2023</p>
    </footer>
</html>
