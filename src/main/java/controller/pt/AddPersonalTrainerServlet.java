/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.pt;

import dao.PersonalTrainerDAO;
import dao.RoleDAO;
import dao.UserDAO;
import dao.UserRoleDAO;
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
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import model.PersonalTrainer;
import model.User;
import utils.PasswordUtil;

/**
 *
 * @author phuga
 */
/*
* Các hàm trong class này:
     *
     * - doGet(): mở trang form thêm Personal Trainer và tạo tài khoản PT.
     * - doPost(): xử lý dữ liệu khi Staff/Admin bấm nút tạo tài khoản PT.
     *
     * Trong doPost():
     * - kiểm tra dữ liệu nhập vào form.
     * - tạo mật khẩu tạm thời cho PT.
     * - hash mật khẩu trước khi lưu vào database.
     * - thêm dữ liệu vào bảng Users.
     * - gán role PT vào bảng UserRoles.
     * - thêm hồ sơ PT vào bảng PersonalTrainers.
     * - chuyển sang trang kết quả sau khi tạo thành công.
     *
     * Các hàm hỗ trợ:
     * - forwardBackWithError(): quay lại form và hiển thị lỗi.
     * - trimToNull(): xóa khoảng trắng thừa, nếu chuỗi rỗng thì cho thành null.
     * - isValidEmail(): kiểm tra email có đúng định dạng cơ bản không.
     * - saveUploadedFile(): lưu file chứng chỉ hoặc avatar được upload.
     * - getFileExtension(): lấy đuôi file.
     * - isAllowedExtension(): kiểm tra đuôi file có được phép upload không.
     *
     * Ghi chú:
     * - Staff/Admin tạo tài khoản PT sau khi PT đã được tuyển dụng offline.
     * - PT sẽ dùng email và mật khẩu tạm thời để đăng nhập lần đầu.
     * - MustChangePassword = true để bắt PT đổi mật khẩu khi đăng nhập lần đầu.
 */
