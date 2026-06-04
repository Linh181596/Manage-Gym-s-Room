/**
 * =========================================================================
 * @file          : EquipmentService.java
 * @description   : Lớp xử lý logic nghiệp vụ quản lý thiết bị phòng gym và báo cáo sự cố.
 * @author        : Đào Minh Hoàng (hoangdm)
 * @created       : 2026-06-04
 * @last_modified : 2026-06-04 bởi Đào Minh Hoàng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.dao.EquipmentDAO;
import com.mycompany.gymcentermanagement.dao.EquipmentIssueDAO;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import com.mycompany.gymcentermanagement.model.entity.Equipment;
import com.mycompany.gymcentermanagement.model.entity.EquipmentIssue;
import com.mycompany.gymcentermanagement.utils.DBContext;

public class EquipmentService {
    public static final String STATUS_AVAILABLE = "Available";
    public static final String STATUS_MAINTENANCE = "Maintenance";
    public static final String STATUS_BROKEN = "Broken";
    public static final String TYPE_CARDIO = "Cardio";
    public static final String TYPE_STRENGTH = "Ta";
    public static final String TYPE_MACHINE = "May keo";
    public static final String TYPE_ACCESSORY = "Phu kien";
    public static final String TYPE_OTHER = "Khac";
    public static final String ISSUE_PENDING = "Pending";
    public static final String ISSUE_IN_PROGRESS = "InProgress";
    public static final String ISSUE_RESOLVED = "Resolved";

    private final EquipmentDAO equipmentDAO = new EquipmentDAO();
    private final EquipmentIssueDAO issueDAO = new EquipmentIssueDAO();

    public List<Equipment> searchEquipments(String keyword, String status, String type) throws SQLException {
        return equipmentDAO.search(keyword, normalizeBlank(status), normalizeBlank(type));
    }

    public List<Equipment> searchEquipments(String keyword, String status, String type, int offset, int pageSize) throws SQLException {
        return equipmentDAO.search(keyword, normalizeBlank(status), normalizeBlank(type), offset, pageSize);
    }

    public int countEquipments(String keyword, String status, String type) throws SQLException {
        return equipmentDAO.countSearch(normalizeBlank(keyword), normalizeBlank(status), normalizeBlank(type));
    }

    public Equipment getEquipment(int id) throws SQLException {
        return equipmentDAO.findById(id);
    }

    public int saveEquipment(Equipment equipment) throws SQLException {
        validateEquipment(equipment);
        if (equipment.getEquipmentId() > 0) {
            equipmentDAO.update(equipment);
            return equipment.getEquipmentId();
        }
        return equipmentDAO.create(equipment);
    }

    public boolean deleteEquipment(int id, String updatedBy) throws SQLException {
        return equipmentDAO.softDelete(id, updatedBy);
    }

    public List<EquipmentIssue> searchIssues(String keyword, String status) throws SQLException {
        return issueDAO.search(keyword, normalizeBlank(status));
    }

    public List<EquipmentIssue> searchIssues(String keyword, String status, int offset, int pageSize) throws SQLException {
        return issueDAO.search(keyword, normalizeBlank(status), offset, pageSize);
    }

    public int countIssues(String keyword, String status) throws SQLException {
        return issueDAO.countSearch(normalizeBlank(keyword), normalizeBlank(status));
    }

    public EquipmentIssue getIssue(int id) throws SQLException {
        return issueDAO.findById(id);
    }

    public int createIssue(EquipmentIssue issue) throws SQLException {
        validateIssueForCreate(issue);
        issue.setStatus(ISSUE_PENDING);
        try (Connection connection = DBContext.getConnection()) {
            boolean oldAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);
            try {
                int id = issueDAO.create(connection, issue);
                equipmentDAO.updateStatus(connection, issue.getEquipmentId(), equipmentStatusForIssue(issue.getStatus()), issue.getCreatedBy());
                connection.commit();
                return id;
            } catch (SQLException ex) {
                connection.rollback();
                throw ex;
            } finally {
                connection.setAutoCommit(oldAutoCommit);
            }
        }
    }

    public boolean updateIssueStatus(int issueId, String status, String updatedBy) throws SQLException {
        if (!isValidIssueStatus(status)) {
            throw new IllegalArgumentException("Issue status is invalid.");
        }
        try (Connection connection = DBContext.getConnection()) {
            boolean oldAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);
            try {
                EquipmentIssue issue = issueDAO.findById(connection, issueId);
                if (issue == null) {
                    connection.rollback();
                    return false;
                }
                boolean updated = issueDAO.updateStatus(connection, issueId, status, updatedBy);
                equipmentDAO.updateStatus(connection, issue.getEquipmentId(), equipmentStatusForIssue(status), updatedBy);
                connection.commit();
                return updated;
            } catch (SQLException ex) {
                connection.rollback();
                throw ex;
            } finally {
                connection.setAutoCommit(oldAutoCommit);
            }
        }
    }

    public boolean updateIssue(EquipmentIssue issue, String updatedBy) throws SQLException {
        validateIssueForUpdate(issue);
        issue.setUpdatedBy(updatedBy);
        try (Connection connection = DBContext.getConnection()) {
            boolean oldAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);
            try {
                boolean updated = issueDAO.update(connection, issue);
                if (updated) {
                    equipmentDAO.updateStatus(connection, issue.getEquipmentId(), equipmentStatusForIssue(issue.getStatus()), updatedBy);
                }
                connection.commit();
                return updated;
            } catch (SQLException ex) {
                connection.rollback();
                throw ex;
            } finally {
                connection.setAutoCommit(oldAutoCommit);
            }
        }
    }

    public ReportData buildReport() throws SQLException {
        return createReport(equipmentDAO.findWithIssueCounts());
    }

    public ReportData buildReport(int offset, int pageSize) throws SQLException {
        return createReport(equipmentDAO.findWithIssueCounts(offset, pageSize));
    }

    private ReportData createReport(List<Equipment> reportEquipments) throws SQLException {
        Map<String, Integer> equipmentCounts = equipmentDAO.countByStatus();
        Map<String, Integer> issueCounts = issueDAO.countByStatus();
        return new ReportData(
                equipmentCounts,
                issueCounts,
                reportEquipments,
                issueDAO.findRecent(10)
        );
    }

    public int countReportEquipments() throws SQLException {
        return equipmentDAO.countActiveEquipments();
    }

    public List<Equipment> findEquipmentOptions() throws SQLException {
        return equipmentDAO.findAllActive();
    }

    private void validateEquipment(Equipment equipment) {
        if (isBlank(equipment.getEquipmentCode())) {
            throw new IllegalArgumentException("Equipment code is required.");
        }
        if (isBlank(equipment.getEquipmentName())) {
            throw new IllegalArgumentException("Equipment name is required.");
        }
        if (equipment.getPurchaseDate() == null) {
            throw new IllegalArgumentException("Purchase date is required.");
        }
        if (equipment.getWarrantyDate() == null) {
            throw new IllegalArgumentException("Warranty date is required.");
        }
        if (equipment.getWarrantyDate().isBefore(equipment.getPurchaseDate())) {
            throw new IllegalArgumentException("Warranty date must not be before purchase date.");
        }
        if (isBlank(equipment.getLocation())) {
            throw new IllegalArgumentException("Location is required.");
        }
        if (isBlank(equipment.getImageUrl())) {
            throw new IllegalArgumentException("Equipment image is required.");
        }
        if (!isValidEquipmentType(equipment.getEquipmentType())) {
            throw new IllegalArgumentException("Equipment type is invalid.");
        }
        if (!isValidEquipmentStatus(equipment.getStatus())) {
            throw new IllegalArgumentException("Equipment status is invalid.");
        }
    }

    private void validateIssueForCreate(EquipmentIssue issue) {
        if (issue.getEquipmentId() <= 0) {
            throw new IllegalArgumentException("Equipment is required.");
        }
        if (issue.getReportedBy() <= 0) {
            throw new IllegalArgumentException("Reporter is required.");
        }
        if (isBlank(issue.getCreatedBy())) {
            throw new IllegalArgumentException("Reporter name is required.");
        }
        if (isBlank(issue.getIssueType())) {
            throw new IllegalArgumentException("Issue type is required.");
        }
    }

    private void validateIssueForUpdate(EquipmentIssue issue) {
        if (issue.getIssueId() <= 0) {
            throw new IllegalArgumentException("Issue is required.");
        }
        validateIssueForCreate(issue);
        if (!isValidIssueStatus(issue.getStatus())) {
            throw new IllegalArgumentException("Issue status is invalid.");
        }
    }

    private boolean isValidEquipmentStatus(String status) {
        return STATUS_AVAILABLE.equals(status) || STATUS_MAINTENANCE.equals(status) || STATUS_BROKEN.equals(status);
    }

    private boolean isValidEquipmentType(String type) {
        return TYPE_CARDIO.equals(type) || TYPE_STRENGTH.equals(type) || TYPE_MACHINE.equals(type)
                || TYPE_ACCESSORY.equals(type) || TYPE_OTHER.equals(type);
    }

    private boolean isValidIssueStatus(String status) {
        return ISSUE_PENDING.equals(status) || ISSUE_IN_PROGRESS.equals(status) || ISSUE_RESOLVED.equals(status);
    }

    private String equipmentStatusForIssue(String issueStatus) {
        if (ISSUE_RESOLVED.equals(issueStatus)) {
            return STATUS_AVAILABLE;
        }
        if (ISSUE_IN_PROGRESS.equals(issueStatus)) {
            return STATUS_MAINTENANCE;
        }
        return STATUS_BROKEN;
    }

    private String normalizeBlank(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }

    private boolean isBlank(String value) {
        return value == null || value.isBlank();
    }

    public static class ReportData {
        private final Map<String, Integer> equipmentCounts;
        private final Map<String, Integer> issueCounts;
        private final List<Equipment> equipments;
        private final List<EquipmentIssue> recentIssues;

        public ReportData(Map<String, Integer> equipmentCounts, Map<String, Integer> issueCounts,
                List<Equipment> equipments, List<EquipmentIssue> recentIssues) {
            this.equipmentCounts = new HashMap<>(equipmentCounts);
            this.issueCounts = new HashMap<>(issueCounts);
            this.equipments = equipments;
            this.recentIssues = recentIssues;
        }

        public int getTotalEquipment() {
            return getAvailable() + getMaintenance() + getBroken();
        }

        public int getAvailable() {
            return equipmentCounts.getOrDefault(STATUS_AVAILABLE, 0);
        }

        public int getMaintenance() {
            return equipmentCounts.getOrDefault(STATUS_MAINTENANCE, 0);
        }

        public int getBroken() {
            return equipmentCounts.getOrDefault(STATUS_BROKEN, 0);
        }

        public int getTotalIssues() {
            return getPendingIssues() + getInProgressIssues() + getResolvedIssues();
        }

        public double getActiveRatePercent() {
            if (getTotalEquipment() == 0) {
                return 0;
            }
            return Math.round((getAvailable() * 1000.0) / getTotalEquipment()) / 10.0;
        }

        public String getActiveRateDisplay() {
            double rate = getActiveRatePercent();
            if (rate == Math.rint(rate)) {
                return String.valueOf((int) rate);
            }
            return String.format(Locale.US, "%.1f", rate);
        }

        public int getPendingIssues() {
            return issueCounts.getOrDefault(ISSUE_PENDING, 0);
        }

        public int getInProgressIssues() {
            return issueCounts.getOrDefault(ISSUE_IN_PROGRESS, 0);
        }

        public int getResolvedIssues() {
            return issueCounts.getOrDefault(ISSUE_RESOLVED, 0);
        }

        public List<Equipment> getEquipments() {
            return equipments;
        }

        public List<EquipmentIssue> getRecentIssues() {
            return recentIssues;
        }
    }
}
