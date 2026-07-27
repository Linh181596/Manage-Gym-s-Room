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

    /**
     * Tìm lịch bảo trì theo bộ lọc và phân trang cho màn quản lý lịch bảo trì.
     */
    public List<MaintenanceSchedule> search(String keyword, String status, Integer equipmentId,
            String maintenanceType, int offset, int pageSize) throws SQLException {
        validateFilter(status, maintenanceType);
        return scheduleDAO.search(normalizeBlank(keyword), normalizeBlank(status), equipmentId,
                normalizeBlank(maintenanceType), offset, pageSize);
    }

    /**
     * Đếm số lịch bảo trì thỏa bộ lọc để tính tổng trang.
     */
    public int countSearch(String keyword, String status, Integer equipmentId,
            String maintenanceType) throws SQLException {
        validateFilter(status, maintenanceType);
        return scheduleDAO.countSearch(normalizeBlank(keyword), normalizeBlank(status), equipmentId,
                normalizeBlank(maintenanceType));
    }

    /**
     * Lấy thống kê số lượng lịch bảo trì theo từng trạng thái.
     */
    public Statistics getStatistics() throws SQLException {
        return new Statistics(scheduleDAO.countByStatus());
    }

    /**
     * Lấy chi tiết một lịch bảo trì theo id.
     */
    public MaintenanceSchedule getById(int id) throws SQLException {
        return scheduleDAO.findById(id);
    }

    /**
     * Lấy danh sách thiết bị đang hoạt động để hiển thị trong form bảo trì.
     */
    public List<Equipment> getEquipmentOptions() throws SQLException {
        return equipmentDAO.findAllActive();
    }

    /**
     * Lấy danh sách sự cố của một thiết bị để liên kết với lịch bảo trì.
     */
    public List<EquipmentIssue> getIssueOptions(int equipmentId) throws SQLException {
        if (equipmentId <= 0) {
            return List.of();
        }
        return issueDAO.findByEquipmentId(equipmentId);
    }

    /**
     * Lấy toàn bộ sự cố thiết bị để hiển thị trong form khi chưa chọn thiết bị cụ thể.
     */
    public List<EquipmentIssue> getAllIssueOptions() throws SQLException {
        return issueDAO.search(null, null);
    }

    /**
     * Tạo lịch bảo trì mới, kiểm tra thiết bị/sự cố liên quan và cập nhật trạng thái sự cố trong cùng giao dịch.
     */
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
                    throw new SQLException("Không thể tạo lịch bảo trì.");
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

    /**
     * Cập nhật thông tin kế hoạch bảo trì khi lịch vẫn ở trạng thái đã lên lịch.
     */
    public boolean updatePlanned(MaintenanceSchedule changes, String actor) throws SQLException {
        requireActor(actor);
        validateCreateFields(changes, LocalDate.now());
        try (Connection connection = DBContext.getConnection()) {
            boolean oldAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);
            try {
                MaintenanceSchedule current = requireSchedule(connection, changes.getMaintenanceScheduleId());
                if (!STATUS_SCHEDULED.equals(current.getStatus())) {
                    throw new IllegalArgumentException("Chỉ lịch bảo trì đã lên lịch mới được chỉnh sửa.");
                }
                changes.setEquipmentId(current.getEquipmentId());
                validateEquipmentAndIssue(connection, changes);
                rejectDuplicate(connection, changes);
                changes.setUpdatedBy(actor);
                boolean updated = scheduleDAO.updatePlanned(connection, changes);
                if (!updated) {
                    throw new SQLException("Không thể cập nhật lịch bảo trì.");
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

    /**
     * Cập nhật tiến độ bảo trì từ đã lên lịch sang đang thực hiện và đồng bộ trạng thái thiết bị/sự cố.
     */
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
                    throw new SQLException("Không thể cập nhật tiến độ bảo trì.");
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

    /**
     * Gửi kết quả hoàn tất bảo trì chờ Admin duyệt, kèm ghi chú và ảnh minh chứng.
     */
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
                    throw new IllegalArgumentException("Chỉ lịch bảo trì đang thực hiện mới được gửi chờ duyệt.");
                }
                boolean updated = scheduleDAO.submitForApproval(
                        connection, id, normalizeBlank(completionNote), normalizeBlank(completionImageUrl),
                        current.getIssueId() != null, actor
                );
                if (!updated) {
                    throw new SQLException("Không thể gửi kết quả bảo trì để chờ duyệt.");
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

    /**
     * Duyệt kết quả bảo trì, chuyển lịch sang hoàn tất và xử lý sự cố liên quan nếu có.
     */
    public boolean approveCompletion(int id, String approvalNote, String actor) throws SQLException {
        requireActor(actor);
        try (Connection connection = DBContext.getConnection()) {
            boolean oldAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);
            try {
                MaintenanceSchedule current = requireSchedule(connection, id);
                if (!STATUS_PENDING_APPROVAL.equals(current.getStatus())) {
                    throw new IllegalArgumentException("Chỉ lịch bảo trì đang chờ duyệt mới được duyệt.");
                }
                boolean approved = scheduleDAO.approveCompletion(
                        connection, id, normalizeBlank(approvalNote), actor
                );
                if (!approved) {
                    throw new SQLException("Không thể duyệt kết quả bảo trì.");
                }
                if (current.getIssueId() != null) {
                    EquipmentIssue issue = issueDAO.findById(connection, current.getIssueId());
                    if (issue == null || issue.getEquipmentId() != current.getEquipmentId()) {
                        throw new IllegalArgumentException("Sự cố thiết bị liên quan không hợp lệ.");
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

    /**
     * Từ chối kết quả bảo trì, đưa lịch về trạng thái đang thực hiện và lưu lý do từ chối.
     */
    public boolean rejectCompletion(int id, String rejectionNote, String actor) throws SQLException {
        requireActor(actor);
        if (rejectionNote == null || rejectionNote.isBlank()) {
            throw new IllegalArgumentException("Lý do từ chối là bắt buộc.");
        }
        try (Connection connection = DBContext.getConnection()) {
            boolean oldAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);
            try {
                MaintenanceSchedule current = requireSchedule(connection, id);
                if (!STATUS_PENDING_APPROVAL.equals(current.getStatus())) {
                throw new IllegalArgumentException("Chỉ lịch bảo trì đang chờ duyệt mới được từ chối.");
                }
                boolean rejected = scheduleDAO.rejectCompletion(
                        connection, id, normalizeBlank(rejectionNote), actor
                );
                if (!rejected) {
                    throw new SQLException("Không thể từ chối kết quả bảo trì.");
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

    /**
     * Hủy lịch bảo trì chưa bắt đầu và đồng bộ lại trạng thái sự cố liên quan nếu cần.
     */
    public boolean cancel(int id, String actor) throws SQLException {
        requireActor(actor);
        try (Connection connection = DBContext.getConnection()) {
            boolean oldAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);
            try {
                MaintenanceSchedule current = requireSchedule(connection, id);
                if (!STATUS_SCHEDULED.equals(current.getStatus())) {
                    throw new IllegalArgumentException("Chỉ lịch bảo trì đã lên lịch mới được hủy.");
                }
                boolean cancelled = scheduleDAO.cancel(connection, id, actor);
                if (!cancelled) {
                    throw new SQLException("Không thể hủy lịch bảo trì.");
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

    /**
     * Kiểm tra các trường bắt buộc khi tạo hoặc chỉnh sửa kế hoạch bảo trì.
     */
    static void validateCreateFields(MaintenanceSchedule schedule, LocalDate today) {
        if (schedule.getEquipmentId() <= 0) {
            throw new IllegalArgumentException("Vui lòng chọn thiết bị.");
        }
        if (schedule.getScheduledDate() == null) {
            throw new IllegalArgumentException("Ngày bảo trì là bắt buộc.");
        }
        if (schedule.getScheduledDate().isBefore(today)) {
            throw new IllegalArgumentException("Ngày bảo trì không được ở trong quá khứ.");
        }
        if (!TYPE_PREVENTIVE.equals(schedule.getMaintenanceType())
                && !TYPE_CORRECTIVE.equals(schedule.getMaintenanceType())) {
            throw new IllegalArgumentException("Loại bảo trì không hợp lệ.");
        }
        if (schedule.getDescription() == null || schedule.getDescription().isBlank()) {
            throw new IllegalArgumentException("Mô tả công việc là bắt buộc.");
        }
    }

    /**
     * Kiểm tra việc chuyển trạng thái tiến độ bảo trì có hợp lệ hay không.
     */
    static void validateProgressTransition(String currentStatus, String nextStatus, String completionNote) {
        if (STATUS_COMPLETED.equals(currentStatus) || STATUS_CANCELLED.equals(currentStatus)
                || STATUS_PENDING_APPROVAL.equals(currentStatus)) {
            throw new IllegalArgumentException("Không thể chỉnh sửa lịch đã hoàn tất hoặc đã hủy.");
        }
        boolean start = STATUS_SCHEDULED.equals(currentStatus) && STATUS_IN_PROGRESS.equals(nextStatus);
        if (!start) {
            throw new IllegalArgumentException("Chuyển trạng thái bảo trì không hợp lệ.");
        }
    }

    /**
     * Kiểm tra ghi chú và ảnh minh chứng trước khi gửi kết quả bảo trì chờ duyệt.
     */
    private void validateCompletionSubmission(String completionNote, String completionImageUrl) {
        if (completionNote == null || completionNote.isBlank()) {
            throw new IllegalArgumentException("Ghi chú hoàn tất là bắt buộc.");
        }
        if (completionImageUrl == null || completionImageUrl.isBlank()) {
            throw new IllegalArgumentException("Ảnh hoàn tất bảo trì là bắt buộc.");
        }
    }

    /**
     * Kiểm tra thiết bị tồn tại và sự cố liên quan có thuộc đúng thiết bị đã chọn hay không.
     */
    private void validateEquipmentAndIssue(Connection connection, MaintenanceSchedule schedule) throws SQLException {
        Equipment equipment = equipmentDAO.findById(connection, schedule.getEquipmentId());
        if (equipment == null) {
            throw new IllegalArgumentException("Thiết bị không tồn tại hoặc đã bị xóa.");
        }
        if (schedule.getIssueId() == null) {
            return;
        }
        EquipmentIssue issue = issueDAO.findById(connection, schedule.getIssueId());
        if (issue == null) {
            throw new IllegalArgumentException("Sự cố thiết bị liên quan không tồn tại hoặc đã bị xóa.");
        }
        if (issue.getEquipmentId() != schedule.getEquipmentId()) {
            throw new IllegalArgumentException("Sự cố liên quan phải thuộc thiết bị đã chọn.");
        }
    }

    /**
     * Chặn tạo hoặc cập nhật lịch trùng thiết bị trong cùng ngày bảo trì.
     */
    private void rejectDuplicate(Connection connection, MaintenanceSchedule schedule) throws SQLException {
        if (scheduleDAO.existsDuplicate(
                connection,
                schedule.getEquipmentId(),
                Date.valueOf(schedule.getScheduledDate()),
                schedule.getMaintenanceScheduleId())) {
            throw new IllegalArgumentException(
                    "Thiết bị này đã có lịch bảo trì chưa hủy trong ngày đã chọn."
            );
        }
    }

    /**
     * Lấy lịch bảo trì bắt buộc phải tồn tại, nếu không có thì báo lỗi nghiệp vụ.
     */
    private MaintenanceSchedule requireSchedule(Connection connection, int id) throws SQLException {
        if (id <= 0) {
            throw new IllegalArgumentException("Vui lòng chọn lịch bảo trì.");
        }
        MaintenanceSchedule schedule = scheduleDAO.findById(connection, id);
        if (schedule == null) {
            throw new IllegalArgumentException("Lịch bảo trì không tồn tại hoặc đã bị xóa.");
        }
        return schedule;
    }

    /**
     * Đồng bộ trạng thái sự cố khi lịch bảo trì thay đổi sự cố liên kết.
     */
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

    /**
     * Chuyển sự cố liên quan sang đang xử lý khi có lịch bảo trì mở xử lý sự cố đó.
     */
    private void markIssueInProgress(Connection connection, Integer issueId, int equipmentId,
            String actor) throws SQLException {
        if (issueId == null) {
            return;
        }
        EquipmentIssue issue = issueDAO.findById(connection, issueId);
        if (issue == null || issue.getEquipmentId() != equipmentId) {
            throw new IllegalArgumentException("Sự cố thiết bị liên quan không hợp lệ.");
        }
        if (!EquipmentService.ISSUE_RESOLVED.equals(issue.getStatus())) {
            issueDAO.updateStatus(connection, issueId, EquipmentService.ISSUE_IN_PROGRESS, actor);
            equipmentDAO.recalculateStatus(connection, equipmentId, actor);
        }
    }

    /**
     * Đưa sự cố về chờ xử lý nếu không còn lịch bảo trì mở nào xử lý sự cố đó.
     */
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

    /**
     * Kiểm tra giá trị bộ lọc trạng thái và loại bảo trì trước khi truy vấn.
     */
    private void validateFilter(String status, String type) {
        if (status != null && !status.isBlank()
                && !STATUS_SCHEDULED.equals(status)
                && !STATUS_IN_PROGRESS.equals(status)
                && !STATUS_PENDING_APPROVAL.equals(status)
                && !STATUS_COMPLETED.equals(status)
                && !STATUS_CANCELLED.equals(status)) {
            throw new IllegalArgumentException("Trạng thái bảo trì không hợp lệ.");
        }
        if (type != null && !type.isBlank()
                && !TYPE_PREVENTIVE.equals(type)
                && !TYPE_CORRECTIVE.equals(type)) {
            throw new IllegalArgumentException("Loại bảo trì không hợp lệ.");
        }
    }

    /**
     * Kiểm tra tên người thao tác để ghi nhận CreatedBy hoặc UpdatedBy.
     */
    private void requireActor(String actor) {
        if (actor == null || actor.isBlank()) {
            throw new IllegalArgumentException("Người dùng đăng nhập là bắt buộc.");
        }
    }

    /**
     * Chuẩn hóa chuỗi rỗng thành null để truyền xuống DAO làm điều kiện lọc hoặc giá trị tùy chọn.
     */
    private String normalizeBlank(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }

    public static class Statistics {
        private final Map<String, Integer> counts;

        /**
         * Tạo đối tượng thống kê lịch bảo trì từ số lượng theo trạng thái.
         */
        public Statistics(Map<String, Integer> counts) {
            this.counts = new HashMap<>(counts);
        }

        /**
         * Tính tổng số lịch bảo trì ở tất cả trạng thái.
         */
        public int getTotal() {
            return getScheduled() + getInProgress() + getPendingApproval() + getCompleted() + getCancelled();
        }

        /**
         * Trả về số lịch đã lên lịch.
         */
        public int getScheduled() {
            return counts.getOrDefault(STATUS_SCHEDULED, 0);
        }

        /**
         * Trả về số lịch đang thực hiện.
         */
        public int getInProgress() {
            return counts.getOrDefault(STATUS_IN_PROGRESS, 0);
        }

        /**
         * Trả về số lịch đang chờ Admin duyệt.
         */
        public int getPendingApproval() {
            return counts.getOrDefault(STATUS_PENDING_APPROVAL, 0);
        }

        /**
         * Trả về số lịch đã hoàn tất.
         */
        public int getCompleted() {
            return counts.getOrDefault(STATUS_COMPLETED, 0);
        }

        /**
         * Trả về số lịch đã hủy.
         */
        public int getCancelled() {
            return counts.getOrDefault(STATUS_CANCELLED, 0);
        }
    }
}
