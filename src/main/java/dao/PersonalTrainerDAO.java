/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.PTServicePrice;
import model.PersonalTrainer;

/**
 *
 * @author phuga
 */
public class PersonalTrainerDAO extends DBContext {

    public List<PersonalTrainer> findActiveTrainers() {
        String sql = """
        SELECT
            pt.PTID,
            pt.UserID,
            pt.ApplicationID,
            pt.Specialization,
            pt.ExperienceYears,
            pt.Description,
            pt.Status,
            u.DisplayName,
            u.Email,
            u.Phone
        FROM PersonalTrainers pt
        JOIN Users u ON pt.UserID = u.UserID
        WHERE pt.Status = 'Active'
          AND pt.IsDeleted = 0
          AND u.IsDeleted = 0
        ORDER BY pt.PTID
    """;

        List<PersonalTrainer> trainers = new ArrayList<>();

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                PersonalTrainer trainer = mapTrainer(rs);
                trainer.setServicePrices(findServicePricesByPTId(trainer.getPtId()));
                trainers.add(trainer);
            }

        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi lấy danh sách PT", e);
        }

        return trainers;
    }

    public List<PersonalTrainer> findActiveTrainersBySpecializations(List<String> specializations) {
        if (specializations == null || specializations.isEmpty()) {
            return findActiveTrainers();
        }

        StringBuilder placeholders = new StringBuilder();

        for (int i = 0; i < specializations.size(); i++) {
            if (i > 0) {
                placeholders.append(", ");
            }
            placeholders.append("?");
        }

        String sql = """
        SELECT
            pt.PTID,
            pt.UserID,
            pt.ApplicationID,
            pt.Specialization,
            pt.ExperienceYears,
            pt.Description,
            pt.Status,
            u.DisplayName,
            u.Email,
            u.Phone
        FROM PersonalTrainers pt
        JOIN Users u ON pt.UserID = u.UserID
        WHERE pt.Status = 'Active'
          AND pt.IsDeleted = 0
          AND u.IsDeleted = 0
          AND pt.Specialization IN (%s)
        ORDER BY pt.PTID
    """.formatted(placeholders.toString());

        List<PersonalTrainer> trainers = new ArrayList<>();

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int i = 0; i < specializations.size(); i++) {
                ps.setString(i + 1, specializations.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PersonalTrainer trainer = mapTrainer(rs);
                    trainer.setServicePrices(findServicePricesByPTId(trainer.getPtId()));
                    trainers.add(trainer);
                }
            }

        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi lọc danh sách PT theo chuyên môn", e);
        }

        return trainers;
    }

    public PersonalTrainer findById(int ptId) {
        String sql = """
        SELECT
            pt.PTID,
            pt.UserID,
            pt.ApplicationID,
            pt.Specialization,
            pt.ExperienceYears,
            pt.Description,
            pt.Status,
            u.DisplayName,
            u.Email,
            u.Phone
        FROM PersonalTrainers pt
        JOIN Users u ON pt.UserID = u.UserID
        WHERE pt.PTID = ?
          AND pt.Status = 'Active'
          AND pt.IsDeleted = 0
          AND u.IsDeleted = 0
    """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ptId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    PersonalTrainer trainer = mapTrainer(rs);
                    trainer.setServicePrices(findServicePricesByPTId(ptId));
                    return trainer;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    private List<PTServicePrice> findServicePricesByPTId(int ptId) {
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
        WHERE sp.PTID = ?
          AND sp.Status = 'Active'
          AND sp.IsDeleted = 0
          AND pkg.Status = 'Active'
          AND pkg.IsDeleted = 0
        ORDER BY pkg.DurationMonths
    """;

        List<PTServicePrice> prices = new ArrayList<>();

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ptId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    prices.add(mapServicePrice(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return prices;
    }

    private PersonalTrainer mapTrainer(ResultSet rs) throws SQLException {
        PersonalTrainer trainer = new PersonalTrainer();

        trainer.setPtId(rs.getInt("PTID"));
        trainer.setUserId(rs.getInt("UserID"));

        int applicationId = rs.getInt("ApplicationID");
        trainer.setApplicationId(rs.wasNull() ? null : applicationId);

        trainer.setDisplayName(rs.getString("DisplayName"));
        trainer.setEmail(rs.getString("Email"));
        trainer.setPhone(rs.getString("Phone"));

        trainer.setSpecialization(rs.getString("Specialization"));

        int experienceYears = rs.getInt("ExperienceYears");
        trainer.setExperienceYears(rs.wasNull() ? null : experienceYears);

        trainer.setDescription(rs.getString("Description"));
        trainer.setStatus(rs.getString("Status"));

        return trainer;
    }

    private PTServicePrice mapServicePrice(ResultSet rs) throws SQLException {
        PTServicePrice price = new PTServicePrice();

        price.setPtServicePriceId(rs.getInt("PTServicePriceID"));
        price.setPtId(rs.getInt("PTID"));
        price.setPtPackageTypeId(rs.getInt("PTPackageTypeID"));

        price.setPackageName(rs.getString("PackageName"));
        price.setPackageDescription(rs.getString("PackageDescription"));

        int durationMonths = rs.getInt("DurationMonths");
        price.setDurationMonths(rs.wasNull() ? null : durationMonths);

        int numberOfSessions = rs.getInt("NumberOfSessions");
        price.setNumberOfSessions(rs.wasNull() ? null : numberOfSessions);

        price.setPrice(rs.getBigDecimal("Price"));
        price.setStatus(rs.getString("PriceStatus"));

        return price;
    }
}
