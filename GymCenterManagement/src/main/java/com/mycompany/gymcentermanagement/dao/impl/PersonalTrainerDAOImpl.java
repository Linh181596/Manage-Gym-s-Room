package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.PersonalTrainerDAO;
import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PersonalTrainerDAOImpl implements PersonalTrainerDAO {
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
    @Override
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
    @Override
    public List<PersonalTrainer> findActiveTrainersBySpecializations(List<String> specializations) {
        if (specializations == null || specializations.isEmpty()) {
            return findActiveTrainers();
        }

        List<PersonalTrainer> trainers = new ArrayList<>();

        StringBuilder conditions = new StringBuilder();
        for (int i = 0; i < specializations.size(); i++) {
            conditions.append("pt.Specialization LIKE ?");
            if (i < specializations.size() - 1) {
                conditions.append(" OR ");
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
                  AND (
                """ + conditions + """
                      )
                    ORDER BY pt.FullName
                """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int i = 0; i < specializations.size(); i++) {
                ps.setString(i + 1, "%" + specializations.get(i) + "%");
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

    @Override
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


    @Override
    public PersonalTrainer findPTByUserId(int userId) {
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
                    WHERE pt.UserID = ?
                      AND pt.IsDeleted = 0
                      AND u.IsDeleted = 0
                """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

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
    @Override
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
    @Override
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
                            OR pt.Specialization LIKE ?
                          )
                    ORDER BY pt.FullName
                """;

        String searchValue = null;
        if (keyword != null && !keyword.trim().isEmpty()) {
            searchValue = "%" + keyword.trim() + "%";
        }

        String specializationValue = null;
        if (specialization != null && !specialization.trim().isEmpty()) {
            specializationValue = "%" + specialization.trim() + "%";
        }

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, searchValue);
            ps.setString(2, searchValue);
            ps.setString(3, searchValue);
            ps.setString(4, searchValue);
            ps.setString(5, searchValue);

            if (specialization == null || specialization.trim().isEmpty()) {
                ps.setString(6, null);
                ps.setString(7, null);
            } else {
                ps.setString(6, specialization.trim());
                ps.setString(7, specializationValue);
            }

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

    /*
     * Search active PT by keyword and multiple specializations.
     */
    @Override
    public List<PersonalTrainer> searchActiveTrainers(String keyword, List<String> specializations) {
        List<PersonalTrainer> trainers = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
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
                """);

        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        boolean hasSpecializations = specializations != null && !specializations.isEmpty();

        if (hasKeyword) {
            sql.append("""
                        AND (
                            pt.FullName LIKE ?
                            OR pt.DisplayName LIKE ?
                            OR pt.Specialization LIKE ?
                            OR pt.Description LIKE ?
                            OR u.Email LIKE ?
                        )
                    """);
        }

        if (hasSpecializations) {
            sql.append(" AND (");

            for (int i = 0; i < specializations.size(); i++) {
                sql.append("pt.Specialization LIKE ?");

                if (i < specializations.size() - 1) {
                    sql.append(" OR ");
                }
            }

            sql.append(") ");
        }

        sql.append(" ORDER BY pt.FullName ");

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int index = 1;

            if (hasKeyword) {
                String searchValue = "%" + keyword.trim() + "%";

                ps.setString(index++, searchValue);
                ps.setString(index++, searchValue);
                ps.setString(index++, searchValue);
                ps.setString(index++, searchValue);
                ps.setString(index++, searchValue);
            }

            if (hasSpecializations) {
                for (String specialization : specializations) {
                    ps.setString(index++, "%" + specialization + "%");
                }
            }

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
    @Override
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
    @Override
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
    @Override
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
    @Override
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

    /**
     * Update PT profile(PT feat): Change avatar, bio/description and displayName
     */
    @Override
    public boolean updateProfile(PersonalTrainer pt) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            //get connection
            conn = DBContext.getConnection();
            String sql = "UPDATE PersonalTrainers SET "
                    + "DisplayName = ?, "
                    + "Description = ?, "
                    + "AvatarPath = ?, "
                    + "UpdatedBy = ?, "
                    + "UpdatedDate = GETDATE() "
                    + "WHERE PTID = ? AND IsDeleted = 0";

            stm = conn.prepareStatement(sql);

            stm.setString(1, pt.getDisplayName());
            stm.setString(2, pt.getDescription());
            stm.setString(3, pt.getAvatarPath());
            stm.setString(4, pt.getUpdatedBy());
            stm.setInt(5, pt.getPtId());

            int rowAffected = stm.executeUpdate();

            return (rowAffected > 0); //true -> updated successfully


        } catch (SQLException e) {
            System.err.println("Lỗi SQL khi update profile: " + e.getMessage());
            throw e; //throw exception -> service
        } finally {
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }

    }
}
