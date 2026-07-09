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
 * Keeps SessionRegistry in sync with the currentUser session attribute.
 */
@WebListener
public class CurrentUserSessionListener implements HttpSessionListener, HttpSessionAttributeListener {

    private static final String CURRENT_USER_ATTRIBUTE = "currentUser";

    @Override
    public void attributeAdded(HttpSessionBindingEvent event) {
        if (CURRENT_USER_ATTRIBUTE.equals(event.getName()) && event.getValue() instanceof User user) {
            SessionRegistry.register(event.getSession(), user);
        }
    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent event) {
        HttpSession session = event.getSession();
        if (!CURRENT_USER_ATTRIBUTE.equals(event.getName())) {
            return;
        }

        if (event.getValue() instanceof User oldUser) {
            SessionRegistry.unregister(session, oldUser);
        }

        Object newValue = session.getAttribute(CURRENT_USER_ATTRIBUTE);
        if (newValue instanceof User newUser) {
            SessionRegistry.register(session, newUser);
        }
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent event) {
        if (CURRENT_USER_ATTRIBUTE.equals(event.getName()) && event.getValue() instanceof User user) {
            SessionRegistry.unregister(event.getSession(), user);
        }
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        SessionRegistry.unregister(event.getSession());
    }
}
