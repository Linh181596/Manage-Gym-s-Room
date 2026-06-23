/**
 * =========================================================================
 * @file          : AddPersonalTrainerController.java
 * @description   : Controller xử lý thêm mới hồ sơ và tài khoản của HLV cá nhân.
 * @author        : Nguyễn Đình Phú (phund)
 * @created       : 2026-06-04
 * @last_modified : 2026-06-04 bởi Nguyễn Đình Phú
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.staff;

import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PersonalTrainerService;
import com.mycompany.gymcentermanagement.service.UserService;
import com.mycompany.gymcentermanagement.service.impl.PersonalTrainerServiceImpl;
import com.mycompany.gymcentermanagement.service.impl.UserServiceImpl;
import com.mycompany.gymcentermanagement.utils.PasswordUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.time.format.DateTimeParseException;

/**
 * Controller for creating a Personal Trainer account and profile by Staff/Admin.
 */
@WebServlet(name = "AddPersonalTrainerController", urlPatterns = {"/staff/pt/add"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class AddPersonalTrainerController extends HttpServlet {

    private static final String ADD_PT_VIEW = "/WEB-INF/views/pt/add-personal-trainer.jsp";
    private static final String RESULT_VIEW = "/WEB-INF/views/pt/pt-account-creation-result.jsp";

    private static final String CERTIFICATE_UPLOAD_DIR = "assets/uploads/pt-certificate";
    private static final String AVATAR_UPLOAD_DIR = "assets/uploads/pt-avatar";

    private final UserService userService = new UserServiceImpl();
    private final PersonalTrainerService personalTrainerService = new PersonalTrainerServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<String> specOptions = List.of(
                "Quản lý cân nặng",
                "Tăng cơ",
                "Cardio",
                "Yoga",
                "Boxing",
                "Dinh dưỡng",
                "Phục hồi thể lực"
        );
        request.setAttribute("specOptions", specOptions);
        request.getRequestDispatcher(ADD_PT_VIEW).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String fullName = trimToNull(request.getParameter("fullName"));
        String displayName = trimToNull(request.getParameter("displayName"));
        String email = trimToNull(request.getParameter("email"));
        String phone = trimToNull(request.getParameter("phone"));
        
        String[] specializations = request.getParameterValues("specializations");
        String specialization = null;
        if (specializations != null && specializations.length > 0) {
            specialization = String.join(", ", specializations);
            request.setAttribute("selectedSpecs", List.of(specializations));
        } else {
            request.setAttribute("selectedSpecs", List.of());
            forwardBackWithError(request, response, "Vui lòng chọn ít nhất một chuyên môn của PT.");
            return;
        }

        String careerStartDateRaw = trimToNull(request.getParameter("careerStartDate"));
        String description = trimToNull(request.getParameter("description"));

        if (description != null && countWords(description) > 500) {
            forwardBackWithError(request, response, "Mô tả giới thiệu bản thân không được vượt quá 500 từ.");
            return;
        }

        if (fullName == null) {
            forwardBackWithError(request, response, "Vui lòng nhập họ tên đầy đủ của PT.");
            return;
        }

        if (email == null || !isValidEmail(email)) {
            forwardBackWithError(request, response, "Email không hợp lệ.");
            return;
        }

        if (phone == null || !phone.matches("^0\\d{9}$")) {
            forwardBackWithError(request, response, "Số điện thoại phải bắt đầu bằng 0 và có đúng 10 chữ số.");
            return;
        }

        if (careerStartDateRaw == null) {
            forwardBackWithError(request, response, "Vui lòng nhập ngày bắt đầu sự nghiệp của PT.");
            return;
        }

        LocalDate careerStartDate;
        try {
            careerStartDate = LocalDate.parse(careerStartDateRaw);
        } catch (DateTimeParseException e) {
            forwardBackWithError(request, response, "Ngày bắt đầu sự nghiệp không hợp lệ.");
            return;
        }

        if (careerStartDate.isAfter(LocalDate.now())) {
            forwardBackWithError(request, response, "Ngày bắt đầu sự nghiệp không được lớn hơn ngày hiện tại.");
            return;
        }

        try {
            if (userService.getUserByEmail(email) != null) {
                forwardBackWithError(request, response, "Email này đã được sử dụng bởi tài khoản khác.");
                return;
            }
            
            if (userService.checkPhoneExists(phone)) {
                forwardBackWithError(request, response, "Số điện thoại này đã tồn tại trong hệ thống. Vui lòng điền số khác!");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            forwardBackWithError(request, response, "Lỗi hệ thống khi kiểm tra dữ liệu: " + e.getMessage());
            return;
        }

        String certificateFilePath;
        String certificateFileName;
        String avatarPath;

        try {
            UploadedFile certificateFile = saveUploadedFile(
                    request,
                    "certificateFile",
                    CERTIFICATE_UPLOAD_DIR,
                    new String[]{"pdf", "jpg", "jpeg", "png"}
            );

            certificateFilePath = certificateFile.filePath;
            certificateFileName = certificateFile.originalFileName;

            UploadedFile avatarFile = saveUploadedFile(
                    request,
                    "avatarFile",
                    AVATAR_UPLOAD_DIR,
                    new String[]{"jpg", "jpeg", "png"}
            );

            avatarPath = avatarFile.filePath;

        } catch (IllegalArgumentException e) {
            forwardBackWithError(request, response, e.getMessage());
            return;
        }

        String temporaryPassword = PasswordUtils.generateTemporaryPassword(10);
        String passwordHash = PasswordUtils.hashPassword(temporaryPassword);

        String publicDisplayName = displayName != null ? displayName : fullName;

        // Get logged-in user from session for audit trails
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        String createdBy = (currentUser != null) ? currentUser.getFullName() : "Staff";
        
        User newUser = new User();
        newUser.setEmail(email);
        newUser.setPasswordHash(passwordHash);
        newUser.setFullName(publicDisplayName);
        newUser.setPhoneNumber(phone);
        newUser.setRole(User.Role.PT);
        newUser.setAccountStatus(User.AccountStatus.Active);
        newUser.setMustChangePassword(true);
        newUser.setCreatedBy(createdBy);

        try {
            boolean success = userService.createUser(newUser);
            if (!success || newUser.getUserId() <= 0) {
                forwardBackWithError(request, response, "Không thể tạo tài khoản người dùng PT. Vui lòng thử lại.");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            forwardBackWithError(request, response, "Lỗi cơ sở dữ liệu khi tạo tài khoản: " + e.getMessage());
            return;
        }

        PersonalTrainer trainer = new PersonalTrainer();
        trainer.setUserId(newUser.getUserId());
        trainer.setFullName(fullName);
        trainer.setDisplayName(displayName);
        trainer.setSpecialization(specialization);
        trainer.setCareerStartDate(careerStartDate);
        trainer.setCertificateFileName(certificateFileName);
        trainer.setCertificateFilePath(certificateFilePath);
        trainer.setAvatarPath(avatarPath);
        trainer.setDescription(description);
        trainer.setStatus("Active");
        trainer.setCreatedBy(createdBy);

        boolean trainerInserted = personalTrainerService.createPersonalTrainer(trainer);

        if (!trainerInserted) {
            forwardBackWithError(request, response, "Tạo tài khoản thành công nhưng tạo hồ sơ PT thất bại.");
            return;
        }

        request.setAttribute("fullName", fullName);
        request.setAttribute("displayName", publicDisplayName);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("temporaryPassword", temporaryPassword);
        request.setAttribute("mustChangePassword", true);

        request.getRequestDispatcher(RESULT_VIEW).forward(request, response);
    }

    private void forwardBackWithError(HttpServletRequest request, HttpServletResponse response,
            String errorMessage)
            throws ServletException, IOException {
        List<String> specOptions = List.of(
                "Quản lý cân nặng",
                "Tăng cơ",
                "Cardio",
                "Yoga",
                "Boxing",
                "Dinh dưỡng",
                "Phục hồi thể lực"
        );
        request.setAttribute("specOptions", specOptions);
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher(ADD_PT_VIEW).forward(request, response);
    }

    private String trimToNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmedValue = value.trim();
        return trimmedValue.isEmpty() ? null : trimmedValue;
    }

    private boolean isValidEmail(String email) {
        return email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    }

    private UploadedFile saveUploadedFile(HttpServletRequest request, String partName,
            String uploadDirectory, String[] allowedExtensions)
            throws IOException, ServletException {
        Part part = request.getPart(partName);

        if (part == null || part.getSize() == 0) {
            return new UploadedFile(null, null);
        }

        long maxFileSize = 5 * 1024 * 1024; // 5MB
        if (part.getSize() > maxFileSize) {
            String fieldLabel = "avatarFile".equals(partName) ? "Ảnh đại diện" : "Chứng chỉ";
            throw new IllegalArgumentException(fieldLabel + " vượt quá kích thước giới hạn cho phép (tối đa 5MB).");
        }

        String originalFileName = Paths.get(part.getSubmittedFileName())
                .getFileName()
                .toString();

        if (originalFileName == null || originalFileName.trim().isEmpty()) {
            return new UploadedFile(null, null);
        }

        String extension = getFileExtension(originalFileName);

        if (!isAllowedExtension(extension, allowedExtensions)) {
            throw new IllegalArgumentException("File không hợp lệ. Chỉ hỗ trợ: "
                    + String.join(", ", allowedExtensions).toUpperCase() + ".");
        }

        String uniqueFileName = System.currentTimeMillis() + "_" + originalFileName;
        String realUploadPath = getServletContext().getRealPath("/") + uploadDirectory;

        File uploadFolder = new File(realUploadPath);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }

        String realFilePath = realUploadPath + File.separator + uniqueFileName;
        part.write(realFilePath);

        String relativeFilePath = uploadDirectory + "/" + uniqueFileName;
        return new UploadedFile(originalFileName, relativeFilePath);
    }

    private String getFileExtension(String fileName) {
        int lastDotIndex = fileName.lastIndexOf('.');
        if (lastDotIndex == -1 || lastDotIndex == fileName.length() - 1) {
            return "";
        }
        return fileName.substring(lastDotIndex + 1).toLowerCase();
    }

    private boolean isAllowedExtension(String extension, String[] allowedExtensions) {
        for (String allowedExtension : allowedExtensions) {
            if (allowedExtension.equalsIgnoreCase(extension)) {
                return true;
            }
        }
        return false;
    }

    private int countWords(String text) {
        if (text == null || text.trim().isEmpty()) {
            return 0;
        }
        return text.trim().split("\\s+").length;
    }

    private static class UploadedFile {
        private final String originalFileName;
        private final String filePath;

        private UploadedFile(String originalFileName, String filePath) {
            this.originalFileName = originalFileName;
            this.filePath = filePath;
        }
    }
}
