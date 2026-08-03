/**
 * =========================================================================
 * @file          : EquipmentService.java
 * @description   : Lớp xử lý logic nghiệp vụ quản lý thiết bị phòng gym và báo cáo sự cố.
 * @author        : Đỗ Minh Hoàng (hoangdm)
 * @created       : 2026-06-04
 * @last_modified : 2026-06-04 bởi Đỗ Minh Hoàng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.dao.EquipmentDAO;
import com.mycompany.gymcentermanagement.dao.EquipmentIssueDAO;
import java.sql.Connection;
import java.sql.SQLException;
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
    public static final String ISSUE_TYPE_DAMAGE = "Hu hong";
    public static final String ISSUE_PENDING = "Pending";
    public static final String ISSUE_IN_PROGRESS = "InProgress";
    public static final String ISSUE_RESOLVED = "Resolved";

    private final EquipmentDAO equipmentDAO = new EquipmentDAO();
    private final EquipmentIssueDAO issueDAO = new EquipmentIssueDAO();

    /**
     * Tìm thiết bị theo từ khóa, trạng thái và loại thiết bị, dùng cho danh sách không phân trang.
     */
    public List<Equipment> searchEquipments(String keyword, String status, String type) throws SQLException {
        return equipmentDAO.search(keyword, normalizeBlank(status), normalizeBlank(type));
    }

    /**
     * Tìm thiết bị theo bộ lọc và phân trang cho màn quản lý thiết bị.
     */
    public List<Equipment> searchEquipments(String keyword, String status, String type, int offset, int pageSize) throws SQLException {
        return equipmentDAO.search(keyword, normalizeBlank(status), normalizeBlank(type), offset, pageSize);
    }

    /**
     * Đếm số thiết bị thỏa bộ lọc để tính tổng trang.
     */
    public int countEquipments(String keyword, String status, String type) throws SQLException {
        return equipmentDAO.countSearch(normalizeBlank(keyword), normalizeBlank(status), normalizeBlank(type));
    }

    /**
     * Lấy thông tin một thiết bị theo id.
     */
    public Equipment getEquipment(int id) throws SQLException {
        return equipmentDAO.findById(id);
    }

    /**
     * Kiểm tra dữ liệu thiết bị và quyết định tạo mới hoặc cập nhật.
     */
    public int saveEquipment(Equipment equipment) throws SQLException {
        validateEquipment(equipment);
        if (equipment.getEquipmentId() > 0) {
            equipmentDAO.update(equipment);
            return equipment.getEquipmentId();
        }
        return equipmentDAO.create(equipment);
    }

    /**
     * Xóa mềm thiết bị và ghi nhận người cập nhật.
     */
    public boolean deleteEquipment(int id, String updatedBy) throws SQLException {
        return equipmentDAO.softDelete(id, updatedBy);
    }

    /**
     * Tìm sự cố thiết bị theo từ khóa và trạng thái, dùng cho danh sách không phân trang.
     */
    public List<EquipmentIssue> searchIssues(String keyword, String status) throws SQLException {
        return issueDAO.search(keyword, normalizeBlank(status));
    }

    /**
     * Tìm sự cố thiết bị theo bộ lọc và phân trang cho màn quản lý sự cố.
     */
    public List<EquipmentIssue> searchIssues(String keyword, String status, int offset, int pageSize) throws SQLException {
        return issueDAO.search(keyword, normalizeBlank(status), offset, pageSize);
    }

    /**
     * Đếm số sự cố thỏa bộ lọc để tính tổng trang.
     */
    public int countIssues(String keyword, String status) throws SQLException {
        return issueDAO.countSearch(normalizeBlank(keyword), normalizeBlank(status));
    }

    /**
     * Lấy thông tin một sự cố theo id.
     */
    public EquipmentIssue getIssue(int id) throws SQLException {
        return issueDAO.findById(id);
    }

    /**
     * Lấy danh sách sự cố liên quan đến một thiết bị.
     */
    public List<EquipmentIssue> getIssuesByEquipment(int equipmentId) throws SQLException {
        return issueDAO.findByEquipmentId(equipmentId);
    }

    /**
     * Tạo báo cáo sự cố mới, đặt trạng thái chờ xử lý và cập nhật lại trạng thái thiết bị trong cùng giao dịch.
     */
    public int createIssue(EquipmentIssue issue) throws SQLException {
        issue.setIssueType(ISSUE_TYPE_DAMAGE);
        validateIssueForCreate(issue);
        issue.setStatus(ISSUE_PENDING);
        try (Connection connection = DBContext.getConnection()) {
            boolean oldAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);
            try {
                int id = issueDAO.create(connection, issue);
                equipmentDAO.recalculateStatus(connection, issue.getEquipmentId(), issue.getCreatedBy());
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

    /**
     * Cập nhật trạng thái sự cố và tính lại trạng thái thiết bị liên quan trong cùng giao dịch.
     */
    public boolean updateIssueStatus(int issueId, String status, String updatedBy) throws SQLException {
        if (!isValidIssueStatus(status)) {
            throw new IllegalArgumentException("Trạng thái sự cố không hợp lệ.");
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
                equipmentDAO.recalculateStatus(connection, issue.getEquipmentId(), updatedBy);
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

    /**
     * Cập nhật thông tin sự cố và tính lại trạng thái thiết bị nếu cập nhật thành công.
     */
    public boolean updateIssue(EquipmentIssue issue, String updatedBy) throws SQLException {
        validateIssueForUpdate(issue);
        issue.setUpdatedBy(updatedBy);
        try (Connection connection = DBContext.getConnection()) {
            boolean oldAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);
            try {
                boolean updated = issueDAO.update(connection, issue);
                if (updated) {
                    equipmentDAO.recalculateStatus(connection, issue.getEquipmentId(), updatedBy);
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

    /**
     * Tạo dữ liệu báo cáo thiết bị đầy đủ không phân trang.
     */
    public ReportData buildReport() throws SQLException {
        return createReport(equipmentDAO.findWithIssueCounts());
    }

    /**
     * Tạo dữ liệu báo cáo thiết bị với danh sách thiết bị được phân trang.
     */
    public ReportData buildReport(int offset, int pageSize) throws SQLException {
        return createReport(equipmentDAO.findWithIssueCounts(offset, pageSize));
    }

    /**
     * Tổng hợp số liệu thiết bị, số liệu sự cố, danh sách thiết bị và sự cố gần đây cho trang báo cáo.
     */
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

    /**
     * Đếm tổng số thiết bị chưa bị xóa mềm để phân trang báo cáo.
     */
    public int countReportEquipments() throws SQLException {
        return equipmentDAO.countActiveEquipments();
    }

    /**
     * Lấy danh sách thiết bị đang hoạt động trong hệ thống để hiển thị trong các form chọn thiết bị.
     */
    public List<Equipment> findEquipmentOptions() throws SQLException {
        return equipmentDAO.findAllActive();
    }

    /**
     * Kiểm tra dữ liệu bắt buộc và các giá trị hợp lệ trước khi lưu thiết bị.
     */
    private void validateEquipment(Equipment equipment) {
        if (isBlank(equipment.getEquipmentCode())) {
            throw new IllegalArgumentException("Mã thiết bị là bắt buộc.");
        }
        if (isBlank(equipment.getEquipmentName())) {
            throw new IllegalArgumentException("Tên thiết bị là bắt buộc.");
        }
        if (equipment.getPurchaseDate() == null) {
            throw new IllegalArgumentException("Ngày mua là bắt buộc.");
        }
        if (equipment.getWarrantyDate() == null) {
            throw new IllegalArgumentException("Ngày hết hạn bảo hành là bắt buộc.");
        }
        if (equipment.getWarrantyDate().isBefore(equipment.getPurchaseDate())) {
            throw new IllegalArgumentException("Ngày hết hạn bảo hành không được trước ngày mua.");
        }
        if (isBlank(equipment.getLocation())) {
            throw new IllegalArgumentException("Vị trí thiết bị là bắt buộc.");
        }
        if (isBlank(equipment.getImageUrl())) {
            throw new IllegalArgumentException("Ảnh thiết bị là bắt buộc.");
        }
        if (!isValidEquipmentType(equipment.getEquipmentType())) {
            throw new IllegalArgumentException("Loại thiết bị không hợp lệ.");
        }
        if (!isValidEquipmentStatus(equipment.getStatus())) {
            throw new IllegalArgumentException("Trạng thái thiết bị không hợp lệ.");
        }
    }

    /**
     * Kiểm tra dữ liệu bắt buộc trước khi tạo báo cáo sự cố thiết bị.
     */
    private void validateIssueForCreate(EquipmentIssue issue) {
        if (issue.getEquipmentId() <= 0) {
            throw new IllegalArgumentException("Vui lòng chọn thiết bị.");
        }
        if (issue.getReportedBy() <= 0) {
            throw new IllegalArgumentException("Người báo cáo là bắt buộc.");
        }
        if (isBlank(issue.getCreatedBy())) {
            throw new IllegalArgumentException("Tên người báo cáo là bắt buộc.");
        }
        if (isBlank(issue.getIssueType())) {
            throw new IllegalArgumentException("Loại sự cố là bắt buộc.");
        }
    }

    /**
     * Kiểm tra dữ liệu bắt buộc và trạng thái hợp lệ trước khi cập nhật sự cố.
     */
    private void validateIssueForUpdate(EquipmentIssue issue) {
        if (issue.getIssueId() <= 0) {
            throw new IllegalArgumentException("Vui lòng chọn sự cố.");
        }
        validateIssueForCreate(issue);
        if (!isValidIssueStatus(issue.getStatus())) {
            throw new IllegalArgumentException("Trạng thái sự cố không hợp lệ.");
        }
    }

    /**
     * Kiểm tra trạng thái thiết bị có thuộc các trạng thái hệ thống hỗ trợ hay không.
     */
    private boolean isValidEquipmentStatus(String status) {
        return STATUS_AVAILABLE.equals(status) || STATUS_MAINTENANCE.equals(status) || STATUS_BROKEN.equals(status);
    }

    /**
     * Kiểm tra loại thiết bị có thuộc các loại hệ thống hỗ trợ hay không.
     */
    private boolean isValidEquipmentType(String type) {
        return TYPE_CARDIO.equals(type) || TYPE_STRENGTH.equals(type) || TYPE_MACHINE.equals(type)
                || TYPE_ACCESSORY.equals(type) || TYPE_OTHER.equals(type);
    }

    /**
     * Kiểm tra trạng thái sự cố có thuộc các trạng thái hệ thống hỗ trợ hay không.
     */
    private boolean isValidIssueStatus(String status) {
        return ISSUE_PENDING.equals(status) || ISSUE_IN_PROGRESS.equals(status) || ISSUE_RESOLVED.equals(status);
    }

    /**
     * Chuẩn hóa chuỗi rỗng thành null để truyền xuống DAO làm điều kiện lọc.
     */
    private String normalizeBlank(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }

    /**
     * Kiểm tra chuỗi null hoặc rỗng.
     */
    private boolean isBlank(String value) {
        return value == null || value.isBlank();
    }

    public static class ReportData {
        private final Map<String, Integer> equipmentCounts;
        private final Map<String, Integer> issueCounts;
        private final List<Equipment> equipments;
        private final List<EquipmentIssue> recentIssues;

        /**
         * Tạo đối tượng dữ liệu báo cáo từ các nhóm số liệu đã truy vấn.
         */
        public ReportData(Map<String, Integer> equipmentCounts, Map<String, Integer> issueCounts,
                List<Equipment> equipments, List<EquipmentIssue> recentIssues) {
            this.equipmentCounts = new HashMap<>(equipmentCounts);
            this.issueCounts = new HashMap<>(issueCounts);
            this.equipments = equipments;
            this.recentIssues = recentIssues;
        }

        /**
         * Tính tổng số thiết bị theo các trạng thái đang được báo cáo.
         */
        public int getTotalEquipment() {
            return getAvailable() + getMaintenance() + getBroken();
        }

        /**
         * Trả về số thiết bị đang hoạt động.
         */
        public int getAvailable() {
            return equipmentCounts.getOrDefault(STATUS_AVAILABLE, 0);
        }

        /**
         * Trả về số thiết bị đang bảo trì.
         */
        public int getMaintenance() {
            return equipmentCounts.getOrDefault(STATUS_MAINTENANCE, 0);
        }

        /**
         * Trả về số thiết bị đang hỏng.
         */
        public int getBroken() {
            return equipmentCounts.getOrDefault(STATUS_BROKEN, 0);
        }

        /**
         * Tính tổng số sự cố theo các trạng thái đang được báo cáo.
         */
        public int getTotalIssues() {
            return getPendingIssues() + getInProgressIssues() + getResolvedIssues();
        }

        /**
         * Tính tỷ lệ phần trăm thiết bị đang hoạt động trên tổng thiết bị.
         */
        public double getActiveRatePercent() {
            if (getTotalEquipment() == 0) {
                return 0;
            }
            return Math.round((getAvailable() * 1000.0) / getTotalEquipment()) / 10.0;
        }

        /**
         * Định dạng tỷ lệ thiết bị đang hoạt động để hiển thị trên JSP.
         */
        public String getActiveRateDisplay() {
            return formatNumber(getActiveRatePercent());
        }

        /**
         * Tính số thiết bị cần chú ý gồm thiết bị bảo trì và thiết bị hỏng.
         */
        public int getNeedsAttentionEquipment() {
            return getMaintenance() + getBroken();
        }

        /**
         * Tính tỷ lệ thiết bị cần chú ý trên tổng số thiết bị.
         */
        public double getNeedsAttentionRatePercent() {
            if (getTotalEquipment() == 0) {
                return 0;
            }
            return Math.round((getNeedsAttentionEquipment() * 1000.0) / getTotalEquipment()) / 10.0;
        }

        /**
         * Định dạng tỷ lệ thiết bị cần chú ý để hiển thị trên JSP.
         */
        public String getNeedsAttentionRateDisplay() {
            return formatNumber(getNeedsAttentionRatePercent());
        }

        /**
         * Tính số sự cố đang mở gồm chờ xử lý và đang xử lý.
         */
        public int getOpenIssues() {
            return getPendingIssues() + getInProgressIssues();
        }

        /**
         * Tính tỷ lệ sự cố đã xử lý trên tổng số sự cố.
         */
        public double getResolvedIssueRatePercent() {
            if (getTotalIssues() == 0) {
                return 0;
            }
            return Math.round((getResolvedIssues() * 1000.0) / getTotalIssues()) / 10.0;
        }

        /**
         * Định dạng tỷ lệ sự cố đã xử lý để hiển thị trên JSP.
         */
        public String getResolvedIssueRateDisplay() {
            return formatNumber(getResolvedIssueRatePercent());
        }

        /**
         * Tính số sự cố trung bình trên mỗi thiết bị.
         */
        public double getIssuesPerEquipment() {
            if (getTotalEquipment() == 0) {
                return 0;
            }
            return Math.round((getTotalIssues() * 10.0) / getTotalEquipment()) / 10.0;
        }

        /**
         * Định dạng số sự cố trung bình trên mỗi thiết bị để hiển thị trên JSP.
         */
        public String getIssuesPerEquipmentDisplay() {
            return formatNumber(getIssuesPerEquipment());
        }

        /**
         * Trả về số sự cố đang chờ xử lý.
         */
        public int getPendingIssues() {
            return issueCounts.getOrDefault(ISSUE_PENDING, 0);
        }

        /**
         * Trả về số sự cố đang xử lý.
         */
        public int getInProgressIssues() {
            return issueCounts.getOrDefault(ISSUE_IN_PROGRESS, 0);
        }

        /**
         * Trả về số sự cố đã xử lý.
         */
        public int getResolvedIssues() {
            return issueCounts.getOrDefault(ISSUE_RESOLVED, 0);
        }

        /**
         * Trả về danh sách thiết bị dùng trong bảng báo cáo.
         */
        public List<Equipment> getEquipments() {
            return equipments;
        }

        /**
         * Trả về danh sách sự cố gần đây dùng trong trang báo cáo.
         */
        public List<EquipmentIssue> getRecentIssues() {
            return recentIssues;
        }

        /**
         * Định dạng số dạng nguyên hoặc một chữ số thập phân để hiển thị gọn.
         */
        private String formatNumber(double value) {
            if (value == Math.rint(value)) {
                return String.valueOf((int) value);
            }
            return String.format(Locale.US, "%.1f", value);
        }
    }
}

