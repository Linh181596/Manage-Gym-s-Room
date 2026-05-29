package com.mycompany.gymcentermanagement.controller.pt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Controller to handle Personal Trainer Dashboard GET requests.
 * Mapped to /pt/dashboard.
 */
@WebServlet(name = "PtDashboardController", urlPatterns = {"/pt/dashboard"})
public class PtDashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/WEB-INF/views/pt/dashboard.jsp").forward(request, response);
    }
}
