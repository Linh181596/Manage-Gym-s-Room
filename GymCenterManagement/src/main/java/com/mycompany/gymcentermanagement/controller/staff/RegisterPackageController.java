/**
 * =========================================================================
 * @file          : RegisterPackageController.java
 * @description   : Controller đăng ký gói tập thành viên cho Staff
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-01 bởi Nguyễn Hoàng Thắng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.staff;

import com.mycompany.gymcentermanagement.model.entity.GymPackage;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.Invoice;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.GymPackageService;
import com.mycompany.gymcentermanagement.service.MemberPackageService;
import com.mycompany.gymcentermanagement.service.impl.GymPackageServiceImpl;
import com.mycompany.gymcentermanagement.service.impl.MemberPackageServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "RegisterPackageController", urlPatterns = {"/staff/register-package"})
public class RegisterPackageController extends HttpServlet {

    private final MemberPackageService memberPackageService = new MemberPackageServiceImpl();
    private final GymPackageService gymPackageService = new GymPackageServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            List<Member> members = memberPackageService.getActiveMembers();
            List<GymPackage> packages = gymPackageService.getActivePackages();
            
            request.setAttribute("members", members);
            request.setAttribute("packages", packages);
            request.getRequestDispatcher("/WEB-INF/views/staff/package-register.jsp").forward(request, response);
        } catch (SQLException ex) {
            request.setAttribute("errorMessage", "Lỗi khi tải dữ liệu đăng ký: " + ex.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/staff/dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");
        int staffUserId = (currentUser != null) ? currentUser.getUserId() : 2; // Fallback to demo staff ID

        String memberIdStr = request.getParameter("memberId");
        String packageIdStr = request.getParameter("packageId");

        if (memberIdStr == null || memberIdStr.trim().isEmpty() ||
            packageIdStr == null || packageIdStr.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Vui lòng chọn cả hội viên và gói tập.");
            doGet(request, response);
            return;
        }

        try {
            int memberId = Integer.parseInt(memberIdStr);
            int packageId = Integer.parseInt(packageIdStr);

            Invoice pendingInvoice = memberPackageService.registerMemberPackage(memberId, packageId, staffUserId);
            
            if (pendingInvoice != null) {
                // Redirect immediately to record payment screen with invoiceId!
                response.sendRedirect(request.getContextPath() + "/staff/record-payment?invoiceId=" + pendingInvoice.getInvoiceId());
            } else {
                request.setAttribute("errorMessage", "Đăng ký gói tập thất bại.");
                doGet(request, response);
            }
        } catch (SQLException | NumberFormatException ex) {
            request.setAttribute("errorMessage", "Lỗi: " + ex.getMessage());
            doGet(request, response);
        }
    }
}
