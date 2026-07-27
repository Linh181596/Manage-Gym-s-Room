package com.mycompany.gymcentermanagement.dao;

import com.mycompany.gymcentermanagement.model.entity.MaintenanceSchedule;
import com.mycompany.gymcentermanagement.utils.DBContext;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MaintenanceScheduleDAO {

    private static final String SELECT_WITH_RELATIONS = """
            SELECT ms.*, e.EquipmentCode, e.EquipmentName, e.Location AS EquipmentLocation,
                   i.Description AS IssueDescription, i.Status AS IssueStatus
            FROM MaintenanceSchedules ms
            INNER JOIN Equipments e ON e.EquipmentID = ms.EquipmentID
            LEFT JOIN EquipmentIssues i ON i.IssueID = ms.IssueID
            """;

    /**
     * SQL trong hàm này dùng để tìm lịch bảo trì theo bộ lọc, kèm thông tin thiết bị và sự cố liên quan.
     */
    public List<MaintenanceSchedule> search(String keyword, String status, Integer equipmentId,
            String maintenanceType, int offset, int limit) throws SQLException {
        StringBuilder sql = new StringBuilder(SELECT_WITH_RELATIONS);
        sql.append(" WHERE ms.IsDeleted = 0 AND e.IsDeleted = 0");
        List<Object> params = new ArrayList<>();
        appendFilters(sql, params, keyword, status, equipmentId, maintenanceType);
        sql.append(" ORDER BY ms.ScheduledDate DESC, ms.MaintenanceScheduleID DESC");
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(Math.max(0, offset));
        params.add(Math.max(1, limit));

        try (Connection connection = DBContext.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql.toString())) {
            bind(statement, params);
            try (ResultSet resultSet = statement.executeQuery()) {
                List<MaintenanceSchedule> schedules = new ArrayList<>();
                while (resultSet.next()) {
                    schedules.add(mapSchedule(resultSet));
                }
                return schedules;
            }
        }
    }

    /**
     * SQL trong hàm này dùng để đếm số lịch bảo trì thỏa bộ lọc cho phân trang.
     */
    public int countSearch(String keyword, String status, Integer equipmentId,
            String maintenanceType) throws SQLException {
        StringBuilder sql = new StringBuilder("""
                SELECT COUNT(*) AS Total
                FROM MaintenanceSchedules ms
                INNER JOIN Equipments e ON e.EquipmentID = ms.EquipmentID
                LEFT JOIN EquipmentIssues i ON i.IssueID = ms.IssueID
                WHERE ms.IsDeleted = 0 AND e.IsDeleted = 0
                """);
        List<Object> params = new ArrayList<>();
        appendFilters(sql, params, keyword, status, equipmentId, maintenanceType);
        try (Connection connection = DBContext.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql.toString())) {
            bind(statement, params);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next() ? resultSet.getInt("Total") : 0;
            }
        }
    }

    /**
     * SQL trong hàm này dùng để đếm số lịch bảo trì theo từng trạng thái cho thống kê.
     */
    public Map<String, Integer> countByStatus() throws SQLException {
        String sql = """
                SELECT Status, COUNT(*) AS Total
                FROM MaintenanceSchedules
                WHERE IsDeleted = 0
                GROUP BY Status
                """;
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
     * SQL trong hàm này dùng để mở kết nối và lấy chi tiết lịch bảo trì theo id.
     */
    public MaintenanceSchedule findById(int id) throws SQLException {
        try (Connection connection = DBContext.getConnection()) {
            return findById(connection, id);
        }
    }

    /**
     * SQL trong hàm này dùng để lấy chi tiết lịch bảo trì theo id trên kết nối có sẵn.
     */
    public MaintenanceSchedule findById(Connection connection, int id) throws SQLException {
        String sql = SELECT_WITH_RELATIONS
                + " WHERE ms.MaintenanceScheduleID = ? AND ms.IsDeleted = 0 AND e.IsDeleted = 0";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next() ? mapSchedule(resultSet) : null;
            }
        }
    }

    /**
     * SQL trong hàm này dùng để kiểm tra thiết bị đã có lịch bảo trì chưa hủy trong cùng ngày hay chưa.
     */
    public boolean existsDuplicate(Connection connection, int equipmentId, Date scheduledDate,
            int excludedScheduleId) throws SQLException {
        String sql = """
                SELECT COUNT(*) AS Total
                FROM MaintenanceSchedules
                WHERE EquipmentID = ? AND ScheduledDate = ?
                  AND Status <> 'Cancelled' AND IsDeleted = 0
                  AND MaintenanceScheduleID <> ?
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, equipmentId);
            statement.setDate(2, scheduledDate);
            statement.setInt(3, excludedScheduleId);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next() && resultSet.getInt("Total") > 0;
            }
        }
    }

    /**
     * SQL trong hàm này dùng để kiểm tra sự cố còn lịch bảo trì mở nào khác hay không.
     */
    public boolean existsOpenScheduleForIssue(Connection connection, int issueId,
            int excludedScheduleId) throws SQLException {
        String sql = """
                SELECT COUNT(*) AS Total
                FROM MaintenanceSchedules
                WHERE IssueID = ?
                  AND Status IN ('Scheduled', 'InProgress', 'PendingApproval')
                  AND IsDeleted = 0
                  AND MaintenanceScheduleID <> ?
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, issueId);
            statement.setInt(2, excludedScheduleId);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next() && resultSet.getInt("Total") > 0;
            }
        }
    }

    /**
     * SQL trong hàm này dùng để tạo lịch bảo trì mới ở trạng thái đã lên lịch và lấy khóa chính vừa sinh.
     */
    public int create(Connection connection, MaintenanceSchedule schedule) throws SQLException {
        String sql = """
                INSERT INTO MaintenanceSchedules
                    (EquipmentID, IssueID, ScheduledDate, MaintenanceType, Description, Status,
                     CompletionDate, CompletionNote, CreatedBy, CreatedDate, IsDeleted)
                VALUES (?, ?, ?, ?, ?, 'Scheduled', NULL, NULL, ?, SYSDATETIME(), 0)
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            fillPlannedFields(statement, schedule);
            statement.setString(6, schedule.getCreatedBy());
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
     * SQL trong hàm này dùng để cập nhật thông tin kế hoạch của lịch bảo trì còn ở trạng thái đã lên lịch.
     */
    public boolean updatePlanned(Connection connection, MaintenanceSchedule schedule) throws SQLException {
        String sql = """
                UPDATE MaintenanceSchedules
                SET EquipmentID = ?, IssueID = ?, ScheduledDate = ?, MaintenanceType = ?,
                    Description = ?, UpdatedBy = ?, UpdatedDate = SYSDATETIME()
                WHERE MaintenanceScheduleID = ? AND Status = 'Scheduled' AND IsDeleted = 0
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            fillPlannedFields(statement, schedule);
            statement.setString(6, schedule.getUpdatedBy());
            statement.setInt(7, schedule.getMaintenanceScheduleId());
            return statement.executeUpdate() > 0;
        }
    }

    /**
     * SQL trong hàm này dùng để cập nhật trạng thái tiến độ bảo trì và người cập nhật.
     */
    public boolean updateProgress(Connection connection, int id, String nextStatus,
            String completionNote, String updatedBy) throws SQLException {
        String sql = """
                UPDATE MaintenanceSchedules
                SET Status = ?, UpdatedBy = ?, UpdatedDate = SYSDATETIME()
                WHERE MaintenanceScheduleID = ? AND IsDeleted = 0
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, nextStatus);
            statement.setString(2, updatedBy);
            statement.setInt(3, id);
            return statement.executeUpdate() > 0;
        }
    }

    /**
     * SQL trong hàm này dùng để gửi kết quả bảo trì sang trạng thái chờ duyệt, lưu ghi chú và ảnh minh chứng.
     */
    public boolean submitForApproval(Connection connection, int id, String completionNote,
            String completionImageUrl, boolean resolveRelatedIssue, String updatedBy) throws SQLException {
        String sql = """
                UPDATE MaintenanceSchedules
                SET Status = 'PendingApproval',
                    CompletionDate = SYSDATETIME(),
                    CompletionNote = ?,
                    CompletionImageURL = ?,
                    SubmittedForApprovalAt = SYSDATETIME(),
                    SubmittedBy = ?,
                    RequestedIssueResolution = ?,
                    ApprovalNote = NULL,
                    ApprovedBy = NULL,
                    ApprovedAt = NULL,
                    UpdatedBy = ?,
                    UpdatedDate = SYSDATETIME()
                WHERE MaintenanceScheduleID = ? AND Status = 'InProgress' AND IsDeleted = 0
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, completionNote);
            statement.setString(2, completionImageUrl);
            statement.setString(3, updatedBy);
            statement.setBoolean(4, resolveRelatedIssue);
            statement.setString(5, updatedBy);
            statement.setInt(6, id);
            return statement.executeUpdate() > 0;
        }
    }

    /**
     * SQL trong hàm này dùng để duyệt lịch bảo trì chờ duyệt và chuyển sang trạng thái hoàn tất.
     */
    public boolean approveCompletion(Connection connection, int id, String approvalNote, String updatedBy)
            throws SQLException {
        String sql = """
                UPDATE MaintenanceSchedules
                SET Status = 'Completed',
                    ApprovedBy = ?,
                    ApprovedAt = SYSDATETIME(),
                    ApprovalNote = ?,
                    UpdatedBy = ?,
                    UpdatedDate = SYSDATETIME()
                WHERE MaintenanceScheduleID = ? AND Status = 'PendingApproval' AND IsDeleted = 0
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, updatedBy);
            statement.setString(2, approvalNote);
            statement.setString(3, updatedBy);
            statement.setInt(4, id);
            return statement.executeUpdate() > 0;
        }
    }

    /**
     * SQL trong hàm này dùng để từ chối kết quả bảo trì và đưa lịch về trạng thái đang thực hiện.
     */
    public boolean rejectCompletion(Connection connection, int id, String rejectionNote, String updatedBy)
            throws SQLException {
        String sql = """
                UPDATE MaintenanceSchedules
                SET Status = 'InProgress',
                    ApprovalNote = ?,
                    UpdatedBy = ?,
                    UpdatedDate = SYSDATETIME()
                WHERE MaintenanceScheduleID = ? AND Status = 'PendingApproval' AND IsDeleted = 0
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, rejectionNote);
            statement.setString(2, updatedBy);
            statement.setInt(3, id);
            return statement.executeUpdate() > 0;
        }
    }

    /**
     * SQL trong hàm này dùng để hủy lịch bảo trì còn ở trạng thái đã lên lịch.
     */
    public boolean cancel(Connection connection, int id, String updatedBy) throws SQLException {
        String sql = """
                UPDATE MaintenanceSchedules
                SET Status = 'Cancelled', UpdatedBy = ?, UpdatedDate = SYSDATETIME()
                WHERE MaintenanceScheduleID = ? AND Status = 'Scheduled' AND IsDeleted = 0
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, updatedBy);
            statement.setInt(2, id);
            return statement.executeUpdate() > 0;
        }
    }

    /**
     * Bổ sung điều kiện lọc động vào SQL tìm kiếm lịch bảo trì.
     */
    private void appendFilters(StringBuilder sql, List<Object> params, String keyword,
            String status, Integer equipmentId, String maintenanceType) {
        if (keyword != null && !keyword.isBlank()) {
            String trimmed = keyword.trim();
            String like = "%" + trimmed + "%";
            sql.append("""
                     AND (
                         CAST(ms.MaintenanceScheduleID AS varchar(20)) LIKE ?
                         OR CONCAT('MT-', ms.MaintenanceScheduleID) LIKE ?
                         OR CONCAT('#MT-', ms.MaintenanceScheduleID) LIKE ?
                         OR e.EquipmentCode LIKE ?
                         OR e.EquipmentName LIKE ?
                         OR ms.Description LIKE ?
                         OR CAST(ms.IssueID AS varchar(20)) LIKE ?
                         OR i.Description LIKE ?
                     )
                    """);
            for (int i = 0; i < 8; i++) {
                params.add(like);
            }
        }
        if (status != null && !status.isBlank()) {
            sql.append(" AND ms.Status = ?");
            params.add(status);
        }
        if (equipmentId != null && equipmentId > 0) {
            sql.append(" AND ms.EquipmentID = ?");
            params.add(equipmentId);
        }
        if (maintenanceType != null && !maintenanceType.isBlank()) {
            sql.append(" AND ms.MaintenanceType = ?");
            params.add(maintenanceType);
        }
    }

    /**
     * Gán các trường kế hoạch bảo trì vào PreparedStatement dùng chung cho INSERT và UPDATE.
     */
    private void fillPlannedFields(PreparedStatement statement, MaintenanceSchedule schedule) throws SQLException {
        statement.setInt(1, schedule.getEquipmentId());
        if (schedule.getIssueId() == null) {
            statement.setNull(2, Types.INTEGER);
        } else {
            statement.setInt(2, schedule.getIssueId());
        }
        statement.setDate(3, Date.valueOf(schedule.getScheduledDate()));
        statement.setString(4, schedule.getMaintenanceType());
        statement.setString(5, schedule.getDescription());
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
     * Chuyển một dòng ResultSet thành đối tượng MaintenanceSchedule kèm thông tin thiết bị và sự cố.
     */
    private MaintenanceSchedule mapSchedule(ResultSet resultSet) throws SQLException {
        MaintenanceSchedule schedule = new MaintenanceSchedule();
        schedule.setMaintenanceScheduleId(resultSet.getInt("MaintenanceScheduleID"));
        schedule.setEquipmentId(resultSet.getInt("EquipmentID"));
        Object issueId = resultSet.getObject("IssueID");
        schedule.setIssueId(issueId == null ? null : ((Number) issueId).intValue());
        Date scheduledDate = resultSet.getDate("ScheduledDate");
        schedule.setScheduledDate(scheduledDate == null ? null : scheduledDate.toLocalDate());
        schedule.setMaintenanceType(resultSet.getString("MaintenanceType"));
        schedule.setDescription(resultSet.getString("Description"));
        schedule.setStatus(resultSet.getString("Status"));
        Timestamp completionDate = resultSet.getTimestamp("CompletionDate");
        schedule.setCompletionDate(completionDate == null ? null : completionDate.toLocalDateTime());
        schedule.setCompletionNote(resultSet.getString("CompletionNote"));
        schedule.setCompletionImageUrl(resultSet.getString("CompletionImageURL"));
        Timestamp submittedAt = resultSet.getTimestamp("SubmittedForApprovalAt");
        schedule.setSubmittedForApprovalAt(submittedAt == null ? null : submittedAt.toLocalDateTime());
        schedule.setSubmittedBy(resultSet.getString("SubmittedBy"));
        schedule.setRequestedIssueResolution(resultSet.getBoolean("RequestedIssueResolution"));
        schedule.setApprovedBy(resultSet.getString("ApprovedBy"));
        Timestamp approvedAt = resultSet.getTimestamp("ApprovedAt");
        schedule.setApprovedAt(approvedAt == null ? null : approvedAt.toLocalDateTime());
        schedule.setApprovalNote(resultSet.getString("ApprovalNote"));
        schedule.setCreatedBy(resultSet.getString("CreatedBy"));
        Timestamp createdDate = resultSet.getTimestamp("CreatedDate");
        schedule.setCreatedDate(createdDate == null ? null : createdDate.toLocalDateTime());
        schedule.setUpdatedBy(resultSet.getString("UpdatedBy"));
        Timestamp updatedDate = resultSet.getTimestamp("UpdatedDate");
        schedule.setUpdatedDate(updatedDate == null ? null : updatedDate.toLocalDateTime());
        schedule.setDeleted(resultSet.getBoolean("IsDeleted"));
        schedule.setEquipmentCode(resultSet.getString("EquipmentCode"));
        schedule.setEquipmentName(resultSet.getString("EquipmentName"));
        schedule.setEquipmentLocation(resultSet.getString("EquipmentLocation"));
        schedule.setIssueDescription(resultSet.getString("IssueDescription"));
        schedule.setIssueStatus(resultSet.getString("IssueStatus"));
        return schedule;
    }
}
