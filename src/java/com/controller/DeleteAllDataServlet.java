package com.controller;

import com.dao.DeleteAllDataDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/deleteall")
public class DeleteAllDataServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            DeleteAllDataDAO.deleteAllData();
            out.println("All data in the cart table has been deleted successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error deleting data from the cart table: " + e.getMessage());
        }
    }
}
