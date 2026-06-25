package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.dto.PTRegistrationDTO;
import com.mycompany.gymcentermanagement.model.entity.PTSchedule;
import com.mycompany.gymcentermanagement.service.PTRegistrationService;
import com.mycompany.gymcentermanagement.service.PTScheduleService;
import com.mycompany.gymcentermanagement.service.impl.PTRegistrationServiceImpl;
import com.mycompany.gymcentermanagement.service.impl.PTScheduleServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "ScheduleSetupController", urlPatterns = {"/admin/pt/schedule-setup"})
public class ScheduleSetupController extends HttpServlet {
    private PTRegistrationService ptRegistrationService = new PTRegistrationServiceImpl();
    private PTScheduleService ptScheduleService = new PTScheduleServiceImpl();
    // Hàm siêu trí tuệ: Xây dựng ma trận lịch rảnh/bận
    private void setupTimetableMatrix(HttpServletRequest request, int ptId, LocalDate referenceDate) {
        // 1. Tìm ngày Thứ 2 và Chủ Nhật của cái tuần chứa referenceDate
        LocalDate monday = referenceDate.with(java.time.temporal.TemporalAdjusters.previousOrSame(java.time.DayOfWeek.MONDAY));
        LocalDate sunday = referenceDate.with(java.time.temporal.TemporalAdjusters.nextOrSame(java.time.DayOfWeek.SUNDAY));

        // 2. Gọi DB lấy danh sách lịch PT đã có trong tuần đó
        List<PTSchedule> weekSchedules = ptScheduleService.getSchedulesForWeek(ptId, monday, sunday);

        // 3. Khởi tạo ma trận 3 hàng (Sáng, Chiều, Tối) x 7 cột (T2 -> CN). Mặc định Java gán sẵn là FALSE (Rảnh)
        boolean[][] matrix = new boolean[3][7];

        for (PTSchedule s : weekSchedules) {
            int col = s.getSessionDate().getDayOfWeek().getValue() - 1; // Thứ 2 = 1 -> Đẩy về index 0

            int row = -1;
            String timeStr = s.getStartTime().toString();
            if (timeStr.startsWith("08")) row = 0;      // Ca Sáng
            else if (timeStr.startsWith("15")) row = 1; // Ca Chiều
            else if (timeStr.startsWith("18")) row = 2; // Ca Tối

            if (row != -1) matrix[row][col] = true; // Chuyển thành TRUE (Bận)
        }

        // 4. Đẩy ra View
        java.time.format.DateTimeFormatter fmt = java.time.format.DateTimeFormatter.ofPattern("dd/MM");
        request.setAttribute("timetableMatrix", matrix);
        request.setAttribute("weekStartStr", monday.format(fmt));
        request.setAttribute("weekEndStr", sunday.format(fmt));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String regIdStr = request.getParameter("regId");

        try {
            int regId = Integer.parseInt(regIdStr);
            PTRegistrationDTO reg = ptRegistrationService.getRegistrationById(regId);

            if (reg == null) {
                response.sendRedirect(request.getContextPath() + "/admin/schedule/manage?error=notfound");
                return;
            }

            request.setAttribute("reg", reg);
            // Lấy ngày dự kiến làm mốc quét tuần
            LocalDate preferredDate = reg.getPreferredStartDate();
            LocalDate today = LocalDate.now();

            //if expected date < today -> Today is point |||| if expected date >= today: expected day is point
            LocalDate refDate = preferredDate.isBefore(today) ? today : preferredDate;
            setupTimetableMatrix(request, reg.getPtId(), refDate);
            request.getRequestDispatcher("/WEB-INF/views/admin/schedule-setup.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/schedule/manage?error=invalid");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            int regId = Integer.parseInt(request.getParameter("regId"));
            int totalSessions = Integer.parseInt(request.getParameter("sessions"));
            int ptId = Integer.parseInt(request.getParameter("ptId"));
            int memberId = Integer.parseInt(request.getParameter("memberId"));

            LocalDate actualStartDate = LocalDate.parse(request.getParameter("actualStartDate"));
            String[] daysOfWeekStr = request.getParameterValues("daysOfWeek");

            if (daysOfWeekStr != null && daysOfWeekStr.length > 0) {
                request.setAttribute("submittedDays", Arrays.asList(daysOfWeekStr));
            } else {
                request.setAttribute("errorMsg", "Vui lòng chọn ít nhất một ngày.");
                request.setAttribute("submittedDays", new ArrayList<String>());
                request.setAttribute("submittedTimeSlot", request.getParameter("timeSlot"));
                request.setAttribute("submittedStartDate", request.getParameter("actualStartDate"));
                request.setAttribute("submittedPayment", request.getParameter("confirmPayment") != null);

                PTRegistrationDTO reg = ptRegistrationService.getRegistrationById(regId);
                request.setAttribute("reg", reg);

                LocalDate refDate = LocalDate.parse(request.getParameter("actualStartDate"));
                setupTimetableMatrix(request, ptId, refDate);

                request.getRequestDispatcher("/WEB-INF/views/admin/schedule-setup.jsp").forward(request, response);
                return;
            }

            String timeSlot = request.getParameter("timeSlot");
            boolean isPaymentConfirmed = request.getParameter("confirmPayment") != null;

            List<DayOfWeek> selectedDays = new ArrayList<>();
            if (daysOfWeekStr != null) {
                for (String day : daysOfWeekStr) {
                    selectedDays.add(DayOfWeek.valueOf(day));
                }
            }

            String[] timeParts = timeSlot.split("-");
            java.sql.Time startTime = java.sql.Time.valueOf(timeParts[0] + ":00");
            java.sql.Time endTime = java.sql.Time.valueOf(timeParts[1] + ":00");

            LocalDate checkDate = actualStartDate;
            int sessionsSimulated = 0;
            int searchCounter = 0;
            int maxDaysToSearch = 180;
            List<LocalDate> conflictDates = new ArrayList<>();
            java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy");

            while (sessionsSimulated < totalSessions && searchCounter < maxDaysToSearch) {
                if (selectedDays.contains(checkDate.getDayOfWeek())) {
                    boolean isConflict = ptScheduleService.isScheduleConflict(ptId, checkDate, startTime, endTime);

                    if (isConflict) {
                        conflictDates.add(checkDate);
                    }
                    sessionsSimulated++;
                }
                checkDate = checkDate.plusDays(1);
                searchCounter++;
            }

            if (!conflictDates.isEmpty()) {
                StringBuilder errorMsg = new StringBuilder("Ca tập này đã bị trùng vào các ngày: ");
                for (LocalDate d : conflictDates) {
                    String daysInWeekVietnam = d.getDayOfWeek().getDisplayName(
                            java.time.format.TextStyle.FULL,
                            new java.util.Locale("vi", "VN")
                    );

                    errorMsg.append(d.format(formatter)).append(" (").append(daysInWeekVietnam).append("), ");
                }
                errorMsg.append("vui lòng chọn Ca tập khác hoặc đổi lại Thứ/Ngày!");

                request.setAttribute("errorMsg", errorMsg.toString());

                request.setAttribute("submittedDays", Arrays.asList(daysOfWeekStr));
                request.setAttribute("submittedTimeSlot", timeSlot);
                request.setAttribute("submittedStartDate", request.getParameter("actualStartDate"));
                request.setAttribute("submittedPayment", isPaymentConfirmed);

                request.setAttribute("reg", ptRegistrationService.getRegistrationById(regId));

                LocalDate refDate = LocalDate.parse(request.getParameter("actualStartDate"));
                setupTimetableMatrix(request, ptId, refDate);

                request.getRequestDispatcher("/WEB-INF/views/admin/schedule-setup.jsp").forward(request, response);
                return;
            }

            List<PTSchedule> generatedSchedules = new ArrayList<>();
            LocalDate insertDate = actualStartDate;
            int sessionsScheduled = 0;
            searchCounter = 0;

            while (sessionsScheduled < totalSessions && searchCounter < maxDaysToSearch) {
                if (selectedDays.contains(insertDate.getDayOfWeek())) {
                    PTSchedule schedule = new PTSchedule();
                    schedule.setPtId(ptId);
                    schedule.setRegistrationId(regId);
                    schedule.setMemberId(memberId);
                    schedule.setSessionDate(insertDate);
                    schedule.setStartTime(startTime);
                    schedule.setEndTime(endTime);

                    generatedSchedules.add(schedule);
                    sessionsScheduled++;
                }
                insertDate = insertDate.plusDays(1);
                searchCounter++;
            }

            com.mycompany.gymcentermanagement.model.entity.User currentUser =
                    (com.mycompany.gymcentermanagement.model.entity.User) request.getSession().getAttribute("currentUser");
            int adminId = (currentUser != null) ? currentUser.getUserId() : 1;

            boolean isSaved = ptScheduleService.insertSchedules(generatedSchedules, adminId);

            if (isSaved) {
                String paymentStatus = isPaymentConfirmed ? "Paid" : "Unpaid";
                boolean isUpdated = ptRegistrationService.updateRegistrationAndPaymentStatus(regId, "Active", paymentStatus);

                if (!isUpdated) {
                    throw new Exception("Xếp lịch vào DB thành công nhưng Cập nhật trạng thái Đơn thất bại!");
                }

                request.getSession().setAttribute("toastMsg", "Tạo lịch và hoàn tất đơn thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/schedule/manage");
            } else {
                throw new Exception("Lỗi khi lưu lịch tập vào Database!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi xử lý: " + e.getMessage());
        }
    }
}
