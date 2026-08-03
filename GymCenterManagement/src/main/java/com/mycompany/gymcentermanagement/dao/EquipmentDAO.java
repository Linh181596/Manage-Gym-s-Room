/**
 * =========================================================================
 * @file          : EquipmentDAO.java
 * @description   : Lớp truy cập dữ liệu để quản lý thông tin thiết bị và dụng cụ phòng gym.
 * @author        : Đỗ Minh Hoàng (hoangdm)
 * @created       : 2026-06-04
 * @last_modified : 2026-06-04 bởi Đỗ Minh Hoàng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.mycompany.gymcentermanagement.model.entity.Equipment;
import com.mycompany.gymcentermanagement.utils.DBContext;

public class EquipmentDAO {
    /**
     * SQL trong hàm này dùng để lấy toàn bộ thiết bị chưa xóa mềm theo bộ lọc, không giới hạn phân trang thực tế.
     */
    public List<Equipment> search(String keyword, String status, String type) throws SQLException {
        return search(keyword, status, type, 0, Integer.MAX_VALUE);
    }

    /**
     * SQL trong hàm này dùng để tìm thiết bị chưa xóa mềm theo từ khóa, trạng thái, loại thiết bị và phân trang.
     */
    public List<Equipment> search(String keyword, String status, String type, int offset, int limit) throws SQLException {
        ensureEquipmentTypeColumn();
        StringBuilder sql = new StringBuilder("SELECT * FROM Equipments WHERE IsDeleted = 0");
        List<Object> params = new ArrayList<>();
        appendSearchFilters(sql, params, keyword, status, type);
        sql.append(" ORDER BY EquipmentID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(Math.max(0, offset));
        params.add(Math.max(1, limit));

        try (Connection connection = DBContext.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql.toString())) {
            bind(statement, params);
            try (ResultSet resultSet = statement.executeQuery()) {
                List<Equipment> items = new ArrayList<>();
                while (resultSet.next()) {
                    items.add(mapEquipment(resultSet));
                }
                return items;
            }
        }
    }

    /**
     * SQL trong hàm này dùng để đếm số thiết bị thỏa điều kiện lọc cho phân trang.
     */
    public int countSearch(String keyword, String status, String type) throws SQLException {
        ensureEquipmentTypeColumn();
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) AS Total FROM Equipments WHERE IsDeleted = 0");
        List<Object> params = new ArrayList<>();
        appendSearchFilters(sql, params, keyword, status, type);
        try (Connection connection = DBContext.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql.toString())) {
            bind(statement, params);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next() ? resultSet.getInt("Total") : 0;
            }
        }
    }

    /**
     * SQL trong hàm này dùng để lấy danh sách thiết bị chưa xóa mềm làm dữ liệu chọn trong form.
     */
    public List<Equipment> findAllActive() throws SQLException {
        return search(null, null, null);
    }

    /**
     * SQL trong hàm này dùng để mở kết nối và lấy chi tiết một thiết bị theo id.
     */
    public Equipment findById(int id) throws SQLException {
        ensureEquipmentTypeColumn();
        try (Connection connection = DBContext.getConnection()) {
            return findById(connection, id);
        }
    }

    /**
     * SQL trong hàm này dùng để lấy chi tiết một thiết bị chưa xóa mềm theo id trên kết nối có sẵn.
     */
    public Equipment findById(Connection connection, int id) throws SQLException {
        String sql = "SELECT * FROM Equipments WHERE EquipmentID = ? AND IsDeleted = 0";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapEquipment(resultSet);
                }
                return null;
            }
        }
    }

    /**
     * SQL trong hàm này dùng để tính lại trạng thái thiết bị dựa trên sự cố mở và lịch bảo trì đang xử lý.
     */
    public String recalculateStatus(Connection connection, int equipmentId, String updatedBy) throws SQLException {
        String statusSql = """
                SELECT CASE
                    WHEN EXISTS (
                        SELECT 1 FROM EquipmentIssues
                        WHERE EquipmentID = ? AND Status = 'Pending' AND IsDeleted = 0
                    ) THEN 'Broken'
                    WHEN EXISTS (
                        SELECT 1 FROM EquipmentIssues
                        WHERE EquipmentID = ? AND Status = 'InProgress' AND IsDeleted = 0
                    ) OR EXISTS (
                        SELECT 1 FROM MaintenanceSchedules
                        WHERE EquipmentID = ? AND Status IN ('InProgress', 'PendingApproval') AND IsDeleted = 0
                    ) THEN 'Maintenance'
                    ELSE 'Available'
                END AS CalculatedStatus
                """;
        String status;
        try (PreparedStatement statement = connection.prepareStatement(statusSql)) {
            statement.setInt(1, equipmentId);
            statement.setInt(2, equipmentId);
            statement.setInt(3, equipmentId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (!resultSet.next()) {
                    throw new SQLException("Unable to calculate equipment status.");
                }
                status = resultSet.getString("CalculatedStatus");
            }
        }
        updateStatus(connection, equipmentId, status, updatedBy);
        return status;
    }

    /**
     * SQL trong hàm này dùng để thêm thiết bị mới và lấy khóa chính vừa sinh.
     */
    public int create(Equipment equipment) throws SQLException {
        ensureEquipmentTypeColumn();
        String sql = """
                INSERT INTO Equipments
                    (EquipmentCode, EquipmentName, EquipmentType, PurchaseDate, WarrantyDate, Location, ImageURL, Status, CreatedBy, CreatedDate, IsDeleted)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATETIME(), 0)
                """;
        try (Connection connection = DBContext.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            fillEquipmentStatement(statement, equipment, false);
            int affected = statement.executeUpdate();
            if (affected == 0) {
                return 0;
            }
            try (ResultSet keys = statement.getGeneratedKeys()) {
                return keys.next() ? keys.getInt(1) : 0;
            }
        }
    }

    /**
     * SQL trong hàm này dùng để cập nhật thông tin thiết bị chưa bị xóa mềm.
     */
    public boolean update(Equipment equipment) throws SQLException {
        ensureEquipmentTypeColumn();
        String sql = """
                UPDATE Equipments
                SET EquipmentCode = ?, EquipmentName = ?, EquipmentType = ?, PurchaseDate = ?, WarrantyDate = ?,
                    Location = ?, ImageURL = ?, Status = ?, UpdatedBy = ?, UpdatedDate = SYSDATETIME()
                WHERE EquipmentID = ? AND IsDeleted = 0
                """;
        try (Connection connection = DBContext.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            fillEquipmentStatement(statement, equipment, true);
            statement.setInt(10, equipment.getEquipmentId());
            return statement.executeUpdate() > 0;
        }
    }

    /**
     * SQL trong hàm này dùng để xóa mềm thiết bị bằng cách đặt IsDeleted = 1.
     */
    public boolean softDelete(int id, String updatedBy) throws SQLException {
        String sql = "UPDATE Equipments SET IsDeleted = 1, UpdatedBy = ?, UpdatedDate = SYSDATETIME() WHERE EquipmentID = ?";
        try (Connection connection = DBContext.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, updatedBy);
            statement.setInt(2, id);
            return statement.executeUpdate() > 0;
        }
    }

    /**
     * SQL trong hàm này dùng để cập nhật trạng thái thiết bị và thời điểm cập nhật.
     */
    public boolean updateStatus(Connection connection, int equipmentId, String status, String updatedBy) throws SQLException {
        String sql = "UPDATE Equipments SET Status = ?, UpdatedBy = ?, UpdatedDate = SYSDATETIME() WHERE EquipmentID = ? AND IsDeleted = 0";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, status);
            statement.setString(2, updatedBy);
            statement.setInt(3, equipmentId);
            return statement.executeUpdate() > 0;
        }
    }

    /**
     * SQL trong hàm này dùng để đếm số thiết bị theo từng trạng thái cho thống kê.
     */
    public Map<String, Integer> countByStatus() throws SQLException {
        ensureEquipmentTypeColumn();
        String sql = "SELECT Status, COUNT(*) AS Total FROM Equipments WHERE IsDeleted = 0 GROUP BY Status";
        Map<String, Integer> counts = new HashMap<>();
        try (Connection connection = DBContext.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                counts.put(resultSet.getString("Status"), resultSet.getInt("Total"));
            }
        }
        return counts;
    }

    /**
     * SQL trong hàm này dùng để lấy danh sách thiết bị kèm số lượng sự cố, không giới hạn phân trang thực tế.
     */
    public List<Equipment> findWithIssueCounts() throws SQLException {
        return findWithIssueCounts(0, Integer.MAX_VALUE);
    }

    /**
     * SQL trong hàm này dùng để lấy thiết bị kèm số lượng sự cố và mã sự cố mới nhất cho bảng báo cáo.
     */
    public List<Equipment> findWithIssueCounts(int offset, int limit) throws SQLException {
        ensureEquipmentTypeColumn();
        String sql = """
                SELECT e.*, COUNT(i.IssueID) AS IssueCount, MAX(i.IssueID) AS LatestIssueID
                FROM Equipments e
                LEFT JOIN EquipmentIssues i ON i.EquipmentID = e.EquipmentID AND i.IsDeleted = 0
                WHERE e.IsDeleted = 0
                GROUP BY e.EquipmentID, e.EquipmentCode, e.EquipmentName, e.EquipmentType, e.PurchaseDate, e.WarrantyDate,
                         e.Location, e.ImageURL, e.Status, e.CreatedBy, e.CreatedDate, e.UpdatedBy, e.UpdatedDate, e.IsDeleted
                ORDER BY e.Status, e.EquipmentName
                OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
                """;
        try (Connection connection = DBContext.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, Math.max(0, offset));
            statement.setInt(2, Math.max(1, limit));
            try (ResultSet resultSet = statement.executeQuery()) {
                List<Equipment> items = new ArrayList<>();
                while (resultSet.next()) {
                    Equipment equipment = mapEquipment(resultSet);
                    equipment.setIssueCount(resultSet.getInt("IssueCount"));
                    equipment.setLatestIssueId(resultSet.getInt("LatestIssueID"));
                    items.add(equipment);
                }
                return items;
            }
        }
    }

    /**
     * SQL trong hàm này dùng để đếm tổng số thiết bị chưa xóa mềm cho trang báo cáo.
     */
    public int countActiveEquipments() throws SQLException {
        String sql = "SELECT COUNT(*) AS Total FROM Equipments WHERE IsDeleted = 0";
        try (Connection connection = DBContext.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {
            return resultSet.next() ? resultSet.getInt("Total") : 0;
        }
    }

    /**
     * Gán dữ liệu thiết bị vào PreparedStatement dùng chung cho câu INSERT và UPDATE.
     */
    private void fillEquipmentStatement(PreparedStatement statement, Equipment equipment, boolean update) throws SQLException {
        statement.setString(1, equipment.getEquipmentCode());
        statement.setString(2, equipment.getEquipmentName());
        statement.setString(3, equipment.getEquipmentType());
        statement.setDate(4, Date.valueOf(equipment.getPurchaseDate()));
        if (equipment.getWarrantyDate() == null) {
            statement.setNull(5, java.sql.Types.DATE);
        } else {
            statement.setDate(5, Date.valueOf(equipment.getWarrantyDate()));
        }
        statement.setString(6, equipment.getLocation());
        statement.setString(7, equipment.getImageUrl());
        statement.setString(8, equipment.getStatus());
        statement.setString(9, update ? equipment.getUpdatedBy() : equipment.getCreatedBy());
    }

    /**
     * Gán danh sách tham số động vào PreparedStatement theo đúng thứ tự điều kiện lọc.
     */
    private void bind(PreparedStatement statement, List<Object> params) throws SQLException {
        for (int i = 0; i < params.size(); i++) {
            statement.setObject(i + 1, params.get(i));
        }
    }

    /**
     * Bổ sung điều kiện lọc động vào SQL tìm kiếm thiết bị.
     */
    private void appendSearchFilters(StringBuilder sql, List<Object> params, String keyword, String status, String type) {
        if (keyword != null && !keyword.isBlank()) {
            sql.append(" AND (EquipmentCode LIKE ? OR EquipmentName LIKE ?)");
            String searchValue = "%" + keyword.trim() + "%";
            params.add(searchValue);
            params.add(searchValue);
        }
        if (status != null && !status.isBlank()) {
            sql.append(" AND Status = ?");
            params.add(status);
        }
        if (type != null && !type.isBlank()) {
            sql.append(" AND EquipmentType = ?");
            params.add(type);
        }
    }

    /**
     * Chuyển một dòng ResultSet từ bảng Equipments thành đối tượng Equipment.
     */
    private Equipment mapEquipment(ResultSet resultSet) throws SQLException {
        Equipment equipment = new Equipment();
        equipment.setEquipmentId(resultSet.getInt("EquipmentID"));
        equipment.setEquipmentCode(resultSet.getString("EquipmentCode"));
        equipment.setEquipmentName(resultSet.getString("EquipmentName"));
        equipment.setEquipmentType(resultSet.getString("EquipmentType"));
        Date purchaseDate = resultSet.getDate("PurchaseDate");
        equipment.setPurchaseDate(purchaseDate == null ? null : purchaseDate.toLocalDate());
        Date warrantyDate = resultSet.getDate("WarrantyDate");
        equipment.setWarrantyDate(warrantyDate == null ? null : warrantyDate.toLocalDate());
        equipment.setLocation(resultSet.getString("Location"));
        equipment.setImageUrl(resultSet.getString("ImageURL"));
        equipment.setStatus(resultSet.getString("Status"));
        equipment.setCreatedBy(resultSet.getString("CreatedBy"));
        Timestamp createdDate = resultSet.getTimestamp("CreatedDate");
        equipment.setCreatedDate(createdDate == null ? null : createdDate.toLocalDateTime());
        equipment.setUpdatedBy(resultSet.getString("UpdatedBy"));
        Timestamp updatedDate = resultSet.getTimestamp("UpdatedDate");
        equipment.setUpdatedDate(updatedDate == null ? null : updatedDate.toLocalDateTime());
        equipment.setDeleted(resultSet.getBoolean("IsDeleted"));
        return equipment;
    }

    private static boolean checkedEquipmentTypeColumn = false;

    /**
     * SQL trong hàm này dùng để kiểm tra và bổ sung cột EquipmentType cho các bản DB cũ nếu còn thiếu.
     */
    private void ensureEquipmentTypeColumn() throws SQLException {
        if (checkedEquipmentTypeColumn) {
            return;
        }
        String checkSql = """
                SELECT COUNT(*) AS ColumnCount
                FROM INFORMATION_SCHEMA.COLUMNS
                WHERE TABLE_NAME = 'Equipments' AND COLUMN_NAME = 'EquipmentType'
                """;
        try (Connection connection = DBContext.getConnection();
                PreparedStatement checkStatement = connection.prepareStatement(checkSql);
                ResultSet resultSet = checkStatement.executeQuery()) {
            if (resultSet.next() && resultSet.getInt("ColumnCount") > 0) {
                checkedEquipmentTypeColumn = true;
                return;
            }

            try (PreparedStatement alterStatement = connection.prepareStatement(
                    "ALTER TABLE Equipments ADD EquipmentType NVARCHAR(50) NULL")) {
                alterStatement.executeUpdate();
            }
            try (PreparedStatement updateStatement = connection.prepareStatement(
                    "UPDATE Equipments SET EquipmentType = N'Khac' WHERE EquipmentType IS NULL OR EquipmentType = N'Gym'")) {
                updateStatement.executeUpdate();
            }
            checkedEquipmentTypeColumn = true;
        }
    }
}

