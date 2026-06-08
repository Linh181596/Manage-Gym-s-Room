package com.mycompany.gymcentermanagement.controller.member;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Controller to handle Member Dashboard GET requests.
 * Mapped to /member/dashboard.
 */
@WebServlet(name = "MemberDashboardController", urlPatterns = {"/member/dashboard"})
public class MemberDashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/WEB-INF/views/member/dashboard.jsp").forward(request, response);
    }
}
