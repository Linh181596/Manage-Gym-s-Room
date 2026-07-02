/**
 * =========================================================================
 * @file          : RecordPaymentController.java
 * @description   : Controller xác nhận thanh toán hóa đơn và in biên lai cho Staff
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-01 bởi Nguyễn Hoàng Thắng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.staff;

import com.mycompany.gymcentermanagement.model.entity.Invoice;
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
import java.util.List;

@WebServlet(name = "RecordPaymentController", urlPatterns = {"/staff/record-payment", "/admin/payment-history"})
public class RecordPaymentController extends HttpServlet {

    private final InvoiceService invoiceService = new InvoiceServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String invoiceIdStr = request.getParameter("invoiceId");
        
        try {
            if (invoiceIdStr != null && !invoiceIdStr.trim().isEmpty()) {
                int invoiceId = Integer.parseInt(invoiceIdStr);
                Invoice inv = invoiceService.getInvoiceById(invoiceId);
                if (inv != null) {
                    request.setAttribute("invoice", inv);
                    request.getRequestDispatcher("/WEB-INF/views/staff/payment-record-detail.jsp").forward(request, response);
                    return;
                } else {
                    request.setAttribute("errorMessage", "Không tìm thấy hóa đơn.");
                }
            }
            
            // Calculate KPI aggregates on server side from all invoices
            List<Invoice> allInvoices = invoiceService.getAllInvoices();
            java.math.BigDecimal totalRevenue = java.math.BigDecimal.ZERO;
            int pendingCount = 0;
            int paidCount = 0;
            for (Invoice inv : allInvoices) {
                if ("Paid".equals(inv.getStatus())) {
                    totalRevenue = totalRevenue.add(inv.getAmount());
                    paidCount++;
                } else if ("Pending".equals(inv.getStatus())) {
                    pendingCount++;
                }
            }
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("pendingCount", pendingCount);
            request.setAttribute("paidCount", paidCount);

            // Pagination using PaginationHelper
            int page = com.mycompany.gymcentermanagement.utils.PaginationHelper.parseInt(request.getParameter("page"), 1);
            int pageSize = com.mycompany.gymcentermanagement.utils.PaginationHelper.normalizePageSize(
                    com.mycompany.gymcentermanagement.utils.PaginationHelper.parseInt(request.getParameter("pageSize"), 10));
            int totalItems = allInvoices.size();
            int totalPages = com.mycompany.gymcentermanagement.utils.PaginationHelper.totalPages(totalItems, pageSize);
            page = com.mycompany.gymcentermanagement.utils.PaginationHelper.normalizePage(page, totalPages);
            int offset = (page - 1) * pageSize;

            List<Invoice> paginatedList = invoiceService.getInvoicesPaginated(offset, pageSize);
            request.setAttribute("invoices", paginatedList);

            String servletPath = request.getServletPath();
            String queryBase = com.mycompany.gymcentermanagement.utils.PaginationHelper.buildQueryBase(
                    request, servletPath, "pageSize", String.valueOf(pageSize));

            com.mycompany.gymcentermanagement.utils.PaginationHelper.setPaginationAttributes(
                    request, page, pageSize, totalItems, queryBase, "hóa đơn");
            
            request.getRequestDispatcher("/WEB-INF/views/staff/payment-list.jsp").forward(request, response);
            
        } catch (SQLException | NumberFormatException ex) {
            request.setAttribute("errorMessage", "Lỗi: " + ex.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/staff/dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");
        int staffUserId = (currentUser != null) ? currentUser.getUserId() : 2; // Fallback to demo staff ID

        String invoiceIdStr = request.getParameter("invoiceId");
        String action = request.getParameter("action");
        String servletPath = request.getServletPath();

        if (invoiceIdStr == null || invoiceIdStr.trim().isEmpty() || (!"pay".equals(action) && !"cancel".equals(action))) {
            request.setAttribute("errorMessage", "Thao tác hoặc thông tin hóa đơn không hợp lệ.");
            response.sendRedirect(request.getContextPath() + servletPath);
            return;
        }

        try {
            int invoiceId = Integer.parseInt(invoiceIdStr);
            boolean success = false;
            String message = "";
            
            if ("pay".equals(action)) {
                success = invoiceService.recordCashPayment(invoiceId, staffUserId);
                message = "Ghi nhận thanh toán thành công";
            } else if ("cancel".equals(action)) {
                success = invoiceService.cancelInvoice(invoiceId, staffUserId);
                message = "Hủy hóa đơn thành công";
            }
            
            if (success) {
                String successMsg = java.net.URLEncoder.encode(message, java.nio.charset.StandardCharsets.UTF_8);
                response.sendRedirect(request.getContextPath() + servletPath + "?invoiceId=" + invoiceId + "&successMsg=" + successMsg);
            } else {
                request.setAttribute("errorMessage", "Thao tác thất bại.");
                Invoice inv = invoiceService.getInvoiceById(invoiceId);
                request.setAttribute("invoice", inv);
                request.getRequestDispatcher("/WEB-INF/views/staff/payment-record-detail.jsp").forward(request, response);
            }
        } catch (SQLException | NumberFormatException ex) {
            request.setAttribute("errorMessage", "Lỗi: " + ex.getMessage());
            try {
                int invoiceId = Integer.parseInt(invoiceIdStr);
                Invoice inv = invoiceService.getInvoiceById(invoiceId);
                request.setAttribute("invoice", inv);
            } catch (Exception e) {
                // Ignore
            }
            request.getRequestDispatcher("/WEB-INF/views/staff/payment-record-detail.jsp").forward(request, response);
        }
    }
}
