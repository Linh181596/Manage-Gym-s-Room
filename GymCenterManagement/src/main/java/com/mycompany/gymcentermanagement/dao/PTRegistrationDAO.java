package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.PTRegistration;
import com.mycompany.gymcentermanagement.model.entity.PTServicePrice;
import com.mycompany.gymcentermanagement.utils.DBContext;
import java.math.BigDecimal;
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
 * DAO class for managing Personal Trainer registrations and service prices.
 */
public class PTRegistrationDAO {

    /**
     * Maps a ResultSet row to a PTServicePrice object.
     */
    private PTServicePrice mapServicePrice(ResultSet rs) throws SQLException {
        PTServicePrice price = new PTServicePrice();

        price.setPtServicePriceId(rs.getInt("PTServicePriceID"));
        price.setPtId(rs.getInt("PTID"));
        price.setPtPackageTypeId(rs.getInt("PTPackageTypeID"));
        price.setPrice(rs.getBigDecimal("Price"));
        price.setStatus(rs.getString("PriceStatus"));

        price.setTrainerName(rs.getString("TrainerName"));
        price.setPackageName(rs.getString("PackageName"));
        price.setPackageDescription(rs.getString("PackageDescription"));

        int durationMonths = rs.getInt("DurationMonths");
        price.setDurationMonths(rs.wasNull() ? null : durationMonths);

        int numberOfSessions = rs.getInt("NumberOfSessions");
        price.setNumberOfSessions(rs.wasNull() ? null : numberOfSessions);

        return price;
    }

    /**
     * Maps a ResultSet row to a PTRegistration object.
     */
    private PTRegistration mapPTRegistration(ResultSet rs) throws SQLException {
        PTRegistration registration = new PTRegistration();

        registration.setPtRegistrationId(rs.getInt("PTRegistrationID"));
        registration.setMemberId(rs.getInt("MemberID"));
        registration.setPtServicePriceId(rs.getInt("PTServicePriceID"));

        int ptId = rs.getInt("PTID");
        if (!rs.wasNull()) {
            registration.setPtId(ptId);
        }

        Date preferredStartDate = rs.getDate("PreferredStartDate");
        if (preferredStartDate != null) {
            registration.setPreferredStartDate(preferredStartDate.toLocalDate());
        }

        Date startDate = rs.getDate("StartDate");
        if (startDate != null) {
            registration.setStartDate(startDate.toLocalDate());
        }

        Date endDate = rs.getDate("EndDate");
        if (endDate != null) {
            registration.setEndDate(endDate.toLocalDate());
        }

        registration.setTotalAmount(rs.getBigDecimal("TotalAmount"));
        registration.setStatus(rs.getString("Status"));
        registration.setPaymentStatus(rs.getString("PaymentStatus"));
        registration.setNote(rs.getString("Note"));

        int processedByUserId = rs.getInt("ProcessedByUserID");
        if (!rs.wasNull()) {
            registration.setProcessedByUserId(processedByUserId);
        }

        Timestamp processedAt = rs.getTimestamp("ProcessedAt");
        if (processedAt != null) {
            registration.setProcessedAt(processedAt.toLocalDateTime());
        }

        registration.setCreatedBy(rs.getString("CreatedBy"));

        Timestamp createdDate = rs.getTimestamp("CreatedDate");
        if (createdDate != null) {
            registration.setCreatedDate(createdDate.toLocalDateTime());
        }

        registration.setUpdatedBy(rs.getString("UpdatedBy"));

        Timestamp updatedDate = rs.getTimestamp("UpdatedDate");
        if (updatedDate != null) {
            registration.setUpdatedDate(updatedDate.toLocalDateTime());
        }

        registration.setDeleted(rs.getBoolean("IsDeleted"));

        registration.setMemberName(rs.getString("MemberName"));
        registration.setTrainerName(rs.getString("TrainerName"));
        registration.setPackageTypeName(rs.getString("PackageName"));

        return registration;
    }

    /**
     * Sets a LocalDate value to PreparedStatement as SQL Date.
     */
    private void setDateOrNull(PreparedStatement ps, int parameterIndex, java.time.LocalDate date)
            throws SQLException {
        if (date != null) {
            ps.setDate(parameterIndex, Date.valueOf(date));
        } else {
            ps.setNull(parameterIndex, Types.DATE);
        }
    }

