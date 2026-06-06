/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gcms.controller.auth;

import com.gcms.dao.RegisterDAO;
import com.gcms.model.Member;
import com.gcms.model.User;
import com.gcms.model.UserToken;
import com.gcms.util.EmailUtil;
import com.gcms.util.PasswordUtil;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * Project: Gym Center Management System (GCMS)
 * Course: SWP391 - Software Development Project
 * File: RegisterServlet.java
 * Description: Controller xử lý luồng đăng ký tài khoản cho Guest thành Member (UC-02).
 * Thực hiện thêm mới Users, Members, phân quyền mặc định và gửi email kích hoạt (Token).
 * Author: [duongnd] - [he187234]
 * Created Date: [05/06/2026]
 * Version: 1.0
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    private final RegisterDAO registerDAO = new RegisterDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Điều hướng người dùng tới trang giao diện đăng ký ban đầu (Bước 1 & 2)
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Cấu hình mã hóa ký tự nhận dữ liệu tiếng Việt mượt mà không bị lỗi font
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Thu thập các thông số gửi lên từ thẻ <form> HTML của giao diện front-end (Bước 3)
        String displayName = request.getParameter("displayName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("dateOfBirth");
        String address = request.getParameter("address");

        // Giữ lại các giá trị cũ đã nhập nạp ngược về form giúp người dùng không phải điền lại từ đầu khi có lỗi xảy ra
        request.setAttribute("oldDisplayName", displayName);
        request.setAttribute("oldEmail", email);
        request.setAttribute("oldPhone", phone);
        request.setAttribute("oldGender", gender);
        request.setAttribute("oldDob", dobStr);
        request.setAttribute("oldAddress", address);

        // --- GIAI ĐOẠN VALIDATION & KIỂM TRA LUỒNG DỮ LIỆU TOÀN DIỆN (Bước 4) ---

        // 1. Kiểm tra trống các trường thông tin bắt buộc theo quy định tài liệu thiết kế
        if (displayName == null || displayName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            password == null || password.isEmpty() ||
            confirmPassword == null || confirmPassword.isEmpty()) {
            
            request.setAttribute("error", "Vui lòng điền đầy đủ tất cả các trường thông tin bắt buộc!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Loại bỏ khoảng trắng thừa đầu cuối của dữ liệu dạng văn bản phẳng
        displayName = displayName.trim();
        email = email.trim();
        phone = phone.trim();
        if (address != null) address = address.trim();

        // 2. Kiểm tra giới hạn độ dài tối đa (Max Length Validation) để khớp với DB và SRS
        if (displayName.length() > 100) {
            request.setAttribute("error", "Họ và tên không được vượt quá 100 ký tự!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (email.length() > 100) {
            request.setAttribute("error", "Địa chỉ Email không được vượt quá 100 ký tự!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (address != null && address.length() > 255) {
            request.setAttribute("error", "Địa chỉ không được vượt quá 255 ký tự!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 3. Kiểm tra định dạng Họ và Tên (Alphabetic characters and spaces only - SRS Page 43)
        // Sử dụng Regex hỗ trợ Unicode tự động kiểm duyệt chính xác toàn bộ bảng chữ cái tiếng Việt có dấu và dấu cách
        if (!displayName.matches("^[\\p{L} ]+$")) {
            request.setAttribute("error", "Họ và tên không hợp lệ! Vui lòng chỉ nhập các ký tự chữ cái và khoảng trắng.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 4. Kiểm tra định dạng Email chuẩn quốc tế
        if (!email.matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$")) {
            request.setAttribute("error", "Định dạng địa chỉ Email không hợp lệ! (Ví dụ chuẩn: vidu@example.com).");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 5. Giải quyết bài toán của bạn: Kiểm tra định dạng số và giới hạn từ 10 đến 15 chữ số của SĐT (SRS Page 43)
        if (!phone.matches("^0[0-9]{9}$")) {
            request.setAttribute("error", "Số điện thoại không hợp lệ! Số điện thoại bắt buộc phải có đúng 10 chữ số và bắt đầu bằng số 0.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        // Luồng ngoại lệ E2: Mật khẩu nhập lại không khớp nhau
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu và xác nhận mật khẩu không trùng khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Ràng buộc nghiệp vụ BR-01: Độ dài mật khẩu tối thiểu 8 ký tự, bắt buộc chứa cả chữ cái và chữ số
        if (password.length() < 8 || !password.matches(".*[A-Za-z].*") || !password.matches(".*\\d.*")) {
            request.setAttribute("error", "Mật khẩu không đạt yêu cầu bảo mật! Độ dài tối thiểu phải từ 8 ký tự trở lên, bao gồm cả chữ cái và chữ số.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 6. Kiểm tra tính hợp lệ của Ngày Sinh (Phải là một ngày trong quá khứ - SRS Page 43)
        Date dateOfBirth = null;
        if (dobStr != null && !dobStr.trim().isEmpty()) {
            try {
                dateOfBirth = Date.valueOf(dobStr); // Ép kiểu định dạng chuẩn Ngày HTML: yyyy-MM-dd
                
                // Lấy mốc thời gian ngày hiện tại xóa bỏ phần giờ phút giây để so sánh chính xác ngày
                Date today = new Date(System.currentTimeMillis());
                
                if (!dateOfBirth.before(today)) {
                    request.setAttribute("error", "Ngày sinh không hợp lệ! Ngày sinh của bạn bắt buộc phải là một ngày nằm trong quá khứ.");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                }
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Định dạng ngày sinh nhập vào không hợp lệ!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
        }

        // Luồng ngoại lệ E1: Kiểm tra trùng lặp tài khoản email trên hệ thống (Truy vấn DB)
        if (registerDAO.checkEmailExists(email)) {
            request.setAttribute("error", "Địa chỉ email này đã được sử dụng trên hệ thống phòng tập!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // --- ĐÓNG GÓI DỮ LIỆU ĐỂ LƯU VÀO CƠ SỞ DỮ LIỆU (Bước 5, 6 & 7) ---

        // Tạo thực thể đối tượng User
        User user = new User();
        user.setEmail(email);
        user.setPasswordHash(PasswordUtil.hashPassword(password)); // Băm mã mật khẩu SHA-256
        user.setDisplayName(displayName);
        user.setPhone(phone);
        user.setStatus("Inactive"); // Gán trạng thái 'Inactive' theo thiết kế cốt lõi
        user.setMustChangePassword(false);

        // Tạo thực thể đối tượng Member
        Member member = new Member();
        member.setGender(gender);
        member.setDateOfBirth(dateOfBirth); // Nạp đối tượng Date đã được validate sạch sẽ phía trên vào mô hình
        member.setAddress(address);
        member.setMembershipStatus("Pending"); // Gán trạng thái ban đầu của hội viên là Chờ kích hoạt email

        // Sinh mã Token xác thực bảo mật ngẫu nhiên (UUID Cryptographic Hash)
        String tokenValue = UUID.randomUUID().toString();
        // Cấu hình vòng đời tồn tại chính xác của mã là 24 giờ kể từ thời điểm tạo (BR-03)
        Timestamp expiresAt = new Timestamp(System.currentTimeMillis() + (24L * 60 * 60 * 1000));
        UserToken token = new UserToken(0, tokenValue, "VERIFICATION", expiresAt);

        // Thực thi gọi hàm lưu CSDL lồng trong Transaction
        boolean isRegistered = registerDAO.registerMember(user, member, token);

        if (isRegistered) {
            // Gửi email kích hoạt tài khoản thông qua SMTP Server giả lập Mailtrap
            boolean isEmailSent = EmailUtil.sendVerificationEmail(email, tokenValue);
            
            if (isEmailSent) {
                request.setAttribute("message", "Đăng ký thành công! Hệ thống đã gửi một liên kết xác minh. Vui lòng kiểm tra hộp thư đến để kích hoạt tài khoản của bạn.");
            } else {
                request.setAttribute("message", "Tài khoản được ghi nhận trên hệ thống, nhưng máy chủ gửi mail kích hoạt đang bận. Vui lòng liên hệ bộ phận hỗ trợ.");
            }
            // Chuyển tiếp giao diện và in thông tin hướng dẫn kiểm tra email lên màn hình (Bước 8)
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            // Nếu chạy vào đây tức là lỗi kết nối hệ thống vật lý (mất mạng, sập nguồn DB Server) thực tế chứ không phải do lỗi nhập liệu của người dùng nữa
            request.setAttribute("error", "Đăng ký không thành công do hệ thống máy chủ CSDL bận. Vui lòng thử lại sau!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
