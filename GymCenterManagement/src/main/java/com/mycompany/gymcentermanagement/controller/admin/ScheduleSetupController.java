package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.dto.PTRegistrationDTO;
import com.mycompany.gymcentermanagement.model.entity.PTSchedule;
import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PTRegistrationService;
import com.mycompany.gymcentermanagement.service.PTScheduleService;
import com.mycompany.gymcentermanagement.service.PersonalTrainerService;
import com.mycompany.gymcentermanagement.service.impl.PTRegistrationServiceImpl;
import com.mycompany.gymcentermanagement.service.impl.PTScheduleServiceImpl;
import com.mycompany.gymcentermanagement.service.impl.PersonalTrainerServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ScheduleSetupController", urlPatterns = {"/admin/pt/schedule-setup"})
public class ScheduleSetupController extends HttpServlet {
    private PTRegistrationService ptRegistrationService = new PTRegistrationServiceImpl();
    private PTScheduleService ptScheduleService = new PTScheduleServiceImpl();

    // Hàm siêu trí tuệ: Xây dựng ma trận lịch rảnh/bận
    private void setupTimetableMatrix(HttpServletRequest request, int ptId, int memberId, LocalDate referenceDate) {
        // 1. Tìm ngày Thứ 2 và Chủ Nhật của cái tuần chứa referenceDate
        LocalDate monday = referenceDate.with(java.time.temporal.TemporalAdjusters.previousOrSame(java.time.DayOfWeek.MONDAY));
        LocalDate sunday = referenceDate.with(java.time.temporal.TemporalAdjusters.nextOrSame(java.time.DayOfWeek.SUNDAY));

        // 2. Gọi DB lấy danh sách lịch PT và Member đã có trong tuần đó
        List<PTSchedule> weekSchedules = ptScheduleService.getSchedulesForWeek(ptId, monday, sunday);
        List<PTSchedule> memberWeekSchedules = ptScheduleService.getMemberSchedulesForWeek(memberId, monday, sunday);

        // 3. Khởi tạo các ma trận bận/rảnh
        boolean[][] matrix = new boolean[6][7];
        boolean[][] ptMatrix = new boolean[6][7];
        boolean[][] memberMatrix = new boolean[6][7];

        for (PTSchedule s : weekSchedules) {
            int col = s.getSessionDate().getDayOfWeek().getValue() - 1; // Thứ 2 = 1 -> Đẩy về index 0
            int row = getTimeSlotRow(s.getStartTime().toString());
            if (row != -1 && col >= 0 && col < 7) {
                matrix[row][col] = true; // Chuyển thành TRUE (Bận)
                ptMatrix[row][col] = true;
            }
        }

        for (PTSchedule s : memberWeekSchedules) {
            int col = s.getSessionDate().getDayOfWeek().getValue() - 1; // Thứ 2 = 1 -> Index 0
            int row = getTimeSlotRow(s.getStartTime().toString());
            if (row != -1 && col >= 0 && col < 7) {
                matrix[row][col] = true; // Chuyển thành TRUE (Bận)
                memberMatrix[row][col] = true;
            }
        }

        // 4. Đẩy ra View
        java.time.format.DateTimeFormatter fmt = java.time.format.DateTimeFormatter.ofPattern("dd/MM");
        request.setAttribute("timetableMatrix", matrix);
        request.setAttribute("ptMatrix", ptMatrix);
        request.setAttribute("memberMatrix", memberMatrix);
        request.setAttribute("weekStartStr", monday.format(fmt));
        request.setAttribute("weekEndStr", sunday.format(fmt));
    }

