/**
 * =========================================================================
 * @file          : ManageCheckinController.java
 * @description   : Controller điều phối điểm danh Staff và PT (UC 2.3.4).
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi LinhNT
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
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ManageCheckinController", urlPatterns = {"/staff/checkin"})
public class ManageCheckinController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ManageCheckinController.class.getName());
    private final StaffPTAttendanceService attendanceService = new StaffPTAttendanceServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (!hasCheckinPermission(session)) {
            request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
            return;
        }

        String shift = getShift(request);
        LocalDate date = getDate(request);
        String keyword = getKeyword(request);

        request.setAttribute("selectedShift", shift);
        request.setAttribute("selectedDate", date.toString());
        request.setAttribute("keyword", keyword);
        request.setAttribute("shiftWindow", getShiftWindowLabel(shift));
        request.setAttribute("attendanceAllowed",
                isAttendanceAllowed(shift, date, LocalDate.now(), LocalTime.now()));
        request.setAttribute("checkoutAllowed", isCheckoutAllowed(date, LocalDate.now()));
        request.setAttribute("attendanceBlockedMessage",
                getAttendanceBlockedMessage(shift, date, LocalDate.now(), LocalTime.now()));

        try {
            List<StaffPTAttendance> records = attendanceService.getCheckinStatusList(shift, date, keyword);
            request.setAttribute("attendanceList", records);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error loading check-in list", ex);
            request.setAttribute("errorMessage", "Không thể tải danh sách điểm danh. Vui lòng thử lại.");
        }

        request.getRequestDispatcher("/WEB-INF/views/staff/checkin-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (!hasCheckinPermission(session)) {
            response.sendRedirect(request.getContextPath() + "/error/403");
            return;
        }

        String shift = getShift(request);
        LocalDate date = getDate(request);
        String keyword = getKeyword(request);
        String action = request.getParameter("action");
        if (action == null || action.isBlank()) {
            action = "checkin";
        }

        User currentUser = (User) session.getAttribute("currentUser");
        int actorUserId = currentUser.getUserId();
        String actorName = currentUser.getFullName();

        try {
            switch (action) {
                case "checkout" -> {
                    if (validateCheckoutDate(session, date)) {
                        handleCheckout(request, session, actorUserId);
                    }
                }
                case "undoCheckout" -> handleUndoCheckout(request, session, actorUserId);
                case "cancel" -> handleCancel(request, session, actorUserId);
                case "checkin" -> {
                    if (validateAttendanceTime(session, shift, date)) {
                        handleCheckin(request, session, shift, date, actorUserId, actorName);
                    }
                }
                default -> setFlash(session, "error", "Thao tác điểm danh không hợp lệ.");
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error processing check-in action", ex);
            setFlash(session, "error", "Lỗi hệ thống khi xử lý điểm danh. Vui lòng thử lại.");
        }

        redirectBack(response, request, shift, date, keyword);
    }

    private void handleCheckin(HttpServletRequest request, HttpSession session,
                               String shift, LocalDate date, int checkedBy,
                               String checkedByName) throws SQLException {
        String targetUserIdStr = request.getParameter("targetUserId");
        String targetUserRole = request.getParameter("targetUserRole");

        if (targetUserIdStr == null || targetUserIdStr.isBlank()
                || targetUserRole == null || targetUserRole.isBlank()) {
            setFlash(session, "error", "Thông tin điểm danh không hợp lệ.");
            return;
        }

        int targetUserId;
        try {
            targetUserId = Integer.parseInt(targetUserIdStr);
        } catch (NumberFormatException e) {
            setFlash(session, "error", "ID người dùng không hợp lệ.");
            return;
        }

        if (attendanceService.existsCheckinForShift(targetUserId, shift, date)) {
            setFlash(session, "warning", "Người này đã được ghi giờ vào trong ca " + getShiftLabel(shift)
                    + " ngày " + date + ".");
            return;
        }

        StaffPTAttendance attendance = new StaffPTAttendance();
        attendance.setUserId(targetUserId);
        attendance.setUserRole(targetUserRole);
        attendance.setShiftBlock(shift);
        attendance.setCheckedBy(checkedBy);
        attendance.setNote(request.getParameter("note"));
        attendance.setCreatedBy(checkedByName);

        int newId = attendanceService.checkinUser(attendance);
        if (newId > 0) {
            setFlash(session, "success", "Ghi giờ vào thành công!");
        } else {
            setFlash(session, "error", "Không thể lưu bản ghi điểm danh. Vui lòng thử lại.");
        }
    }

    private void handleCheckout(HttpServletRequest request, HttpSession session, int checkedBy) throws SQLException {
        int attendanceId = parseAttendanceId(request);
        if (attendanceId <= 0) {
            setFlash(session, "error", "Bản ghi điểm danh không hợp lệ.");
            return;
        }

        boolean updated = attendanceService.checkoutAttendance(attendanceId, checkedBy);
        setFlash(session, updated ? "success" : "warning",
                updated ? "Ghi giờ ra thành công!" : "Không thể ghi giờ ra cho bản ghi này.");
    }

    private void handleUndoCheckout(HttpServletRequest request, HttpSession session, int updatedBy) throws SQLException {
        int attendanceId = parseAttendanceId(request);
        if (attendanceId <= 0) {
            setFlash(session, "error", "Bản ghi điểm danh không hợp lệ.");
            return;
        }

        boolean updated = attendanceService.undoCheckout(attendanceId, updatedBy);
        setFlash(session, updated ? "success" : "warning",
                updated ? "Hoàn tác giờ ra thành công!" : "Không thể hoàn tác giờ ra cho bản ghi này.");
    }

    private void handleCancel(HttpServletRequest request, HttpSession session, int cancelledBy) throws SQLException {
        int attendanceId = parseAttendanceId(request);
        if (attendanceId <= 0) {
            setFlash(session, "error", "Bản ghi điểm danh không hợp lệ.");
            return;
        }

        boolean updated = attendanceService.cancelAttendance(attendanceId, cancelledBy);
        setFlash(session, updated ? "success" : "warning",
                updated ? "Hủy bản ghi điểm danh thành công!" : "Không thể hủy bản ghi này.");
    }

    private String getShift(HttpServletRequest req) {
        String shift = req.getParameter("shift");
        if ("Afternoon".equals(shift) || "Evening".equals(shift)) {
            return shift;
        }
        return "Morning";
    }

    private LocalDate getDate(HttpServletRequest req) {
        String dateStr = req.getParameter("date");
        if (dateStr != null && !dateStr.isBlank()) {
            try {
                return LocalDate.parse(dateStr);
            } catch (Exception ignored) {
            }
        }
        return LocalDate.now();
    }

    private String getKeyword(HttpServletRequest req) {
        String keyword = req.getParameter("keyword");
        return keyword == null ? "" : keyword.trim();
    }

    private String getShiftLabel(String shift) {
        return switch (shift) {
            case "Afternoon" -> "Chiều";
            case "Evening" -> "Tối";
            default -> "Sáng";
        };
    }

    private boolean validateAttendanceTime(HttpSession session, String shift, LocalDate selectedDate) {
        String blockedMessage = getAttendanceBlockedMessage(shift, selectedDate, LocalDate.now(), LocalTime.now());
        if (blockedMessage == null) {
            return true;
        }
        setFlash(session, "error", blockedMessage);
        return false;
    }

    private boolean validateCheckoutDate(HttpSession session, LocalDate selectedDate) {
        if (isCheckoutAllowed(selectedDate, LocalDate.now())) {
            return true;
        }
        setFlash(session, "error", "Chỉ được ghi giờ ra cho ngày hiện tại.");
        return false;
    }

    static boolean isAttendanceAllowed(String shift, LocalDate selectedDate, LocalDate currentDate, LocalTime currentTime) {
        return getAttendanceBlockedMessage(shift, selectedDate, currentDate, currentTime) == null;
    }

    static boolean isCheckoutAllowed(LocalDate selectedDate, LocalDate currentDate) {
        return selectedDate.equals(currentDate);
    }

    static String getAttendanceBlockedMessage(String shift, LocalDate selectedDate,
                                              LocalDate currentDate, LocalTime currentTime) {
        if (!selectedDate.equals(currentDate)) {
            return "Chỉ được điểm danh cho ngày hiện tại.";
        }

        ShiftWindow window = getShiftWindow(shift);
        if (currentTime.isBefore(window.attendanceStart()) || currentTime.isAfter(window.attendanceEnd())) {
            return "Chưa đến hoặc đã quá khung giờ điểm danh của ca "
                    + getShiftLabelStatic(shift) + " (" + getShiftWindowLabel(shift) + ").";
        }

        return null;
    }

    private static ShiftWindow getShiftWindow(String shift) {
        return switch (shift) {
            case "Afternoon" -> new ShiftWindow(LocalTime.of(13, 15), LocalTime.of(16, 45),
                    LocalTime.of(13, 0), LocalTime.of(17, 0));
            case "Evening" -> new ShiftWindow(LocalTime.of(17, 0), LocalTime.of(20, 30),
                    LocalTime.of(16, 45), LocalTime.of(20, 45));
            default -> new ShiftWindow(LocalTime.of(8, 0), LocalTime.of(12, 0),
                    LocalTime.of(7, 45), LocalTime.of(12, 15));
        };
    }

    static String getShiftWindowLabel(String shift) {
        ShiftWindow window = getShiftWindow(shift);
        return formatTime(window.shiftStart()) + "-" + formatTime(window.shiftEnd())
                + ", điểm danh " + formatTime(window.attendanceStart()) + "-" + formatTime(window.attendanceEnd());
    }

    private static String getShiftLabelStatic(String shift) {
        return switch (shift) {
            case "Afternoon" -> "Chiều";
            case "Evening" -> "Tối";
            default -> "Sáng";
        };
    }

    private static String formatTime(LocalTime time) {
        return String.format("%02d:%02d", time.getHour(), time.getMinute());
    }

    private record ShiftWindow(LocalTime shiftStart, LocalTime shiftEnd,
                               LocalTime attendanceStart, LocalTime attendanceEnd) {
    }

    private int parseAttendanceId(HttpServletRequest request) {
        String value = request.getParameter("attendanceId");
        if (value == null || value.isBlank()) {
            return 0;
        }
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private boolean hasCheckinPermission(HttpSession session) {
        if (session == null) {
            return false;
        }
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            return false;
        }
        User.Role role = user.getRole();
        return role == User.Role.Staff || role == User.Role.Admin;
    }

    private void setFlash(HttpSession session, String type, String message) {
        session.setAttribute("flashType", type);
        session.setAttribute("flashMessage", message);
    }

    private void redirectBack(HttpServletResponse response, HttpServletRequest request,
                              String shift, LocalDate date, String keyword) throws IOException {
        response.sendRedirect(request.getContextPath()
                + "/staff/checkin?shift=" + shift
                + "&date=" + date
                + "&keyword=" + URLEncoder.encode(keyword, StandardCharsets.UTF_8));
    }
}
