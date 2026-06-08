/**
 * =========================================================================
 * @file          : EquipmentIssueDAO.java
 * @description   : Lớp truy cập dữ liệu để quản lý các báo cáo sự cố của thiết bị.
 * @author        : Đào Minh Hoàng (hoangdm)
 * @created       : 2026-06-04
 * @last_modified : 2026-06-04 bởi Đào Minh Hoàng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.mycompany.gymcentermanagement.model.entity.EquipmentIssue;
import com.mycompany.gymcentermanagement.utils.DBContext;

public class EquipmentIssueDAO {
    public List<EquipmentIssue> search(String keyword, String status) throws SQLException {
        return search(keyword, status, 0, Integer.MAX_VALUE);
    }

    public List<EquipmentIssue> search(String keyword, String status, int offset, int limit) throws SQLException {
        ensureIssueImageColumn();
        StringBuilder sql = new StringBuilder("""
                SELECT i.*, e.EquipmentCode, e.EquipmentName, COALESCE(NULLIF(i.CreatedBy, ''), u.DisplayName) AS ReporterName
                FROM EquipmentIssues i
                INNER JOIN Equipments e ON e.EquipmentID = i.EquipmentID
                INNER JOIN Users u ON u.UserID = i.ReportedBy
                WHERE i.IsDeleted = 0 AND e.IsDeleted = 0
                """);
        List<Object> params = new ArrayList<>();
        appendSearchFilters(sql, params, keyword, status);
        sql.append(" ORDER BY i.ReportedAt DESC, i.IssueID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(Math.max(0, offset));
        params.add(Math.max(1, limit));

        try (Connection connection = DBContext.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql.toString())) {
            bind(statement, params);
            try (ResultSet resultSet = statement.executeQuery()) {
                List<EquipmentIssue> items = new ArrayList<>();
                while (resultSet.next()) {
                    items.add(mapIssue(resultSet));
                }
                return items;
            }
        }
    }

    public int countSearch(String keyword, String status) throws SQLException {
        ensureIssueImageColumn();
        StringBuilder sql = new StringBuilder("""
                SELECT COUNT(*) AS Total
                FROM EquipmentIssues i
                INNER JOIN Equipments e ON e.EquipmentID = i.EquipmentID
                WHERE i.IsDeleted = 0 AND e.IsDeleted = 0
                """);
        List<Object> params = new ArrayList<>();
        appendSearchFilters(sql, params, keyword, status);
        try (Connection connection = DBContext.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql.toString())) {
            bind(statement, params);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next() ? resultSet.getInt("Total") : 0;
            }
        }
    }

    public EquipmentIssue findById(int issueId) throws SQLException {
        ensureIssueImageColumn();
        String sql = """
                SELECT i.*, e.EquipmentCode, e.EquipmentName, COALESCE(NULLIF(i.CreatedBy, ''), u.DisplayName) AS ReporterName
                FROM EquipmentIssues i
                INNER JOIN Equipments e ON e.EquipmentID = i.EquipmentID
                INNER JOIN Users u ON u.UserID = i.ReportedBy
                WHERE i.IssueID = ? AND i.IsDeleted = 0 AND e.IsDeleted = 0
                """;
        try (Connection connection = DBContext.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, issueId);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next() ? mapIssue(resultSet) : null;
            }
        }
    }

    public int create(Connection connection, EquipmentIssue issue) throws SQLException {
        ensureIssueImageColumn(connection);
        String sql = """
                INSERT INTO EquipmentIssues
                    (EquipmentID, ReportedBy, IssueType, Description, IssueImageURL, ReportedAt, Status, CreatedBy, CreatedDate, IsDeleted)
                VALUES (?, ?, ?, ?, ?, SYSDATETIME(), ?, ?, SYSDATETIME(), 0)
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, issue.getEquipmentId());
            statement.setInt(2, issue.getReportedBy());
            statement.setString(3, issue.getIssueType());
            statement.setString(4, issue.getDescription());
            statement.setString(5, issue.getIssueImageUrl());
            statement.setString(6, issue.getStatus());
            statement.setString(7, issue.getCreatedBy());
            int affected = statement.executeUpdate();
            if (affected == 0) {
                return 0;
            }
            try (ResultSet keys = statement.getGeneratedKeys()) {
                return keys.next() ? keys.getInt(1) : 0;
            }
        }
    }

    public boolean updateStatus(Connection connection, int issueId, String status, String updatedBy) throws SQLException {
        String sql = "UPDATE EquipmentIssues SET Status = ?, UpdatedBy = ?, UpdatedDate = SYSDATETIME() WHERE IssueID = ? AND IsDeleted = 0";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, status);
            statement.setString(2, updatedBy);
            statement.setInt(3, issueId);
            return statement.executeUpdate() > 0;
        }
    }

    public boolean update(Connection connection, EquipmentIssue issue) throws SQLException {
        ensureIssueImageColumn(connection);
        String sql = """
                UPDATE EquipmentIssues
                SET EquipmentID = ?, IssueType = ?, Description = ?, IssueImageURL = ?,
                    Status = ?, CreatedBy = ?, UpdatedBy = ?, UpdatedDate = SYSDATETIME()
                WHERE IssueID = ? AND IsDeleted = 0
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, issue.getEquipmentId());
            statement.setString(2, issue.getIssueType());
            statement.setString(3, issue.getDescription());
            statement.setString(4, issue.getIssueImageUrl());
            statement.setString(5, issue.getStatus());
            statement.setString(6, issue.getCreatedBy());
            statement.setString(7, issue.getUpdatedBy());
            statement.setInt(8, issue.getIssueId());
            return statement.executeUpdate() > 0;
        }
    }

    public EquipmentIssue findById(Connection connection, int issueId) throws SQLException {
        ensureIssueImageColumn(connection);
        String sql = "SELECT i.*, e.EquipmentCode, e.EquipmentName, COALESCE(NULLIF(i.CreatedBy, ''), u.DisplayName) AS ReporterName FROM EquipmentIssues i INNER JOIN Equipments e ON e.EquipmentID = i.EquipmentID INNER JOIN Users u ON u.UserID = i.ReportedBy WHERE i.IssueID = ? AND i.IsDeleted = 0";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, issueId);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next() ? mapIssue(resultSet) : null;
            }
        }
    }

    public Map<String, Integer> countByStatus() throws SQLException {
        ensureIssueImageColumn();
        String sql = "SELECT Status, COUNT(*) AS Total FROM EquipmentIssues WHERE IsDeleted = 0 GROUP BY Status";
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

    public List<EquipmentIssue> findRecent(int limit) throws SQLException {
        ensureIssueImageColumn();
        String sql = """
                SELECT TOP (?) i.*, e.EquipmentCode, e.EquipmentName, COALESCE(NULLIF(i.CreatedBy, ''), u.DisplayName) AS ReporterName
                FROM EquipmentIssues i
                INNER JOIN Equipments e ON e.EquipmentID = i.EquipmentID
                INNER JOIN Users u ON u.UserID = i.ReportedBy
                WHERE i.IsDeleted = 0 AND e.IsDeleted = 0
                ORDER BY i.ReportedAt DESC, i.IssueID DESC
                """;
        try (Connection connection = DBContext.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, limit);
            try (ResultSet resultSet = statement.executeQuery()) {
                List<EquipmentIssue> items = new ArrayList<>();
                while (resultSet.next()) {
                    items.add(mapIssue(resultSet));
                }
                return items;
            }
        }
    }

    private void bind(PreparedStatement statement, List<Object> params) throws SQLException {
        for (int i = 0; i < params.size(); i++) {
            statement.setObject(i + 1, params.get(i));
        }
    }

    private void appendSearchFilters(StringBuilder sql, List<Object> params, String keyword, String status) {
        if (keyword != null && !keyword.isBlank()) {
            sql.append(" AND (e.EquipmentCode LIKE ? OR e.EquipmentName LIKE ? OR i.Description LIKE ?)");
            String searchValue = "%" + keyword.trim() + "%";
            params.add(searchValue);
            params.add(searchValue);
            params.add(searchValue);
        }
        if (status != null && !status.isBlank()) {
            sql.append(" AND i.Status = ?");
            params.add(status);
        }
    }

    private EquipmentIssue mapIssue(ResultSet resultSet) throws SQLException {
        EquipmentIssue issue = new EquipmentIssue();
        issue.setIssueId(resultSet.getInt("IssueID"));
        issue.setEquipmentId(resultSet.getInt("EquipmentID"));
        issue.setReportedBy(resultSet.getInt("ReportedBy"));
        issue.setIssueType(resultSet.getString("IssueType"));
        issue.setDescription(resultSet.getString("Description"));
        Timestamp reportedAt = resultSet.getTimestamp("ReportedAt");
        issue.setReportedAt(reportedAt == null ? null : reportedAt.toLocalDateTime());
        issue.setStatus(resultSet.getString("Status"));
        issue.setCreatedBy(resultSet.getString("CreatedBy"));
        Timestamp createdDate = resultSet.getTimestamp("CreatedDate");
        issue.setCreatedDate(createdDate == null ? null : createdDate.toLocalDateTime());
        issue.setUpdatedBy(resultSet.getString("UpdatedBy"));
        Timestamp updatedDate = resultSet.getTimestamp("UpdatedDate");
        issue.setUpdatedDate(updatedDate == null ? null : updatedDate.toLocalDateTime());
        issue.setDeleted(resultSet.getBoolean("IsDeleted"));
        issue.setEquipmentCode(resultSet.getString("EquipmentCode"));
        issue.setEquipmentName(resultSet.getString("EquipmentName"));
        issue.setReporterName(resultSet.getString("ReporterName"));
        issue.setIssueImageUrl(resultSet.getString("IssueImageURL"));
        return issue;
    }

    // Runtime guard for older DB copies; the SQL migration file is the preferred fix.
    private void ensureIssueImageColumn() throws SQLException {
        try (Connection connection = DBContext.getConnection()) {
            ensureIssueImageColumn(connection);
        }
    }

    private void ensureIssueImageColumn(Connection connection) throws SQLException {
        String checkSql = """
                SELECT COUNT(*) AS ColumnCount
                FROM INFORMATION_SCHEMA.COLUMNS
                WHERE TABLE_NAME = 'EquipmentIssues' AND COLUMN_NAME = 'IssueImageURL'
                """;
        try (PreparedStatement checkStatement = connection.prepareStatement(checkSql);
                ResultSet resultSet = checkStatement.executeQuery()) {
            if (resultSet.next() && resultSet.getInt("ColumnCount") > 0) {
                return;
            }
        }
        try (PreparedStatement alterStatement = connection.prepareStatement(
                "ALTER TABLE EquipmentIssues ADD IssueImageURL VARCHAR(255) NULL")) {
            alterStatement.executeUpdate();
        }
    }
}
