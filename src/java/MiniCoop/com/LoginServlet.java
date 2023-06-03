
package MiniCoop.com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author FarisHarr
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        // Perform database validation
        boolean isValid = false;

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");

            String myURL = "jdbc:mysql://localhost/minicoop";
            String username = "root";
            String dbPassword = "admin";

            connection = DriverManager.getConnection(myURL, username, dbPassword);

            String query = "SELECT * FROM staff WHERE email=? AND password=? AND role=?";
            statement = connection.prepareStatement(query);
            statement.setString(1, email);
            statement.setString(2, password);
            statement.setString(3, userType);

            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                isValid = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (statement != null) {
                try {
                    statement.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        if (isValid) {
            // Redirect to respective pages based on user type
            if (userType.equals("staff")) {
                response.sendRedirect("ManagePayment.html");
            } else if (userType.equals("manager")) {
                response.sendRedirect("ManageStock.html");
            } else if (userType.equals("owner")) {
                response.sendRedirect("ManageStaff.html");
            }
        } else {
            response.getWriter().println("Invalid credentials. Please try again.");
        }
    }
}
