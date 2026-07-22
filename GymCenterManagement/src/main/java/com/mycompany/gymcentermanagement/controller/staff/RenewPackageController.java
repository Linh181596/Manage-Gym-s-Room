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

            // Tìm gói tập mới nhất của hội viên (bất kể trạng thái)
            MemberPackage latestPkg = memberPackageService.getLatestPackageByMemberId(member.getMemberId());
            
            if (latestPkg == null || latestPkg.getGymPackage() == null) {
                request.setAttribute("errorMessage", "Hội viên chưa có gói tập nào để gia hạn. Vui lòng hướng dẫn hội viên đăng ký mới.");
                request.getRequestDispatcher("/WEB-INF/views/staff/members.jsp").forward(request, response);
                return;
            }

            // Kiểm tra điều kiện gia hạn <= 3 ngày nếu đã hết hạn
            if ("Expired".equalsIgnoreCase(latestPkg.getStatus())) {
                java.time.LocalDate endDate = latestPkg.getEndDate();
                java.time.LocalDate now = java.time.LocalDate.now();
                long daysBetween = java.time.temporal.ChronoUnit.DAYS.between(endDate, now);
                if (daysBetween > 3) {
                    request.setAttribute("errorMessage", "Gói tập đã hết hạn quá 3 ngày. Vui lòng hướng dẫn hội viên đăng ký mới.");
                    request.getRequestDispatcher("/WEB-INF/views/staff/members.jsp").forward(request, response);
                    return;
                }
            }

            // Gói tập được phép gia hạn chính là gói tập gần nhất của hội viên
            GymPackage allowedPackage = latestPkg.getGymPackage();

            request.setAttribute("member", member);
            request.setAttribute("latestPkg", latestPkg);
            request.setAttribute("allowedPackage", allowedPackage);
            
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

            // Bảo mật: Kiểm tra xem packageId muốn gia hạn có khớp với gói gần nhất không
            MemberPackage latestPkg = memberPackageService.getLatestPackageByMemberId(member.getMemberId());
            if (latestPkg == null || latestPkg.getGymPackage() == null || latestPkg.getGymPackage().getPackageId() != packageId) {
                request.setAttribute("errorMessage", "Yêu cầu gia hạn không hợp lệ. Chỉ có thể gia hạn đúng gói tập hiện tại.");
                doGet(request, response);
                return;
            }

            // Kiểm tra điều kiện gia hạn <= 3 ngày nếu đã hết hạn
            if ("Expired".equalsIgnoreCase(latestPkg.getStatus())) {
                java.time.LocalDate endDate = latestPkg.getEndDate();
                java.time.LocalDate now = java.time.LocalDate.now();
                long daysBetween = java.time.temporal.ChronoUnit.DAYS.between(endDate, now);
                if (daysBetween > 3) {
                    request.setAttribute("errorMessage", "Yêu cầu gia hạn không hợp lệ do gói tập đã hết hạn quá 3 ngày.");
                    doGet(request, response);
                    return;
                }
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
