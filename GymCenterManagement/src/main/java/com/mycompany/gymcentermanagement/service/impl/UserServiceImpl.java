package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.UserService;
import com.mycompany.gymcentermanagement.utils.PasswordUtils;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Service implementation for User business operations.
 */
public class UserServiceImpl implements UserService {
    private static final Logger LOGGER = Logger.getLogger(UserServiceImpl.class.getName());
    
    // In a clean JEE environment, this can be injected via CDI.
    // Here we instantiate manually for simplicity.
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    public User login(String email, String rawPassword) {
        try {
            User user = userDAO.findByEmail(email);
            if (user != null && PasswordUtils.checkPassword(rawPassword, user.getPasswordHash())) {
                // Ensure account is Active before allowing login
                if (user.getAccountStatus() == User.AccountStatus.Active) {
                    return user;
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error performing authentication for: " + email, ex);
        }
        return null;
    }

    @Override
    public boolean registerMember(User user, String rawPassword) {
        try {
            // Check if email already registered
            if (userDAO.findByEmail(user.getEmail()) != null) {
                LOGGER.warning("Registration failed: Email already exists: " + user.getEmail());
                return false;
            }

            // Set user identifiers and system attributes
            user.setUserId(UUID.randomUUID().toString());
            user.setPasswordHash(PasswordUtils.hashPassword(rawPassword));
            user.setRole(User.Role.Member);
            user.setAccountStatus(User.AccountStatus.Active);
            user.setCreatedBy("System/Registration");
            user.setCreatedDate(LocalDateTime.now());

            return userDAO.insert(user);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error performing registration for: " + user.getEmail(), ex);
        }
        return false;
    }

    @Override
    public User getProfile(String userId) {
        try {
            return userDAO.findById(userId);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error loading profile for user ID: " + userId, ex);
        }
        return null;
    }

    @Override
    public boolean updateProfile(User user) {
        try {
            User existing = userDAO.findById(user.getUserId());
            if (existing == null) {
                return false;
            }

            // Update basic editable details
            existing.setFullName(user.getFullName());
            existing.setPhoneNumber(user.getPhoneNumber());
            existing.setEmail(user.getEmail());
            existing.setUpdatedBy(user.getUserId());
            existing.setUpdatedDate(LocalDateTime.now());

            return userDAO.update(existing);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error updating profile for user ID: " + user.getUserId(), ex);
        }
        return false;
    }
}
