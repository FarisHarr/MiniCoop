<%-- 
    Document   : LoginStaff
    Created on : 3 Jun 2023, 3:37:55?pm
    Author     : FarisHarr
--%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="LoginStaff.css">
        <title>Login Page</title>
    </head>
    <body>
        <div class="container">
            <div class="side">
                <img src="logoRe.png" alt="">
            </div>
            <form action="LoginServlet" class="form" method="post">
                <h2>LOG IN</h2>
                <h4>For Employee</h4>
                <div class="radio-group">
                    <input type="radio" id="staff" name="user-type" value="staff">
                    <label for="staff">Staff</label>
                    <input type="radio" id="manager" name="user-type" value="manager">
                    <label for="manager">Manager</label>
                    <input type="radio" id="owner" name="user-type" value="owner">
                    <label for="owner">Owner</label>
                </div>
                <input type="text" id="email" name="email" class="box" placeholder="Enter Email">
                <input type="password" id="password" name="password" class="box" placeholder="Enter Password">
                <button type="submit" id="submit">LOGIN</button
            </form>
        </div>
    </body>
</html>