@WebServlet(name = "AddPersonalTrainerServlet", urlPatterns = {"/staff/pt/add"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 20 * 1024 * 1024
)
public class AddPersonalTrainerServlet extends HttpServlet {

    private static final String ADD_PT_VIEW = "/views/pt/add-personal-trainer.jsp";
    private static final String RESULT_VIEW = "/views/pt/pt-account-creation-result.jsp";

    private static final String PT_ROLE_NAME = "PT";
    private static final String DEFAULT_ACCOUNT_STATUS = "Active";
    private static final String DEFAULT_TRAINER_STATUS = "Active";

    private static final String CERTIFICATE_UPLOAD_DIR = "uploads/pt-certificate";
    private static final String AVATAR_UPLOAD_DIR = "uploads/pt-avatar";

    private final UserDAO userDAO = new UserDAO();
    private final RoleDAO roleDAO = new RoleDAO();
    private final UserRoleDAO userRoleDAO = new UserRoleDAO();
    private final PersonalTrainerDAO personalTrainerDAO = new PersonalTrainerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
        String specialization = trimToNull(request.getParameter("specialization"));
        String careerStartDateRaw = trimToNull(request.getParameter("careerStartDate"));
        String description = trimToNull(request.getParameter("description"));

        if (fullName == null) {
            forwardBackWithError(request, response, "Vui lòng nhập họ tên đầy đủ của PT.");
            return;
        }

        if (email == null || !isValidEmail(email)) {
            forwardBackWithError(request, response, "Email không hợp lệ.");
            return;
        }

        if (phone == null || !phone.matches("\\d{10}")) {
            forwardBackWithError(request, response, "Số điện thoại phải có đúng 10 chữ số.");
            return;
        }

        if (specialization == null) {
            forwardBackWithError(request, response, "Vui lòng chọn hoặc nhập chuyên môn của PT.");
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

        if (userDAO.isEmailExists(email)) {
            forwardBackWithError(request, response, "Email này đã được sử dụng bởi tài khoản khác.");
            return;
        }

        int ptRoleId = roleDAO.findRoleIdByName(PT_ROLE_NAME);

        if (ptRoleId == -1) {
            forwardBackWithError(request, response, "Không tìm thấy role PT trong hệ thống.");
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

        String temporaryPassword = PasswordUtil.generateTemporaryPassword(10);
        String passwordHash = PasswordUtil.hashPassword(temporaryPassword);

        String publicDisplayName = displayName != null ? displayName : fullName;

        // Tạm thời dùng "Staff" vì phần session Staff/Admin có thể chưa tích hợp.
        // Sau này thay bằng username/displayName của Staff/Admin đang đăng nhập.
        String createdBy = "Staff";

        User user = new User(
                email,
                passwordHash,
                publicDisplayName,
                phone,
                DEFAULT_ACCOUNT_STATUS,
                true,
                createdBy
        );

        int generatedUserId = userDAO.insertUser(user);

        if (generatedUserId == -1) {
            forwardBackWithError(request, response, "Không thể tạo tài khoản PT. Vui lòng thử lại.");
            return;
        }

        boolean roleAssigned = userRoleDAO.assignRoleToUser(generatedUserId, ptRoleId);

        if (!roleAssigned) {
            forwardBackWithError(request, response, "Tạo tài khoản thành công nhưng gán role PT thất bại.");
            return;
        }

        PersonalTrainer trainer = new PersonalTrainer();
        trainer.setUserId(generatedUserId);
        trainer.setFullName(fullName);
        trainer.setDisplayName(displayName);
        trainer.setSpecialization(specialization);
        trainer.setCareerStartDate(careerStartDate);
        trainer.setCertificateFileName(certificateFileName);
        trainer.setCertificateFilePath(certificateFilePath);
        trainer.setAvatarPath(avatarPath);
        trainer.setDescription(description);
        trainer.setStatus(DEFAULT_TRAINER_STATUS);
        trainer.setCreatedBy(createdBy);

        boolean trainerInserted = personalTrainerDAO.insertPersonalTrainer(trainer);

        if (!trainerInserted) {
            forwardBackWithError(request, response, "Tạo tài khoản thành công nhưng tạo hồ sơ PT thất bại.");
            return;
        }

        request.setAttribute("fullName", fullName);
        request.setAttribute("displayName", displayName);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("temporaryPassword", temporaryPassword);
        request.setAttribute("mustChangePassword", true);

        request.getRequestDispatcher(RESULT_VIEW).forward(request, response);
    }

    /**
     * Forwards back to the Add PT form with an error message.
     *
     * @param request HTTP request
     * @param response HTTP response
     * @param errorMessage error message
     * @throws ServletException if forwarding fails
     * @throws IOException if forwarding fails
     */
    private void forwardBackWithError(HttpServletRequest request, HttpServletResponse response,
            String errorMessage)
            throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher(ADD_PT_VIEW).forward(request, response);
    }

    /**
     * Trims a string and converts empty string to null.
     *
     * @param value input value
     * @return trimmed value or null
     */
    private String trimToNull(String value) {
        if (value == null) {
            return null;
        }

        String trimmedValue = value.trim();

        return trimmedValue.isEmpty() ? null : trimmedValue;
    }

    /**
     * Validates a basic email format.
     *
     * @param email email value
     * @return true if valid, otherwise false
     */
    private boolean isValidEmail(String email) {
        return email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    }

    /**
     * Saves an uploaded file and returns its relative file path. If no file is
     * uploaded, the method returns an empty UploadedFile object.
     *
     * @param request HTTP request
     * @param partName file input name
     * @param uploadDirectory relative upload directory
     * @param allowedExtensions allowed file extensions
     * @return uploaded file information
     * @throws IOException if file saving fails
     * @throws ServletException if reading part fails
     */
    private UploadedFile saveUploadedFile(HttpServletRequest request, String partName,
            String uploadDirectory, String[] allowedExtensions)
            throws IOException, ServletException {
        Part part = request.getPart(partName);

        if (part == null || part.getSize() == 0) {
            return new UploadedFile(null, null);
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

    /**
     * Gets file extension from a file name.
     *
     * @param fileName file name
     * @return file extension without dot
     */
    private String getFileExtension(String fileName) {
        int lastDotIndex = fileName.lastIndexOf('.');

        if (lastDotIndex == -1 || lastDotIndex == fileName.length() - 1) {
            return "";
        }

        return fileName.substring(lastDotIndex + 1).toLowerCase();
    }

    /**
     * Checks whether file extension is allowed.
     *
     * @param extension file extension
     * @param allowedExtensions allowed extensions
     * @return true if allowed, otherwise false
     */
    private boolean isAllowedExtension(String extension, String[] allowedExtensions) {
        for (String allowedExtension : allowedExtensions) {
            if (allowedExtension.equalsIgnoreCase(extension)) {
                return true;
            }
        }

        return false;
    }

    /**
     * Simple DTO for uploaded file information.
     */
    private static class UploadedFile {

        private final String originalFileName;
        private final String filePath;

        private UploadedFile(String originalFileName, String filePath) {
            this.originalFileName = originalFileName;
            this.filePath = filePath;
        }
    }
}
