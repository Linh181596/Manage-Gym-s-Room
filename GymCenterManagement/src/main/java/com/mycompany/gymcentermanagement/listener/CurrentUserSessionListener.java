/**
 * =========================================================================
 * @file          : CurrentUserSessionListener.java
 * @description   : Listener đồng bộ thuộc tính currentUser trong session với SessionRegistry.
 * @author        : Nguyễn Đại Dương (duongnd)
 * @created       : 2026-06-25
 * @last_modified : 2026-06-25
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.listener;

import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.utils.SessionRegistry;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionAttributeListener;
import jakarta.servlet.http.HttpSessionBindingEvent;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

/**
 * Listener để lắng nghe các sự kiện thay đổi trên HttpSession.
 * Nhiệm vụ chính là đảm bảo `SessionRegistry` (bộ đệm quản lý các phiên đăng nhập) 
 * luôn được đồng bộ mỗi khi thuộc tính `currentUser` (chứa thông tin người dùng đang đăng nhập)
 * được thêm vào, sửa đổi, hay xóa đi khỏi Session.
 */
@WebListener
public class CurrentUserSessionListener implements HttpSessionListener, HttpSessionAttributeListener {

    private static final String CURRENT_USER_ATTRIBUTE = "currentUser";

    /**
     * Kích hoạt khi có một thuộc tính MỚI được thêm vào Session.
     * Dùng để nhận diện lúc User vừa đăng nhập thành công.
     */
    @Override
    public void attributeAdded(HttpSessionBindingEvent event) {
        if (CURRENT_USER_ATTRIBUTE.equals(event.getName()) && event.getValue() instanceof User user) {
            SessionRegistry.register(event.getSession(), user);
        }
    }

    /**
     * Kích hoạt khi một thuộc tính đã tồn tại trong Session BỊ GHI ĐÈ bằng giá trị mới.
     * Dùng để cập nhật SessionRegistry nếu tài khoản đăng nhập thay đổi hoặc refresh thông tin User.
     */
    @Override
    public void attributeReplaced(HttpSessionBindingEvent event) {
        HttpSession session = event.getSession();
        if (!CURRENT_USER_ATTRIBUTE.equals(event.getName())) {
            return;
        }

        // Hủy đăng ký tài khoản cũ
        if (event.getValue() instanceof User oldUser) {
            SessionRegistry.unregister(session, oldUser);
        }

        // Đăng ký tài khoản mới vừa được set vào
        Object newValue = session.getAttribute(CURRENT_USER_ATTRIBUTE);
        if (newValue instanceof User newUser) {
            SessionRegistry.register(session, newUser);
        }
    }

    /**
     * Kích hoạt khi thuộc tính `currentUser` BỊ XÓA khỏi Session (ví dụ khi Logout).
     */
    @Override
    public void attributeRemoved(HttpSessionBindingEvent event) {
        if (CURRENT_USER_ATTRIBUTE.equals(event.getName()) && event.getValue() instanceof User user) {
            SessionRegistry.unregister(event.getSession(), user);
        }
    }

    /**
     * Kích hoạt khi toàn bộ Session BỊ HỦY (Timeout hoặc bị gọi session.invalidate()).
     * Dọn dẹp session id rác khỏi SessionRegistry để tránh tràn bộ nhớ.
     */
    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        SessionRegistry.unregister(event.getSession());
    }
}
