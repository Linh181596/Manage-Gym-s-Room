package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.UserToken;
import java.sql.SQLException;
import java.util.List;

/**
 * Interface defining access operations to 'users' table in database.
 */
public interface UserDAO {
    
    /**
     * Finds user by email address (used for login and unique constraint checks).
     * 
     * @param email The user's email.
     * @return User object or null if not found.
     * @throws SQLException if a database error occurs.
     */
    User findByEmail(String email) throws SQLException;

    /**
     * Finds user by ID.
     * 
     * @param userId The user's unique identifier.
     * @return User object or null if not found.
     * @throws SQLException if a database error occurs.
     */
    User findById(int userId) throws SQLException;

    /**
     * Inserts a new user record.
     * 
     * @param user The user object containing insert details.
     * @return true if insertion succeeds, false otherwise.
     * @throws SQLException if a database error occurs.
     */
    boolean insert(User user) throws SQLException;

    /**
     * Updates an existing user record.
     * 
     * @param user The user object containing update details.
     * @return true if update succeeds, false otherwise.
     * @throws SQLException if a database error occurs.
     */
    boolean update(User user) throws SQLException;

    /**
     * Performs a soft delete by marking the user as deleted.
     * 
     * @param userId The ID of user to soft delete.
     * @return true if successful, false otherwise.
     * @throws SQLException if a database error occurs.
     */
    boolean delete(int userId) throws SQLException;

    /**
     * Retrieves all active, non-deleted users.
     * 
     * @return List of Users.
     * @throws SQLException if a database error occurs.
     */
    List<User> findAllActive() throws SQLException;

    // --- New Auth & Verification Methods ---
    
    boolean checkEmailExists(String email) throws SQLException;
    
    boolean registerMember(User user, Member member, UserToken token) throws SQLException;
    
    String verifyAccountAndGetEmail(String tokenValue) throws SQLException;
    
    boolean saveRememberMeToken(UserToken token) throws SQLException;
    
    User getUserByRememberMeToken(String tokenValue) throws SQLException;
    
    boolean deleteRememberMeToken(String tokenValue) throws SQLException;
    
    boolean updatePassword(int userId, String newPasswordHash, boolean mustChangePassword) throws SQLException;
}
