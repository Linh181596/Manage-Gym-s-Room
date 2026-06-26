/**
 * =========================================================================
 * @file          : ManageCheckinController.java
 * @description   : Controller điều phối điểm danh Staff và PT (UC 2.3.4).
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.staff;

import com.mycompany.gymcentermanagement.model.entity.StaffPTAttendance;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.StaffPTAttendanceService;
import com.mycompany.gymcentermanagement.service.impl.StaffPTAttendanceServiceImpl;
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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Controller for UC 2.3.4 – Manage Staff & PT Check-ins.
 * URL: /staff/checkin
 */
@WebServlet(name = "ManageCheckinController", urlPatterns = {"/staff/checkin"})
public class ManageCheckinController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ManageCheckinController.class.getName());
    private final StaffPTAttendanceService attendanceService = new StaffPTAttendanceServiceImpl();

    // ------------------------------------------------------------------ //
    //  GET – hiển thị danh sách điểm danh theo ca và ngày
    // ------------------------------------------------------------------ //

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // A3: Kiểm tra quyền – chỉ Staff/Admin mới có thể truy cập
        HttpSession session = request.getSession(false);
        if (!hasCheckinPermission(session)) {
            request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
            return;
        }

        // Lấy ca và ngày từ query param (mặc định: ca Sáng, ngày hôm nay)
        String shift = getShift(request);
        LocalDate date = getDate(request);

        request.setAttribute("selectedShift", shift);
        request.setAttribute("selectedDate", date.toString());

        try {
            List<StaffPTAttendance> records =
                    attendanceService.getCheckinStatusList(shift, date);
            request.setAttribute("attendanceList", records);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error loading check-in list", ex);
            request.setAttribute("errorMessage", "Không thể tải danh sách điểm danh. Vui lòng thử lại.");
        }

        request.getRequestDispatcher("/WEB-INF/views/staff/checkin-list.jsp")
               .forward(request, response);
    }

    // ------------------------------------------------------------------ //
    //  POST – thực hiện điểm danh
    // ------------------------------------------------------------------ //

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // A3: Kiểm tra quyền
        HttpSession session = request.getSession(false);
        if (!hasCheckinPermission(session)) {
            response.sendRedirect(request.getContextPath() + "/error/403");
            return;
        }

        String shift = getShift(request);
        LocalDate date = getDate(request);

        String targetUserIdStr = request.getParameter("targetUserId");
        String targetUserRole  = request.getParameter("targetUserRole");

        // A2: Kiểm tra tham số đầu vào
        if (targetUserIdStr == null || targetUserIdStr.isBlank()
                || targetUserRole == null || targetUserRole.isBlank()) {
            setFlash(session, "error", "Thông tin điểm danh không hợp lệ.");
            redirectBack(response, request, shift, date);
            return;
        }

        int targetUserId;
        try {
            targetUserId = Integer.parseInt(targetUserIdStr);
        } catch (NumberFormatException e) {
            setFlash(session, "error", "ID người dùng không hợp lệ.");
            redirectBack(response, request, shift, date);
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");
        int checkedBy = currentUser.getUserId();
        String checkedByName = currentUser.getFullName();

        try {
            // A1: Kiểm tra trùng lặp điểm danh trong cùng ca ngày
            if (attendanceService.existsCheckinForShift(targetUserId, shift, date)) {
                setFlash(session, "warning",
                        "Người này đã được điểm danh trong ca " + shift + " ngày " + date + ".");
                redirectBack(response, request, shift, date);
                return;
            }

            // Tạo bản ghi điểm danh
            StaffPTAttendance attendance = new StaffPTAttendance();
            attendance.setUserId(targetUserId);
            attendance.setUserRole(targetUserRole);
            attendance.setShiftBlock(shift);
            attendance.setCheckedBy(checkedBy);
            attendance.setNote(request.getParameter("note"));
            attendance.setCreatedBy(checkedByName);

            int newId = attendanceService.checkinUser(attendance);
            if (newId > 0) {
                setFlash(session, "success", "Điểm danh thành công!");
            } else {
                setFlash(session, "error", "Không thể lưu bản ghi điểm danh. Vui lòng thử lại.");
            }

        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error creating check-in record", ex);
            setFlash(session, "error", "Lỗi hệ thống khi điểm danh. Vui lòng thử lại.");
        }

        redirectBack(response, request, shift, date);
    }

    // ------------------------------------------------------------------ //
    //  Helpers
    // ------------------------------------------------------------------ //

    /** Lấy ca từ request param; mặc định Morning */
    private String getShift(HttpServletRequest req) {
        String shift = req.getParameter("shift");
        if ("Afternoon".equals(shift) || "Evening".equals(shift)) return shift;
        return "Morning";
    }

    /** Lấy ngày từ request param; mặc định hôm nay */
    private LocalDate getDate(HttpServletRequest req) {
        String dateStr = req.getParameter("date");
        if (dateStr != null && !dateStr.isBlank()) {
            try {
                return LocalDate.parse(dateStr);
            } catch (Exception ignored) {}
        }
        return LocalDate.now();
    }

    private boolean hasCheckinPermission(HttpSession session) {
        if (session == null) return false;
        User user = (User) session.getAttribute("currentUser");
        if (user == null) return false;
        User.Role role = user.getRole();
        return role == User.Role.Staff || role == User.Role.Admin;
    }

    private void setFlash(HttpSession session, String type, String message) {
        session.setAttribute("flashType", type);
        session.setAttribute("flashMessage", message);
    }

    private void redirectBack(HttpServletResponse response, HttpServletRequest request,
                               String shift, LocalDate date) throws IOException {
        response.sendRedirect(request.getContextPath()
                + "/staff/checkin?shift=" + shift + "&date=" + date);
    }
}