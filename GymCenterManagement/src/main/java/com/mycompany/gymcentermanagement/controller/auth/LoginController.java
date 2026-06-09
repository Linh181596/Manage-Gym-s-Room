package com.mycompany.gymcentermanagement.controller.auth;

import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.model.entity.UserToken;
import com.mycompany.gymcentermanagement.service.UserService;
import com.mycompany.gymcentermanagement.service.impl.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Controller to handle Authentication (Login) GET and POST requests.
 * Mapped to /login.
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
    
    private final UserService userService = new UserServiceImpl();
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // If already logged in, redirect straight to their respective dashboard
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;
        
        if (user != null) {
            redirectToDashboard(user, request, response);
            return;
        }

        // Check remember me cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("remember_me_token".equals(cookie.getName())) {
                    String tokenValue = cookie.getValue();
                    try {
                        User autoUser = userDAO.getUserByRememberMeToken(tokenValue);
                        if (autoUser != null && autoUser.getAccountStatus() == User.AccountStatus.Active) {
                            HttpSession newSession = request.getSession(true);
                            newSession.setAttribute("currentUser", autoUser);
                            redirectToDashboard(autoUser, request, response);
                            return;
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        
        // Transfer flash attributes from session to request if they exist
        if (session != null) {
            String successMsg = (String) session.getAttribute("successMessage");
            if (successMsg != null) {
                request.setAttribute("successMessage", successMsg);
                session.removeAttribute("successMessage");
            }
            String prepopulatedEmailVal = (String) session.getAttribute("prepopulatedEmail");
            if (prepopulatedEmailVal != null) {
                request.setAttribute("prepopulatedEmail", prepopulatedEmailVal);
                session.removeAttribute("prepopulatedEmail");
            }
        }

        // Show login view
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        
        // Validation
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Email và Mật khẩu không được để trống.");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            return;
        }
        
        // Authenticate user (supporting temporary demo bypass)
        User authenticatedUser = null;
        if ("admin@gym.com".equalsIgnoreCase(email.trim()) && "admin123".equals(password)) {
            authenticatedUser = new User(1, "admin@gym.com", "", "Demo Admin", "0987654321", User.Role.Admin, User.AccountStatus.Active);
        } else if ("staff@gym.com".equalsIgnoreCase(email.trim()) && "staff123".equals(password)) {
            authenticatedUser = new User(2, "staff@gym.com", "", "Demo Staff", "0987654321", User.Role.Staff, User.AccountStatus.Active);
        } else if ("member@gym.com".equalsIgnoreCase(email.trim()) && "member123".equals(password)) {
            authenticatedUser = new User(4, "member@gym.com", "", "Demo Member", "0987654321", User.Role.Member, User.AccountStatus.Active);
        } else {
            authenticatedUser = userService.login(email.trim(), password);
        }
        
        if (authenticatedUser != null) {
            // Success: Create session and save user info
            HttpSession session = request.getSession(true);
            session.setAttribute("currentUser", authenticatedUser);

            // Handle Remember Me token creation
            if (rememberMe != null && "true".equals(rememberMe)) {
                String randomToken = UUID.randomUUID().toString();
                LocalDateTime expiresAt = LocalDateTime.now().plusDays(7);
                UserToken tokenEntity = new UserToken(authenticatedUser.getUserId(), randomToken, "REMEMBER_ME", expiresAt);
                try {
                    userDAO.saveRememberMeToken(tokenEntity);
                    Cookie rememberCookie = new Cookie("remember_me_token", randomToken);
                    rememberCookie.setMaxAge(7 * 24 * 60 * 60);
                    rememberCookie.setHttpOnly(true);
                    rememberCookie.setPath(request.getContextPath() != null ? request.getContextPath() : "/");
                    response.addCookie(rememberCookie);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            
            // Redirect based on User Role
            redirectToDashboard(authenticatedUser, request, response);
        } else {
            // Failure: Return error feedback
            request.setAttribute("errorMessage", "Email hoặc mật khẩu không hợp lệ, hoặc tài khoản chưa kích hoạt.");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }
    
    private void redirectToDashboard(User user, HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        String context = request.getContextPath();
        switch (user.getRole()) {
            case Admin:
                response.sendRedirect(context + "/admin/dashboard");
                break;
            case Staff:
                response.sendRedirect(context + "/staff/dashboard");
                break;
            case Member:
                response.sendRedirect(context + "/member/dashboard");
                break;
            case PT:
                response.sendRedirect(context + "/pt/dashboard");
                break;
            default:
                response.sendRedirect(context + "/index.html");
        }
    }
}
