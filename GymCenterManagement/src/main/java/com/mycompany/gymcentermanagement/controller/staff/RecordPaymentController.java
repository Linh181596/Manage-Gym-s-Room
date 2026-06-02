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

@WebServlet(name = "RecordPaymentController", urlPatterns = {"/staff/record-payment"})
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
                    request.setAttribute("errorMessage", "Invoice not found.");
                }
            }
            
            // Show list of all invoices
            List<Invoice> list = invoiceService.getAllInvoices();
            request.setAttribute("invoices", list);
            request.getRequestDispatcher("/WEB-INF/views/staff/payment-list.jsp").forward(request, response);
            
        } catch (SQLException | NumberFormatException ex) {
            request.setAttribute("errorMessage", "Error: " + ex.getMessage());
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

        if (invoiceIdStr == null || invoiceIdStr.trim().isEmpty() || !"pay".equals(action)) {
            request.setAttribute("errorMessage", "Invalid action or invoice details.");
            response.sendRedirect(request.getContextPath() + "/staff/record-payment");
            return;
        }

        try {
            int invoiceId = Integer.parseInt(invoiceIdStr);
            boolean success = invoiceService.recordCashPayment(invoiceId, staffUserId);
            
            if (success) {
                // Redirect back to detail view which now shows "Paid" status and print receipt button
                response.sendRedirect(request.getContextPath() + "/staff/record-payment?invoiceId=" + invoiceId + "&successMsg=Payment+recorded+successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to record payment.");
                Invoice inv = invoiceService.getInvoiceById(invoiceId);
                request.setAttribute("invoice", inv);
                request.getRequestDispatcher("/WEB-INF/views/staff/payment-record-detail.jsp").forward(request, response);
            }
        } catch (SQLException | NumberFormatException ex) {
            request.setAttribute("errorMessage", "Error: " + ex.getMessage());
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
