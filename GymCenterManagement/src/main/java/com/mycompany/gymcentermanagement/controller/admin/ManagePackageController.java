/**
 * =========================================================================
 * @file          : ManagePackageController.java
 * @description   : Controller quản lý CRUD gói tập cho Admin
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-01 bởi Nguyễn Hoàng Thắng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.model.entity.GymPackage;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.GymPackageService;
import com.mycompany.gymcentermanagement.service.impl.GymPackageServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "ManagePackageController", urlPatterns = {"/admin/packages"})
public class ManagePackageController extends HttpServlet {

    private final GymPackageService gymPackageService = new GymPackageServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "create":
                    request.setAttribute("formTitle", "Thêm gói tập mới");
                    request.getRequestDispatcher("/WEB-INF/views/admin/package-form.jsp").forward(request, response);
                    break;
                case "edit":
                    String idStr = request.getParameter("id");
                    if (idStr != null) {
                        int id = Integer.parseInt(idStr);
                        GymPackage pkg = gymPackageService.getPackageById(id);
                        if (pkg != null) {
                            request.setAttribute("pkg", pkg);
                            request.setAttribute("formTitle", "Sửa gói tập");
                            request.getRequestDispatcher("/WEB-INF/views/admin/package-form.jsp").forward(request, response);
                            return;
                        }
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/packages");
                    break;
                case "delete":
                    String delIdStr = request.getParameter("id");
                    if (delIdStr != null) {
                        int id = Integer.parseInt(delIdStr);
                        gymPackageService.deletePackage(id);
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/packages");
                    break;
                case "list":
                default:
                    List<GymPackage> list = gymPackageService.getAllPackages();
                    request.setAttribute("packages", list);
                    request.getRequestDispatcher("/WEB-INF/views/admin/package-list.jsp").forward(request, response);
                    break;
            }
        } catch (SQLException | NumberFormatException ex) {
            request.setAttribute("errorMessage", "Lỗi xử lý yêu cầu: " + ex.getMessage());
            try {
                List<GymPackage> list = gymPackageService.getAllPackages();
                request.setAttribute("packages", list);
            } catch (SQLException sqle) {
                // Ignore
            }
            request.getRequestDispatcher("/WEB-INF/views/admin/package-list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");
        String creatorName = (currentUser != null) ? currentUser.getFullName() : "Admin";

        String idStr = request.getParameter("packageId");
        String packageName = request.getParameter("packageName");
        String durationStr = request.getParameter("durationMonths");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");
        String status = request.getParameter("status");

        // Validation
        if (packageName == null || packageName.trim().isEmpty() ||
            durationStr == null || durationStr.trim().isEmpty() ||
            priceStr == null || priceStr.trim().isEmpty() ||
            status == null || status.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ các trường thông tin (trừ mô tả).");
            request.setAttribute("formTitle", idStr == null || idStr.isEmpty() ? "Thêm gói tập mới" : "Sửa gói tập");
            
            GymPackage pkg = new GymPackage();
            if (idStr != null && !idStr.isEmpty()) {
                pkg.setPackageId(Integer.parseInt(idStr));
            }
            pkg.setPackageName(packageName);
            pkg.setDescription(description);
            pkg.setStatus(status);
            try {
                if (durationStr != null && !durationStr.isEmpty()) pkg.setDurationMonths(Integer.parseInt(durationStr));
                if (priceStr != null && !priceStr.isEmpty()) pkg.setPrice(new BigDecimal(priceStr));
            } catch (NumberFormatException e) {
                // Ignore
            }
            request.setAttribute("pkg", pkg);
            request.getRequestDispatcher("/WEB-INF/views/admin/package-form.jsp").forward(request, response);
            return;
        }

        try {
            int durationMonths = Integer.parseInt(durationStr);
            BigDecimal price = new BigDecimal(priceStr);

            if (idStr == null || idStr.trim().isEmpty()) {
                // Insert new package
                GymPackage pkg = new GymPackage(0, packageName.trim(), durationMonths, price, description, status);
                pkg.setCreatedBy(creatorName);
                gymPackageService.createPackage(pkg);
            } else {
                // Update existing package
                int id = Integer.parseInt(idStr);
                GymPackage pkg = gymPackageService.getPackageById(id);
                if (pkg != null) {
                    pkg.setPackageName(packageName.trim());
                    pkg.setDurationMonths(durationMonths);
                    pkg.setPrice(price);
                    pkg.setDescription(description);
                    pkg.setStatus(status);
                    pkg.setUpdatedBy(creatorName);
                    gymPackageService.updatePackage(pkg);
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/packages");
        } catch (SQLException | NumberFormatException ex) {
            request.setAttribute("errorMessage", "Lỗi cơ sở dữ liệu hoặc định dạng: " + ex.getMessage());
            request.setAttribute("formTitle", idStr == null || idStr.isEmpty() ? "Thêm gói tập mới" : "Sửa gói tập");
            request.getRequestDispatcher("/WEB-INF/views/admin/package-form.jsp").forward(request, response);
        }
    }
}
