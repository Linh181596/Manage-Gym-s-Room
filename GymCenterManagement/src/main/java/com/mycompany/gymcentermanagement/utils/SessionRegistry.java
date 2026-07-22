/**
 * =========================================================================
 * @file          : SessionRegistry.java
 * @description   : Tiện ích theo dõi session đăng nhập để thu hồi các phiên khác của cùng tài khoản sau khi đổi mật khẩu.
 * @author        : Nguyễn Đại Dương (duongnd)
 * @created       : 2026-06-25
 * @last_modified : 2026-06-25
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.utils;

import com.mycompany.gymcentermanagement.model.entity.User;
import jakarta.servlet.http.HttpSession;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Theo dõi các phiên đăng nhập (Session) đã được xác thực để có thể 
 * vô hiệu hóa các phiên khác của cùng một tài khoản khi cần (VD: khi đổi mật khẩu).
 */
public final class SessionRegistry {

    // Ánh xạ Session ID với đối tượng HttpSession tương ứng
    private static final ConcurrentHashMap<String, HttpSession> SESSIONS_BY_ID = new ConcurrentHashMap<>();
    // Ánh xạ User ID với danh sách các Session ID mà user này đang đăng nhập
    private static final ConcurrentHashMap<Integer, Set<String>> SESSION_IDS_BY_USER_ID = new ConcurrentHashMap<>();

    private SessionRegistry() {
    }

    /**
     * Đăng ký một phiên làm việc mới khi người dùng đăng nhập thành công.
     */
    public static void register(HttpSession session, User user) {
        if (session == null || user == null) {
            return;
        }

        String sessionId = session.getId();
        int userId = user.getUserId();

        SESSIONS_BY_ID.put(sessionId, session);
        // computeIfAbsent: Nếu userId chưa có session nào, khởi tạo một Set mới an toàn với luồng (Thread-safe Set)
        SESSION_IDS_BY_USER_ID
                .computeIfAbsent(userId, ignored -> ConcurrentHashMap.newKeySet())
                .add(sessionId);
    }

    /**
     * Gỡ bỏ một phiên làm việc khi người dùng đăng xuất hoặc session hết hạn.
     */
    public static void unregister(HttpSession session) {
        if (session == null) {
            return;
        }

        unregister(session.getId());
    }

    /**
     * Gỡ bỏ phiên làm việc dựa trên Session ID.
     */
    public static void unregister(String sessionId) {
        if (sessionId == null) {
            return;
        }

        SESSIONS_BY_ID.remove(sessionId);
        // Phải lặp qua tất cả user để xóa do không truyền vào User ID
        for (Set<String> sessionIds : SESSION_IDS_BY_USER_ID.values()) {
            sessionIds.remove(sessionId);
        }
    }

    /**
     * Gỡ bỏ phiên làm việc hiệu quả hơn khi có thông tin User.
     */
    public static void unregister(HttpSession session, User user) {
        if (session == null) {
            return;
        }

        String sessionId = session.getId();
        SESSIONS_BY_ID.remove(sessionId);

        if (user != null) {
            Set<String> sessionIds = SESSION_IDS_BY_USER_ID.get(user.getUserId());
            if (sessionIds != null) {
                sessionIds.remove(sessionId);
                // Xóa Set nếu User này không còn session nào
                if (sessionIds.isEmpty()) {
                    SESSION_IDS_BY_USER_ID.remove(user.getUserId(), sessionIds);
                }
            }
        }
    }

    /**
     * Vô hiệu hóa tất cả các phiên đăng nhập khác của một User ngoại trừ phiên hiện tại.
     * Thường gọi sau khi người dùng đổi mật khẩu thành công.
     * 
     * @param userId ID của người dùng
     * @param currentSessionId Session ID hiện hành (không bị vô hiệu hóa)
     * @return Số lượng session đã bị vô hiệu hóa
     */
    public static int invalidateOtherSessions(int userId, String currentSessionId) {
        Set<String> sessionIds = SESSION_IDS_BY_USER_ID.getOrDefault(userId, Collections.emptySet());
        // Tạo bản sao để tránh lỗi ConcurrentModificationException khi lặp
        Set<String> sessionIdsSnapshot = new HashSet<>(sessionIds);
        int invalidatedCount = 0;

        for (String sessionId : sessionIdsSnapshot) {
            // Bỏ qua session hiện tại
            if (sessionId.equals(currentSessionId)) {
                continue;
            }

            HttpSession session = SESSIONS_BY_ID.get(sessionId);
            if (session == null) {
                // Nếu session không còn trong bộ nhớ, chỉ cần xóa khỏi registry
                unregister(sessionId);
                continue;
            }

            try {
                // Ra lệnh invalidate (hủy) phiên đăng nhập
                // Listener (như CurrentUserSessionListener) sẽ tự động gọi unregister thông qua sự kiện sessionDestroyed
                session.invalidate();
                invalidatedCount++;
            } catch (IllegalStateException ex) {
                // Bắt lỗi nếu session đã bị invalidate từ trước
                unregister(sessionId);
            }
        }

        return invalidatedCount;
    }
}
