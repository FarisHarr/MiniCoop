/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controller;

import com.dao.ProductDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import javax.servlet.annotation.WebServlet;

/**
 *
 * @author FarisHarr
 */
@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            ProductDAO.deleteAllData();
            out.println("All data in the cart table has been deleted successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error deleting data from the cart table: " + e.getMessage());
        }
    }
}

  

