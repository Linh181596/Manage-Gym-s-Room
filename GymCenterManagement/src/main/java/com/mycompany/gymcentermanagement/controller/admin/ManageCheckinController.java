/**
 * =========================================================================
 * @file          : ManageCheckinController.java
 * @description   : Controller điều phối điểm danh Staff và PT.
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-06-26
 * @last_modified : 2026-06-26 bởi LinhNT
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.admin;

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

@WebServlet(name = "ManageCheckinController", urlPatterns = {"/admin/checkin"})
public class ManageCheckinController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ManageCheckinController.class.getName());
    private final StaffPTAttendanceService attendanceService = new StaffPTAttendanceServiceImpl();

    /**
     * Kiểm tra quyền Admin, lấy ca, ngày và từ khóa lọc, sau đó tải danh sách
     * Staff/PT kèm trạng thái check-in.
     */
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
        request.setAttribute("recordActionsAllowed", isRecordActionsAllowed(date, LocalDate.now()));
        request.setAttribute("attendanceBlockedMessage",
                getAttendanceBlockedMessage(shift, date, LocalDate.now(), LocalTime.now()));

        try {
            List<StaffPTAttendance> records = attendanceService.getCheckinStatusList(shift, date, keyword);
            request.setAttribute("attendanceList", records);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error loading check-in list", ex);
            request.setAttribute("errorMessage", "Không thể tải danh sách điểm danh. Vui lòng thử lại.");
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/checkin-list.jsp").forward(request, response);
    }

    /**
     * Xử lý các thao tác check-in, check-out, hoàn tác check-out và hủy bản ghi
     * điểm danh, sau đó redirect về danh sách đang lọc.
     */
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
                    if (validateMutableAttendanceRecord(request, session)) {
                        handleCheckout(request, session, actorUserId);
                    }
                }
                case "undoCheckout" -> {
                    if (validateMutableAttendanceRecord(request, session)) {
                        handleUndoCheckout(request, session, actorUserId);
                    }
                }
                case "cancel" -> {
                    if (validateMutableAttendanceRecord(request, session)) {
                        handleCancel(request, session, actorUserId);
                    }
                }
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

    /**
     * Tạo bản ghi check-in cho Staff/PT sau khi kiểm tra đủ thông tin mục tiêu
     * và bảo đảm người đó chưa check-in trong cùng ca/ngày.
     */
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

    /**
     * Ghi giờ ra cho một bản ghi điểm danh active dựa trên attendanceId được gửi
     * từ form thao tác.
     */
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

    /**
     * Hoàn tác giờ ra bằng cách xóa CheckedOutAt của bản ghi điểm danh đã
     * check-out nhưng vẫn còn active.
     */
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

    /**
     * Hủy mềm một bản ghi điểm danh active để bản ghi không còn xuất hiện như
     * một lần điểm danh hợp lệ.
     */
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

    /**
     * Đọc ca làm việc từ request và chuẩn hóa về Morning/Afternoon/Evening; nếu
     * giá trị không hợp lệ thì dùng Morning.
     */
    private String getShift(HttpServletRequest req) {
        String shift = req.getParameter("shift");
        if ("Afternoon".equals(shift) || "Evening".equals(shift)) {
            return shift;
        }
        return "Morning";
    }

    /**
     * Đọc ngày điểm danh từ request; nếu thiếu hoặc sai định dạng thì dùng ngày
     * hiện tại.
     */
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

    /**
     * Đọc từ khóa tìm kiếm Staff/PT từ request và chuẩn hóa null thành chuỗi
     * rỗng.
     */
    private String getKeyword(HttpServletRequest req) {
        String keyword = req.getParameter("keyword");
        return keyword == null ? "" : keyword.trim();
    }

    /**
     * Chuyển mã ca tiếng Anh trong dữ liệu sang nhãn tiếng Việt để dùng trong
     * thông báo nghiệp vụ.
     */
    private String getShiftLabel(String shift) {
        return switch (shift) {
            case "Afternoon" -> "Chiều";
            case "Evening" -> "Tối";
            default -> "Sáng";
        };
    }

    /**
     * Kiểm tra ca/ngày hiện tại có được phép check-in hay không và ghi flash lỗi
     * nếu đang ngoài khung giờ hợp lệ.
     */
    private boolean validateAttendanceTime(HttpSession session, String shift, LocalDate selectedDate) {
        String blockedMessage = getAttendanceBlockedMessage(shift, selectedDate, LocalDate.now(), LocalTime.now());
        if (blockedMessage == null) {
            return true;
        }
        setFlash(session, "error", blockedMessage);
        return false;
    }

    /**
     * Kiểm tra bản ghi điểm danh có tồn tại và còn thuộc ngày được phép sửa/hủy
     * trước khi xử lý check-out, hoàn tác hoặc hủy.
     */
    private boolean validateMutableAttendanceRecord(HttpServletRequest request, HttpSession session) throws SQLException {
        int attendanceId = parseAttendanceId(request);
        if (attendanceId <= 0) {
            setFlash(session, "error", "Bản ghi điểm danh không hợp lệ.");
            return false;
        }

        StaffPTAttendance attendance = attendanceService.findById(attendanceId);
        if (attendance == null || attendance.getAttendanceId() <= 0 || attendance.getAttendanceDate() == null) {
            setFlash(session, "error", "Không tìm thấy bản ghi điểm danh cần cập nhật.");
            return false;
        }

        if (isRecordActionsAllowed(attendance.getAttendanceDate(), LocalDate.now())) {
            return true;
        }

        setFlash(session, "error", "Ngày điểm danh đã kết thúc, không thể sửa, hoàn tác hoặc hủy bản ghi của ngày đó.");
        return false;
    }

    /**
     * Kiểm tra ngày được chọn có phải ngày hiện tại để cho phép thao tác
     * check-out.
     */
    private boolean validateCheckoutDate(HttpSession session, LocalDate selectedDate) {
        if (isCheckoutAllowed(selectedDate, LocalDate.now())) {
            return true;
        }
        setFlash(session, "error", "Chỉ được ghi giờ ra cho ngày hiện tại.");
        return false;
    }

    /**
     * Trả về true khi ca/ngày đang chọn nằm trong khung thời gian được phép
     * check-in.
     */
    static boolean isAttendanceAllowed(String shift, LocalDate selectedDate, LocalDate currentDate, LocalTime currentTime) {
        return getAttendanceBlockedMessage(shift, selectedDate, currentDate, currentTime) == null;
    }

    /**
     * Trả về true khi ngày thao tác trùng ngày hiện tại để cho phép check-out.
     */
    static boolean isCheckoutAllowed(LocalDate selectedDate, LocalDate currentDate) {
        return selectedDate.equals(currentDate);
    }

    /**
     * Trả về true khi bản ghi điểm danh thuộc ngày hiện tại, dùng để cho phép
     * sửa, hoàn tác hoặc hủy bản ghi.
     */
    static boolean isRecordActionsAllowed(LocalDate selectedDate, LocalDate currentDate) {
        return selectedDate != null && selectedDate.equals(currentDate);
    }

    /**
     * Tạo thông báo lý do không được check-in nếu ngày không phải hiện tại hoặc
     * thời gian hiện tại nằm ngoài khung điểm danh của ca.
     */
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

    /**
     * Trả về cấu hình giờ bắt đầu/kết thúc ca và giờ được phép điểm danh cho
     * từng ca Morning/Afternoon/Evening.
     */
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

    /**
     * Tạo chuỗi mô tả khung giờ ca và khung giờ điểm danh để hiển thị trên màn
     * hình check-in.
     */
    static String getShiftWindowLabel(String shift) {
        ShiftWindow window = getShiftWindow(shift);
        return formatTime(window.shiftStart()) + "-" + formatTime(window.shiftEnd())
                + ", điểm danh " + formatTime(window.attendanceStart()) + "-" + formatTime(window.attendanceEnd());
    }

    /**
     * Chuyển mã ca sang nhãn tiếng Việt trong các helper static.
     */
    private static String getShiftLabelStatic(String shift) {
        return switch (shift) {
            case "Afternoon" -> "Chiều";
            case "Evening" -> "Tối";
            default -> "Sáng";
        };
    }

    /**
     * Định dạng LocalTime thành chuỗi HH:mm để hiển thị khung giờ.
     */
    private static String formatTime(LocalTime time) {
        return String.format("%02d:%02d", time.getHour(), time.getMinute());
    }

    private record ShiftWindow(LocalTime shiftStart, LocalTime shiftEnd,
                               LocalTime attendanceStart, LocalTime attendanceEnd) {
    }

    /**
     * Đọc attendanceId từ request và trả về 0 khi thiếu hoặc không phải số hợp
     * lệ.
     */
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

    /**
     * Kiểm tra session hiện tại có người dùng Admin để được truy cập màn hình
     * quản lý check-in.
     */
    private boolean hasCheckinPermission(HttpSession session) {
        if (session == null) {
            return false;
        }
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            return false;
        }
        User.Role role = user.getRole();
        return role == User.Role.Admin;
    }

    /**
     * Lưu loại thông báo và nội dung thông báo vào session để hiển thị sau
     * redirect.
     */
    private void setFlash(HttpSession session, String type, String message) {
        session.setAttribute("flashType", type);
        session.setAttribute("flashMessage", message);
    }

    /**
     * Redirect về trang check-in với nguyên bộ lọc ca, ngày và từ khóa hiện tại
     * sau khi xử lý thao tác.
     */
    private void redirectBack(HttpServletResponse response, HttpServletRequest request,
                              String shift, LocalDate date, String keyword) throws IOException {
        response.sendRedirect(request.getContextPath()
                + "/admin/checkin?shift=" + shift
                + "&date=" + date
                + "&keyword=" + URLEncoder.encode(keyword, StandardCharsets.UTF_8));
    }
}
