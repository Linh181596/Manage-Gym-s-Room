package com.mycompany.gymcentermanagement.controller.auth;

import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Controller to handle Logout requests.
 * Invalidates the current session and redirects to the login page.
 * Mapped to /logout.
 */
@WebServlet(name = "LogoutController", urlPatterns = {"/logout"})
public class LogoutController extends HttpServlet {

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Delete Remember Me Cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("remember_me_token".equals(cookie.getName())) {
                    String tokenValue = cookie.getValue();
                    try {
                        userDAO.deleteRememberMeToken(tokenValue);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    Cookie cleanCookie = new Cookie("remember_me_token", "");
                    cleanCookie.setMaxAge(0);
                    cleanCookie.setPath(request.getContextPath() != null ? request.getContextPath() : "/");
                    response.addCookie(cleanCookie);
                    break;
                }
            }
        }

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
