/**
 * =========================================================================
 * @file          : ManageAccountController.java
 * @description   : Controller xử lý chức năng quản lý tài khoản cho Admin, bao gồm tìm kiếm, tạo, cập nhật, khóa, mở khóa, đặt lại mật khẩu và vô hiệu hóa tài khoản.
 * @author        : Nguyễn Đại Dương (duongnd)
 * @created       : 2026-06-25
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.controller.admin;

import com.mycompany.gymcentermanagement.dto.AccountOperationResult;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.UserService;
import com.mycompany.gymcentermanagement.service.impl.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageAccountController", urlPatterns = {"/admin/accounts"})
public class ManageAccountController extends HttpServlet {

    private static final String LIST_VIEW = "/WEB-INF/views/admin/account-list.jsp";
    private static final String FORM_VIEW = "/WEB-INF/views/admin/account-form.jsp";
    private static final User.AccountStatus[] MANAGED_STATUSES = {
            User.AccountStatus.Active,
            User.AccountStatus.Inactive,
            User.AccountStatus.Locked
    };

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        consumeFlashMessages(request);

        String action = normalizeBlank(request.getParameter("action"));
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "create":
                showCreateForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "list":
            default:
                showAccountList(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = normalizeBlank(request.getParameter("action"));
        if (action == null) {
            action = "save";
        }

        switch (action) {
            case "save":
                saveAccount(request, response);
                break;
            case "lock":
                runAccountAction(request, response, action);
                break;
            case "unlock":
                runAccountAction(request, response, action);
                break;
            case "deactivate":
                runAccountAction(request, response, action);
                break;
            case "resetPassword":
                runAccountAction(request, response, action);
                break;
            case "changeRole":
                changeRole(request, response);
                break;
            default:
                setFlash(request, "errorMessage", "Thao tác tài khoản không được hỗ trợ.");
                response.sendRedirect(request.getContextPath() + "/admin/accounts");
                break;
        }
    }

    private void showAccountList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = normalizeBlank(request.getParameter("keyword"));
        String roleStr = normalizeBlank(request.getParameter("role"));
        String statusStr = normalizeBlank(request.getParameter("status"));

        User.Role role = null;
        if (roleStr != null) {
            try {
                role = User.Role.valueOf(roleStr);
            } catch (IllegalArgumentException e) {
                // Ignore invalid role
            }
        }

        User.AccountStatus status = null;
        if (statusStr != null) {
            try {
                status = User.AccountStatus.valueOf(statusStr);
            } catch (IllegalArgumentException e) {
                // Ignore invalid status
            }
        }

        // Pagination setup
        int page = com.mycompany.gymcentermanagement.utils.PaginationHelper.parseInt(request.getParameter("page"), 1);
        int pageSize = com.mycompany.gymcentermanagement.utils.PaginationHelper.normalizePageSize(
                com.mycompany.gymcentermanagement.utils.PaginationHelper.parseInt(request.getParameter("pageSize"), 10));
        
        int totalItems = userService.countAccounts(keyword, role, status);
        int totalPages = com.mycompany.gymcentermanagement.utils.PaginationHelper.totalPages(totalItems, pageSize);
        page = com.mycompany.gymcentermanagement.utils.PaginationHelper.normalizePage(page, totalPages);
        int offset = (page - 1) * pageSize;

        List<User> accounts = userService.searchAccounts(keyword, role, status, offset, pageSize);
        request.setAttribute("accounts", accounts);
        request.setAttribute("statuses", MANAGED_STATUSES);
        request.setAttribute("roles", new User.Role[]{User.Role.Staff, User.Role.Member});
        request.setAttribute("selectedRole", roleStr);
        request.setAttribute("selectedStatus", statusStr);
        request.setAttribute("keyword", keyword);

        String queryBase = com.mycompany.gymcentermanagement.utils.PaginationHelper.buildQueryBase(
                request, "/admin/accounts", "keyword", keyword, "role", roleStr, "status", statusStr, "pageSize", String.valueOf(pageSize));

        com.mycompany.gymcentermanagement.utils.PaginationHelper.setPaginationAttributes(
                request, page, pageSize, totalItems, queryBase, "tài khoản");

        request.getRequestDispatcher(LIST_VIEW).forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User account = new User();
        account.setRole(User.Role.Member);
        account.setAccountStatus(User.AccountStatus.Active);
        prepareForm(request, account, true, "Tạo tài khoản");
        request.getRequestDispatcher(FORM_VIEW).forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer userId = parseUserId(request);
        if (userId == null) {
            setFlash(request, "errorMessage", "Mã tài khoản không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
            return;
        }

        User account = userService.getAccountById(userId);
        if (account == null) {
            setFlash(request, "errorMessage", "Không tìm thấy tài khoản.");
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
            return;
        }

        prepareForm(request, account, false,
                account.getAccountStatus() == User.AccountStatus.Inactive ? "Thông tin tài khoản" : "Cập nhật tài khoản");
        request.getRequestDispatcher(FORM_VIEW).forward(request, response);
    }

    private void saveAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer userId = parseUserIdFromValue(request.getParameter("userId"));
        boolean isCreate = userId == null || userId <= 0;

        if (!isCreate) {
            User existingAccount = userService.getAccountById(userId);
            if (existingAccount == null) {
                setFlash(request, "errorMessage", "Không tìm thấy tài khoản.");
                response.sendRedirect(request.getContextPath() + "/admin/accounts");
                return;
            }
            if (existingAccount.getAccountStatus() == User.AccountStatus.Inactive) {
                setFlash(request, "errorMessage", "Tài khoản đã vô hiệu hóa chỉ có thể xem thông tin.");
                response.sendRedirect(request.getContextPath() + "/admin/accounts?action=edit&id=" + userId);
                return;
            }
        }

        User account = new User();
        account.setUserId(isCreate ? 0 : userId);
        account.setFullName(request.getParameter("fullName"));
        account.setEmail(request.getParameter("email"));
        account.setPhoneNumber(request.getParameter("phone"));
        account.setRole(parseRole(request.getParameter("role")));
        account.setAccountStatus(parseStatus(request.getParameter("status")));

        User currentAdmin = getCurrentUser(request);
        String actorName = actorName(currentAdmin);
        int currentAdminId = currentAdmin != null ? currentAdmin.getUserId() : 0;

        AccountOperationResult result;
        if (isCreate) {
            result = userService.createManagedAccount(account, actorName);
        } else {
            result = userService.updateManagedAccount(account, account.getRole(), currentAdminId, actorName);
        }

        if (!result.isSuccess()) {
            request.setAttribute("errorMessage", result.getMessage());
            prepareForm(request, account, isCreate, isCreate ? "Tạo tài khoản" : "Cập nhật tài khoản");
            request.getRequestDispatcher(FORM_VIEW).forward(request, response);
            return;
        }

        setFlash(request, "successMessage", result.getMessage());
        if (result.getTemporaryPassword() != null) {
            setFlash(request, "temporaryPassword", result.getTemporaryPassword());
            setFlash(request, "temporaryPasswordEmail", account.getEmail());
        }

        response.sendRedirect(request.getContextPath() + "/admin/accounts");
    }

    private void runAccountAction(HttpServletRequest request, HttpServletResponse response, String action)
            throws IOException {
        Integer userId = parseUserId(request);
        if (userId == null) {
            setFlash(request, "errorMessage", "Mã tài khoản không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
            return;
        }

        User targetAccount = userService.getAccountById(userId);
        if (targetAccount == null) {
            setFlash(request, "errorMessage", "Không tìm thấy tài khoản.");
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
            return;
        }
        if (targetAccount.getAccountStatus() == User.AccountStatus.Inactive) {
            setFlash(request, "errorMessage", "Tài khoản đã vô hiệu hóa không thể thực hiện thao tác này.");
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
            return;
        }

        User currentAdmin = getCurrentUser(request);
        String actorName = actorName(currentAdmin);
        int currentAdminId = currentAdmin != null ? currentAdmin.getUserId() : 0;

        AccountOperationResult result;
        switch (action) {
            case "lock":
                result = userService.lockAccount(userId, currentAdminId, actorName);
                break;
            case "unlock":
                result = userService.unlockAccount(userId, actorName);
                break;
            case "deactivate":
                result = userService.deactivateAccount(userId, currentAdminId, actorName);
                break;
            case "resetPassword":
                result = userService.resetManagedPassword(userId, actorName);
                break;
            default:
                result = AccountOperationResult.failure("Thao tác tài khoản không được hỗ trợ.");
                break;
        }

        if (result.isSuccess()) {
            setFlash(request, "successMessage", result.getMessage());
            if (result.getTemporaryPassword() != null) {
                User account = userService.getAccountById(userId);
                setFlash(request, "temporaryPassword", result.getTemporaryPassword());
                setFlash(request, "temporaryPasswordEmail", account != null ? account.getEmail() : "");
            }
        } else {
            setFlash(request, "errorMessage", result.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/accounts");
    }

    private void changeRole(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Integer userId = parseUserId(request);
        User.Role newRole = parseRole(request.getParameter("role"));
        if (userId == null || newRole == null) {
            setFlash(request, "errorMessage", "Yêu cầu đổi vai trò không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
            return;
        }

        User targetAccount = userService.getAccountById(userId);
        if (targetAccount == null) {
            setFlash(request, "errorMessage", "Không tìm thấy tài khoản.");
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
            return;
        }
        if (targetAccount.getAccountStatus() == User.AccountStatus.Inactive) {
            setFlash(request, "errorMessage", "Tài khoản đã vô hiệu hóa không thể thay đổi vai trò.");
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
            return;
        }

        User currentAdmin = getCurrentUser(request);
        AccountOperationResult result = userService.changeManagedAccountRole(
                userId,
                newRole,
                currentAdmin != null ? currentAdmin.getUserId() : 0,
                actorName(currentAdmin)
        );

        setFlash(request, result.isSuccess() ? "successMessage" : "errorMessage", result.getMessage());
        response.sendRedirect(request.getContextPath() + "/admin/accounts");
    }

    private void prepareForm(HttpServletRequest request, User account, boolean isCreate, String formTitle) {
        request.setAttribute("account", account);
        request.setAttribute("isCreate", isCreate);
        request.setAttribute("formTitle", formTitle);
        request.setAttribute("statuses", MANAGED_STATUSES);
    }

    private User getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null ? (User) session.getAttribute("currentUser") : null;
    }

    private String actorName(User currentUser) {
        if (currentUser == null || normalizeBlank(currentUser.getFullName()) == null) {
            return "Admin";
        }
        return currentUser.getFullName();
    }

    private Integer parseUserId(HttpServletRequest request) {
        String rawId = request.getParameter("id");
        if (rawId == null) {
            rawId = request.getParameter("userId");
        }
        return parseUserIdFromValue(rawId);
    }

    private Integer parseUserIdFromValue(String rawId) {
        try {
            String normalized = normalizeBlank(rawId);
            return normalized == null ? null : Integer.parseInt(normalized);
        } catch (NumberFormatException ex) {
            return null;
        }
    }

    private User.Role parseRole(String rawRole) {
        try {
            String normalized = normalizeBlank(rawRole);
            return normalized == null ? null : User.Role.valueOf(normalized);
        } catch (IllegalArgumentException ex) {
            return null;
        }
    }

    private User.AccountStatus parseStatus(String rawStatus) {
        try {
            String normalized = normalizeBlank(rawStatus);
            return normalized == null ? null : User.AccountStatus.valueOf(normalized);
        } catch (IllegalArgumentException ex) {
            return null;
        }
    }

    private String normalizeBlank(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private void setFlash(HttpServletRequest request, String key, String value) {
        request.getSession().setAttribute(key, value);
    }

    private void consumeFlashMessages(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }

        moveFlash(session, request, "successMessage");
        moveFlash(session, request, "errorMessage");
        moveFlash(session, request, "temporaryPassword");
        moveFlash(session, request, "temporaryPasswordEmail");
    }

    private void moveFlash(HttpSession session, HttpServletRequest request, String key) {
        Object value = session.getAttribute(key);
        if (value != null) {
            request.setAttribute(key, value);
            session.removeAttribute(key);
        }
    }
}
