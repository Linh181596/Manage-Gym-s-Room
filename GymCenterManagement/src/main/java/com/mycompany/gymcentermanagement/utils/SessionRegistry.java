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
 * Tracks authenticated sessions so password changes can invalidate other
 * sessions that belong to the same account.
 */
public final class SessionRegistry {

    private static final ConcurrentHashMap<String, HttpSession> SESSIONS_BY_ID = new ConcurrentHashMap<>();
    private static final ConcurrentHashMap<Integer, Set<String>> SESSION_IDS_BY_USER_ID = new ConcurrentHashMap<>();

    private SessionRegistry() {
    }

    public static void register(HttpSession session, User user) {
        if (session == null || user == null) {
            return;
        }

        String sessionId = session.getId();
        int userId = user.getUserId();

        SESSIONS_BY_ID.put(sessionId, session);
        SESSION_IDS_BY_USER_ID
                .computeIfAbsent(userId, ignored -> ConcurrentHashMap.newKeySet())
                .add(sessionId);
    }

    public static void unregister(HttpSession session) {
        if (session == null) {
            return;
        }

        unregister(session.getId());
    }

    public static void unregister(String sessionId) {
        if (sessionId == null) {
            return;
        }

        SESSIONS_BY_ID.remove(sessionId);
        for (Set<String> sessionIds : SESSION_IDS_BY_USER_ID.values()) {
            sessionIds.remove(sessionId);
        }
    }

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
                if (sessionIds.isEmpty()) {
                    SESSION_IDS_BY_USER_ID.remove(user.getUserId(), sessionIds);
                }
            }
        }
    }

    public static int invalidateOtherSessions(int userId, String currentSessionId) {
        Set<String> sessionIds = SESSION_IDS_BY_USER_ID.getOrDefault(userId, Collections.emptySet());
        Set<String> sessionIdsSnapshot = new HashSet<>(sessionIds);
        int invalidatedCount = 0;

        for (String sessionId : sessionIdsSnapshot) {
            if (sessionId.equals(currentSessionId)) {
                continue;
            }

            HttpSession session = SESSIONS_BY_ID.get(sessionId);
            if (session == null) {
                unregister(sessionId);
                continue;
            }

            try {
                session.invalidate();
                invalidatedCount++;
            } catch (IllegalStateException ex) {
                unregister(sessionId);
            }
        }

        return invalidatedCount;
    }
}
