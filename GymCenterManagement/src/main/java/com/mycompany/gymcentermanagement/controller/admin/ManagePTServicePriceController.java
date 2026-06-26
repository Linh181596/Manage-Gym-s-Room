/**
 * =========================================================================
 * @file          : ManagePTServicePriceController.java
 * @description   : Controller xử lý việc quản lý cấu hình biểu giá dịch vụ cho PT bởi Admin.
 * @author        : Nguyễn Đình Phú (phund)
 * @created       : 2026-06-04
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.model.entity.PTServicePrice;
import com.mycompany.gymcentermanagement.service.PersonalTrainerService;
import com.mycompany.gymcentermanagement.service.PTRegistrationService;
import com.mycompany.gymcentermanagement.service.impl.PersonalTrainerServiceImpl;
import com.mycompany.gymcentermanagement.service.impl.PTRegistrationServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name = "ManagePTServicePriceController", urlPatterns = {"/admin/pt/service-prices"})
public class ManagePTServicePriceController extends HttpServlet {
    private final PersonalTrainerService personalTrainerService = new PersonalTrainerServiceImpl();
    private final PTRegistrationService ptRegistrationService = new PTRegistrationServiceImpl();

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

            List<PTServicePrice> prices = ptRegistrationService.getAllServicePricesByTrainerId(ptId);
            PTServicePrice price12 = null;
            PTServicePrice price36 = null;

            for (PTServicePrice p : prices) {
                if (p.getPtPackageTypeId() == 1) {
                    price12 = p;
                } else if (p.getPtPackageTypeId() == 2) {
                    price36 = p;
                }
            }

            if (price12 == null) {
                price12 = new PTServicePrice(ptId, 1, BigDecimal.ZERO, "Active");
            }
            if (price36 == null) {
                price36 = new PTServicePrice(ptId, 2, BigDecimal.ZERO, "Active");
            }

            request.setAttribute("trainer", trainer);
            request.setAttribute("price12", price12);
            request.setAttribute("price36", price36);

            request.getRequestDispatcher("/WEB-INF/views/admin/manage-pt-service-prices.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/pt/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String idStr = request.getParameter("id");
        String price12Str = request.getParameter("price12");
        String price36Str = request.getParameter("price36");

        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/pt/list");
            return;
        }

        if (price12Str == null || price12Str.trim().isEmpty() || price36Str == null || price36Str.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ giá tiền cho cả hai gói tập.");
            doGet(request, response);
            return;
        }

        try {
            int ptId = Integer.parseInt(idStr);
            BigDecimal price12Val;
            BigDecimal price36Val;

            try {
                price12Val = new BigDecimal(price12Str.trim());
                price36Val = new BigDecimal(price36Str.trim());
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Giá tiền không hợp lệ. Vui lòng nhập số.");
                doGet(request, response);
                return;
            }

            if (price12Val.compareTo(BigDecimal.ZERO) < 0 || price36Val.compareTo(BigDecimal.ZERO) < 0) {
                request.setAttribute("error", "Giá tiền không được nhỏ hơn 0.");
                doGet(request, response);
                return;
            }

            PTServicePrice price12 = new PTServicePrice(ptId, 1, price12Val, "Active");
            PTServicePrice price36 = new PTServicePrice(ptId, 2, price36Val, "Active");

            boolean success12 = ptRegistrationService.saveOrUpdateServicePrice(price12);
            boolean success36 = ptRegistrationService.saveOrUpdateServicePrice(price36);

            if (success12 && success36) {
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
