package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.dao.EquipmentDAO;
import com.mycompany.gymcentermanagement.dao.EquipmentIssueDAO;
import com.mycompany.gymcentermanagement.dao.MaintenanceScheduleDAO;
import com.mycompany.gymcentermanagement.model.entity.Equipment;
import com.mycompany.gymcentermanagement.model.entity.EquipmentIssue;
import com.mycompany.gymcentermanagement.model.entity.MaintenanceSchedule;
import com.mycompany.gymcentermanagement.utils.DBContext;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MaintenanceScheduleService {
    public static final String STATUS_SCHEDULED = "Scheduled";
    public static final String STATUS_IN_PROGRESS = "InProgress";
    public static final String STATUS_PENDING_APPROVAL = "PendingApproval";
    public static final String STATUS_COMPLETED = "Completed";
    public static final String STATUS_CANCELLED = "Cancelled";
    public static final String TYPE_PREVENTIVE = "Preventive";
    public static final String TYPE_CORRECTIVE = "Corrective";

    private final MaintenanceScheduleDAO scheduleDAO = new MaintenanceScheduleDAO();
    private final EquipmentDAO equipmentDAO = new EquipmentDAO();
    private final EquipmentIssueDAO issueDAO = new EquipmentIssueDAO();

    public List<MaintenanceSchedule> search(String keyword, String status, Integer equipmentId,
            String maintenanceType, int offset, int pageSize) throws SQLException {
        validateFilter(status, maintenanceType);
        return scheduleDAO.search(normalizeBlank(keyword), normalizeBlank(status), equipmentId,
                normalizeBlank(maintenanceType), offset, pageSize);
    }

    public int countSearch(String keyword, String status, Integer equipmentId,
            String maintenanceType) throws SQLException {
        validateFilter(status, maintenanceType);
        return scheduleDAO.countSearch(normalizeBlank(keyword), normalizeBlank(status), equipmentId,
                normalizeBlank(maintenanceType));
    }

    public Statistics getStatistics() throws SQLException {
        return new Statistics(scheduleDAO.countByStatus());
    }

    public MaintenanceSchedule getById(int id) throws SQLException {
        return scheduleDAO.findById(id);
    }

    public List<Equipment> getEquipmentOptions() throws SQLException {
        return equipmentDAO.findAllActive();
    }

    public List<EquipmentIssue> getIssueOptions(int equipmentId) throws SQLException {
        if (equipmentId <= 0) {
            return List.of();
        }
        return issueDAO.findByEquipmentId(equipmentId);
    }

    public List<EquipmentIssue> getAllIssueOptions() throws SQLException {
        return issueDAO.search(null, null);
    }

    public int create(MaintenanceSchedule schedule, String actor) throws SQLException {
        validateCreateFields(schedule, LocalDate.now());
        requireActor(actor);
        try (Connection connection = DBContext.getConnection()) {
            boolean oldAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);
            try {
                validateEquipmentAndIssue(connection, schedule);
                rejectDuplicate(connection, schedule);
                schedule.setStatus(STATUS_SCHEDULED);
                schedule.setCreatedBy(actor);
                int id = scheduleDAO.create(connection, schedule);
                if (id <= 0) {
                    throw new SQLException("Maintenance schedule could not be created.");
                }
                markIssueInProgress(connection, schedule.getIssueId(), schedule.getEquipmentId(), actor);
                connection.commit();
                return id;
            } catch (SQLException | IllegalArgumentException ex) {
                connection.rollback();
                throw ex;
            } finally {
                connection.setAutoCommit(oldAutoCommit);
            }
        }
    }

    public boolean updatePlanned(MaintenanceSchedule changes, String actor) throws SQLException {
        requireActor(actor);
        validateCreateFields(changes, LocalDate.now());
        try (Connection connection = DBContext.getConnection()) {
            boolean oldAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);
            try {
                MaintenanceSchedule current = requireSchedule(connection, changes.getMaintenanceScheduleId());
                if (!STATUS_SCHEDULED.equals(current.getStatus())) {
                    throw new IllegalArgumentException("Only scheduled maintenance can be edited.");
                }
                changes.setEquipmentId(current.getEquipmentId());
                validateEquipmentAndIssue(connection, changes);
                rejectDuplicate(connection, changes);
                changes.setUpdatedBy(actor);
                boolean updated = scheduleDAO.updatePlanned(connection, changes);
                if (!updated) {
                    throw new SQLException("Maintenance schedule could not be updated.");
                }
                syncIssueLinkChange(connection, current, changes, actor);
                connection.commit();
                return true;
            } catch (SQLException | IllegalArgumentException ex) {
                connection.rollback();
                throw ex;
            } finally {
                connection.setAutoCommit(oldAutoCommit);
            }
        }
    }

    public boolean updateProgress(int id, String nextStatus, String completionNote,
            boolean resolveRelatedIssue, String actor) throws SQLException {
        requireActor(actor);
        try (Connection connection = DBContext.getConnection()) {
            boolean oldAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);
            try {
                MaintenanceSchedule current = requireSchedule(connection, id);
                validateProgressTransition(current.getStatus(), nextStatus, completionNote);
                boolean updated = scheduleDAO.updateProgress(
                        connection, id, nextStatus, normalizeBlank(completionNote), actor
                );
                if (!updated) {
                    throw new SQLException("Maintenance progress could not be updated.");
                }
                markIssueInProgress(connection, current.getIssueId(), current.getEquipmentId(), actor);
                equipmentDAO.recalculateStatus(connection, current.getEquipmentId(), actor);
                connection.commit();
                return true;
            } catch (SQLException | IllegalArgumentException ex) {
                connection.rollback();
                throw ex;
            } finally {
                connection.setAutoCommit(oldAutoCommit);
            }
        }
    }

    public boolean submitForApproval(int id, String completionNote, String completionImageUrl,
            boolean resolveRelatedIssue, String actor) throws SQLException {
        requireActor(actor);
        validateCompletionSubmission(completionNote, completionImageUrl);
        try (Connection connection = DBContext.getConnection()) {
            boolean oldAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);
            try {
                MaintenanceSchedule current = requireSchedule(connection, id);
                if (!STATUS_IN_PROGRESS.equals(current.getStatus())) {
                    throw new IllegalArgumentException("Only in-progress maintenance can be submitted for approval.");
                }
                boolean updated = scheduleDAO.submitForApproval(
                        connection, id, normalizeBlank(completionNote), normalizeBlank(completionImageUrl),
                        current.getIssueId() != null, actor
                );
                if (!updated) {
                    throw new SQLException("Maintenance completion could not be submitted for approval.");
                }
                equipmentDAO.recalculateStatus(connection, current.getEquipmentId(), actor);
                connection.commit();
                return true;
            } catch (SQLException | IllegalArgumentException ex) {
                connection.rollback();
                throw ex;
            } finally {
                connection.setAutoCommit(oldAutoCommit);
            }
        }
    }

    public boolean approveCompletion(int id, String approvalNote, String actor) throws SQLException {
        requireActor(actor);
        try (Connection connection = DBContext.getConnection()) {
            boolean oldAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);
            try {
                MaintenanceSchedule current = requireSchedule(connection, id);
                if (!STATUS_PENDING_APPROVAL.equals(current.getStatus())) {
                    throw new IllegalArgumentException("Only pending approval maintenance can be approved.");
                }
                boolean approved = scheduleDAO.approveCompletion(
                        connection, id, normalizeBlank(approvalNote), actor
                );
                if (!approved) {
                    throw new SQLException("Maintenance completion could not be approved.");
                }
                if (current.getIssueId() != null) {
                    EquipmentIssue issue = issueDAO.findById(connection, current.getIssueId());
                    if (issue == null || issue.getEquipmentId() != current.getEquipmentId()) {
                        throw new IllegalArgumentException("Related equipment issue is invalid.");
                    }
                    issueDAO.updateStatus(connection, issue.getIssueId(), EquipmentService.ISSUE_RESOLVED, actor);
                }
                equipmentDAO.recalculateStatus(connection, current.getEquipmentId(), actor);
                connection.commit();
                return true;
            } catch (SQLException | IllegalArgumentException ex) {
                connection.rollback();
                throw ex;
            } finally {
                connection.setAutoCommit(oldAutoCommit);
            }
        }
    }

    public boolean rejectCompletion(int id, String rejectionNote, String actor) throws SQLException {
        requireActor(actor);
        if (rejectionNote == null || rejectionNote.isBlank()) {
            throw new IllegalArgumentException("Rejection reason is required.");
        }
        try (Connection connection = DBContext.getConnection()) {
            boolean oldAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);
            try {
                MaintenanceSchedule current = requireSchedule(connection, id);
                if (!STATUS_PENDING_APPROVAL.equals(current.getStatus())) {
                    throw new IllegalArgumentException("Only pending approval maintenance can be rejected.");
                }
                boolean rejected = scheduleDAO.rejectCompletion(
                        connection, id, normalizeBlank(rejectionNote), actor
                );
                if (!rejected) {
                    throw new SQLException("Maintenance completion could not be rejected.");
                }
                equipmentDAO.recalculateStatus(connection, current.getEquipmentId(), actor);
                connection.commit();
                return true;
            } catch (SQLException | IllegalArgumentException ex) {
                connection.rollback();
                throw ex;
            } finally {
                connection.setAutoCommit(oldAutoCommit);
            }
        }
    }

    public boolean cancel(int id, String actor) throws SQLException {
        requireActor(actor);
        try (Connection connection = DBContext.getConnection()) {
            boolean oldAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);
            try {
                MaintenanceSchedule current = requireSchedule(connection, id);
                if (!STATUS_SCHEDULED.equals(current.getStatus())) {
                    throw new IllegalArgumentException("Only scheduled maintenance can be cancelled.");
                }
                boolean cancelled = scheduleDAO.cancel(connection, id, actor);
                if (!cancelled) {
                    throw new SQLException("Maintenance schedule could not be cancelled.");
                }
                resetIssueToPendingIfNoOpenSchedule(connection, current.getIssueId(),
                        current.getMaintenanceScheduleId(), current.getEquipmentId(), actor);
                connection.commit();
                return true;
            } catch (SQLException | IllegalArgumentException ex) {
                connection.rollback();
                throw ex;
            } finally {
                connection.setAutoCommit(oldAutoCommit);
            }
        }
    }

    static void validateCreateFields(MaintenanceSchedule schedule, LocalDate today) {
        if (schedule.getEquipmentId() <= 0) {
            throw new IllegalArgumentException("Equipment is required.");
        }
        if (schedule.getScheduledDate() == null) {
            throw new IllegalArgumentException("Scheduled date is required.");
        }
        if (schedule.getScheduledDate().isBefore(today)) {
            throw new IllegalArgumentException("Scheduled date cannot be in the past.");
        }
        if (!TYPE_PREVENTIVE.equals(schedule.getMaintenanceType())
                && !TYPE_CORRECTIVE.equals(schedule.getMaintenanceType())) {
            throw new IllegalArgumentException("Maintenance type is invalid.");
        }
        if (schedule.getDescription() == null || schedule.getDescription().isBlank()) {
            throw new IllegalArgumentException("Work description is required.");
        }
    }

    static void validateProgressTransition(String currentStatus, String nextStatus, String completionNote) {
        if (STATUS_COMPLETED.equals(currentStatus) || STATUS_CANCELLED.equals(currentStatus)
                || STATUS_PENDING_APPROVAL.equals(currentStatus)) {
            throw new IllegalArgumentException("Completed or cancelled schedules cannot be edited.");
        }
        boolean start = STATUS_SCHEDULED.equals(currentStatus) && STATUS_IN_PROGRESS.equals(nextStatus);
        if (!start) {
            throw new IllegalArgumentException("Maintenance status transition is invalid.");
        }
    }

    private void validateCompletionSubmission(String completionNote, String completionImageUrl) {
        if (completionNote == null || completionNote.isBlank()) {
            throw new IllegalArgumentException("Completion note is required.");
        }
        if (completionImageUrl == null || completionImageUrl.isBlank()) {
            throw new IllegalArgumentException("Completion image is required.");
        }
    }

    private void validateEquipmentAndIssue(Connection connection, MaintenanceSchedule schedule) throws SQLException {
        Equipment equipment = equipmentDAO.findById(connection, schedule.getEquipmentId());
        if (equipment == null) {
            throw new IllegalArgumentException("Equipment does not exist or has been deleted.");
        }
        if (schedule.getIssueId() == null) {
            return;
        }
        EquipmentIssue issue = issueDAO.findById(connection, schedule.getIssueId());
        if (issue == null) {
            throw new IllegalArgumentException("Related equipment issue does not exist or has been deleted.");
        }
        if (issue.getEquipmentId() != schedule.getEquipmentId()) {
            throw new IllegalArgumentException("Related issue must belong to the selected equipment.");
        }
    }

    private void rejectDuplicate(Connection connection, MaintenanceSchedule schedule) throws SQLException {
        if (scheduleDAO.existsDuplicate(
                connection,
                schedule.getEquipmentId(),
                Date.valueOf(schedule.getScheduledDate()),
                schedule.getMaintenanceScheduleId())) {
            throw new IllegalArgumentException(
                    "This equipment already has a non-cancelled maintenance schedule on the selected date."
            );
        }
    }

    private MaintenanceSchedule requireSchedule(Connection connection, int id) throws SQLException {
        if (id <= 0) {
            throw new IllegalArgumentException("Maintenance schedule is required.");
        }
        MaintenanceSchedule schedule = scheduleDAO.findById(connection, id);
        if (schedule == null) {
            throw new IllegalArgumentException("Maintenance schedule does not exist or has been deleted.");
        }
        return schedule;
    }

    private void syncIssueLinkChange(Connection connection, MaintenanceSchedule current,
            MaintenanceSchedule changes, String actor) throws SQLException {
        Integer oldIssueId = current.getIssueId();
        Integer newIssueId = changes.getIssueId();
        if (oldIssueId != null && !oldIssueId.equals(newIssueId)) {
            resetIssueToPendingIfNoOpenSchedule(connection, oldIssueId,
                    current.getMaintenanceScheduleId(), current.getEquipmentId(), actor);
        }
        markIssueInProgress(connection, newIssueId, current.getEquipmentId(), actor);
    }

    private void markIssueInProgress(Connection connection, Integer issueId, int equipmentId,
            String actor) throws SQLException {
        if (issueId == null) {
            return;
        }
        EquipmentIssue issue = issueDAO.findById(connection, issueId);
        if (issue == null || issue.getEquipmentId() != equipmentId) {
            throw new IllegalArgumentException("Related equipment issue is invalid.");
        }
        if (!EquipmentService.ISSUE_RESOLVED.equals(issue.getStatus())) {
            issueDAO.updateStatus(connection, issueId, EquipmentService.ISSUE_IN_PROGRESS, actor);
            equipmentDAO.recalculateStatus(connection, equipmentId, actor);
        }
    }

    private void resetIssueToPendingIfNoOpenSchedule(Connection connection, Integer issueId,
            int excludedScheduleId, int equipmentId, String actor) throws SQLException {
        if (issueId == null || scheduleDAO.existsOpenScheduleForIssue(connection, issueId, excludedScheduleId)) {
            return;
        }
        EquipmentIssue issue = issueDAO.findById(connection, issueId);
        if (issue == null || issue.getEquipmentId() != equipmentId
                || EquipmentService.ISSUE_RESOLVED.equals(issue.getStatus())) {
            return;
        }
        issueDAO.updateStatus(connection, issueId, EquipmentService.ISSUE_PENDING, actor);
        equipmentDAO.recalculateStatus(connection, equipmentId, actor);
    }

    private void validateFilter(String status, String type) {
        if (status != null && !status.isBlank()
                && !STATUS_SCHEDULED.equals(status)
                && !STATUS_IN_PROGRESS.equals(status)
                && !STATUS_PENDING_APPROVAL.equals(status)
                && !STATUS_COMPLETED.equals(status)
                && !STATUS_CANCELLED.equals(status)) {
            throw new IllegalArgumentException("Maintenance status is invalid.");
        }
        if (type != null && !type.isBlank()
                && !TYPE_PREVENTIVE.equals(type)
                && !TYPE_CORRECTIVE.equals(type)) {
            throw new IllegalArgumentException("Maintenance type is invalid.");
        }
    }

    private void requireActor(String actor) {
        if (actor == null || actor.isBlank()) {
            throw new IllegalArgumentException("Authenticated user is required.");
        }
    }

    private String normalizeBlank(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }

    public static class Statistics {
        private final Map<String, Integer> counts;

        public Statistics(Map<String, Integer> counts) {
            this.counts = new HashMap<>(counts);
        }

        public int getTotal() {
            return getScheduled() + getInProgress() + getPendingApproval() + getCompleted() + getCancelled();
        }

        public int getScheduled() {
            return counts.getOrDefault(STATUS_SCHEDULED, 0);
        }

        public int getInProgress() {
            return counts.getOrDefault(STATUS_IN_PROGRESS, 0);
        }

        public int getPendingApproval() {
            return counts.getOrDefault(STATUS_PENDING_APPROVAL, 0);
        }

        public int getCompleted() {
            return counts.getOrDefault(STATUS_COMPLETED, 0);
        }

        public int getCancelled() {
            return counts.getOrDefault(STATUS_CANCELLED, 0);
        }
    }
}
