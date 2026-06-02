package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.model.entity.User;

/**
 * Service interface for User business operations (Auth, Account Management).
 */
public interface UserService {

    /**
     * Authenticates a user with email and password.
     * 
     * @param email       The email of the user.
     * @param rawPassword The plain text password.
     * @return User object if authentication is successful, null otherwise.
     */
    User login(String email, String rawPassword);

    /**
     * Registers a new Member user. Hashes the password and sets default status.
     * 
     * @param user        The User entity.
     * @param rawPassword The plain text password to hash.
     * @return true if registration is successful.
     */
    boolean registerMember(User user, String rawPassword);

    /**
     * Gets user profile details by ID.
     * 
     * @param userId The ID of the user.
     * @return User entity or null if not found.
     */
    User getProfile(int userId);

    /**
     * Updates profile details of a user.
     * 
     * @param user The User entity with updated fields.
     * @return true if update is successful.
     */
    boolean updateProfile(User user);
}
