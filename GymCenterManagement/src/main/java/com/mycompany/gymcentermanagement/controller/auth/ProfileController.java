/**
 * =========================================================================
 * @file          : ProfileController.java
 * @description   : Controller xử lý xem và cập nhật hồ sơ cá nhân theo từng vai trò (UC-03).
 *                  Áp dụng mô hình PRG (Post-Redirect-Get), phòng thủ lỗi Ngày sinh trong tương lai,
 *                  chặn sửa đổi các trường Read-only (Email, Status, Role) tại tầng Backend.
 * @author        : Nguyễn Đại Dương
 * @created       : 2026-06-05
 * @last_modified : 2026-06-11 bởi Antigravity
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.auth;

import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import com.mycompany.gymcentermanagement.dto.*;
import com.mycompany.gymcentermanagement.model.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 5,       // Khóa cứng tối đa 5MB theo ngoại lệ nghiệp vụ E2
    maxRequestSize = 1024 * 1024 * 10    // 10MB tổng dung lượng request cho phép
)
@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
public class ProfileController extends HttpServlet {
    
    private final UserDAO userDAO = new UserDAOImpl();
    private static final String UPLOAD_DIR = "uploads";

    /**
     * LUỒNG SỰ KIỆN CHÍNH: Đọc và hiển thị hồ sơ cá nhân của người dùng (Phương thức GET)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User loggedInUser = (User) session.getAttribute("currentUser");
        int userId = loggedInUser.getUserId();

        // Đọc thông báo Flash từ Session tạm thời nếu có và giải phóng ngay lập tức để phục vụ tính năng F5
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }
        
        String errorMessage = (String) session.getAttribute("errorMessage");
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            session.removeAttribute("errorMessage");
        }

        try {
            UserProfileBaseDTO profile = userDAO.getUserProfileById(userId);

            if (profile == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy dữ liệu hồ sơ cá nhân.");
                return;
            }

            request.setAttribute("profile", profile);
            request.getRequestDispatcher("/WEB-INF/views/auth/profile.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi truy cập cơ sở dữ liệu.");
        }
    }

    /**
     * LUỒNG SỰ KIỆN CHÍNH: Đón nhận yêu cầu cập nhật thông tin hồ sơ (Phương thức POST)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User loggedInUser = (User) session.getAttribute("currentUser");
        int userId = loggedInUser.getUserId();
        
        try {
            String roleName = userDAO.getHighestPriorityRole(userId);
            UserProfileBaseDTO currentProfile = userDAO.getUserProfileById(userId);

            if (currentProfile == null) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể đọc thông tin gốc để tiến hành cập nhật.");
                return;
            }

            // [LUỒNG NGOẠI LỆ E3]: Chặn hành vi hack sửa Email thông qua sửa đổi thuộc tính HTML công cụ F12
            String submittedEmail = request.getParameter("email");
            if (submittedEmail != null && !submittedEmail.trim().isEmpty() 
                    && !submittedEmail.trim().equalsIgnoreCase(currentProfile.getEmail())) {
                
                session.setAttribute("errorMessage", "Cảnh báo an ninh: Phát hiện hành vi can thiệp chỉnh sửa dữ liệu cố định (Email)! Thao tác bị từ chối.");
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }

            // Tiếp nhận các trường dữ liệu chung gửi lên từ Form giao diện
            String displayName = request.getParameter("displayName");
            String phone = request.getParameter("phone");

            if (displayName != null) displayName = displayName.trim();
            if (phone != null) phone = phone.trim();

            // [Luồng ngoại lệ E1 - Validate trống]: Kiểm tra bỏ trống các trường bắt buộc
            if (displayName == null || displayName.isEmpty() || phone == null || phone.isEmpty()) {
                request.setAttribute("errorMessage", "Họ tên / Tên hiển thị và Số điện thoại không được phép để trống!");
                request.setAttribute("profile", currentProfile);
                request.getRequestDispatcher("/WEB-INF/views/auth/profile.jsp").forward(request, response);
                return;
            }

            // [Luồng ngoại lệ E1 - Validate định dạng số]: Số điện thoại phải là ký tự số thuần túy
            if (!phone.matches("[0-9]+")) {
                request.setAttribute("errorMessage", "Số điện thoại không hợp lệ! Vui lòng chỉ nhập các ký tự số liên mạch.");
                request.setAttribute("profile", currentProfile);
                request.getRequestDispatcher("/WEB-INF/views/auth/profile.jsp").forward(request, response);
                return;
            }

            // Kiểm tra trùng lặp số điện thoại nếu thay đổi số mới
            if (phone != null && !phone.equals(currentProfile.getPhone())) {
                if (userDAO.checkPhoneExists(phone)) {
                    request.setAttribute("errorMessage", "Cập nhật thất bại: Số điện thoại này đã được sử dụng bởi một tài khoản khác.");
                    request.setAttribute("profile", currentProfile);
                    request.getRequestDispatcher("/WEB-INF/views/auth/profile.jsp").forward(request, response);
                    return;
                }
            }

            // 🌟 LẬP TRÌNH PHÒNG THỦ: CHỦ ĐỘNG KIỂM TRA ĐỘ DÀI GIỚI HẠN DỮ LIỆU CHUNG
            if (phone.length() > 10) {
                request.setAttribute("errorMessage", "Cập nhật thất bại: Số điện thoại không được nhập quá 10 chữ số!");
                request.setAttribute("profile", currentProfile);
                request.getRequestDispatcher("/WEB-INF/views/auth/profile.jsp").forward(request, response);
                return;
            }

            if (displayName.length() > 100) {
                request.setAttribute("errorMessage", "Cập nhật thất bại: Họ tên / Tên hiển thị không được vượt quá 100 ký tự.");
                request.setAttribute("profile", currentProfile);
                request.getRequestDispatcher("/WEB-INF/views/auth/profile.jsp").forward(request, response);
                return;
            }

            // Tiến hành đột biến đồng bộ dữ liệu tạm thời lên đối tượng profile hiện hành
            currentProfile.setDisplayName(displayName);
            currentProfile.setPhone(phone);

            // XỬ LÝ RIÊNG BIỆT THEO PHÂN HỆ QUYỀN HẠN
            if ("Member".equalsIgnoreCase(roleName) && currentProfile instanceof MemberProfileDTO) {
                MemberProfileDTO memberDto = (MemberProfileDTO) currentProfile;
                memberDto.setGender(request.getParameter("gender"));
                
                String address = request.getParameter("address");
                if (address != null) address = address.trim();
                
                if (address != null && address.length() > 255) {
                    request.setAttribute("errorMessage", "Cập nhật thất bại: Địa chỉ cư trú không được vượt quá 255 ký tự.");
                    request.setAttribute("profile", currentProfile);
                    request.getRequestDispatcher("/WEB-INF/views/auth/profile.jsp").forward(request, response);
                    return;
                }
                memberDto.setAddress(address);
                
                // =========================================================================
                // 🌟 KIỂM TRA NGÀY SINH CỦA MEMBER: CHẶN ĐỨNG THỜI GIAN TƯƠNG LAI
                // =========================================================================
                String dobStr = request.getParameter("dateOfBirth");
                if (dobStr != null && !dobStr.isEmpty()) {
                    try {
                        Date selectedDob = Date.valueOf(dobStr); // Ép kiểu chuỗi lịch sang java.sql.Date
                        Date today = new Date(System.currentTimeMillis()); // Lấy ngày hiện tại chính xác của hệ thống
                        
                        // Ngày sinh không được ở tương lai.
                        if (selectedDob.after(today)) {
                            request.setAttribute("errorMessage", "Cập nhật thất bại: Ngày tháng năm sinh không thể vượt quá ngày hiện tại!");
                            request.setAttribute("profile", currentProfile);
                            request.getRequestDispatcher("/WEB-INF/views/auth/profile.jsp").forward(request, response);
                            return;
                        }

                        // Đồng nhất với luồng đăng ký: hội viên phải đủ 14 tuổi tại ngày cập nhật.
                        if (selectedDob.toLocalDate().plusYears(14).isAfter(LocalDate.now())) {
                            request.setAttribute("errorMessage", "Bạn chưa đủ tuổi để đăng kí tập gym.");
                            request.setAttribute("profile", currentProfile);
                            request.getRequestDispatcher("/WEB-INF/views/auth/profile.jsp").forward(request, response);
                            return;
                        }
                        memberDto.setDateOfBirth(selectedDob); // Thỏa mãn điều kiện an toàn, tiến hành nạp vào DTO
                    } catch (IllegalArgumentException e) {
                        request.setAttribute("errorMessage", "Định dạng cấu trúc ngày sinh không hợp lệ! Vui lòng kiểm tra lại dữ liệu nhập lịch.");
                        request.setAttribute("profile", currentProfile);
                        request.getRequestDispatcher("/WEB-INF/views/auth/profile.jsp").forward(request, response);
                        return;
                    }
                }
                // =========================================================================
            } 
            else if ("PT".equalsIgnoreCase(roleName) && currentProfile instanceof PTProfileDTO) {
                PTProfileDTO ptDto = (PTProfileDTO) currentProfile;
                
                String description = request.getParameter("description");
                if (description != null && countWords(description) > 500) {
                    request.setAttribute("errorMessage", "Tiểu sử (Bio) không được vượt quá 500 từ!");
                    request.setAttribute("profile", currentProfile);
                    request.getRequestDispatcher("/WEB-INF/views/auth/profile.jsp").forward(request, response);
                    return;
                }
                
                // Áp dụng quy tắc BR-03: Họ tên trang trọng của PT
                ptDto.setFullName(displayName); 
                ptDto.setDescription(description);

                String applicationPath = request.getServletContext().getRealPath("");
                String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
                File uploadFolder = new File(uploadFilePath);
                if (!uploadFolder.exists()) {
                    uploadFolder.mkdirs(); 
                }

                Part avatarPart = request.getPart("avatarFile");
                if (avatarPart != null && avatarPart.getSize() > 0) {
                    String error = validateFile(avatarPart, "image");
                    if (error != null) {
                        request.setAttribute("errorMessage", error);
                        request.setAttribute("profile", currentProfile);
                        request.getRequestDispatcher("/WEB-INF/views/auth/profile.jsp").forward(request, response);
                        return;
                    }
                    String fileName = "avatar_" + userId + "_" + System.currentTimeMillis() + "_" + getFileName(avatarPart);
                    avatarPart.write(uploadFilePath + File.separator + fileName);
                    ptDto.setAvatarPath(UPLOAD_DIR + "/" + fileName);
                }

                Part certPart = request.getPart("certificateFile");
                if (certPart != null && certPart.getSize() > 0) {
                    String error = validateFile(certPart, "document");
                    if (error != null) {
                        request.setAttribute("errorMessage", error);
                        request.setAttribute("profile", currentProfile);
                        request.getRequestDispatcher("/WEB-INF/views/auth/profile.jsp").forward(request, response);
                        return;
                    }
                    String originName = getFileName(certPart);
                    String savedName = "cert_" + userId + "_" + System.currentTimeMillis() + "_" + originName;
                    certPart.write(uploadFilePath + File.separator + savedName);
                    ptDto.setCertificateFileName(originName);
                    ptDto.setCertificateFilePath(UPLOAD_DIR + "/" + savedName);
                }
            }

            // 4. Thực thi lưu trữ dữ liệu bền vững xuống Database thông qua tầng DAO
            boolean isSuccess = userDAO.updateUserProfile(currentProfile, roleName);

            if (isSuccess) {
                // Điều hướng PRG làm sạch Form Payload và giữ chữ xanh lịch sự khi lưu thành công
                session.setAttribute("successMessage", "Thông tin hồ sơ tài khoản cá nhân của bạn đã được cập nhật thành công.");
                response.sendRedirect(request.getContextPath() + "/profile");
            } else {
                request.setAttribute("errorMessage", "Cập nhật thất bại: Bản ghi dữ liệu không có sự thay đổi hoặc đã bị khóa.");
                request.setAttribute("profile", currentProfile);
                request.getRequestDispatcher("/WEB-INF/views/auth/profile.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            // Ghi nhận log lỗi hệ thống chi tiết ra console Server phục vụ lập trình viên điều tra nội bộ
            e.printStackTrace(); 
            
            // Mặt nạ che chắn bảo mật tuyệt đối chuỗi SQL thô, đẩy câu thông báo lịch sự về UI
            request.setAttribute("errorMessage", "Cập nhật hồ sơ thất bại. Đã có lỗi xảy ra trong hệ thống lưu trữ dữ liệu, vui lòng thử lại sau.");
            try {
                UserProfileBaseDTO fallbackProfile = userDAO.getUserProfileById(userId);
                request.setAttribute("profile", fallbackProfile);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            request.getRequestDispatcher("/WEB-INF/views/auth/profile.jsp").forward(request, response);
        }
    }

    /**
     * [Luồng ngoại lệ E2]: Kiểm soát định dạng và kích thước ràng buộc của tệp tin upload
     */
    private String validateFile(Part part, String type) {
        if (part.getSize() > 1024 * 1024 * 5) {
            return "Tệp tin tải lên thất bại do vượt quá dung lượng tối đa cho phép (Tối đa 5MB).";
        }
        
        String contentType = part.getContentType();
        if (contentType == null) return "Định dạng tệp tin không hợp lệ.";

        if ("image".equals(type)) {
            if (!contentType.equals("image/jpeg") && !contentType.equals("image/jpg") && !contentType.equals("image/png")) {
                return "Ảnh đại diện không đúng định dạng! Hệ thống chỉ chấp nhận tệp tin mở rộng dạng .jpg hoặc .png.";
            }
        } else if ("document".equals(type)) {
            if (!contentType.equals("application/pdf") && !contentType.equals("image/jpeg") && !contentType.equals("image/png")) {
                return "Tệp chứng chỉ không đúng định dạng! Hệ thống chỉ chấp nhận định dạng .pdf, .jpg hoặc .png.";
            }
        }
        return null;
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                String name = token.substring(token.indexOf("=") + 2, token.length() - 1);
                return name.substring(name.lastIndexOf(File.separator) + 1).replace("\"", "");
            }
        }
        return "unknown_file";
    }

    private int countWords(String text) {
        if (text == null || text.trim().isEmpty()) {
            return 0;
        }
        return text.trim().split("\\s+").length;
    }
}

