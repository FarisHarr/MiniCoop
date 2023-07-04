<%-- 
    Document   : Product
    Created on : 3 Jul 2023, 9:58:16 pm
    Author     : FarisHarr
--%>

<%@ page import="java.util.Base64" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page contentType="application/json; charset=UTF-8" %>

<%
    // Database connection details
    String url = "jdbc:mysql://localhost/minicoop2";
    String username = "root";
    String password = "admin";

    // SQL query to retrieve product data
    String query = "SELECT * FROM product";

    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        // Establish database connection
        connection = DriverManager.getConnection(url, username, password);
        statement = connection.createStatement();

        // Execute the query
        resultSet = statement.executeQuery(query);

        // Create a JSONArray to store the product data
        JSONArray productArray = new JSONArray();

        // Process the results
        while (resultSet.next()) {
            int id = resultSet.getInt("id");
            Blob imageBlob = resultSet.getBlob("image");
            String title = resultSet.getString("title");
            double price = resultSet.getDouble("price");

            // Check if the image is present
            if (imageBlob != null && imageBlob.length() > 0) {
                // Read the image data as bytes
                byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());

                // Generate the base64 representation of the image
                String base64Image = Base64.getEncoder().encodeToString(imageBytes);

                // Create a JSONObject for each product
                JSONObject productObject = new JSONObject();
                productObject.put("id", id);
                productObject.put("image", "data:image/png;base64," + base64Image);
                productObject.put("title", title);
                productObject.put("price", price);

                // Add the product to the JSONArray
                productArray.put(productObject);
            }
        }

        // Send the product data as the response
        out.print(productArray.toString());
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close the resources in a finally block to ensure they are always closed
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
