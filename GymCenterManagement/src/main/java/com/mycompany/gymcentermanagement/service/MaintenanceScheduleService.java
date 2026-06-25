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
                if (STATUS_COMPLETED.equals(nextStatus)
                        && resolveRelatedIssue
                        && current.getIssueId() != null) {
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
        if (STATUS_COMPLETED.equals(currentStatus) || STATUS_CANCELLED.equals(currentStatus)) {
            throw new IllegalArgumentException("Completed or cancelled schedules cannot be edited.");
        }
        boolean start = STATUS_SCHEDULED.equals(currentStatus) && STATUS_IN_PROGRESS.equals(nextStatus);
        boolean complete = STATUS_IN_PROGRESS.equals(currentStatus) && STATUS_COMPLETED.equals(nextStatus);
        if (!start && !complete) {
            throw new IllegalArgumentException("Maintenance status transition is invalid.");
        }
        if (complete && (completionNote == null || completionNote.isBlank())) {
            throw new IllegalArgumentException("Completion note is required.");
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

    private void validateFilter(String status, String type) {
        if (status != null && !status.isBlank()
                && !STATUS_SCHEDULED.equals(status)
                && !STATUS_IN_PROGRESS.equals(status)
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
            return getScheduled() + getInProgress() + getCompleted() + getCancelled();
        }

        public int getScheduled() {
            return counts.getOrDefault(STATUS_SCHEDULED, 0);
        }

        public int getInProgress() {
            return counts.getOrDefault(STATUS_IN_PROGRESS, 0);
        }

        public int getCompleted() {
            return counts.getOrDefault(STATUS_COMPLETED, 0);
        }

        public int getCancelled() {
            return counts.getOrDefault(STATUS_CANCELLED, 0);
        }
    }
}
