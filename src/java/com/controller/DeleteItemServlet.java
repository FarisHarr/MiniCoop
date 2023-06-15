package com.controller;

import com.dao.DeleteItemDAO;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteitem")
public class DeleteItemServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // retrieve the item ID to delete from the request parameters
        int itemIdToDelete = Integer.parseInt(request.getParameter("id"));

        DeleteItemDAO deleteItemDAO = new DeleteItemDAO();
        deleteItemDAO.deleteItemFromCart(itemIdToDelete);

        response.getWriter().println("Item deleted successfully!");
    }
}
