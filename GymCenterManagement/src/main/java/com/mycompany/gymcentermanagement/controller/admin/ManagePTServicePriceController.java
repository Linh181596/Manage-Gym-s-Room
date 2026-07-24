/**
 * =========================================================================
 * @file          : ManagePTServicePriceController.java
 * @description   : Controller xử lý việc quản lý cấu hình biểu giá dịch vụ cho PT bởi Admin (Động theo các gói PT).
 * @author        : Nguyễn Đình Phú (phund)
 * @created       : 2026-06-04
 * @last_modified : 2026-07-15 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.model.entity.PTServicePrice;
import com.mycompany.gymcentermanagement.model.entity.PTPackageType;
import com.mycompany.gymcentermanagement.service.PersonalTrainerService;
import com.mycompany.gymcentermanagement.service.PTRegistrationService;
import com.mycompany.gymcentermanagement.service.PTPackageTypeService;
import com.mycompany.gymcentermanagement.service.impl.PersonalTrainerServiceImpl;
import com.mycompany.gymcentermanagement.service.impl.PTRegistrationServiceImpl;
import com.mycompany.gymcentermanagement.service.impl.PTPackageTypeServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ManagePTServicePriceController", urlPatterns = {"/admin/pt/service-prices"})
public class ManagePTServicePriceController extends HttpServlet {
    private final PersonalTrainerService personalTrainerService = new PersonalTrainerServiceImpl();
    private final PTRegistrationService ptRegistrationService = new PTRegistrationServiceImpl();
    private final PTPackageTypeService ptPackageTypeService = new PTPackageTypeServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/pt/list");
            return;
        }

        try {
            int ptId = Integer.parseInt(idStr);
            PersonalTrainer trainer = personalTrainerService.getPersonalTrainerById(ptId);
            if (trainer == null) {
                response.sendRedirect(request.getContextPath() + "/pt/list");
                return;
            }

            // 1. Lấy tất cả các loại gói PT đang hoạt động (Active)
            List<PTPackageType> activePackages = ptPackageTypeService.getActivePackages();

            // 2. Lấy danh sách biểu giá hiện có của PT này
            List<PTServicePrice> existingPrices = ptRegistrationService.getAllServicePricesByTrainerId(ptId);
            
            // 3. Đưa biểu giá hiện có vào Map để dễ tra cứu ở JSP
            Map<Integer, BigDecimal> priceMap = new HashMap<>();
            for (PTServicePrice p : existingPrices) {
                priceMap.put(p.getPtPackageTypeId(), p.getPrice());
            }

            request.setAttribute("trainer", trainer);
            request.setAttribute("activePackages", activePackages);
            request.setAttribute("priceMap", priceMap);

            request.getRequestDispatcher("/WEB-INF/views/admin/manage-pt-service-prices.jsp").forward(request, response);
        } catch (NumberFormatException | SQLException e) {
            response.sendRedirect(request.getContextPath() + "/pt/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/pt/list");
            return;
        }

        try {
            int ptId = Integer.parseInt(idStr);
            
            // Lấy các gói PT đang hoạt động để đọc tham số động từ Form gửi lên
            List<PTPackageType> activePackages = ptPackageTypeService.getActivePackages();
            
            boolean allSuccess = true;
            for (PTPackageType pkg : activePackages) {
                String inputName = "price_" + pkg.getPtPackageTypeId();
                String priceStr = request.getParameter(inputName);

                if (priceStr == null || priceStr.trim().isEmpty()) {
                    request.setAttribute("error", "Vui lòng nhập đầy đủ giá tiền cho các gói tập.");
                    doGet(request, response);
                    return;
                }

                BigDecimal priceVal;
                try {
                    priceVal = new BigDecimal(priceStr.trim());
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Giá tiền cho gói '" + pkg.getPackageName() + "' không hợp lệ. Vui lòng nhập số.");
                    doGet(request, response);
                    return;
                }

                if (priceVal.compareTo(BigDecimal.ZERO) <= 0) {
                    request.setAttribute("error", "Giá tiền cho gói '" + pkg.getPackageName() + "' phải lớn hơn 0.");
                    doGet(request, response);
                    return;
                }

                // Cập nhật hoặc lưu mới biểu giá
                PTServicePrice servicePrice = new PTServicePrice(ptId, pkg.getPtPackageTypeId(), priceVal, "Active");
                boolean success = ptRegistrationService.saveOrUpdateServicePrice(servicePrice);
                if (!success) {
                    allSuccess = false;
                }
            }

            if (allSuccess) {
                request.getSession().setAttribute("toastMsg", "Cập nhật giá dịch vụ PT thành công!");
                response.sendRedirect(request.getContextPath() + "/pt/detail?id=" + ptId);
            } else {
                request.setAttribute("error", "Lỗi lưu cấu hình giá vào cơ sở dữ liệu.");
                doGet(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            doGet(request, response);
        }
    }
}
