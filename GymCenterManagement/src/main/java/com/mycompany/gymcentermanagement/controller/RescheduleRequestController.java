package com.mycompany.gymcentermanagement.controller;

import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.RescheduleRequestService;
import com.mycompany.gymcentermanagement.service.impl.RescheduleRequestServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet(name = "RescheduleRequestController", urlPatterns = {"/reschedule-request/create", "/reschedule-request/respond"})
public class RescheduleRequestController extends HttpServlet {

    private final RescheduleRequestService rescheduleRequestService = new RescheduleRequestServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User currentUser = session == null ? null : (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();

        if ("/reschedule-request/respond".equals(path)) {
            int requestId = parseInt(request.getParameter("requestId"));
            String action = request.getParameter("action");
            String responseReason = request.getParameter("responseReason");

            String returnUrl = request.getParameter("returnUrl");
            if (returnUrl == null || returnUrl.isBlank()) {
                returnUrl = defaultReturnUrl(request, currentUser);
            } else if (!returnUrl.startsWith(request.getContextPath() + "/")) {
                returnUrl = defaultReturnUrl(request, currentUser);
            }

            String result = rescheduleRequestService.respondToRequest(
                    requestId,
                    action,
                    currentUser.getUserId(),
                    responseReason
            );

            if ("SUCCESS".equals(result)) {
                String actionViet = "đồng ý";
                if ("reject".equalsIgnoreCase(action)) {
                    actionViet = "từ chối";
                } else if ("escalate".equalsIgnoreCase(action)) {
                    actionViet = "khiếu nại";
                }
                session.setAttribute("toastMsg", "Đã " + actionViet + " yêu cầu đổi lịch!");
            } else {
                session.setAttribute("errorMessage", result);
            }
            response.sendRedirect(returnUrl);
            return;
        }

        // Default handle: /reschedule-request/create
        String returnUrl = request.getParameter("returnUrl");
        if (returnUrl == null || returnUrl.isBlank()) {
            returnUrl = defaultReturnUrl(request, currentUser);
        } else if (!returnUrl.startsWith(request.getContextPath() + "/")) {
            returnUrl = defaultReturnUrl(request, currentUser);
        }

        int scheduleId = parseInt(request.getParameter("scheduleId"));
        LocalDate proposedDate = parseDate(request.getParameter("proposedDate"));
        String proposedSlot = request.getParameter("proposedSlot");
        String reason = request.getParameter("reason");

        String result = rescheduleRequestService.createRequest(
                currentUser.getUserId(),
                currentUser.getRole(),
                scheduleId,
                proposedDate,
                proposedSlot,
                reason
        );

        if ("SUCCESS".equals(result)) {
            session.setAttribute("toastMsg", "Gửi yêu cầu đổi lịch thành công!");
        } else {
            session.setAttribute("errorMessage", result);
        }
        response.sendRedirect(returnUrl);
    }

    private int parseInt(String value) {
        if (value == null || value.isBlank()) {
            return -1;
        }
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return -1;
        }
    }

    private LocalDate parseDate(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        try {
            return LocalDate.parse(value.trim());
        } catch (Exception e) {
            return null;
        }
    }

    private String defaultReturnUrl(HttpServletRequest request, User currentUser) {
        if (currentUser.getRole() == User.Role.PT) {
            return request.getContextPath() + "/pt/schedule-dashboard";
        }
        return request.getContextPath() + "/member/schedule-dashboard";
    }
}
