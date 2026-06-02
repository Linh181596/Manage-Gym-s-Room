/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import model.PTApplication;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author phuga
 */
public class PTApplicationDAO extends DBContext {

    public boolean insert(PTApplication application) {
        String sql = """
            INSERT INTO PTApplications (
                ApplicationCode,
                FullName,
                Email,
                Phone,
                Gender,
                DateOfBirth,
                Specialization,
                ExperienceYears,
                ExperienceDescription,
                Description,
                Introduction,
                CertificateFileName,
                CertificateFilePath,
                CertificateFileType,
                CertificateFileSize,
                Status,
                ReviewNote,
                ReviewedByUserID,
                ReviewedAt,
                CreatedUserID,
                CreatedBy,
                CreatedDate,
                UpdatedBy,
                UpdatedDate,
                IsDeleted
            )
            VALUES (
                ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
                ?, ?, ?, ?,
                'Pending',
                NULL, NULL, NULL, NULL,
                'System',
                SYSDATETIME(),
                NULL,
                NULL,
                0
            )
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, application.getApplicationCode());
            ps.setString(2, application.getFullName());
            ps.setString(3, application.getEmail());
            ps.setString(4, application.getPhone());
            ps.setString(5, application.getGender());

            if (application.getDateOfBirth() == null || application.getDateOfBirth().trim().isEmpty()) {
                ps.setNull(6, java.sql.Types.DATE);
            } else {
                ps.setDate(6, java.sql.Date.valueOf(application.getDateOfBirth()));
            }

            ps.setString(7, application.getSpecialization());

            if (application.getExperienceYears() == null) {
                ps.setNull(8, java.sql.Types.INTEGER);
            } else {
                ps.setInt(8, application.getExperienceYears());
            }

            ps.setString(9, application.getExperienceDescription());
            ps.setString(10, application.getDescription());
            ps.setString(11, application.getIntroduction());
            ps.setString(12, application.getCertificateFileName());
            ps.setString(13, application.getCertificateFilePath());
            ps.setString(14, application.getCertificateFileType());

            if (application.getCertificateFileSize() == null) {
                ps.setNull(15, java.sql.Types.INTEGER);
            } else {
                ps.setInt(15, application.getCertificateFileSize());
            }

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public PTApplication findByCodeAndPhone(String applicationCode, String phone) {
        String sql = """
            SELECT
                ApplicationID,
                ApplicationCode,
                FullName,
                Email,
                Phone,
                Specialization,
                ExperienceYears,
                ExperienceDescription,
                Description,
                Introduction,
                CertificateFileName,
                CertificateFilePath,
                CertificateFileType,
                CertificateFileSize,
                Status,
                ReviewNote,
                ReviewedByUserID,
                ReviewedAt,
                CreatedUserID,
                CreatedDate,
                IsDeleted
            FROM PTApplications
            WHERE ApplicationCode = ?
              AND Phone = ?
              AND IsDeleted = 0
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, applicationCode);
            ps.setString(2, phone);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPTApplication(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean existsPendingApplication(String email, String phone) {
        String sql = """
        SELECT 1
        FROM PTApplications
        WHERE IsDeleted = 0
          AND Status = 'Pending'
          AND (Email = ? OR Phone = ?)
    """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, phone);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi kiểm tra đơn ứng tuyển PT trùng", e);
        }
    }

    private PTApplication mapResultSetToPTApplication(ResultSet rs) throws SQLException {
        PTApplication application = new PTApplication();

        application.setApplicationId(rs.getInt("ApplicationID"));
        application.setApplicationCode(rs.getString("ApplicationCode"));
        application.setFullName(rs.getString("FullName"));
        application.setEmail(rs.getString("Email"));
        application.setPhone(rs.getString("Phone"));
        application.setSpecialization(rs.getString("Specialization"));

        int expYears = rs.getInt("ExperienceYears");
        application.setExperienceYears(rs.wasNull() ? null : expYears);

        application.setExperienceDescription(rs.getString("ExperienceDescription"));
        application.setDescription(rs.getString("Description"));
        application.setIntroduction(rs.getString("Introduction"));

        application.setCertificateFileName(rs.getString("CertificateFileName"));
        application.setCertificateFilePath(rs.getString("CertificateFilePath"));
        application.setCertificateFileType(rs.getString("CertificateFileType"));

        int fileSize = rs.getInt("CertificateFileSize");
        application.setCertificateFileSize(rs.wasNull() ? null : fileSize);

        application.setStatus(rs.getString("Status"));
        application.setReviewNote(rs.getString("ReviewNote"));

        int reviewedBy = rs.getInt("ReviewedByUserID");
        application.setReviewedByUserId(rs.wasNull() ? null : reviewedBy);

        if (rs.getTimestamp("ReviewedAt") != null) {
            application.setReviewedAt(rs.getTimestamp("ReviewedAt").toLocalDateTime());
        }

        int createdUserId = rs.getInt("CreatedUserID");
        application.setCreatedUserId(rs.wasNull() ? null : createdUserId);

        if (rs.getTimestamp("CreatedDate") != null) {
            application.setCreatedDate(rs.getTimestamp("CreatedDate").toLocalDateTime());
        }

        application.setDeleted(rs.getBoolean("IsDeleted"));

        return application;
    }
}
