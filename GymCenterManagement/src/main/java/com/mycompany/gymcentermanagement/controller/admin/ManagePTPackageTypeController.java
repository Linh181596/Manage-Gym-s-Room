package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.model.entity.PTPackageType;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PTPackageTypeService;
import com.mycompany.gymcentermanagement.service.impl.PTPackageTypeServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "ManagePTPackageTypeController", urlPatterns = {"/admin/pt/packages"})
public class ManagePTPackageTypeController extends HttpServlet {

    private final PTPackageTypeService ptPackageTypeService = new PTPackageTypeServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        // 1. Phân quyền: Chỉ Admin và Staff mới có quyền truy cập GET (Xem)
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (currentUser.getRole() != User.Role.Admin && currentUser.getRole() != User.Role.Staff) {
            String redirectUrl = request.getContextPath() + "/home";
            if (currentUser.getRole() == User.Role.Member) {
                redirectUrl = request.getContextPath() + "/member/dashboard";
            } else if (currentUser.getRole() == User.Role.PT) {
                redirectUrl = request.getContextPath() + "/pt/dashboard";
            }
            response.sendRedirect(redirectUrl);
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "create":
                    // Chỉ Admin được phép tạo gói
                    if (currentUser.getRole() != User.Role.Admin) {
                        request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
                        return;
                    }
                    request.setAttribute("formTitle", "Thêm gói tập PT mới");
                    request.getRequestDispatcher("/WEB-INF/views/admin/pt-package-form.jsp").forward(request, response);
                    break;
                    
                case "edit":
                    // Chỉ Admin được phép sửa gói
                    if (currentUser.getRole() != User.Role.Admin) {
                        request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
                        return;
                    }
                    String idStr = request.getParameter("id");
                    if (idStr != null) {
                        int id = Integer.parseInt(idStr);
                        PTPackageType pkg = ptPackageTypeService.getPackageById(id);
                        if (pkg != null) {
                            request.setAttribute("pkg", pkg);
                            request.setAttribute("formTitle", "Sửa gói tập PT");
                            request.getRequestDispatcher("/WEB-INF/views/admin/pt-package-form.jsp").forward(request, response);
                            return;
                        }
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/pt/packages");
                    break;
                    
                case "delete":
                    // Chỉ Admin được phép xóa gói
                    if (currentUser.getRole() != User.Role.Admin) {
                        request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
                        return;
                    }
                    String delIdStr = request.getParameter("id");
                    if (delIdStr != null) {
                        int id = Integer.parseInt(delIdStr);
                        ptPackageTypeService.deletePackage(id);
                        response.sendRedirect(request.getContextPath() + "/admin/pt/packages?successMsg=" + 
                                java.net.URLEncoder.encode("Xóa gói tập PT thành công!", java.nio.charset.StandardCharsets.UTF_8));
                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin/pt/packages");
                    }
                    break;
                    
                case "list":
                default:
                    // Đọc trạng thái lọc (Active, Inactive, All)
                    String status = request.getParameter("status");
                    if (status == null || status.trim().isEmpty()) {
                        status = "All";
                    }
                    
                    List<PTPackageType> list = ptPackageTypeService.getPackagesByStatus(status);
                    request.setAttribute("packages", list);
                    request.setAttribute("selectedStatus", status);
                    request.getRequestDispatcher("/WEB-INF/views/admin/pt-package-list.jsp").forward(request, response);
                    break;
            }
        } catch (SQLException | NumberFormatException ex) {
            request.setAttribute("errorMessage", "Lỗi xử lý yêu cầu: " + ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/pt/packages");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        // 2. Phân quyền: Chỉ Admin mới có quyền thực hiện POST (Thêm, Sửa)
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        if (currentUser.getRole() != User.Role.Admin) {
            String redirectUrl = request.getContextPath() + "/home";
            if (currentUser.getRole() == User.Role.Member) {
                redirectUrl = request.getContextPath() + "/member/dashboard";
            } else if (currentUser.getRole() == User.Role.PT) {
                redirectUrl = request.getContextPath() + "/pt/dashboard";
            } else if (currentUser.getRole() == User.Role.Staff) {
                redirectUrl = request.getContextPath() + "/staff/dashboard";
            }
            response.sendRedirect(redirectUrl);
            return;
        }

        String creatorName = currentUser.getFullName();
        String idStr = request.getParameter("packageId");
        String packageName = request.getParameter("packageName");
        String durationStr = request.getParameter("durationMonths");
        String sessionsStr = request.getParameter("numberOfSessions");
        String description = request.getParameter("description");
        String status = request.getParameter("status");

        // Validation phía Server
        if (packageName == null || packageName.trim().isEmpty() ||
            durationStr == null || durationStr.trim().isEmpty() ||
            sessionsStr == null || sessionsStr.trim().isEmpty() ||
            status == null || status.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Vui lòng điền đầy đủ các thông tin bắt buộc.");
            request.setAttribute("formTitle", idStr == null || idStr.isEmpty() ? "Thêm gói tập PT mới" : "Sửa gói tập PT");
            
            PTPackageType pkg = new PTPackageType();
            if (idStr != null && !idStr.isEmpty()) {
                pkg.setPtPackageTypeId(Integer.parseInt(idStr));
            }
            pkg.setPackageName(packageName);
            pkg.setDescription(description);
            pkg.setStatus(status);
            try {
                if (durationStr != null && !durationStr.isEmpty()) pkg.setDurationMonths(Integer.parseInt(durationStr));
                if (sessionsStr != null && !sessionsStr.isEmpty()) pkg.setNumberOfSessions(Integer.parseInt(sessionsStr));
            } catch (NumberFormatException e) {
                // Bỏ qua lỗi định dạng tại đây
            }
            request.setAttribute("pkg", pkg);
            request.getRequestDispatcher("/WEB-INF/views/admin/pt-package-form.jsp").forward(request, response);
            return;
        }

        int currentId = 0;
        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                currentId = Integer.parseInt(idStr);
            } catch (NumberFormatException e) {
                // Ignore
            }
        }

