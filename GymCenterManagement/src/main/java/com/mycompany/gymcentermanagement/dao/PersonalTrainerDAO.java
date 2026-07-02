/**
 * =========================================================================
 * @file          : PersonalTrainerDAO.java
 * @description   : Lớp truy cập dữ liệu để quản lý hồ sơ Huấn luyện viên cá nhân (PT).
 * @author        : Nguyễn Đình Phú (phund)
 * @created       : 2026-06-02
 * @last_modified : 2026-06-04 bởi Nguyễn Đình Phú
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import java.sql.SQLException;
import java.util.List;

/**
 * DAO class for managing Personal Trainer profiles.
 */
public interface PersonalTrainerDAO {
    /**
     * Gets all active Personal Trainers for public trainer list.
     */
    public List<PersonalTrainer> findActiveTrainers();

    /**
     * Gets active Personal Trainers by multiple specialization values.
     */
    public List<PersonalTrainer> findActiveTrainersBySpecializations(List<String> specializations);

    public PersonalTrainer findById(int ptId);

    public PersonalTrainer findPTByUserId(int userId);

    /**
     * Gets all Personal Trainers for Staff/Admin management screen.
     */
    public List<PersonalTrainer> findAllForManagement();

    /**
     * Searches active Personal Trainers by keyword and specialization.
     */
    public List<PersonalTrainer> searchActiveTrainers(String keyword, String specialization);

    /*
     * Search active PT by keyword and multiple specializations.
     */
    public List<PersonalTrainer> searchActiveTrainers(String keyword, List<String> specializations);

    public List<PersonalTrainer> searchTrainersForManagement(String keyword, List<String> specializations, String status);

    /**
     * Inserts an official Personal Trainer profile.
     */
    public boolean insertPersonalTrainer(PersonalTrainer trainer);

    /**
     * Updates verified and public trainer information.
     */
    public boolean updatePersonalTrainer(PersonalTrainer trainer);

    /**
     * Updates only trainer working status.
     */
    public boolean updateTrainerStatus(int ptId, String status, String updatedBy);

    /**
     * Soft deletes a Personal Trainer profile.
     */
    public boolean softDeletePersonalTrainer(int ptId, String updatedBy);

    /**
     * Update PT profile(PT feat): Change avatar, bio/description and displayName
     */
    public boolean updateProfile(PersonalTrainer pt) throws SQLException;

    /**
     * Gets all active members currently trained by the Personal Trainer.
     */
    public List<com.mycompany.gymcentermanagement.dto.PTMemberDTO> getActiveMembersForPT(int ptId);
    
    public int getActiveMembersForPTCount(int ptId);
    
    public List<com.mycompany.gymcentermanagement.dto.PTMemberDTO> getActiveMembersForPTPaginated(int ptId, int offset, int limit);
}
