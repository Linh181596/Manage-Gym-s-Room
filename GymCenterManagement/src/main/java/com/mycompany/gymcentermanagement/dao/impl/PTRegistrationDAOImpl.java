package com.mycompany.gymcentermanagement.dao.impl;

import com.mycompany.gymcentermanagement.dao.PTRegistrationDAO;
import com.mycompany.gymcentermanagement.dto.PTRegistrationDTO;
import com.mycompany.gymcentermanagement.model.entity.PTRegistration;
import com.mycompany.gymcentermanagement.model.entity.PTServicePrice;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PTRegistrationDAOImpl implements PTRegistrationDAO {
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
    @Override
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
                    INNER JOIN Users u
                        ON pt.UserID = u.UserID
                    WHERE sp.PTID = ?
                      AND sp.Status = 'Active'
                      AND sp.IsDeleted = 0
                      AND pkg.Status = 'Active'
                      AND pkg.IsDeleted = 0
                      AND pt.Status = 'Active'
                      AND pt.IsDeleted = 0
                    AND u.Status = 'Active'
                    AND u.IsDeleted = 0
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

    @Override
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

    @Override
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
                        IsDeleted,
                        PurchasedSessions
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
                        0,
                        ?
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
            ps.setInt(9, registration.getPurchasedSessions());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Finds a PT service registration by ID.
     */
    @Override
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
    @Override
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
    @Override
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
    @Override
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
                      AND Status = 'Pending'
                      AND PaymentStatus = 'Unpaid'
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

    @Override
    public List<PTRegistrationDTO> getPendingRegistrations() {
        List<PTRegistrationDTO> list = new ArrayList<>();
        // Query JOIN các bảng: PTRegistrations, Members, Users, PTServicePrices, PersonalTrainers, PTPackageTypes
        String sql = """
                    SELECT r.PTRegistrationID, 
                           u.DisplayName AS MemberName, 
                           u.Phone AS MemberPhone,
                           COALESCE(pt.DisplayName, pt.FullName) AS PTDisplayName, 
                           pkg.PackageName, 
                           pkg.NumberOfSessions, 
                           r.PreferredStartDate, 
                           r.TotalAmount,
                           r.PurchasedSessions,
                           r.PaymentStatus,
                           pt.PTID,
                           r.MemberID
                    FROM PTRegistrations r
                    INNER JOIN Members m ON r.MemberID = m.MemberID
                    INNER JOIN Users u ON m.UserID = u.UserID
                    INNER JOIN PTServicePrices sp ON r.PTServicePriceID = sp.PTServicePriceID
                    INNER JOIN PersonalTrainers pt ON sp.PTID = pt.PTID
                    INNER JOIN PTPackageTypes pkg ON sp.PTPackageTypeID = pkg.PTPackageTypeID
                    WHERE r.Status = 'Pending' AND r.IsDeleted = 0
                    ORDER BY r.CreatedDate ASC
                """;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                PTRegistrationDTO dto = new PTRegistrationDTO();
                dto.setPtRegistrationId(rs.getInt("PTRegistrationID"));
                dto.setMemberName(rs.getString("MemberName"));
                dto.setMemberPhone(rs.getString("MemberPhone"));
                dto.setPtDisplayName(rs.getString("PTDisplayName"));
                dto.setPackageName(rs.getString("PackageName"));
                dto.setNumberOfSessions(rs.getInt("NumberOfSessions"));
                dto.setPurchasedSessions(rs.getInt("PurchasedSessions"));
                dto.setPaymentStatus(rs.getString("PaymentStatus"));
                dto.setPtId(rs.getInt("PTID"));
                dto.setMemberId(rs.getInt("MemberID"));

                if (rs.getDate("PreferredStartDate") != null) {
                    dto.setPreferredStartDate(rs.getDate("PreferredStartDate").toLocalDate());
                }

                dto.setTotalAmount(rs.getDouble("TotalAmount"));
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }    @Override
    public PTRegistrationDTO getRegistrationById(int regId) {
        String sql = """
                    SELECT r.PTRegistrationID, 
                           pt.PTID,
                           r.MemberID,
                           u.DisplayName AS MemberName, 
                           u.Phone AS MemberPhone,
                           COALESCE(pt.DisplayName, pt.FullName) AS PTDisplayName, 
                           pkg.PackageName, 
                           pkg.NumberOfSessions, 
                           r.PreferredStartDate, 
                           r.TotalAmount,
                           r.Note,
                           pt.Status AS PTStatus,
                           CASE 
                                WHEN r.Status = 'Active' AND r.EndDate < CAST(GETDATE() AS Date) THEN 'Completed'
                                ELSE r.Status
                           END AS Status,
                           r.PaymentStatus,
                           r.EndDate,
                           r.PurchasedSessions
                    FROM PTRegistrations r
                    INNER JOIN Members m ON r.MemberID = m.MemberID
                    INNER JOIN Users u ON m.UserID = u.UserID
                    INNER JOIN PTServicePrices sp ON r.PTServicePriceID = sp.PTServicePriceID
                    INNER JOIN PersonalTrainers pt ON sp.PTID = pt.PTID
                    INNER JOIN PTPackageTypes pkg ON sp.PTPackageTypeID = pkg.PTPackageTypeID
                    WHERE r.PTRegistrationID = ? AND r.IsDeleted = 0
                """;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, regId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    PTRegistrationDTO dto = new PTRegistrationDTO();
                    dto.setPtRegistrationId(rs.getInt("PTRegistrationID"));

                    dto.setPtId(rs.getInt("PTID"));
                    dto.setMemberId(rs.getInt("MemberID"));
                    dto.setMemberName(rs.getString("MemberName"));
                    dto.setMemberPhone(rs.getString("MemberPhone"));
                    dto.setPtDisplayName(rs.getString("PTDisplayName"));
                    dto.setPackageName(rs.getString("PackageName"));
                    dto.setNumberOfSessions(rs.getInt("NumberOfSessions"));
                    if (rs.getDate("PreferredStartDate") != null) {
                        dto.setPreferredStartDate(rs.getDate("PreferredStartDate").toLocalDate());
                    }
                    dto.setTotalAmount(rs.getDouble("TotalAmount"));
                    dto.setNote(rs.getString("Note"));
                    dto.setPtStatus(rs.getString("PTStatus"));
                    dto.setStatus(rs.getString("Status"));
                    dto.setPaymentStatus(rs.getString("PaymentStatus"));
                    dto.setPurchasedSessions(rs.getInt("PurchasedSessions"));
                    if (rs.getDate("EndDate") != null) {
                        dto.setEndDate(rs.getDate("EndDate").toLocalDate());
                    }
                    return dto;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean updateRegistrationAndPaymentStatus(int regId, String status, String paymentStatus) {
        String sql = "UPDATE PTRegistrations SET Status = ?, PaymentStatus = ? WHERE PTRegistrationID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, paymentStatus);
            ps.setInt(3, regId);

            int rowsAffected = ps.executeUpdate();
            System.out.println("DEBUG - Đã update " + rowsAffected + " đơn đăng ký (regId=" + regId + ")");
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi SQL khi Update trạng thái đơn: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean cancelRegistration(int regId, String cancelReason, int processedByUserId, String updatedBy) {
        String sql = """
                    UPDATE PTRegistrations
                    SET Status = 'Cancelled',
                        PaymentStatus = 'Cancelled',
                        Note = CASE 
                            WHEN Note IS NULL OR Note = '' THEN ?
                            ELSE CONCAT(Note, ' | Lý do hủy: ', ?)
                        END,
                        ProcessedByUserID = ?,
                        ProcessedAt = SYSDATETIME(),
                        UpdatedBy = ?,
                        UpdatedDate = SYSDATETIME()
                    WHERE PTRegistrationID = ?
                      AND IsDeleted = 0
                """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "Lý do hủy: " + cancelReason);
            ps.setString(2, cancelReason);
            ps.setInt(3, processedByUserId);
            ps.setString(4, updatedBy);
            ps.setInt(5, regId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<PTServicePrice> getAllServicePricesByTrainerId(int ptId) {
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
                      AND sp.IsDeleted = 0
                      AND pkg.IsDeleted = 0
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

    @Override
    public boolean saveOrUpdateServicePrice(PTServicePrice price) {
        String checkSql = "SELECT PTServicePriceID FROM PTServicePrices WHERE PTID = ? AND PTPackageTypeID = ? AND IsDeleted = 0";
        String insertSql = """
            INSERT INTO PTServicePrices (PTID, PTPackageTypeID, Price, Status, CreatedBy, CreatedDate, IsDeleted)
            VALUES (?, ?, ?, 'Active', 'System', GETDATE(), 0)
        """;
        String updateSql = """
            UPDATE PTServicePrices
            SET Price = ?, Status = 'Active', UpdatedBy = 'System', UpdatedDate = GETDATE()
            WHERE PTServicePriceID = ?
        """;

        try (Connection conn = DBContext.getConnection()) {
            int existingId = -1;
            try (PreparedStatement checkPs = conn.prepareStatement(checkSql)) {
                checkPs.setInt(1, price.getPtId());
                checkPs.setInt(2, price.getPtPackageTypeId());
                try (ResultSet rs = checkPs.executeQuery()) {
                    if (rs.next()) {
                        existingId = rs.getInt("PTServicePriceID");
                    }
                }
            }

            if (existingId != -1) {
                try (PreparedStatement updatePs = conn.prepareStatement(updateSql)) {
                    updatePs.setBigDecimal(1, price.getPrice());
                    updatePs.setInt(2, existingId);
                    return updatePs.executeUpdate() > 0;
                }
            } else {
                try (PreparedStatement insertPs = conn.prepareStatement(insertSql)) {
                    insertPs.setInt(1, price.getPtId());
                    insertPs.setInt(2, price.getPtPackageTypeId());
                    insertPs.setBigDecimal(3, price.getPrice());
                    return insertPs.executeUpdate() > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<PTRegistrationDTO> getProcessedRegistrations(int page, int pageSize) {
        List<PTRegistrationDTO> list = new ArrayList<>();
        String sql = """
                    SELECT r.PTRegistrationID, 
                           u.DisplayName AS MemberName, 
                           u.Phone AS MemberPhone,
                           COALESCE(pt.DisplayName, pt.FullName) AS PTDisplayName, 
                           pkg.PackageName, 
                           pkg.NumberOfSessions, 
                           r.PreferredStartDate, 
                           r.TotalAmount,
                           CASE 
                                WHEN r.Status = 'Active' AND r.EndDate < CAST(GETDATE() AS Date) THEN 'Completed'
                                ELSE r.Status
                            END AS Status,
                           r.PaymentStatus,
                           r.Note,
                           r.ProcessedAt,
                           u_proc.DisplayName AS ProcessedByUserName,
                           r.EndDate,
                           r.PurchasedSessions
                    FROM PTRegistrations r
                    INNER JOIN Members m ON r.MemberID = m.MemberID
                    INNER JOIN Users u ON m.UserID = u.UserID
                    INNER JOIN PTServicePrices sp ON r.PTServicePriceID = sp.PTServicePriceID
                    INNER JOIN PersonalTrainers pt ON sp.PTID = pt.PTID
                    INNER JOIN PTPackageTypes pkg ON sp.PTPackageTypeID = pkg.PTPackageTypeID
                    LEFT JOIN Users u_proc ON r.ProcessedByUserID = u_proc.UserID
                    WHERE r.Status <> 'Pending' AND r.IsDeleted = 0
                    ORDER BY r.ProcessedAt DESC, r.PTRegistrationID DESC
                    OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
                """;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PTRegistrationDTO dto = new PTRegistrationDTO();
                    dto.setPtRegistrationId(rs.getInt("PTRegistrationID"));
                    dto.setMemberName(rs.getString("MemberName"));
                    dto.setMemberPhone(rs.getString("MemberPhone"));
                    dto.setPtDisplayName(rs.getString("PTDisplayName"));
                    dto.setPackageName(rs.getString("PackageName"));
                    dto.setNumberOfSessions(rs.getInt("NumberOfSessions"));
                    dto.setPurchasedSessions(rs.getInt("PurchasedSessions"));
                    if (rs.getDate("PreferredStartDate") != null) {
                        dto.setPreferredStartDate(rs.getDate("PreferredStartDate").toLocalDate());
                    }
                    dto.setTotalAmount(rs.getDouble("TotalAmount"));
                    dto.setStatus(rs.getString("Status"));
                    dto.setPaymentStatus(rs.getString("PaymentStatus"));
                    dto.setNote(rs.getString("Note"));
                    if (rs.getTimestamp("ProcessedAt") != null) {
                        dto.setProcessedAt(rs.getTimestamp("ProcessedAt").toLocalDateTime());
                    }
                    dto.setProcessedByUserName(rs.getString("ProcessedByUserName"));
                    if (rs.getDate("EndDate") != null) {
                        dto.setEndDate(rs.getDate("EndDate").toLocalDate());
                    }
                    list.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int getProcessedRegistrationsCount() {
        String sql = "SELECT COUNT(*) FROM PTRegistrations WHERE Status <> 'Pending' AND IsDeleted = 0";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public boolean deleteRegistrationPermanent(int regId) {
        String sql = "UPDATE PTRegistrations SET IsDeleted = 1, UpdatedDate = SYSDATETIME() WHERE PTRegistrationID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, regId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<PTRegistrationDTO> getActivePaidRegistrationsWithoutScheduleByPT(int ptId) {
        List<PTRegistrationDTO> list = new ArrayList<>();
        String sql = """
                    SELECT r.PTRegistrationID, 
                           u.DisplayName AS MemberName, 
                           u.Phone AS MemberPhone,
                           COALESCE(pt.DisplayName, pt.FullName) AS PTDisplayName, 
                           pkg.PackageName, 
                           pkg.NumberOfSessions, 
                           r.PreferredStartDate, 
                           r.TotalAmount,
                           r.PurchasedSessions,
                           r.PaymentStatus,
                           pt.PTID,
                           r.MemberID
                    FROM PTRegistrations r
                    INNER JOIN Members m ON r.MemberID = m.MemberID
                    INNER JOIN Users u ON m.UserID = u.UserID
                    INNER JOIN PTServicePrices sp ON r.PTServicePriceID = sp.PTServicePriceID
                    INNER JOIN PersonalTrainers pt ON sp.PTID = pt.PTID
                    INNER JOIN PTPackageTypes pkg ON sp.PTPackageTypeID = pkg.PTPackageTypeID
                    WHERE r.Status = 'Active' 
                      AND r.PaymentStatus = 'Paid' 
                      AND sp.PTID = ? 
                      AND r.IsDeleted = 0
                      AND NOT EXISTS (
                          SELECT 1 FROM PTSchedules s 
                          WHERE s.PTRegistrationID = r.PTRegistrationID 
                            AND s.IsDeleted = 0
                      )
                    ORDER BY r.CreatedDate ASC
                """;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ptId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PTRegistrationDTO dto = new PTRegistrationDTO();
                    dto.setPtRegistrationId(rs.getInt("PTRegistrationID"));
                    dto.setMemberName(rs.getString("MemberName"));
                    dto.setMemberPhone(rs.getString("MemberPhone"));
                    dto.setPtDisplayName(rs.getString("PTDisplayName"));
                    dto.setPackageName(rs.getString("PackageName"));
                    dto.setNumberOfSessions(rs.getInt("NumberOfSessions"));
                    dto.setPurchasedSessions(rs.getInt("PurchasedSessions"));
                    dto.setPaymentStatus(rs.getString("PaymentStatus"));
                    dto.setPtId(rs.getInt("PTID"));
                    dto.setMemberId(rs.getInt("MemberID"));

                    if (rs.getDate("PreferredStartDate") != null) {
                        dto.setPreferredStartDate(rs.getDate("PreferredStartDate").toLocalDate());
                    }

                    dto.setTotalAmount(rs.getDouble("TotalAmount"));
                    list.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int countSchedulesByRegistration(int regId) {
        String sql = "SELECT COUNT(*) FROM PTSchedules WHERE PTRegistrationID = ? AND IsDeleted = 0";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, regId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public boolean updateActualDates(int regId, LocalDate startDate, LocalDate endDate) {
        String sql = "UPDATE PTRegistrations SET StartDate = ?, EndDate = ? WHERE PTRegistrationID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, java.sql.Date.valueOf(startDate));
            ps.setDate(2, java.sql.Date.valueOf(endDate));
            ps.setInt(3, regId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<PTRegistrationDTO> getPTRegistrationsWithProgress(int ptId) {
        List<PTRegistrationDTO> list = new ArrayList<>();
        String sql = """
                    SELECT r.PTRegistrationID, 
                           u.DisplayName AS MemberName, 
                           u.Phone AS MemberPhone,
                           pkg.PackageName, 
                           r.PurchasedSessions,
                           r.StartDate, 
                           r.EndDate,
                           (SELECT COUNT(*) FROM PTSchedules s WHERE s.PTRegistrationID = r.PTRegistrationID AND s.SessionStatus = 'Upcoming' AND s.IsDeleted = 0) AS UpcomingCount,
                           (SELECT COUNT(*) FROM PTSchedules s WHERE s.PTRegistrationID = r.PTRegistrationID AND s.SessionStatus = 'Completed' AND s.IsDeleted = 0) AS CompletedCount,
                           (SELECT COUNT(*) FROM PTSchedules s WHERE s.PTRegistrationID = r.PTRegistrationID AND s.SessionStatus = 'Cancelled' AND s.IsDeleted = 0) AS CancelledCount
                    FROM PTRegistrations r
                    INNER JOIN Members m ON r.MemberID = m.MemberID
                    INNER JOIN Users u ON m.UserID = u.UserID
                    INNER JOIN PTServicePrices sp ON r.PTServicePriceID = sp.PTServicePriceID
                    INNER JOIN PTPackageTypes pkg ON sp.PTPackageTypeID = pkg.PTPackageTypeID
                    WHERE sp.PTID = ? 
                      AND r.Status = 'Active' 
                      AND r.PaymentStatus = 'Paid'
                      AND r.IsDeleted = 0
                      AND EXISTS (
                          SELECT 1 FROM PTSchedules s 
                          WHERE s.PTRegistrationID = r.PTRegistrationID 
                            AND s.IsDeleted = 0
                      )
                    ORDER BY r.CreatedDate DESC
                """;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ptId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PTRegistrationDTO dto = new PTRegistrationDTO();
                    dto.setPtRegistrationId(rs.getInt("PTRegistrationID"));
                    dto.setMemberName(rs.getString("MemberName"));
                    dto.setMemberPhone(rs.getString("MemberPhone"));
                    dto.setPackageName(rs.getString("PackageName"));
                    dto.setPurchasedSessions(rs.getInt("PurchasedSessions"));
                    
                    if (rs.getDate("StartDate") != null) {
                        dto.setStartDate(rs.getDate("StartDate").toLocalDate());
                    }
                    if (rs.getDate("EndDate") != null) {
                        dto.setEndDate(rs.getDate("EndDate").toLocalDate());
                    }
                    
                    dto.setUpcomingCount(rs.getInt("UpcomingCount"));
                    dto.setCompletedCount(rs.getInt("CompletedCount"));
                    dto.setCancelledCount(rs.getInt("CancelledCount"));
                    
                    list.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
