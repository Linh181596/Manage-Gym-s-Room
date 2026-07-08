package com.mycompany.gymcentermanagement.controller.pt;

import com.mycompany.gymcentermanagement.dto.PTScheduleDetailDTO;
import com.mycompany.gymcentermanagement.dto.PTRegistrationDTO;
import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PersonalTrainerService;
import com.mycompany.gymcentermanagement.service.PTScheduleService;
import com.mycompany.gymcentermanagement.service.PTRegistrationService;
import com.mycompany.gymcentermanagement.service.impl.PersonalTrainerServiceImpl;
import com.mycompany.gymcentermanagement.service.impl.PTScheduleServiceImpl;
import com.mycompany.gymcentermanagement.service.impl.PTRegistrationServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "PTScheduleDashboardController", urlPatterns = {"/pt/schedule-dashboard"})
public class PTScheduleDashboardController extends HttpServlet {
    private PTScheduleService ptScheduleService;
    private PersonalTrainerService personalTrainerService;

    @Override
    public void init() throws ServletException {
        ptScheduleService = new PTScheduleServiceImpl();
        personalTrainerService = new PersonalTrainerServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Kiểm tra đăng nhập (Bảo mật)
        HttpSession session = req.getSession();
        User ptUser = (User) session.getAttribute("currentUser");
        if (ptUser == null || ptUser.getRole() != User.Role.PT) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 2. Lấy mốc thời gian từ URL (Nếu không có thì lấy Hôm nay)
        String refDateStr = req.getParameter("refDate");
        LocalDate refDate = (refDateStr != null && !refDateStr.isEmpty())
                ? LocalDate.parse(refDateStr)
                : LocalDate.now();

        // 3. Tính toán ngày Thứ 2 và Chủ Nhật của tuần đó
        LocalDate monday = refDate.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
        LocalDate sunday = refDate.with(TemporalAdjusters.nextOrSame(DayOfWeek.SUNDAY));

        // Tính ngày của Tuần trước & Tuần sau (Để gắn vào nút Next/Prev trên giao diện)
        LocalDate prevWeek = monday.minusWeeks(1);
        LocalDate nextWeek = monday.plusWeeks(1);

        // 4. Query Database lấy lịch
        PersonalTrainer pt = personalTrainerService.getPTByUserId(ptUser.getUserId());
        if (pt == null) {
            resp.sendRedirect(req.getContextPath() + "/pt/dashboard");
            return;
        }
        List<PTScheduleDetailDTO> weekSchedules = ptScheduleService.getPTScheduleDetailsForWeek(pt.getPtId(), monday, sunday);
        List<PTScheduleDetailDTO> allUpcomingSchedules = ptScheduleService.getPTScheduleDetailsForWeek(pt.getPtId(), monday.minusWeeks(2), sunday.plusWeeks(6));
        req.setAttribute("allUpcomingSchedules", allUpcomingSchedules);

        PTRegistrationService ptRegistrationService = new PTRegistrationServiceImpl();
        List<PTRegistrationDTO> pendingSchedules = ptRegistrationService.getActivePaidRegistrationsWithoutScheduleByPT(pt.getPtId());
        req.setAttribute("pendingSchedules", pendingSchedules);

        // 5. Nhào nặn dữ liệu: Gom nhóm lịch theo từng ngày (Tạo 6 cột, bỏ Chủ Nhật)
        Map<String, List<PTScheduleDetailDTO>> scheduleMap = new LinkedHashMap<>();
        DateTimeFormatter uiFmt = DateTimeFormatter.ofPattern("dd/MM");

        // Khởi tạo sẵn 6 ngày (Từ Thứ 2 đến Thứ 7)
        for (int i = 0; i < 6; i++) {
            LocalDate d = monday.plusDays(i);
            String dayName = "Thứ " + (d.getDayOfWeek().getValue() + 1);
            String key = dayName + " (" + d.format(uiFmt) + ")";
            scheduleMap.put(key, new ArrayList<>());
        }

        // Nhét ca tập vào đúng cái ngày của nó
        for (PTScheduleDetailDTO s : weekSchedules) {
            LocalDate d = s.getSessionDate();
            if (d.getDayOfWeek() == DayOfWeek.SUNDAY) {
                continue;
            }
            String dayName = "Thứ " + (d.getDayOfWeek().getValue() + 1);
            String key = dayName + " (" + d.format(uiFmt) + ")";
            if (scheduleMap.containsKey(key)) {
                scheduleMap.get(key).add(s);
            }
        }

        // 6. Đẩy ra JSP
        DateTimeFormatter fullFmt = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        req.setAttribute("weekStartStr", monday.format(fullFmt));
        req.setAttribute("weekEndStr", sunday.format(fullFmt));
        req.setAttribute("prevWeekDate", prevWeek.toString());
        req.setAttribute("nextWeekDate", nextWeek.toString());
        req.setAttribute("scheduleMap", scheduleMap);

        req.getRequestDispatcher("/WEB-INF/views/pt/pt-schedule-dashboard.jsp").forward(req, resp);
    }
}
