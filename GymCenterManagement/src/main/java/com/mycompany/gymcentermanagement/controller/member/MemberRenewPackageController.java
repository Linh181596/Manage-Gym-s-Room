package com.mycompany.gymcentermanagement.controller.member;

import com.mycompany.gymcentermanagement.dao.MemberDAO;
import com.mycompany.gymcentermanagement.dao.impl.MemberDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.GymPackage;
import com.mycompany.gymcentermanagement.model.entity.Invoice;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.MemberPackage;
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
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "MemberRenewPackageController", urlPatterns = {"/member/renew-package"})
public class MemberRenewPackageController extends HttpServlet {

    private final MemberPackageService memberPackageService = new MemberPackageServiceImpl();
    private final GymPackageService gymPackageService = new GymPackageServiceImpl();
    private final MemberDAO memberDAO = new MemberDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        try {
            Member member = memberDAO.findByUserId(currentUser.getUserId());
            if (member == null) {
                session.setAttribute("errorMessage", "Không tìm thấy thông tin hội viên của bạn.");
                response.sendRedirect(request.getContextPath() + "/member/portal");
                return;
            }

            // Lấy thông tin gói tập hiện tại để cho phép gia hạn
            MemberPackage latestPkg = memberPackageService.getLatestPackageByMemberId(member.getMemberId());
            if (latestPkg == null) {
                session.setAttribute("errorMessage", "Bạn chưa có gói tập nào để gia hạn. Vui lòng đăng ký mới.");
                response.sendRedirect(request.getContextPath() + "/member/portal");
                return;
            }

            if (latestPkg.getEndDate() != null && latestPkg.getEndDate().plusDays(3).isBefore(LocalDate.now())) {
                session.setAttribute("errorMessage", "Gói tập của bạn đã hết hạn quá 3 ngày. Vui lòng đăng ký gói mới thay vì gia hạn.");
                response.sendRedirect(request.getContextPath() + "/member/portal");
                return;
            }

            if (latestPkg.getEndDate() != null && LocalDate.now().plusMonths(1).isBefore(latestPkg.getEndDate())) {
                session.setAttribute("errorMessage", "Bạn chỉ có thể gia hạn khi gói tập hiện tại còn thời hạn dưới 1 tháng.");
                response.sendRedirect(request.getContextPath() + "/member/portal");
                return;
            }

            // Hiển thị danh sách các gói tập để Member chọn gia hạn
            List<GymPackage> packages = gymPackageService.getActivePackages();
            request.setAttribute("packages", packages);
            request.setAttribute("latestPkg", latestPkg);
            request.getRequestDispatcher("/WEB-INF/views/member/package-renew.jsp").forward(request, response);
        } catch (SQLException ex) {
            session.setAttribute("errorMessage", "Lỗi hệ thống: " + ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/member/portal");
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
                request.setAttribute("errorMessage", "Không tìm thấy thông tin hội viên.");
                doGet(request, response);
                return;
            }

            int packageId = Integer.parseInt(packageIdStr);

            Invoice pendingInvoice = memberPackageService.renewMemberPackage(member.getMemberId(), packageId, paymentMethod);
            
            if (pendingInvoice != null) {
                if ("VNPay".equalsIgnoreCase(paymentMethod)) {
                    response.sendRedirect(request.getContextPath() + "/member/vnpay-create?invoiceId=" + pendingInvoice.getInvoiceId());
                } else {
                    session.setAttribute("successMessage", "Đăng ký gia hạn thành công! Vui lòng thanh toán tiền mặt tại quầy để hoàn tất gia hạn.");
                    response.sendRedirect(request.getContextPath() + "/member/renew-package");
                }
            } else {
                request.setAttribute("errorMessage", "Gia hạn gói tập thất bại.");
                doGet(request, response);
            }
        } catch (SQLException | NumberFormatException ex) {
            request.setAttribute("errorMessage", "Lỗi: " + ex.getMessage());
            doGet(request, response);
        }
    }
}
