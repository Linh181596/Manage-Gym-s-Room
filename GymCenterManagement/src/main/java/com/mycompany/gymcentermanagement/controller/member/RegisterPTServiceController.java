/**
 * =========================================================================
 * @file          : RegisterPTServiceController.java
 * @description   : Controller điều phối luồng đăng ký gói dịch vụ PT cho hội viên.
 * @author        : Nguyễn Đình Phú (phund)
 * @created       : 2026-06-02
 * @last_modified : 2026-06-04 bởi Nguyễn Đình Phú
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.member;

import com.mycompany.gymcentermanagement.dao.MemberDAO;
import com.mycompany.gymcentermanagement.dao.impl.MemberDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.PTRegistration;
import com.mycompany.gymcentermanagement.model.entity.PTServicePrice;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PTRegistrationService;
import com.mycompany.gymcentermanagement.service.impl.PTRegistrationServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

/**
 * Controller for member to register for training service with a Personal Trainer.
 */
@WebServlet(name = "RegisterPTServiceController", urlPatterns = {"/member/pt/register"})
public class RegisterPTServiceController extends HttpServlet {

    private final PTRegistrationService registrationService = new PTRegistrationServiceImpl();
    private final MemberDAO memberDAO = new MemberDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String priceIdRaw = request.getParameter("priceId");

        if (priceIdRaw == null || priceIdRaw.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/pt/list");
            return;
        }

        int priceId;
        try {
            priceId = Integer.parseInt(priceIdRaw);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/pt/list");
            return;
        }

        PTServicePrice servicePrice = registrationService.getServicePriceById(priceId);

        if (servicePrice == null) {
            request.setAttribute("error", "Không tìm thấy gói PT phù hợp.");
            request.getRequestDispatcher("/WEB-INF/views/pt/register-pt-service.jsp").forward(request, response);
            return;
        }

        request.setAttribute("servicePrice", servicePrice);
        request.getRequestDispatcher("/WEB-INF/views/pt/register-pt-service.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String priceIdRaw = request.getParameter("priceId");
        String preferredStartDateRaw = request.getParameter("preferredStartDate");
        String note = request.getParameter("note");

        int priceId;
        try {
            priceId = Integer.parseInt(priceIdRaw);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/pt/list");
            return;
        }

        PTServicePrice servicePrice = registrationService.getServicePriceById(priceId);

        if (servicePrice == null) {
            request.setAttribute("error", "Không tìm thấy gói PT phù hợp.");
            request.getRequestDispatcher("/WEB-INF/views/pt/register-pt-service.jsp").forward(request, response);
            return;
        }

        if (preferredStartDateRaw == null || preferredStartDateRaw.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng chọn ngày bắt đầu mong muốn.");
            request.setAttribute("servicePrice", servicePrice);
            request.getRequestDispatcher("/WEB-INF/views/pt/register-pt-service.jsp").forward(request, response);
            return;
        }

        LocalDate preferredStartDate;

        try {
            preferredStartDate = LocalDate.parse(preferredStartDateRaw);
        } catch (DateTimeParseException e) {
            request.setAttribute("error", "Ngày bắt đầu không hợp lệ.");
            request.setAttribute("servicePrice", servicePrice);
            request.getRequestDispatcher("/WEB-INF/views/pt/register-pt-service.jsp").forward(request, response);
            return;
        }

        if (preferredStartDate.isBefore(LocalDate.now())) {
            request.setAttribute("error", "Ngày bắt đầu không được nhỏ hơn ngày hiện tại.");
            request.setAttribute("servicePrice", servicePrice);
            request.getRequestDispatcher("/WEB-INF/views/pt/register-pt-service.jsp").forward(request, response);
            return;
        }

        if (preferredStartDate.isAfter(LocalDate.now().plusYears(1))) {
            request.setAttribute("error", "Ngày bắt đầu không được vượt quá 1 năm trong tương lai.");
            request.setAttribute("servicePrice", servicePrice);
            request.getRequestDispatcher("/WEB-INF/views/pt/register-pt-service.jsp").forward(request, response);
            return;
        }

        Integer durationMonths = servicePrice.getDurationMonths();

        if (durationMonths == null || durationMonths <= 0) {
            request.setAttribute("error", "Thời hạn gói PT không hợp lệ.");
            request.setAttribute("servicePrice", servicePrice);
            request.getRequestDispatcher("/WEB-INF/views/pt/register-pt-service.jsp").forward(request, response);
            return;
        }

        LocalDate startDate = preferredStartDate;
        LocalDate endDate = startDate.plusMonths(durationMonths).minusDays(1);

        // Get logged-in user and lookup their Member record
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Member member = null;
        try {
            member = memberDAO.findByUserId(currentUser.getUserId());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (member == null) {
            request.setAttribute("error", "Tài khoản của bạn không có hồ sơ hội viên hợp lệ để đăng ký.");
            request.setAttribute("servicePrice", servicePrice);
            request.getRequestDispatcher("/WEB-INF/views/pt/register-pt-service.jsp").forward(request, response);
            return;
        }

        PTRegistration registration = new PTRegistration();
        registration.setMemberId(member.getMemberId());
        registration.setPtServicePriceId(priceId);
        registration.setPreferredStartDate(preferredStartDate);
        registration.setStartDate(startDate);
        registration.setEndDate(endDate);
        registration.setNote(note);
        registration.setTotalAmount(servicePrice.getPrice());
        registration.setCreatedBy(currentUser.getFullName());
        registration.setPurchasedSessions(servicePrice.getNumberOfSessions());

        boolean inserted = registrationService.registerPTService(registration);

        if (!inserted) {
            request.setAttribute("error", "Không thể đăng ký gói PT. Vui lòng thử lại.");
            request.setAttribute("servicePrice", servicePrice);
            request.getRequestDispatcher("/WEB-INF/views/pt/register-pt-service.jsp").forward(request, response);
            return;
        }

        request.setAttribute("servicePrice", servicePrice);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.getRequestDispatcher("/WEB-INF/views/pt/register-pt-service-result.jsp").forward(request, response);
    }
}
