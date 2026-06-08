package com.mycompany.gymcentermanagement.controller.auth;

import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.model.entity.UserToken;
import com.mycompany.gymcentermanagement.utils.EmailUtils;
import com.mycompany.gymcentermanagement.utils.PasswordUtils;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Controller to handle guest registration as a Member.
 * Mapped to /register.
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String displayName = request.getParameter("displayName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("dateOfBirth");
        String address = request.getParameter("address");

        request.setAttribute("oldDisplayName", displayName);
        request.setAttribute("oldEmail", email);
        request.setAttribute("oldPhone", phone);
        request.setAttribute("oldGender", gender);
        request.setAttribute("oldDob", dobStr);
        request.setAttribute("oldAddress", address);

        // Validation
        if (displayName == null || displayName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            password == null || password.isEmpty() ||
            confirmPassword == null || confirmPassword.isEmpty()) {
            
            request.setAttribute("error", "Vui lòng điền đầy đủ tất cả các trường thông tin bắt buộc!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        displayName = displayName.trim();
        email = email.trim();
        phone = phone.trim();
        if (address != null) address = address.trim();

        if (displayName.length() > 100) {
            request.setAttribute("error", "Họ và tên không được vượt quá 100 ký tự!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (email.length() > 100) {
            request.setAttribute("error", "Địa chỉ Email không được vượt quá 100 ký tự!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (address != null && address.length() > 255) {
            request.setAttribute("error", "Địa chỉ không được vượt quá 255 ký tự!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (!displayName.matches("^[\\p{L} ]+$")) {
            request.setAttribute("error", "Họ và tên không hợp lệ! Vui lòng chỉ nhập các ký tự chữ cái và khoảng trắng.");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (!email.matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$")) {
            request.setAttribute("error", "Định dạng địa chỉ Email không hợp lệ! (Ví dụ chuẩn: vidu@example.com).");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (!phone.matches("^0[0-9]{9}$")) {
            request.setAttribute("error", "Số điện thoại không hợp lệ! Số điện thoại bắt buộc phải có đúng 10 chữ số và bắt đầu bằng số 0.");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu và xác nhận mật khẩu không trùng khớp!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 8 || !password.matches(".*[A-Za-z].*") || !password.matches(".*\\d.*")) {
            request.setAttribute("error", "Mật khẩu không đạt yêu cầu bảo mật! Độ dài tối thiểu phải từ 8 ký tự trở lên, bao gồm cả chữ cái và chữ số.");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        LocalDate dateOfBirth = null;
        if (dobStr != null && !dobStr.trim().isEmpty()) {
            try {
                dateOfBirth = LocalDate.parse(dobStr);
                if (!dateOfBirth.isBefore(LocalDate.now())) {
                    request.setAttribute("error", "Ngày sinh không hợp lệ! Ngày sinh của bạn bắt buộc phải là một ngày nằm trong quá khứ.");
                    request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                    return;
                }
            } catch (DateTimeParseException e) {
                request.setAttribute("error", "Định dạng ngày sinh nhập vào không hợp lệ!");
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                return;
            }
        }

        try {
            if (userDAO.checkEmailExists(email)) {
                request.setAttribute("error", "Địa chỉ email này đã được sử dụng trên hệ thống phòng tập!");
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                return;
            }

            User user = new User();
            user.setEmail(email);
            user.setPasswordHash(PasswordUtils.hashPassword(password));
            user.setFullName(displayName);
            user.setPhoneNumber(phone);
            user.setRole(User.Role.Member);
            user.setAccountStatus(User.AccountStatus.Inactive);

            Member member = new Member();
            member.setGender(gender);
            member.setDateOfBirth(dateOfBirth);
            member.setAddress(address);
            member.setMembershipStatus("Pending");

            String tokenValue = UUID.randomUUID().toString();
            LocalDateTime expiresAt = LocalDateTime.now().plusDays(1);
            UserToken token = new UserToken(0, tokenValue, "VERIFICATION", expiresAt);

            boolean isRegistered = userDAO.registerMember(user, member, token);

            if (isRegistered) {
                boolean isEmailSent = EmailUtils.sendVerificationEmail(email, tokenValue);
                if (isEmailSent) {
                    request.setAttribute("message", "Đăng ký thành công! Hệ thống đã gửi một liên kết xác minh. Vui lòng kiểm tra hộp thư đến để kích hoạt tài khoản của bạn.");
                } else {
                    request.setAttribute("message", "Tài khoản được ghi nhận trên hệ thống, nhưng máy chủ gửi mail kích hoạt đang bận. Vui lòng liên hệ bộ phận hỗ trợ.");
                }
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Đăng ký không thành công do hệ thống máy chủ CSDL bận. Vui lòng thử lại sau!");
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
    }
}
