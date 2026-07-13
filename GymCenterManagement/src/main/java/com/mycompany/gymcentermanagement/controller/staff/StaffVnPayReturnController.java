package com.mycompany.gymcentermanagement.controller.staff;

import com.mycompany.gymcentermanagement.service.InvoiceService;
import com.mycompany.gymcentermanagement.service.impl.InvoiceServiceImpl;
import com.mycompany.gymcentermanagement.utils.VnPayConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "StaffVnPayReturnController", urlPatterns = {"/staff/vnpay-return"})
public class StaffVnPayReturnController extends HttpServlet {
    private final InvoiceService invoiceService = new InvoiceServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Map<String, String> fields = new HashMap<>();
            for (Enumeration<String> params = req.getParameterNames(); params.hasMoreElements();) {
                String paramName = params.nextElement();
                String fieldName = URLEncoder.encode(paramName, StandardCharsets.US_ASCII.toString());
                String paramValue = req.getParameter(paramName);
                if (paramValue != null && paramValue.length() > 0) {
                    String fieldValue = URLEncoder.encode(paramValue, StandardCharsets.US_ASCII.toString());
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = req.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }

            String signValue = VnPayConfig.hashAllFields(fields);
            
            // Lấy ID hóa đơn từ vnp_TxnRef (định dạng invoiceId_random)
            String vnp_TxnRef = req.getParameter("vnp_TxnRef");
            String invoiceIdStr;
            if (vnp_TxnRef.contains("_")) {
                invoiceIdStr = vnp_TxnRef.split("_")[0];
            } else {
                // Xử lý trường hợp lỡ tạo không có dấu _ (chỉ có trong giao dịch vừa rồi)
                // Cắt bỏ 8 số ngẫu nhiên cuối cùng
                invoiceIdStr = vnp_TxnRef.substring(0, vnp_TxnRef.length() - 8);
            }
            int invoiceId = Integer.parseInt(invoiceIdStr);

            if (signValue.equals(vnp_SecureHash)) {
                if ("00".equals(req.getParameter("vnp_TransactionStatus"))) {
                    // Thanh toán thành công, ghi nhận thanh toán
                    invoiceService.recordOnlinePayment(invoiceId);
                    req.getSession().setAttribute("message", "Thanh toán thành công qua VNPAY.");
                } else {
                    // Thanh toán lỗi hoặc người dùng hủy
                    req.getSession().setAttribute("error", "Giao dịch không thành công hoặc đã bị hủy.");
                }
            } else {
                req.getSession().setAttribute("error", "Lỗi xác thực chữ ký số VNPAY (Checksum failed).");
            }

            // Chuyển hướng về trang chi tiết hóa đơn của Staff
            resp.sendRedirect(req.getContextPath() + "/staff/record-payment?invoiceId=" + invoiceId);
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", "Đã xảy ra lỗi trong quá trình xử lý giao dịch VNPAY.");
            resp.sendRedirect(req.getContextPath() + "/staff/dashboard");
        }
    }
}
