/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.pt;

import dao.PTApplicationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.PTApplication;
import utils.ValidationUtils;

/**
 *
 * @author phuga
 */
@WebServlet(name = "PTApplicationResultServlet", urlPatterns = {"/pt-application-result"})
public class PTApplicationResultServlet extends HttpServlet {

    private final PTApplicationDAO applicationDAO = new PTApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/pt/application-result-lookup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String applicationCode = request.getParameter("applicationCode");
        String phone = request.getParameter("phone");

        if (ValidationUtils.isBlank(applicationCode)) {
            request.setAttribute("error", "Vui lòng nhập mã đơn ứng tuyển.");
            keepLookupData(request, applicationCode, phone);
            request.getRequestDispatcher("/views/pt/application-result-lookup.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtils.isValidPhone(phone)) {
            request.setAttribute("error", "Số điện thoại phải gồm đúng 10 chữ số.");
            keepLookupData(request, applicationCode, phone);
            request.getRequestDispatcher("/views/pt/application-result-lookup.jsp").forward(request, response);
            return;
        }

        PTApplication application = applicationDAO.findByCodeAndPhone(
                applicationCode.trim(),
                phone.trim()
        );

        if (application == null) {
            request.setAttribute("error", "Không tìm thấy đơn ứng tuyển phù hợp với mã đơn và số điện thoại.");
            keepLookupData(request, applicationCode, phone);
            request.getRequestDispatcher("/views/pt/application-result-lookup.jsp").forward(request, response);
            return;
        }

        request.setAttribute("application", application);
        keepLookupData(request, applicationCode, phone);
        request.getRequestDispatcher("/views/pt/application-result-lookup.jsp").forward(request, response);
    }

    private void keepLookupData(HttpServletRequest request, String applicationCode, String phone) {
        request.setAttribute("applicationCode", applicationCode);
        request.setAttribute("phone", phone);
    }
}