    /**
     * Gets active PT service prices for a selected Personal Trainer.
     */
    public List<PTServicePrice> findActiveServicePricesByTrainerId(int ptId) {
        List<PTServicePrice> prices = new ArrayList<>();

        String sql = """
        SELECT
            sp.PTServicePriceID,
            sp.PTID,
            sp.PTPackageTypeID,
            sp.Price,
            sp.Status AS PriceStatus,
            COALESCE(pt.DisplayName, pt.FullName) AS TrainerName,
            pkg.PackageName,
            pkg.Description AS PackageDescription,
            pkg.DurationMonths,
            pkg.NumberOfSessions
        FROM PTServicePrices sp
        INNER JOIN PTPackageTypes pkg
            ON sp.PTPackageTypeID = pkg.PTPackageTypeID
        INNER JOIN PersonalTrainers pt
            ON sp.PTID = pt.PTID
        WHERE sp.PTID = ?
          AND sp.Status = 'Active'
          AND sp.IsDeleted = 0
          AND pkg.Status = 'Active'
          AND pkg.IsDeleted = 0
          AND pt.Status = 'Active'
          AND pt.IsDeleted = 0
        ORDER BY pkg.DurationMonths
    """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ptId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    prices.add(mapServicePrice(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return prices;
    }

    public PTServicePrice findServicePriceById(int ptServicePriceId) {
        String sql = """
            SELECT
                sp.PTServicePriceID,
                sp.PTID,
                sp.PTPackageTypeID,
                sp.Price,
                sp.Status AS PriceStatus,
                COALESCE(pt.DisplayName, pt.FullName) AS TrainerName,
                pkg.PackageName,
                pkg.Description AS PackageDescription,
                pkg.DurationMonths,
                pkg.NumberOfSessions
            FROM PTServicePrices sp
            INNER JOIN PTPackageTypes pkg
                ON sp.PTPackageTypeID = pkg.PTPackageTypeID
            INNER JOIN PersonalTrainers pt
                ON sp.PTID = pt.PTID
            WHERE sp.PTServicePriceID = ?
              AND sp.Status = 'Active'
              AND sp.IsDeleted = 0
              AND pkg.Status = 'Active'
              AND pkg.IsDeleted = 0
              AND pt.Status = 'Active'
              AND pt.IsDeleted = 0
        """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ptServicePriceId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapServicePrice(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean insert(PTRegistration registration) {

        String sql = """
            INSERT INTO PTRegistrations (
                MemberID,
                PTServicePriceID,
                PreferredStartDate,
                StartDate,
                EndDate,
                TotalAmount,
                Status,
                PaymentStatus,
                Note,
                ProcessedByUserID,
                ProcessedAt,
                CreatedBy,
                CreatedDate,
                UpdatedBy,
                UpdatedDate,
                IsDeleted
            )
            VALUES (
                ?, ?, ?, ?, ?, ?,
                'Pending',
                'Unpaid',
                ?,
                NULL,
                NULL,
                ?,
                SYSDATETIME(),
                NULL,
                NULL,
                0
            )
        """;

        BigDecimal totalAmount = registration.getTotalAmount();
        if (totalAmount == null) {
            PTServicePrice servicePrice = findServicePriceById(registration.getPtServicePriceId());
            if (servicePrice == null) {
                return false;
            }
            totalAmount = servicePrice.getPrice();
        }

        String createdBy = registration.getCreatedBy();
        if (createdBy == null || createdBy.trim().isEmpty()) {
            createdBy = "Member";
        }

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, registration.getMemberId());
            ps.setInt(2, registration.getPtServicePriceId());

            setDateOrNull(ps, 3, registration.getPreferredStartDate());
            setDateOrNull(ps, 4, registration.getStartDate());
            setDateOrNull(ps, 5, registration.getEndDate());

            ps.setBigDecimal(6, totalAmount);
            ps.setString(7, registration.getNote());
            ps.setString(8, createdBy);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Finds a PT service registration by ID.
     */
    public PTRegistration findById(int ptRegistrationId) {
        String sql = """
            SELECT
                r.PTRegistrationID,
                r.MemberID,
                r.PTServicePriceID,
                sp.PTID,
                r.PreferredStartDate,
                r.StartDate,
                r.EndDate,
                r.TotalAmount,
                r.Status,
                r.PaymentStatus,
                r.Note,
                r.ProcessedByUserID,
                r.ProcessedAt,
                r.CreatedBy,
                r.CreatedDate,
                r.UpdatedBy,
                r.UpdatedDate,
                r.IsDeleted,
                memberUser.DisplayName AS MemberName,
                COALESCE(pt.DisplayName, pt.FullName) AS TrainerName,
                pkg.PackageName
            FROM PTRegistrations r
            INNER JOIN Members m
                ON r.MemberID = m.MemberID
            INNER JOIN Users memberUser
                ON m.UserID = memberUser.UserID
            INNER JOIN PTServicePrices sp
                ON r.PTServicePriceID = sp.PTServicePriceID
            INNER JOIN PersonalTrainers pt
                ON sp.PTID = pt.PTID
            INNER JOIN PTPackageTypes pkg
                ON sp.PTPackageTypeID = pkg.PTPackageTypeID
            WHERE r.PTRegistrationID = ?
              AND r.IsDeleted = 0
        """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ptRegistrationId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapPTRegistration(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Gets PT service registrations of a member.
     */
    public List<PTRegistration> findByMemberId(int memberId) {
        List<PTRegistration> registrations = new ArrayList<>();

        String sql = """
            SELECT
                r.PTRegistrationID,
                r.MemberID,
                r.PTServicePriceID,
                sp.PTID,
                r.PreferredStartDate,
                r.StartDate,
                r.EndDate,
                r.TotalAmount,
                r.Status,
                r.PaymentStatus,
                r.Note,
                r.ProcessedByUserID,
                r.ProcessedAt,
                r.CreatedBy,
                r.CreatedDate,
                r.UpdatedBy,
                r.UpdatedDate,
                r.IsDeleted,
                memberUser.DisplayName AS MemberName,
                COALESCE(pt.DisplayName, pt.FullName) AS TrainerName,
                pkg.PackageName
            FROM PTRegistrations r
            INNER JOIN Members m
                ON r.MemberID = m.MemberID
            INNER JOIN Users memberUser
                ON m.UserID = memberUser.UserID
            INNER JOIN PTServicePrices sp
                ON r.PTServicePriceID = sp.PTServicePriceID
            INNER JOIN PersonalTrainers pt
                ON sp.PTID = pt.PTID
            INNER JOIN PTPackageTypes pkg
                ON sp.PTPackageTypeID = pkg.PTPackageTypeID
            WHERE r.MemberID = ?
              AND r.IsDeleted = 0
            ORDER BY r.CreatedDate DESC
        """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, memberId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    registrations.add(mapPTRegistration(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return registrations;
    }

    /**
     * Gets all PT service registrations for Staff/Admin processing.
     */
    public List<PTRegistration> findAllForManagement() {
        List<PTRegistration> registrations = new ArrayList<>();

        String sql = """
            SELECT
                r.PTRegistrationID,
                r.MemberID,
                r.PTServicePriceID,
                sp.PTID,
                r.PreferredStartDate,
                r.StartDate,
                r.EndDate,
                r.TotalAmount,
                r.Status,
                r.PaymentStatus,
                r.Note,
                r.ProcessedByUserID,
                r.ProcessedAt,
                r.CreatedBy,
                r.CreatedDate,
                r.UpdatedBy,
                r.UpdatedDate,
                r.IsDeleted,
                memberUser.DisplayName AS MemberName,
                COALESCE(pt.DisplayName, pt.FullName) AS TrainerName,
                pkg.PackageName
            FROM PTRegistrations r
            INNER JOIN Members m
                ON r.MemberID = m.MemberID
            INNER JOIN Users memberUser
                ON m.UserID = memberUser.UserID
            INNER JOIN PTServicePrices sp
                ON r.PTServicePriceID = sp.PTServicePriceID
            INNER JOIN PersonalTrainers pt
                ON sp.PTID = pt.PTID
            INNER JOIN PTPackageTypes pkg
                ON sp.PTPackageTypeID = pkg.PTPackageTypeID
            WHERE r.IsDeleted = 0
            ORDER BY r.CreatedDate DESC
        """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                registrations.add(mapPTRegistration(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return registrations;
    }

    /**
     * Processes a PT service registration by Staff/Admin.
     */
    public boolean processRegistration(int ptRegistrationId, String status,
            String paymentStatus, int processedByUserId,
            String updatedBy) {
        String sql = """
            UPDATE PTRegistrations
            SET Status = ?,
                PaymentStatus = ?,
                ProcessedByUserID = ?,
                ProcessedAt = SYSDATETIME(),
                UpdatedBy = ?,
                UpdatedDate = SYSDATETIME()
            WHERE PTRegistrationID = ?
              AND IsDeleted = 0
        """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, paymentStatus);
            ps.setInt(3, processedByUserId);
            ps.setString(4, updatedBy);
            ps.setInt(5, ptRegistrationId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
