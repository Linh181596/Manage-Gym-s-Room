package com.mycompany.gymcentermanagement.controller.member;

import com.mycompany.gymcentermanagement.dao.MemberDAO;
import com.mycompany.gymcentermanagement.dao.impl.MemberDAOImpl;
import com.mycompany.gymcentermanagement.dto.PTScheduleDetailDTO;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PTScheduleService;
import com.mycompany.gymcentermanagement.service.impl.PTScheduleServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "MemberScheduleController", urlPatterns = {"/member/schedule-dashboard"})
public class MemberScheduleController extends HttpServlet {
    private final PTScheduleService ptScheduleService = new PTScheduleServiceImpl();
    private final MemberDAO memberDAO = new MemberDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || currentUser.getRole() != User.Role.Member) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String refDateStr = req.getParameter("refDate");
        LocalDate refDate = (refDateStr != null && !refDateStr.isEmpty())
                ? LocalDate.parse(refDateStr)
                : LocalDate.now();

        LocalDate monday = refDate.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
        LocalDate sunday = refDate.with(TemporalAdjusters.nextOrSame(DayOfWeek.SUNDAY));

        LocalDate prevWeek = monday.minusWeeks(1);
        LocalDate nextWeek = monday.plusWeeks(1);

        try {
            Member member = memberDAO.findByUserId(currentUser.getUserId());
            if (member == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy hồ sơ hội viên.");
                return;
            }

            List<PTScheduleDetailDTO> weekSchedules = ptScheduleService.getMemberScheduleDetailsForWeek(member.getMemberId(), monday, sunday);
            List<PTScheduleDetailDTO> allUpcomingSchedules = ptScheduleService.getMemberScheduleDetailsForWeek(member.getMemberId(), monday.minusWeeks(2), sunday.plusWeeks(6));
            req.setAttribute("allUpcomingSchedules", allUpcomingSchedules);

            Map<String, List<PTScheduleDetailDTO>> scheduleMap = new LinkedHashMap<>();
            DateTimeFormatter uiFmt = DateTimeFormatter.ofPattern("dd/MM");

            for (int i = 0; i < 6; i++) {
                LocalDate d = monday.plusDays(i);
                String dayName = "Thứ " + (d.getDayOfWeek().getValue() + 1);
                String key = dayName + " (" + d.format(uiFmt) + ")";
                scheduleMap.put(key, new ArrayList<>());
            }

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

            DateTimeFormatter fullFmt = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            req.setAttribute("weekStartStr", monday.format(fullFmt));
            req.setAttribute("weekEndStr", sunday.format(fullFmt));
            req.setAttribute("prevWeekDate", prevWeek.toString());
            req.setAttribute("nextWeekDate", nextWeek.toString());
            req.setAttribute("scheduleMap", scheduleMap);

            req.getRequestDispatcher("/WEB-INF/views/member/member-schedule-dashboard.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi cơ sở dữ liệu: " + e.getMessage());
        }
    }
}
