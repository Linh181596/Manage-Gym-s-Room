package com.mycompany.gymcentermanagement.controller.staff;

import com.mycompany.gymcentermanagement.dao.MemberDAO;
import com.mycompany.gymcentermanagement.dao.impl.MemberDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.GymPackage;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.MemberPackage;
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

@WebServlet(name = "RenewPackageController", urlPatterns = {"/staff/package/renew"})
public class RenewPackageController extends HttpServlet {

    private final MemberDAO memberDAO = new MemberDAOImpl();
    private final MemberPackageService memberPackageService = new MemberPackageServiceImpl();
    private final GymPackageService gymPackageService = new GymPackageServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String userIdStr = request.getParameter("memberId"); // Nhận userId từ members.jsp
        if (userIdStr == null || userIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/staff/members?error=missing_id");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);
            Member member = memberDAO.findByUserId(userId);
            
            if (member == null) {
                request.setAttribute("errorMessage", "Không tìm thấy thông tin hội viên.");
                request.getRequestDispatcher("/WEB-INF/views/staff/members.jsp").forward(request, response);
                return;
            }

            // Tìm gói tập đang hoạt động hiện tại
            MemberPackage activePkg = memberPackageService.getActivePackageByMemberId(member.getMemberId());
            
            // Lấy danh sách tất cả các gói tập đang active
            List<GymPackage> packages = gymPackageService.getActivePackages();

            request.setAttribute("member", member);
            request.setAttribute("activePkg", activePkg);
            request.setAttribute("packages", packages);
            
            request.getRequestDispatcher("/WEB-INF/views/staff/package-renew.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException ex) {
            ex.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/staff/members?error=system_error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");
        int staffUserId = (currentUser != null) ? currentUser.getUserId() : 2; // Fallback

        String userIdStr = request.getParameter("memberId");
        String packageIdStr = request.getParameter("packageId");

        if (userIdStr == null || userIdStr.trim().isEmpty() ||
            packageIdStr == null || packageIdStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Thông tin yêu cầu gia hạn không hợp lệ.");
            doGet(request, response);
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);
            int packageId = Integer.parseInt(packageIdStr);

            Member member = memberDAO.findByUserId(userId);
            if (member == null) {
                request.setAttribute("errorMessage", "Hội viên không tồn tại.");
                doGet(request, response);
                return;
            }

            Invoice pendingInvoice = memberPackageService.renewMemberPackage(member.getMemberId(), packageId, staffUserId);
            
            if (pendingInvoice != null) {
                // Chuyển sang màn hình thanh toán hóa đơn gia hạn
                response.sendRedirect(request.getContextPath() + "/staff/record-payment?invoiceId=" + pendingInvoice.getInvoiceId());
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
