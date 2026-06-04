/**
 * =========================================================================
 * @file          : PersonalTrainerDAO.java
 * @description   : Lớp truy cập dữ liệu để quản lý hồ sơ Huấn luyện viên cá nhân (PT).
 * @author        : Phạm Ngọc Duy (phund)
 * @created       : 2026-06-02
 * @last_modified : 2026-06-04 bởi Phạm Ngọc Duy
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.utils.DBContext;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class for managing Personal Trainer profiles.
 */
public class PersonalTrainerDAO {

    /**
     * Maps a ResultSet row to a PersonalTrainer object.
     */
    private PersonalTrainer mapPersonalTrainer(ResultSet rs) throws SQLException {
        PersonalTrainer trainer = new PersonalTrainer();

        trainer.setPtId(rs.getInt("PTID"));
        trainer.setUserId(rs.getInt("UserID"));
        trainer.setFullName(rs.getString("FullName"));
        trainer.setDisplayName(rs.getString("DisplayName"));
        trainer.setSpecialization(rs.getString("Specialization"));

        Date careerStartDate = rs.getDate("CareerStartDate");
        if (careerStartDate != null) {
            trainer.setCareerStartDate(careerStartDate.toLocalDate());
        }

        trainer.setCertificateFileName(rs.getString("CertificateFileName"));
        trainer.setCertificateFilePath(rs.getString("CertificateFilePath"));
        trainer.setDescription(rs.getString("Description"));
        trainer.setAvatarPath(rs.getString("AvatarPath"));
        trainer.setStatus(rs.getString("Status"));

        trainer.setCreatedBy(rs.getString("CreatedBy"));

        Timestamp createdDate = rs.getTimestamp("CreatedDate");
        if (createdDate != null) {
            trainer.setCreatedDate(createdDate.toLocalDateTime());
        }

        trainer.setUpdatedBy(rs.getString("UpdatedBy"));

        Timestamp updatedDate = rs.getTimestamp("UpdatedDate");
        if (updatedDate != null) {
            trainer.setUpdatedDate(updatedDate.toLocalDateTime());
        }

        trainer.setDeleted(rs.getBoolean("IsDeleted"));

        // Joined fields from Users table
        trainer.setEmail(rs.getString("Email"));
        trainer.setPhone(rs.getString("Phone"));
        trainer.setAccountStatus(rs.getString("AccountStatus"));
        trainer.setMustChangePassword(rs.getBoolean("MustChangePassword"));

        return trainer;
    }