        try {
            int durationMonths = Integer.parseInt(durationStr);
            int numberOfSessions = Integer.parseInt(sessionsStr);

            if (ptPackageTypeService.isPackageNameExists(packageName.trim(), currentId)) {
                request.setAttribute("errorMessage", "Tên gói tập đã tồn tại trong hệ thống. Vui lòng chọn tên khác.");
                request.setAttribute("formTitle", idStr == null || idStr.isEmpty() ? "Thêm gói tập PT mới" : "Sửa gói tập PT");
                
                PTPackageType pkg = new PTPackageType(currentId, packageName.trim(), description, durationMonths, numberOfSessions, status);
                request.setAttribute("pkg", pkg);
                request.getRequestDispatcher("/WEB-INF/views/admin/pt-package-form.jsp").forward(request, response);
                return;
            }

            String successMsg;
            if (idStr == null || idStr.trim().isEmpty()) {
                // Tạo mới gói
                PTPackageType pkg = new PTPackageType(0, packageName.trim(), description, durationMonths, numberOfSessions, status);
                pkg.setCreatedBy(creatorName);
                ptPackageTypeService.createPackage(pkg);
                successMsg = "Thêm gói tập PT mới thành công!";
            } else {
                // Cập nhật gói
                int id = Integer.parseInt(idStr);
                PTPackageType pkg = ptPackageTypeService.getPackageById(id);
                if (pkg != null) {
                    pkg.setPackageName(packageName.trim());
                    pkg.setDurationMonths(durationMonths);
                    pkg.setNumberOfSessions(numberOfSessions);
                    pkg.setDescription(description);
                    pkg.setStatus(status);
                    pkg.setUpdatedBy(creatorName);
                    ptPackageTypeService.updatePackage(pkg);
                }
                successMsg = "Cập nhật thông tin gói tập PT thành công!";
            }
            response.sendRedirect(request.getContextPath() + "/admin/pt/packages?successMsg=" + 
                    URLEncoder.encode(successMsg, StandardCharsets.UTF_8));
            
        } catch (IllegalArgumentException ex) {
            // Hiển thị lỗi nghiệp vụ do Service ném ra hoặc lỗi định dạng số
            String errorMsg = ex.getMessage();
            if (ex instanceof NumberFormatException) {
                errorMsg = "Định dạng số không hợp lệ. Vui lòng nhập số nguyên.";
            }
            request.setAttribute("errorMessage", errorMsg);
            request.setAttribute("formTitle", idStr == null || idStr.isEmpty() ? "Thêm gói tập PT mới" : "Sửa gói tập PT");
            PTPackageType pkg = new PTPackageType(currentId, packageName.trim(), description, 0, 0, status);
            try {
                if (durationStr != null && !durationStr.isEmpty()) pkg.setDurationMonths(Integer.parseInt(durationStr));
                if (sessionsStr != null && !sessionsStr.isEmpty()) pkg.setNumberOfSessions(Integer.parseInt(sessionsStr));
            } catch (NumberFormatException nfe) {}
            request.setAttribute("pkg", pkg);
            request.getRequestDispatcher("/WEB-INF/views/admin/pt-package-form.jsp").forward(request, response);
            
        } catch (SQLException ex) {
            request.setAttribute("errorMessage", "Lỗi cơ sở dữ liệu: " + ex.getMessage());
            request.setAttribute("formTitle", idStr == null || idStr.isEmpty() ? "Thêm gói tập PT mới" : "Sửa gói tập PT");
            request.getRequestDispatcher("/WEB-INF/views/admin/pt-package-form.jsp").forward(request, response);
        }
    }
}
