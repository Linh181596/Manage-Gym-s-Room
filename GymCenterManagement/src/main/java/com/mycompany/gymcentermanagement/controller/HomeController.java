/**
 * =========================================================================
 * @file          : HomeController.java
 * @description   : Controller xử lý trang chủ công cộng, nạp danh sách gói tập động.
 * @author        : Nguyen Dai Duong (duongnd)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller;

import com.mycompany.gymcentermanagement.dao.GymPackageDAO;
import com.mycompany.gymcentermanagement.dao.impl.GymPackageDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.GymPackage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Public Home Page Controller.
 * Mapped to /home and /index.
 */
@WebServlet(name = "HomeController", urlPatterns = {"/home", "/index"})
public class HomeController extends HttpServlet {

    private final GymPackageDAO gymPackageDAO = new GymPackageDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<GymPackage> activePackages = gymPackageDAO.findAllActive();
            request.setAttribute("activePackages", activePackages);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("packagesLoadError", "Không thể tải danh sách gói tập.");
        }
        
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}
