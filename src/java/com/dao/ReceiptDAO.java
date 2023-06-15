
package com.dao;
import java.sql.*;

/**
 *
 * @author FarisHarr
 */
public class ReceiptDAO {

    public void AddDataToReceipt(int itemId, double itemPrice, String itemTitle) {

        ResultSet rs;
        PreparedStatement st;
        Connection con = null;
        try {
            
            
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop2", "root", "admin");
            
            st = con.prepareStatement("");
        } catch (Exception e) {

        }
    }

}
