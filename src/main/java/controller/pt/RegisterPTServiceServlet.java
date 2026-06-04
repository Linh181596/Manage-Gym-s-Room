/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.pt;

import dao.PTRegistrationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import model.PTRegistration;
import model.PTServicePrice;

/**
 *
 * @author phuga
 */

/*
* Các hàm trong class này:
     *
     * - doGet(): mở form đăng ký gói PT service theo priceId member đã chọn.
     * - doPost(): xử lý khi member xác nhận đăng ký gói PT.
     *
     * Luồng xử lý:
     * - lấy priceId từ request.
     * - tìm thông tin gói PT service.
     * - kiểm tra ngày bắt đầu mong muốn.
     * - tính ngày bắt đầu, ngày kết thúc và tổng tiền.
     * - thêm đăng ký vào bảng PTRegistrations.
     *
     * Ghi chú:
     * - Khi member đăng ký, trạng thái ban đầu là Pending.
     * - Trạng thái thanh toán ban đầu là Unpaid.
     * - Staff/Admin sẽ xử lý thanh toán và sắp xếp lịch tập sau.
     * - MemberID hiện đang tạm hard-code để test, sau này sẽ lấy từ session đăng nhập.
 */
@WebServlet(name = "RegisterPTServiceServlet", urlPatterns = {"/member/pt/register"})
public class RegisterPTServiceServlet extends HttpServlet {

    private final PTRegistrationDAO registrationDAO = new PTRegistrationDAO();

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

        PTServicePrice servicePrice = registrationDAO.findServicePriceById(priceId);

        if (servicePrice == null) {
            request.setAttribute("error", "Không tìm thấy gói PT phù hợp.");
            request.getRequestDispatcher("/views/pt/register-pt-service.jsp").forward(request, response);
            return;
        }

        request.setAttribute("servicePrice", servicePrice);
        request.getRequestDispatcher("/views/pt/register-pt-service.jsp").forward(request, response);
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

        PTServicePrice servicePrice = registrationDAO.findServicePriceById(priceId);

        if (servicePrice == null) {
            request.setAttribute("error", "Không tìm thấy gói PT phù hợp.");
            request.getRequestDispatcher("/views/pt/register-pt-service.jsp").forward(request, response);
            return;
        }

        if (preferredStartDateRaw == null || preferredStartDateRaw.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng chọn ngày bắt đầu mong muốn.");
            request.setAttribute("servicePrice", servicePrice);
            request.getRequestDispatcher("/views/pt/register-pt-service.jsp").forward(request, response);
            return;
        }

        LocalDate preferredStartDate = LocalDate.parse(preferredStartDateRaw);

        if (preferredStartDate.isBefore(LocalDate.now())) {
            request.setAttribute("error", "Ngày bắt đầu không được nhỏ hơn ngày hiện tại.");
            request.setAttribute("servicePrice", servicePrice);
            request.getRequestDispatcher("/views/pt/register-pt-service.jsp").forward(request, response);
            return;
        }

        Integer durationMonths = servicePrice.getDurationMonths();

        if (durationMonths == null || durationMonths <= 0) {
            request.setAttribute("error", "Thời hạn gói PT không hợp lệ.");
            request.setAttribute("servicePrice", servicePrice);
            request.getRequestDispatcher("/views/pt/register-pt-service.jsp").forward(request, response);
            return;
        }

        LocalDate startDate = preferredStartDate;
        LocalDate endDate = startDate.plusMonths(durationMonths).minusDays(1); //start date: 3/6 -> minusDays(1) -> 2/7(not minusDays(1) -> 3/7)

        PTRegistration registration = new PTRegistration();

        // ===================================================
        // Tạm thời dùng MemberID = 1 để test khi login chưa tích hợp.
        // Sau này thay bằng session.getAttribute("memberId").
        /*
        Integer memberId = (Integer) request.getSession().getAttribute("memberId");
        registration.setMemberId(memberId);
         */
        registration.setMemberId(1);
        //====================================================

        registration.setPtServicePriceId(priceId);
        registration.setPreferredStartDate(preferredStartDate);
        registration.setStartDate(startDate);
        registration.setEndDate(endDate);
        registration.setNote(note);

        boolean inserted = registrationDAO.insert(registration);

        if (!inserted) {
            request.setAttribute("error", "Không thể đăng ký gói PT. Vui lòng thử lại.");
            request.setAttribute("servicePrice", servicePrice);
            request.getRequestDispatcher("/views/pt/register-pt-service.jsp").forward(request, response);
            return;
        }

        request.setAttribute("servicePrice", servicePrice);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.getRequestDispatcher("/views/pt/register-pt-service-result.jsp").forward(request, response);
    }
}