    /**
     * Gets all active Personal Trainers for public trainer list.
     */
    public List<PersonalTrainer> findActiveTrainers() {
        String sql = """
            SELECT 
                pt.PTID,
                pt.UserID,
                pt.FullName,
                pt.DisplayName,
                pt.Specialization,
                pt.CareerStartDate,
                pt.CertificateFileName,
                pt.CertificateFilePath,
                pt.Description,
                pt.AvatarPath,
                pt.Status,
                pt.CreatedBy,
                pt.CreatedDate,
                pt.UpdatedBy,
                pt.UpdatedDate,
                pt.IsDeleted,
                u.Email,
                u.Phone,
                u.Status AS AccountStatus,
                u.MustChangePassword
            FROM PersonalTrainers pt
            INNER JOIN Users u ON pt.UserID = u.UserID
            WHERE pt.Status = 'Active'
              AND u.Status = 'Active'
              AND pt.IsDeleted = 0
              AND u.IsDeleted = 0
            ORDER BY pt.FullName
        """;

        List<PersonalTrainer> trainers = new ArrayList<>();

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                trainers.add(mapPersonalTrainer(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return trainers;
    }

    /**
     * Gets active Personal Trainers by multiple specialization values.
     */
    public List<PersonalTrainer> findActiveTrainersBySpecializations(List<String> specializations) {
        if (specializations == null || specializations.isEmpty()) {
            return findActiveTrainers();
        }

        List<PersonalTrainer> trainers = new ArrayList<>();

        StringBuilder placeholders = new StringBuilder();
        for (int i = 0; i < specializations.size(); i++) {
            placeholders.append("?");
            if (i < specializations.size() - 1) {
                placeholders.append(", ");
            }
        }

        String sql = """
        SELECT 
            pt.PTID,
            pt.UserID,
            pt.FullName,
            pt.DisplayName,
            pt.Specialization,
            pt.CareerStartDate,
            pt.CertificateFileName,
            pt.CertificateFilePath,
            pt.Description,
            pt.AvatarPath,
            pt.Status,
            pt.CreatedBy,
            pt.CreatedDate,
            pt.UpdatedBy,
            pt.UpdatedDate,
            pt.IsDeleted,
            u.Email,
            u.Phone,
            u.Status AS AccountStatus,
            u.MustChangePassword
        FROM PersonalTrainers pt
        INNER JOIN Users u ON pt.UserID = u.UserID
        WHERE pt.Status = 'Active'
          AND u.Status = 'Active'
          AND pt.IsDeleted = 0
          AND u.IsDeleted = 0
          AND pt.Specialization IN (
        """ + placeholders + """
          )
        ORDER BY pt.FullName
    """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int i = 0; i < specializations.size(); i++) {
                ps.setString(i + 1, specializations.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    trainers.add(mapPersonalTrainer(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy danh sách PT active", e);
        }

        return trainers;
    }

    public PersonalTrainer findById(int ptId) {
        String sql = """
            SELECT 
                pt.PTID,
                pt.UserID,
                pt.FullName,
                pt.DisplayName,
                pt.Specialization,
                pt.CareerStartDate,
                pt.CertificateFileName,
                pt.CertificateFilePath,
                pt.Description,
                pt.AvatarPath,
                pt.Status,
                pt.CreatedBy,
                pt.CreatedDate,
                pt.UpdatedBy,
                pt.UpdatedDate,
                pt.IsDeleted,
                u.Email,
                u.Phone,
                u.Status AS AccountStatus,
                u.MustChangePassword
            FROM PersonalTrainers pt
            INNER JOIN Users u ON pt.UserID = u.UserID
            WHERE pt.PTID = ?
              AND pt.IsDeleted = 0
              AND u.IsDeleted = 0
        """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ptId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapPersonalTrainer(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Gets all Personal Trainers for Staff/Admin management screen.
     */
    public List<PersonalTrainer> findAllForManagement() {
        List<PersonalTrainer> trainers = new ArrayList<>();

        String sql = """
            SELECT 
                pt.PTID,
                pt.UserID,
                pt.FullName,
                pt.DisplayName,
                pt.Specialization,
                pt.CareerStartDate,
                pt.CertificateFileName,
                pt.CertificateFilePath,
                pt.Description,
                pt.AvatarPath,
                pt.Status,
                pt.CreatedBy,
                pt.CreatedDate,
                pt.UpdatedBy,
                pt.UpdatedDate,
                pt.IsDeleted,
                u.Email,
                u.Phone,
                u.Status AS AccountStatus,
                u.MustChangePassword
            FROM PersonalTrainers pt
            INNER JOIN Users u ON pt.UserID = u.UserID
            WHERE pt.IsDeleted = 0
              AND u.IsDeleted = 0
            ORDER BY pt.CreatedDate DESC
        """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                trainers.add(mapPersonalTrainer(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return trainers;
    }

    /**
     * Searches active Personal Trainers by keyword and specialization.
     */
    public List<PersonalTrainer> searchActiveTrainers(String keyword, String specialization) {
        List<PersonalTrainer> trainers = new ArrayList<>();

        String sql = """
            SELECT 
                pt.PTID,
                pt.UserID,
                pt.FullName,
                pt.DisplayName,
                pt.Specialization,
                pt.CareerStartDate,
                pt.CertificateFileName,
                pt.CertificateFilePath,
                pt.Description,
                pt.AvatarPath,
                pt.Status,
                pt.CreatedBy,
                pt.CreatedDate,
                pt.UpdatedBy,
                pt.UpdatedDate,
                pt.IsDeleted,
                u.Email,
                u.Phone,
                u.Status AS AccountStatus,
                u.MustChangePassword
            FROM PersonalTrainers pt
            INNER JOIN Users u ON pt.UserID = u.UserID
            WHERE pt.Status = 'Active'
              AND u.Status = 'Active'
              AND pt.IsDeleted = 0
              AND u.IsDeleted = 0
              AND (
                    ? IS NULL
                    OR pt.FullName LIKE ?
                    OR pt.DisplayName LIKE ?
                    OR pt.Specialization LIKE ?
                    OR pt.Description LIKE ?
                  )
              AND (
                    ? IS NULL
                    OR pt.Specialization = ?
                  )
            ORDER BY pt.FullName
        """;

        String searchValue = null;
        if (keyword != null && !keyword.trim().isEmpty()) {
            searchValue = "%" + keyword.trim() + "%";
        }

        String specializationValue = null;
        if (specialization != null && !specialization.trim().isEmpty()) {
            specializationValue = specialization.trim();
        }

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, searchValue);
            ps.setString(2, searchValue);
            ps.setString(3, searchValue);
            ps.setString(4, searchValue);
            ps.setString(5, searchValue);
            ps.setString(6, specializationValue);
            ps.setString(7, specializationValue);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    trainers.add(mapPersonalTrainer(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return trainers;
    }

    /**
     * Inserts an official Personal Trainer profile.
     */
    public boolean insertPersonalTrainer(PersonalTrainer trainer) {
        String sql = """
            INSERT INTO PersonalTrainers (
                UserID,
                FullName,
                DisplayName,
                Specialization,
                CareerStartDate,
                CertificateFileName,
                CertificateFilePath,
                Description,
                AvatarPath,
                Status,
                CreatedBy,
                CreatedDate,
                IsDeleted
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), 0)
        """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, trainer.getUserId());
            ps.setString(2, trainer.getFullName());
            ps.setString(3, trainer.getDisplayName());
            ps.setString(4, trainer.getSpecialization());

            if (trainer.getCareerStartDate() != null) {
                ps.setDate(5, Date.valueOf(trainer.getCareerStartDate()));
            } else {
                ps.setNull(5, Types.DATE);
            }

            ps.setString(6, trainer.getCertificateFileName());
            ps.setString(7, trainer.getCertificateFilePath());
            ps.setString(8, trainer.getDescription());
            ps.setString(9, trainer.getAvatarPath());
            String status = trainer.getStatus();
            if (status == null || status.trim().isEmpty()) {
                status = "Active";
            }
            ps.setString(10, status);
            ps.setString(11, trainer.getCreatedBy());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Updates verified and public trainer information.
     */
    public boolean updatePersonalTrainer(PersonalTrainer trainer) {
        String sql = """
            UPDATE PersonalTrainers
            SET FullName = ?,
                DisplayName = ?,
                Specialization = ?,
                CareerStartDate = ?,
                CertificateFileName = ?,
                CertificateFilePath = ?,
                Description = ?,
                AvatarPath = ?,
                Status = ?,
                UpdatedBy = ?,
                UpdatedDate = GETDATE()
            WHERE PTID = ?
              AND IsDeleted = 0
        """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, trainer.getFullName());
            ps.setString(2, trainer.getDisplayName());
            ps.setString(3, trainer.getSpecialization());

            if (trainer.getCareerStartDate() != null) {
                ps.setDate(4, Date.valueOf(trainer.getCareerStartDate()));
            } else {
                ps.setNull(4, Types.DATE);
            }

            ps.setString(5, trainer.getCertificateFileName());
            ps.setString(6, trainer.getCertificateFilePath());
            ps.setString(7, trainer.getDescription());
            ps.setString(8, trainer.getAvatarPath());

            String status = trainer.getStatus();
            if (status == null || status.trim().isEmpty()) {
                status = "Active";
            }
            ps.setString(9, status);

            ps.setString(10, trainer.getUpdatedBy());
            ps.setInt(11, trainer.getPtId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Updates only trainer working status.
     */
    public boolean updateTrainerStatus(int ptId, String status, String updatedBy) {
        String sql = """
            UPDATE PersonalTrainers
            SET Status = ?,
                UpdatedBy = ?,
                UpdatedDate = GETDATE()
            WHERE PTID = ?
              AND IsDeleted = 0
        """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, updatedBy);
            ps.setInt(3, ptId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Soft deletes a Personal Trainer profile.
     */
    public boolean softDeletePersonalTrainer(int ptId, String updatedBy) {
        String sql = """
            UPDATE PersonalTrainers
            SET IsDeleted = 1,
                UpdatedBy = ?,
                UpdatedDate = GETDATE()
            WHERE PTID = ?
        """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, updatedBy);
            ps.setInt(2, ptId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
