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
        pkg.setCreatedDate(LocalDateTime.now());
        pkg.setDeleted(false);
        return gymPackageDAO.insert(pkg);
    }

    @Override
    public boolean updatePackage(GymPackage pkg) throws SQLException {
        pkg.setUpdatedDate(LocalDateTime.now());
        return gymPackageDAO.update(pkg);
    }

    @Override
    public boolean deletePackage(int id) throws SQLException {
        return gymPackageDAO.delete(id);
    }
}
