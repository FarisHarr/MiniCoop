package com.controller;

import com.dao.ReceiptDAO;
import com.dao.SaveDAO;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/savecart")
public class SaveServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the item data from the request parameters
        int itemId = Integer.parseInt(request.getParameter("id"));
        double itemPrice = Double.parseDouble(request.getParameter("price"));
        String itemTitle = request.getParameter("title");

        SaveDAO saveDAO = new SaveDAO();
        saveDAO.saveItemToCartFromServlet(itemId, itemPrice, itemTitle);

        ReceiptDAO receiptDAO = new ReceiptDAO();
        receiptDAO.AddDataToReceipt(itemId, itemPrice, itemTitle);
        
        response.getWriter().println("Item saved successfully!");
    }
}