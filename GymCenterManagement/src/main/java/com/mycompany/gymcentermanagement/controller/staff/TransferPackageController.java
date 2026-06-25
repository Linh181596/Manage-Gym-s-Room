package com.mycompany.gymcentermanagement.controller.staff;

import com.mycompany.gymcentermanagement.dao.MemberDAO;
import com.mycompany.gymcentermanagement.dao.impl.MemberDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.MemberPackage;
import com.mycompany.gymcentermanagement.model.entity.Invoice;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.MemberPackageService;
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

@WebServlet(name = "TransferPackageController", urlPatterns = {"/staff/package/transfer"})
public class TransferPackageController extends HttpServlet {

    private final MemberDAO memberDAO = new MemberDAOImpl();
    private final MemberPackageService memberPackageService = new MemberPackageServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String senderIdStr = request.getParameter("senderId"); // Nhận userId người gửi
        if (senderIdStr == null || senderIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/staff/members?error=missing_id");
            return;
        }

        try {
            int senderUserId = Integer.parseInt(senderIdStr);
            Member sender = memberDAO.findByUserId(senderUserId);
            
            if (sender == null) {
                request.setAttribute("errorMessage", "Không tìm thấy thông tin người chuyển nhượng.");
                request.getRequestDispatcher("/WEB-INF/views/staff/members.jsp").forward(request, response);
                return;
            }

            // Lấy gói tập đang Active của người gửi
            MemberPackage senderPkg = memberPackageService.getActivePackageByMemberId(sender.getMemberId());
            if (senderPkg == null) {
                request.setAttribute("errorMessage", "Hội viên này hiện không có gói tập nào đang hoạt động để chuyển nhượng.");
                request.getRequestDispatcher("/WEB-INF/views/staff/members.jsp").forward(request, response);
                return;
            }

            // Tính số ngày còn lại
            long remainingDays = java.time.temporal.ChronoUnit.DAYS.between(LocalDate.now(), senderPkg.getEndDate());
            if (remainingDays < 1) {
                request.setAttribute("errorMessage", "Thời hạn gói tập còn lại dưới 1 ngày, không đủ điều kiện chuyển nhượng.");
                request.getRequestDispatcher("/WEB-INF/views/staff/members.jsp").forward(request, response);
                return;
            }

            // Lấy danh sách hội viên hoạt động nhận chuyển nhượng (loại trừ người gửi)
            List<Member> activeMembers = memberPackageService.getActiveMembers();
            activeMembers.removeIf(m -> m.getMemberId() == sender.getMemberId());

            request.setAttribute("sender", sender);
            request.setAttribute("senderPkg", senderPkg);
            request.setAttribute("remainingDays", remainingDays);
            request.setAttribute("activeMembers", activeMembers);

            request.getRequestDispatcher("/WEB-INF/views/staff/package-transfer.jsp").forward(request, response);
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

        String senderUserIdStr = request.getParameter("senderId");
        String receiverUserIdStr = request.getParameter("receiverId");
        String transferFeeStr = request.getParameter("transferFee");
        String note = request.getParameter("note");

        if (senderUserIdStr == null || senderUserIdStr.trim().isEmpty() ||
            receiverUserIdStr == null || receiverUserIdStr.trim().isEmpty() ||
            transferFeeStr == null || transferFeeStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Thông tin chuyển nhượng không hợp lệ.");
            doGet(request, response);
            return;
        }

        try {
            int senderUserId = Integer.parseInt(senderUserIdStr);
            int receiverUserId = Integer.parseInt(receiverUserIdStr);
            double transferFee = Double.parseDouble(transferFeeStr);

            Member sender = memberDAO.findByUserId(senderUserId);
            Member receiver = memberDAO.findByUserId(receiverUserId);

            if (sender == null || receiver == null) {
                request.setAttribute("errorMessage", "Thông tin người gửi hoặc người nhận không tồn tại.");
                doGet(request, response);
                return;
            }

            Invoice pendingInvoice = memberPackageService.transferMemberPackage(
                    sender.getMemberId(), receiver.getMemberId(), transferFee, staffUserId, note);
            
            if (pendingInvoice != null) {
                // Chuyển hướng đến hóa đơn chờ thanh toán phí chuyển nhượng
                response.sendRedirect(request.getContextPath() + "/staff/record-payment?invoiceId=" + pendingInvoice.getInvoiceId());
            } else {
                request.setAttribute("errorMessage", "Khởi tạo giao dịch chuyển nhượng thất bại.");
                doGet(request, response);
            }
        } catch (SQLException | NumberFormatException ex) {
            request.setAttribute("errorMessage", "Lỗi: " + ex.getMessage());
            doGet(request, response);
        }
    }
}
