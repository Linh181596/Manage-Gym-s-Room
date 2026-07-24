package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.PTPackageTypeDAO;
import com.mycompany.gymcentermanagement.dao.impl.PTPackageTypeDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.PTPackageType;
import com.mycompany.gymcentermanagement.service.PTPackageTypeService;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

public class PTPackageTypeServiceImpl implements PTPackageTypeService {

    private final PTPackageTypeDAO ptPackageTypeDAO = new PTPackageTypeDAOImpl();

    @Override
    public List<PTPackageType> getAllPackages() throws SQLException {
        return ptPackageTypeDAO.findAll();
    }

    @Override
    public List<PTPackageType> getActivePackages() throws SQLException {
        return ptPackageTypeDAO.findAllActive();
    }

    @Override
    public List<PTPackageType> getPackagesByStatus(String status) throws SQLException {
        return ptPackageTypeDAO.findByStatus(status);
    }

    @Override
    public PTPackageType getPackageById(int id) throws SQLException {
        return ptPackageTypeDAO.findById(id);
    }

    @Override
    public boolean createPackage(PTPackageType pkg) throws SQLException {
        // 1. Kiểm tra thông tin bắt buộc
        if (pkg.getPackageName() == null || pkg.getPackageName().trim().isEmpty()) {
            throw new IllegalArgumentException("Tên gói tập không được để trống.");
        }
        if (pkg.getDurationMonths() <= 0) {
            throw new IllegalArgumentException("Hạn sử dụng gói tập (số tháng) phải lớn hơn 0.");
        }
        if (pkg.getNumberOfSessions() <= 0) {
            throw new IllegalArgumentException("Số buổi tập của gói phải lớn hơn 0.");
        }

        // 2. Kiểm tra trùng tên gói tập
        if (isPackageNameExists(pkg.getPackageName().trim(), 0)) {
            throw new IllegalArgumentException("Tên gói tập này đã tồn tại trong hệ thống.");
        }

        // 3. Thiết lập thông tin mặc định
        pkg.setPackageName(pkg.getPackageName().trim());
        if (pkg.getStatus() == null || pkg.getStatus().trim().isEmpty()) {
            pkg.setStatus("Active");
        }
        pkg.setCreatedDate(LocalDateTime.now());
        pkg.setDeleted(false);

        return ptPackageTypeDAO.insert(pkg);
    }

    @Override
    public boolean updatePackage(PTPackageType pkg) throws SQLException {
        // 1. Kiểm tra gói tập có tồn tại hay không
        PTPackageType existing = ptPackageTypeDAO.findById(pkg.getPtPackageTypeId());
        if (existing == null) {
            throw new IllegalArgumentException("Gói tập không tồn tại trong hệ thống.");
        }

        // 2. Kiểm tra thông tin bắt buộc
        if (pkg.getPackageName() == null || pkg.getPackageName().trim().isEmpty()) {
            throw new IllegalArgumentException("Tên gói tập không được để trống.");
        }
        if (pkg.getDurationMonths() <= 0) {
            throw new IllegalArgumentException("Hạn sử dụng gói tập (số tháng) phải lớn hơn 0.");
        }
        if (pkg.getNumberOfSessions() <= 0) {
            throw new IllegalArgumentException("Số buổi tập của gói phải lớn hơn 0.");
        }

        // 3. Kiểm tra trùng tên với gói khác
        if (isPackageNameExists(pkg.getPackageName().trim(), pkg.getPtPackageTypeId())) {
            throw new IllegalArgumentException("Tên gói tập này đã tồn tại ở một gói khác.");
        }

        // 4. Cập nhật thông tin
        pkg.setPackageName(pkg.getPackageName().trim());
        pkg.setUpdatedDate(LocalDateTime.now());

        return ptPackageTypeDAO.update(pkg);
    }

    @Override
    public boolean deletePackage(int id) throws SQLException {
        PTPackageType existing = ptPackageTypeDAO.findById(id);
        if (existing == null) {
            throw new IllegalArgumentException("Gói tập không tồn tại trong hệ thống.");
        }
        return ptPackageTypeDAO.delete(id);
    }

    @Override
    public boolean isPackageNameExists(String name, int excludeId) throws SQLException {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }
        PTPackageType pkg = ptPackageTypeDAO.findByName(name.trim());
        if (pkg == null) {
            return false;
        }
        return pkg.getPtPackageTypeId() != excludeId;
    }
}
