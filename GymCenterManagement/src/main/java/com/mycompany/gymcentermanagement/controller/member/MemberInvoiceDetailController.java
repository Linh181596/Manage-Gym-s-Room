/**
 * =========================================================================
 * @file          : MemberInvoiceDetailController.java
 * @description   : Controller hiển thị chi tiết hóa đơn dành cho Member (hội viên)
 *                  Đảm bảo kiểm tra phân quyền sở hữu hóa đơn để tránh rò rỉ dữ liệu.
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.member;

import com.mycompany.gymcentermanagement.dao.MemberDAO;
import com.mycompany.gymcentermanagement.dao.impl.MemberDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.Invoice;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.InvoiceService;
import com.mycompany.gymcentermanagement.service.impl.InvoiceServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

/**
 * Controller to handle Member Invoice Detail viewing.
 * Mapped to /member/invoice-detail.
 */
@WebServlet(name = "MemberInvoiceDetailController", urlPatterns = {"/member/invoice-detail"})
public class MemberInvoiceDetailController extends HttpServlet {

    private final InvoiceService invoiceService = new InvoiceServiceImpl();
    private final MemberDAO memberDAO = new MemberDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String invoiceIdStr = request.getParameter("invoiceId");
        if (invoiceIdStr == null || invoiceIdStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing invoice ID");
            return;
        }

        try {
            int invoiceId = Integer.parseInt(invoiceIdStr);
            Invoice invoice = invoiceService.getInvoiceById(invoiceId);

            if (invoice == null) {
                request.setAttribute("errorMessage", "Không tìm thấy thông tin hóa đơn này hoặc hóa đơn đã bị xóa.");
                request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
                return;
            }

            // Authorization check
            if (currentUser.getRole() == User.Role.Member) {
                Member member = memberDAO.findByUserId(currentUser.getUserId());
                if (member == null || invoice.getMemberId() != member.getMemberId()) {
                    request.setAttribute("errorMessage", "Bạn không có quyền xem hóa đơn của người khác.");
                    request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
                    return;
                }
            } else if (currentUser.getRole() != User.Role.Staff && currentUser.getRole() != User.Role.Admin) {
                // If it's a PT or other role attempting to view
                request.setAttribute("errorMessage", "Bạn không có quyền xem thông tin hóa đơn này.");
                request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
                return;
            }

            request.setAttribute("invoice", invoice);
            request.getRequestDispatcher("/WEB-INF/views/member/invoice-detail.jsp").forward(request, response);

        } catch (NumberFormatException | SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống khi tải hóa đơn: " + ex.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
        }
    }
}
