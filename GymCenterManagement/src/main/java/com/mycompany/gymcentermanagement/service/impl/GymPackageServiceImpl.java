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

    @Override
    public List<GymPackage> getAllPackages() throws SQLException {
        return gymPackageDAO.findAll();
    }

    @Override
    public List<GymPackage> getActivePackages() throws SQLException {
        return gymPackageDAO.findAllActive();
    }

    @Override
    public GymPackage getPackageById(int id) throws SQLException {
        return gymPackageDAO.findById(id);
    }

    @Override
    public boolean createPackage(GymPackage pkg) throws SQLException {
        // Tự động gán thời gian tạo hiện tại và đặt cờ IsDeleted = false (0) trước khi insert
        pkg.setCreatedDate(LocalDateTime.now());
        pkg.setDeleted(false);
        return gymPackageDAO.insert(pkg);
    }

    @Override
    public boolean updatePackage(GymPackage pkg) throws SQLException {
        // Cập nhật thời gian UpdatedDate tự động khi thực hiện thay đổi thông tin
        pkg.setUpdatedDate(LocalDateTime.now());
        return gymPackageDAO.update(pkg);
    }

    @Override
    public boolean deletePackage(int id) throws SQLException {
        // Chuyển tiếp lệnh xóa xuống DAO (Thực tế là Soft Delete)
        return gymPackageDAO.delete(id);
    }

    @Override
    public boolean isPackageNameExists(String name, int excludeId) throws SQLException {
        GymPackage pkg = gymPackageDAO.findByName(name);
        if (pkg == null) {
            return false;
        }
        return pkg.getPackageId() != excludeId;
    }

    @Override
    public int getPackagesCount() throws SQLException {
        return gymPackageDAO.countAll();
    }

    @Override
    public List<GymPackage> getPackagesPaginated(int offset, int limit) throws SQLException {
        return gymPackageDAO.findAllPaginated(offset, limit);
    }
}
