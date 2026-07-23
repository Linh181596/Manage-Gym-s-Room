/**
 * =========================================================================
 * @file          : GymPackageServiceImpl.java
 * @description   : Lop trien khai cac dich vu nghiep vu CRUD cho GymPackage
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-03 boi Nguyen Hoang Thang
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.GymPackageDAO;
import com.mycompany.gymcentermanagement.dao.impl.GymPackageDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.GymPackage;
import com.mycompany.gymcentermanagement.service.GymPackageService;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

public class GymPackageServiceImpl implements GymPackageService {

    private final GymPackageDAO gymPackageDAO = new GymPackageDAOImpl();

    /**
     * Lấy tất cả các gói tập (cho quản lý).
     * Luồng nghiệp vụ: Gọi DAO để lấy danh sách toàn bộ gói tập chưa bị xóa.
     * 
     * @return Danh sách GymPackage
     * @throws SQLException
     */
    @Override
    public List<GymPackage> getAllPackages() throws SQLException {
        return gymPackageDAO.findAll();
    }

    /**
     * Lấy danh sách gói tập đang hoạt động (cho người dùng đăng ký).
     * Luồng nghiệp vụ: Gọi DAO lấy danh sách gói có trạng thái Active.
     * 
     * @return Danh sách GymPackage
     * @throws SQLException
     */
    @Override
    public List<GymPackage> getActivePackages() throws SQLException {
        return gymPackageDAO.findAllActive();
    }

    /**
     * Lấy thông tin gói tập theo ID.
     * Luồng nghiệp vụ: Tìm gói tập qua ID từ DAO.
     * 
     * @param id PackageID
     * @return Đối tượng GymPackage
     * @throws SQLException
     */
    @Override
    public GymPackage getPackageById(int id) throws SQLException {
        return gymPackageDAO.findById(id);
    }

    /**
     * Tạo mới một gói tập.
     * Luồng nghiệp vụ: Cập nhật thông tin thời gian tạo, đặt IsDeleted=false và gọi DAO để lưu.
     * [BR-CONS-06]: Membership packages must have valid duration and pricing information.
     * [BR-CONS-58]: Configurations Duration (Months) must be in range 1-120 and Sessions in 1-500.
     * (Việc kiểm tra valid được thực hiện ở controller trước khi gọi hàm này)
     * 
     * @param pkg Thông tin gói tập mới
     * @return true nếu tạo thành công
     * @throws SQLException
     */
    @Override
    public boolean createPackage(GymPackage pkg) throws SQLException {
        // Tự động gán thời gian tạo hiện tại và đặt cờ IsDeleted = false (0) trước khi insert
        pkg.setCreatedDate(LocalDateTime.now());
        pkg.setDeleted(false);
        return gymPackageDAO.insert(pkg);
    }

    /**
     * Cập nhật thông tin gói tập hiện có.
     * Luồng nghiệp vụ: Cập nhật thời gian UpdatedDate và gọi DAO để update dữ liệu.
     * [BR-CONS-06]: Membership packages must have valid duration and pricing information.
     * 
     * @param pkg Thông tin gói tập cập nhật
     * @return true nếu cập nhật thành công
     * @throws SQLException
     */
    @Override
    public boolean updatePackage(GymPackage pkg) throws SQLException {
        // Cập nhật thời gian UpdatedDate tự động khi thực hiện thay đổi thông tin
        pkg.setUpdatedDate(LocalDateTime.now());
        return gymPackageDAO.update(pkg);
    }

    /**
     * Xóa mềm gói tập.
     * Luồng nghiệp vụ: Gọi lệnh soft delete từ DAO.
     * [BR-CONS-59]: Deleting a package type must be executed as a soft delete to preserve historical data.
     * 
     * @param id PackageID cần xóa
     * @return true nếu xóa thành công
     * @throws SQLException
     */
    @Override
    public boolean deletePackage(int id) throws SQLException {
        // Chuyển tiếp lệnh xóa xuống DAO (Thực tế là Soft Delete)
        return gymPackageDAO.delete(id);
    }

    /**
     * Kiểm tra tính duy nhất của tên gói tập.
     * Luồng nghiệp vụ: Gọi DAO tìm theo tên, kiểm tra xem kết quả có bị trùng với gói khác (khác excludeId) không.
     * [BR-CONS-57]: Each package type name must be unique in the system.
     * 
     * @param name Tên gói tập cần kiểm tra
     * @param excludeId PackageID bỏ qua (khi update)
     * @return true nếu tên đã tồn tại
     * @throws SQLException
     */
    @Override
    public boolean isPackageNameExists(String name, int excludeId) throws SQLException {
        GymPackage pkg = gymPackageDAO.findByName(name);
        if (pkg == null) {
            return false;
        }
        return pkg.getPackageId() != excludeId;
    }

    /**
     * Lấy tổng số lượng gói tập.
     * Luồng nghiệp vụ: Gọi DAO đếm tổng bản ghi chưa xóa.
     * 
     * @return Tổng số gói
     * @throws SQLException
     */
    @Override
    public int getPackagesCount() throws SQLException {
        return gymPackageDAO.countAll();
    }

    /**
     * Lấy danh sách gói tập theo phân trang.
     * Luồng nghiệp vụ: Gọi DAO lấy dữ liệu với OFFSET FETCH.
     * 
     * @param offset Vị trí bắt đầu
     * @param limit Số bản ghi mỗi trang
     * @return Danh sách gói tập
     * @throws SQLException
     */
    @Override
    public List<GymPackage> getPackagesPaginated(int offset, int limit) throws SQLException {
        return gymPackageDAO.findAllPaginated(offset, limit);
    }
}
