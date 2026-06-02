/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.PTRegistration;
import model.PTServicePrice;

/**
 *
 * @author phuga
 */
public class PTRegistrationDAO extends DBContext {

    public PTServicePrice findServicePriceById(int ptServicePriceId) {
        String sql = """
            SELECT
                sp.PTServicePriceID,
                sp.PTID,
                sp.PTPackageTypeID,
                sp.Price,
                sp.Status AS PriceStatus,
                pkg.PackageName,
                pkg.Description AS PackageDescription,
                pkg.DurationMonths,
                pkg.NumberOfSessions
            FROM PTServicePrices sp
            JOIN PTPackageTypes pkg
                ON sp.PTPackageTypeID = pkg.PTPackageTypeID
            WHERE sp.PTServicePriceID = ?
              AND sp.Status = 'Active'
              AND sp.IsDeleted = 0
              AND pkg.Status = 'Active'
              AND pkg.IsDeleted = 0
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ptServicePriceId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    PTServicePrice price = new PTServicePrice();

                    price.setPtServicePriceId(rs.getInt("PTServicePriceID"));
                    price.setPtId(rs.getInt("PTID"));
                    price.setPtPackageTypeId(rs.getInt("PTPackageTypeID"));
                    price.setPrice(rs.getBigDecimal("Price"));
                    price.setStatus(rs.getString("PriceStatus"));

                    price.setPackageName(rs.getString("PackageName"));
                    price.setPackageDescription(rs.getString("PackageDescription"));

                    int durationMonths = rs.getInt("DurationMonths");
                    price.setDurationMonths(rs.wasNull() ? null : durationMonths);

                    int numberOfSessions = rs.getInt("NumberOfSessions");
                    price.setNumberOfSessions(rs.wasNull() ? null : numberOfSessions);

                    return price;
                }
            }

        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi lấy thông tin gói PT", e);
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
                Status,
                Note,
                CreatedBy,
                CreatedDate,
                UpdatedBy,
                UpdatedDate,
                IsDeleted
            )
            VALUES (
                ?, ?, ?, ?, ?, 
                'Pending',
                ?, 
                'System',
                SYSDATETIME(),
                NULL,
                NULL,
                0
            )
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, registration.getMemberId());
            ps.setInt(2, registration.getPtServicePriceId());

            ps.setDate(3, java.sql.Date.valueOf(registration.getPreferredStartDate()));
            ps.setDate(4, java.sql.Date.valueOf(registration.getStartDate()));
            ps.setDate(5, java.sql.Date.valueOf(registration.getEndDate()));

            ps.setString(6, registration.getNote());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi đăng ký gói PT", e);
        }
    }
}