    private int getTimeSlotRow(String timeStr) {
        if (timeStr.startsWith("08:15")) return 0;
        if (timeStr.startsWith("10:00")) return 1;
        if (timeStr.startsWith("13:30")) return 2;
        if (timeStr.startsWith("15:15")) return 3;
        if (timeStr.startsWith("17:00")) return 4;
        if (timeStr.startsWith("18:45")) return 5;
        return -1;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User currentUser =
                (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String regIdStr = request.getParameter("regId");

        try {
            int regId = Integer.parseInt(regIdStr);
            PTRegistrationDTO reg = ptRegistrationService.getRegistrationById(regId);

            if (reg == null) {
                if (currentUser.getRole() == User.Role.PT) {
                    response.sendRedirect(request.getContextPath() + "/pt/schedule-dashboard?error=notfound");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/schedule/manage?error=notfound");
                }
                return;
            }

            // PT role check ownership
            if (currentUser.getRole() == User.Role.PT) {
                PersonalTrainerService personalTrainerService =
                        new PersonalTrainerServiceImpl();
                PersonalTrainer pt =
                        personalTrainerService.getPTByUserId(currentUser.getUserId());
                if (pt == null || reg.getPtId() != pt.getPtId()) {
                    request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
                    return;
                }
            }

            request.setAttribute("reg", reg);
            // Lấy ngày dự kiến làm mốc quét tuần
            LocalDate preferredDate = reg.getPreferredStartDate();
            LocalDate today = LocalDate.now();

            //if expected date < today -> Today is point |||| if expected date >= today: expected day is point
            LocalDate refDate = (preferredDate == null || preferredDate.isBefore(today)) ? today : preferredDate;
            setupTimetableMatrix(request, reg.getPtId(), reg.getMemberId(), refDate);
            request.getRequestDispatcher("/WEB-INF/views/admin/schedule-setup.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            if (currentUser.getRole() == User.Role.PT) {
                response.sendRedirect(request.getContextPath() + "/pt/schedule-dashboard?error=invalid");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/schedule/manage?error=invalid");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        User currentUser =
                (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int regId = Integer.parseInt(request.getParameter("regId"));
            int ptId = Integer.parseInt(request.getParameter("ptId"));
            int memberId = Integer.parseInt(request.getParameter("memberId"));

            // PT role check ownership and override ptId to avoid tampering
            if (currentUser.getRole() == User.Role.PT) {
                PersonalTrainerService personalTrainerService =
                        new PersonalTrainerServiceImpl();
                PersonalTrainer pt =
                        personalTrainerService.getPTByUserId(currentUser.getUserId());
                if (pt == null || ptId != pt.getPtId()) {
                    request.getRequestDispatcher("/WEB-INF/views/common/error-403.jsp").forward(request, response);
                    return;
                }
                ptId = pt.getPtId(); // overwrite
            }

            LocalDate actualStartDate = LocalDate.parse(request.getParameter("actualStartDate"));
            String[] daysOfWeekStr = request.getParameterValues("daysOfWeek");

            Map<String, String> dayTimeSlots = new HashMap<>();
            if (daysOfWeekStr != null) {
                for (String day : daysOfWeekStr) {
                    String slot = request.getParameter("timeSlot_" + day);
                    if (slot != null && !slot.trim().isEmpty()) {
                        dayTimeSlots.put(day.trim().toUpperCase(), slot.trim());
                    }
                }
            }

            if (dayTimeSlots.isEmpty()) {
                sendBackError(request, response, regId, ptId, memberId, "Vui lòng chọn ít nhất một ngày và ca tập tương ứng.", actualStartDate, dayTimeSlots);
                return;
            }

            // Kiểm tra giới hạn thời gian (không quá 1 năm trong tương lai)
            if (actualStartDate.isAfter(LocalDate.now().plusYears(1))) {
                sendBackError(request, response, regId, ptId, memberId, "Ngày bắt đầu chính thức không được vượt quá 1 năm trong tương lai.", actualStartDate, dayTimeSlots);
                return;
            }

            String result = ptScheduleService.generateFixedScheduleForPT(
                    regId, ptId, actualStartDate, dayTimeSlots, currentUser.getUserId());

            if ("SUCCESS".equals(result)) {
                request.getSession().setAttribute("toastMsg", "Tạo lịch tập thành công!");
                if (currentUser.getRole() == User.Role.PT) {
                    response.sendRedirect(request.getContextPath() + "/pt/schedule-dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/schedule/manage");
                }
            } else {
                sendBackError(request, response, regId, ptId, memberId, result, actualStartDate, dayTimeSlots);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi xử lý: " + e.getMessage());
        }
    }

    private void sendBackError(HttpServletRequest request, HttpServletResponse response,
                               int regId, int ptId, int memberId, String errorMsg,
                               LocalDate actualStartDate, Map<String, String> dayTimeSlots)
            throws ServletException, IOException {
        request.setAttribute("errorMsg", errorMsg);
        request.setAttribute("submittedDays", dayTimeSlots != null ? new ArrayList<>(dayTimeSlots.keySet()) : new ArrayList<String>());
        request.setAttribute("submittedDayTimeSlots", dayTimeSlots);
        request.setAttribute("submittedStartDate", actualStartDate.toString());

        PTRegistrationDTO reg = ptRegistrationService.getRegistrationById(regId);
        request.setAttribute("reg", reg);

        setupTimetableMatrix(request, ptId, memberId, actualStartDate);
        request.getRequestDispatcher("/WEB-INF/views/admin/schedule-setup.jsp").forward(request, response);
    }
}
