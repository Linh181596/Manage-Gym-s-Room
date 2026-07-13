package com.mycompany.gymcentermanagement.controller.staff;

import com.mycompany.gymcentermanagement.model.entity.Invoice;
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
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet(name = "StaffVnPayCreatePaymentController", urlPatterns = {"/staff/vnpay-create"})
public class StaffVnPayCreatePaymentController extends HttpServlet {
    private final InvoiceService invoiceService = new InvoiceServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String invoiceIdStr = req.getParameter("invoiceId");
        if (invoiceIdStr == null || invoiceIdStr.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing invoiceId");
            return;
        }
        try {
            int invoiceId = Integer.parseInt(invoiceIdStr);
            Invoice invoice = invoiceService.getInvoiceById(invoiceId);
            if (invoice == null || !"Pending".equals(invoice.getStatus())) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid invoice or already paid.");
                return;
            }

            long amount = invoice.getAmount().longValue() * 100; // VNPAY amount is multiplied by 100
            
            String vnp_Version = "2.1.0";
            String vnp_Command = "pay";
            String vnp_OrderInfo = "ThanhToanHoaDon_" + invoiceId;
            String orderType = "other";
            // Use TxnRef to store our invoiceId directly or append it. Let's use format: invoiceId_random
            String vnp_TxnRef = invoiceId + "_" + VnPayConfig.getRandomNumber(8);
            String vnp_IpAddr = "127.0.0.1"; // Hardcoded to avoid IPv6 encoding issues
            String vnp_TmnCode = VnPayConfig.vnp_TmnCode;

            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", vnp_Version);
            vnp_Params.put("vnp_Command", vnp_Command);
            vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
            vnp_Params.put("vnp_Amount", String.valueOf(amount));
            vnp_Params.put("vnp_CurrCode", "VND");
            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.put("vnp_OrderInfo", vnp_OrderInfo);
            vnp_Params.put("vnp_OrderType", orderType);

            String locate = req.getParameter("language");
            if (locate != null && !locate.isEmpty()) {
                vnp_Params.put("vnp_Locale", locate);
            } else {
                vnp_Params.put("vnp_Locale", "vn");
            }
            vnp_Params.put("vnp_ReturnUrl", VnPayConfig.vnp_ReturnUrl);
            vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String vnp_CreateDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

            cld.add(Calendar.MINUTE, 15);
            String vnp_ExpireDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

            // Bước 1: Sắp xếp các key
            List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
            Collections.sort(fieldNames);
            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();
            Iterator<String> itr = fieldNames.iterator();
            while (itr.hasNext()) {
                String fieldName = itr.next();
                String fieldValue = vnp_Params.get(fieldName);
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    // Build hash data theo ĐÚNG sample VNPAY: encode value, KHÔNG replace
                    hashData.append(fieldName);
                    hashData.append('=');
                    hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    
                    // Build query theo ĐÚNG sample VNPAY: encode name và value
                    query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                    query.append('=');
                    query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));

                    if (itr.hasNext()) {
                        query.append('&');
                        hashData.append('&');
                    }
                }
            }
            String queryUrl = query.toString();
            String vnp_SecureHash = VnPayConfig.hmacSHA512(VnPayConfig.secretKey, hashData.toString());
            queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
            String paymentUrl = VnPayConfig.vnp_PayUrl + "?" + queryUrl;
            
            // ===== DEBUG: In ra console để kiểm tra =====
            System.out.println("====== VNPAY DEBUG START ======");
            System.out.println("SecretKey: [" + VnPayConfig.secretKey + "]");
            System.out.println("TmnCode: [" + VnPayConfig.vnp_TmnCode + "]");
            System.out.println("HashData (OFFICIAL): [" + hashData.toString() + "]");
            System.out.println("SecureHash: [" + vnp_SecureHash + "]");
            System.out.println("Full PaymentUrl: " + paymentUrl);
            System.out.println("====== VNPAY DEBUG END ======");
            
            // Redirect to VNPAY
            resp.sendRedirect(paymentUrl);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error occurred during payment creation");
        }
    }
}
