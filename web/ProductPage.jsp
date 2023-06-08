<%-- 
    Document   : ProductPage
    Created on : 8 Jun 2023, 12:24:18 pm
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="ProductPage.css">
        <script src="https://kit.fontawesome.com/92d70a2fd8.js" crossorigin="anonymous"></script>
        <title>Product Page</title>
    </head>
    
    <!--Navigation Bar-->
    <body>
        <header>
            <div class="main">
                <img class="logo" src="logoRe.png" alt="logo">
                <nav>
                    <ul class="nav_links">
                        <li><a href="homePage.jsp">Home</a></li>
                        <li><a href="ProductPage.jsp">Product</a></li>
                        <li><a href="ManageContactUs.jsp">Contact Us</a></li>
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
                <!-- <a href="CustomerProfile.jsp"><img class="profilePic" src="profileImg.png" alt="profileImg"></a> -->
            </nav>
        </header>
        
        <!--Page-->
        <div class="body">
            <div class="top">
                <p class="text">MINI COOP PRODUCT</p>
                <div class="cart"><i class="fa-solid fa-cart-shopping"></i><p id="count">0</p></div>
            </div>
            <div class="container">
                <div id="root"></div>
                <div class="sidebar">
                    <div class="head"><p>My Cart</p></div>
                    <div id="cartItem">Your cart is empty</div>
                    <div class="foot">
                        <h3>Total</h3>
                        <h2 id="total">$ 0.00</h2>
                    </div>
                </div>
            </div>
        </div>
        <script>
            const product = [
            {
                id: 0,
                image: 'product1.png',
                title: 'CHEMISTRY BOOK',
                price: 30,
            },
            {
                id: 1,
                image: 'product2.png',
                title: 'PHYSIC BOOK',
                price: 35,
            },
            {
                id: 2,
                image: 'product3.png',
                title: 'LANYARD',
                price: 10,
            },
            {
                id: 3,
                image: 'product4.png',
                title: 'ERASER',
                price: 1,
            },
            {
                id: 4,
                image: 'product5.png',
                title: 'BLACK PEN',
                price: 5,
            },
            {
                id: 5,
                image: 'product6.png',
                title: 'BLUE PEN',
                price: 5,
            }
        ];
        const categories = [...new Set(product.map((item)=>
            {return item}))]
            let i=0;
        document.getElementById('root').innerHTML = categories.map((item)=>
        {
            var {image, title, price} = item;
            return(
                `<div class='box'>
                    <div class='img-box'>
                        <img class='images' src=${image}></img>
                    </div>
                <div class='bottom'>
                <p>${title}</p>
                <h2>$ ${price}.00</h2>`+
                "<button onclick='addtocart("+(i++)+")'>Add to cart</button>"+
                `</div>
                </div>`
            )
        }).join('')

        var cart =[];

        function addtocart(a){
            cart.push({...categories[a]});
            displaycart();
            
            //send an AJAX request to saveCart.jsp
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "SaveCart.jsp", true);
            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            
            //create a parameter string with the cart data
            var params = "id=" + categories[a].id + 
                                    "&price=" + categories[a].price + 
                                    "&title=" + categories[a].title;
                            
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    console.log(xhr.responseText); //handle the response from the server
                }
            };
            
            //send the request
            xhr.send(params);
        }
        
        function delElement(a){
            var item = cart[a];
            var itemId = item.id;
            
            //send an AJAX request to deleteCart.jsp
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "DeleteCart.jsp", true);
            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            
            //create a parameter string with the item ID
            var params = "id=" + itemId;
            
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    //on success, remove the item from the cart and update the display
                    cart.splice(a, 1);
                    displaycart();
                }
            };
            
            //send the request
            xhr.send(params);
        }

        function displaycart(){
            let j = 0, total=0;
            document.getElementById("count").innerHTML=cart.length;
            if(cart.length==0){
                document.getElementById('cartItem').innerHTML = "Your cart is empty";
                document.getElementById("total").innerHTML = "$ "+0+".00";
            }
            else{
                document.getElementById("cartItem").innerHTML = cart.map((items)=>
                {
                    var {image, title, price} = items;
                    total=total+price;
                    document.getElementById("total").innerHTML = "$ "+total+".00";
                    return(
                        `<div class='cart-item'>
                        <div class='row-img'>
                            <img class='rowimg' src=${image}>
                        </div>
                        <p style='font-size:12px;'>${title}</p>
                        <h2 style='font-size: 15px;'>$ ${price}.00</h2>`+
                        "<i class='fa-solid fa-trash' onclick='delElement("+ (j++) +")'></i></div>"
                    );
                }).join('');
            }

        }
        </script>
    </body>
</html>

