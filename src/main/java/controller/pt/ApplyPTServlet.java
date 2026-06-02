/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.pt;

import dao.PTApplicationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.UUID;
import model.PTApplication;
import utils.ApplicationCodeGenerator;
import utils.ValidationUtils;

/**
 *
 * @author phuga
 */
@WebServlet(name = "ApplyPTServlet", urlPatterns = {"/apply-pt"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class ApplyPTServlet extends HttpServlet {

    private final PTApplicationDAO applicationDAO = new PTApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/pt/apply-pt.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String specialization = request.getParameter("specialization");
        String experienceYearsRaw = request.getParameter("experienceYears");
        String experienceDescription = request.getParameter("experienceDescription");
        String description = request.getParameter("description");
        String introduction = request.getParameter("introduction");

        String error = validateForm(fullName, email, phone, specialization, experienceYearsRaw);

        if (error != null) {
            request.setAttribute("error", error);
            keepFormData(request, fullName, email, phone, gender, dateOfBirth,
                    specialization, experienceYearsRaw, experienceDescription, description, introduction);
            request.getRequestDispatcher("/views/pt/apply-pt.jsp").forward(request, response);
            return;
        }

        if (applicationDAO.existsPendingApplication(email.trim(), phone.trim())) {
            request.setAttribute("error", "Bạn đã có đơn ứng tuyển PT đang chờ xét duyệt.");
            keepFormData(request, fullName, email, phone, gender, dateOfBirth,
                    specialization, experienceYearsRaw, experienceDescription, description, introduction);
            request.getRequestDispatcher("/views/pt/apply-pt.jsp").forward(request, response);
            return;
        }
        
        PTApplication application = new PTApplication();
        application.setApplicationCode(ApplicationCodeGenerator.generatePTApplicationCode());
        application.setFullName(fullName.trim());
        application.setEmail(email.trim());
        application.setPhone(phone.trim());
        application.setGender(gender);
        application.setDateOfBirth(dateOfBirth);
        application.setSpecialization(specialization.trim());
        application.setExperienceYears(ValidationUtils.parseIntegerOrNull(experienceYearsRaw));
        application.setExperienceDescription(experienceDescription);
        application.setDescription(description);
        application.setIntroduction(introduction);

        Part certificatePart = request.getPart("certificate");

        if (certificatePart != null && certificatePart.getSize() > 0) {
            String originalFileName = getSubmittedFileName(certificatePart);
            String extension = getFileExtension(originalFileName);

            if (!ValidationUtils.isValidOptionalCertificateType(extension)) {
                request.setAttribute("error", "File chứng chỉ phải có định dạng PDF, JPG, JPEG hoặc PNG.");
                keepFormData(request, fullName, email, phone, gender, dateOfBirth,
                        specialization, experienceYearsRaw, experienceDescription, description, introduction);
                request.getRequestDispatcher("/views/pt/apply-pt.jsp").forward(request, response);
                return;
            }

            String uploadFolder = getServletContext().getRealPath("/uploads/pt-certificates");
            File folder = new File(uploadFolder);

            if (!folder.exists()) {
                folder.mkdirs();
            }

            String storedFileName = UUID.randomUUID() + "_" + originalFileName;
            String storedFilePath = uploadFolder + File.separator + storedFileName;

            certificatePart.write(storedFilePath);

            application.setCertificateFileName(originalFileName);
            application.setCertificateFilePath("/uploads/pt-certificates/" + storedFileName);
            application.setCertificateFileType(extension.toUpperCase());
            application.setCertificateFileSize((int) certificatePart.getSize());
        }

        boolean inserted = applicationDAO.insert(application);

        if (!inserted) {
            request.setAttribute("error", "Không thể gửi đơn ứng tuyển. Vui lòng thử lại.");
            keepFormData(request, fullName, email, phone, gender, dateOfBirth,
                    specialization, experienceYearsRaw, experienceDescription, description, introduction);
            request.getRequestDispatcher("/views/pt/apply-pt.jsp").forward(request, response);
            return;
        }

        request.setAttribute("applicationCode", application.getApplicationCode());
        request.setAttribute("phone", application.getPhone());
        request.getRequestDispatcher("/views/pt/submission-result.jsp").forward(request, response);
    }

    private String validateForm(String fullName, String email, String phone,
            String specialization, String experienceYearsRaw) {
        if (ValidationUtils.isBlank(fullName)) {
            return "Vui lòng nhập họ và tên.";
        }

        if (!ValidationUtils.isValidEmail(email)) {
            return "Email không đúng định dạng.";
        }

        if (!ValidationUtils.isValidPhone(phone)) {
            return "Số điện thoại phải gồm 10 chữ số.";
        }

        if (ValidationUtils.isBlank(specialization)) {
            return "Vui lòng nhập chuyên môn.";
        }

        if (ValidationUtils.isBlank(experienceYearsRaw)) {
            return "Vui lòng nhập số năm kinh nghiệm.";
        }

        Integer experienceYears = ValidationUtils.parseIntegerOrNull(experienceYearsRaw);

        if (experienceYears == null) {
            return "Số năm kinh nghiệm phải là số hợp lệ.";
        }

        if (experienceYears < 0) {
            return "Số năm kinh nghiệm không được nhỏ hơn 0.";
        }

        if (experienceYears > 60) {
            return "Số năm kinh nghiệm không hợp lệ.";
        }

        return null;
    }

    private void keepFormData(HttpServletRequest request,
            String fullName,
            String email,
            String phone,
            String gender,
            String dateOfBirth,
            String specialization,
            String experienceYears,
            String experienceDescription,
            String description,
            String introduction) {
        request.setAttribute("fullName", fullName);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("gender", gender);
        request.setAttribute("dateOfBirth", dateOfBirth);
        request.setAttribute("specialization", specialization);
        request.setAttribute("experienceYears", experienceYears);
        request.setAttribute("experienceDescription", experienceDescription);
        request.setAttribute("description", description);
        request.setAttribute("introduction", introduction);
    }

    private String getSubmittedFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");

        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 1)
                        .trim()
                        .replace("\"", "");
            }
        }

        return null;
    }

    private String getFileExtension(String fileName) {
        if (fileName == null || !fileName.contains(".")) {
            return "";
        }

        return fileName.substring(fileName.lastIndexOf(".") + 1);
    }
}
