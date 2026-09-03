/**
 * =========================================================================
 * @file          : MemberRegisterPackageController.java
 * @description   : Controller đăng ký gói tập dành cho hội viên
 * @author        : (AI Generated)
 * @created       : 2026-08-01
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.member;

import com.mycompany.gymcentermanagement.dao.MemberDAO;
import com.mycompany.gymcentermanagement.dao.impl.MemberDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.GymPackage;
import com.mycompany.gymcentermanagement.model.entity.Invoice;
import com.mycompany.gymcentermanagement.model.entity.Member;
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

@WebServlet(name = "MemberRegisterPackageController", urlPatterns = {"/member/register-package"})
public class MemberRegisterPackageController extends HttpServlet {

    private final MemberPackageService memberPackageService = new MemberPackageServiceImpl();
    private final GymPackageService gymPackageService = new GymPackageServiceImpl();
    private final MemberDAO memberDAO = new MemberDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            List<GymPackage> packages = gymPackageService.getActivePackages();
            request.setAttribute("packages", packages);
            request.getRequestDispatcher("/WEB-INF/views/member/package-register.jsp").forward(request, response);
        } catch (SQLException ex) {
            request.setAttribute("errorMessage", "Lỗi khi tải dữ liệu đăng ký: " + ex.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/member/portal.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String packageIdStr = request.getParameter("packageId");
        String paymentMethod = request.getParameter("paymentMethod");

        if (packageIdStr == null || packageIdStr.trim().isEmpty() ||
            paymentMethod == null || paymentMethod.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Vui lòng chọn gói tập và phương thức thanh toán.");
            doGet(request, response);
            return;
        }

        try {
            Member member = memberDAO.findByUserId(currentUser.getUserId());
            if (member == null) {
                request.setAttribute("errorMessage", "Không tìm thấy thông tin hội viên của bạn.");
                doGet(request, response);
                return;
            }

            int packageId = Integer.parseInt(packageIdStr);

            Invoice pendingInvoice = memberPackageService.registerMemberPackage(member.getMemberId(), packageId, paymentMethod);
            
            if (pendingInvoice != null) {
                if ("VNPay".equalsIgnoreCase(paymentMethod)) {
                    response.sendRedirect(request.getContextPath() + "/member/vnpay-create?invoiceId=" + pendingInvoice.getInvoiceId());
                } else {
                    // Redirect to a success page or back with success message for Cash payment
                    session.setAttribute("successMessage", "Đăng ký thành công! Vui lòng thanh toán tiền mặt tại quầy để kích hoạt gói.");
                    response.sendRedirect(request.getContextPath() + "/member/register-package");
                }
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
