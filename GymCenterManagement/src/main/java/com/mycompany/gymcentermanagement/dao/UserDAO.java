/**
 * =========================================================================
 * @file          : UserDAO.java
 * @description   : Interface quản lý tương tác dữ liệu trực tiếp với bảng Users và các bảng liên quan.
 * @author        : Nguyễn Đại Dương
 * @created       : 2026-06-05
 * @last_modified : 2026-06-11 bởi Antigravity
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.UserToken;
import com.mycompany.gymcentermanagement.dto.UserProfileBaseDTO;
import java.sql.SQLException;
import java.util.List;

public interface UserDAO {
    
    User findByEmail(String email) throws SQLException;

    User findById(int userId) throws SQLException;

    boolean insert(User user) throws SQLException;

    boolean update(User user) throws SQLException;

    boolean delete(int userId) throws SQLException;

    List<User> findAllActive() throws SQLException;

    // --- New Auth & Verification Methods ---
    
    boolean checkEmailExists(String email) throws SQLException;

    boolean checkPhoneExists(String phone) throws SQLException;
    
    boolean checkPhoneExists(String phone) throws SQLException;
    
    boolean registerMember(User user, Member member, UserToken token) throws SQLException;
    
    String verifyAccountAndGetEmail(String tokenValue) throws SQLException;
    
    boolean saveRememberMeToken(UserToken token) throws SQLException;
    
    User getUserByRememberMeToken(String tokenValue) throws SQLException;
    
    boolean deleteRememberMeToken(String tokenValue) throws SQLException;
    
    boolean updatePassword(int userId, String newPasswordHash, boolean mustChangePassword) throws SQLException;

    // --- Profile Methods (UC-03) ---
    
    String getHighestPriorityRole(int userId) throws SQLException;
    
    UserProfileBaseDTO getUserProfileById(int userId) throws SQLException;
    
    boolean updateUserProfile(UserProfileBaseDTO profileDto, String roleName) throws SQLException;
}

