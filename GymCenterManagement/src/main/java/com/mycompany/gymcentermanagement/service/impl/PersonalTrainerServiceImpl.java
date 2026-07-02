/**
 * =========================================================================
 * @file          : PersonalTrainerServiceImpl.java
 * @description   : Lớp triển khai nghiệp vụ (Service) quản lý hồ sơ và trạng thái hoạt động của PT.
 * @author        : Nguyễn Đình Phú (phund)
 * @created       : 2026-06-02
 * @last_modified : 2026-06-26 bởi Antigravity Agent
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.BaseDAO;
import com.mycompany.gymcentermanagement.dao.PersonalTrainerDAO;
import com.mycompany.gymcentermanagement.dao.UserDAO;
import com.mycompany.gymcentermanagement.dao.impl.PersonalTrainerDAOImpl;
import com.mycompany.gymcentermanagement.dao.impl.UserDAOImpl;
import com.mycompany.gymcentermanagement.model.entity.PersonalTrainer;
import com.mycompany.gymcentermanagement.model.entity.User;
import com.mycompany.gymcentermanagement.service.PersonalTrainerService;
import com.mycompany.gymcentermanagement.utils.DBContext;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class PersonalTrainerServiceImpl implements PersonalTrainerService {
    private final PersonalTrainerDAO personalTrainerDAO = new PersonalTrainerDAOImpl();
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    public PersonalTrainer getPersonalTrainerById(int id) {
        return personalTrainerDAO.findById(id);
    }

    @Override
    public boolean updateProfile(PersonalTrainer pt) throws SQLException {
        PersonalTrainer oldData = personalTrainerDAO.findById(pt.getPtId());

        if (oldData == null) {
            return false;
        }

        if (pt.getAvatarPath() == null || pt.getAvatarPath().trim().isEmpty()) {
            pt.setAvatarPath(oldData.getAvatarPath());
        }

        return personalTrainerDAO.updateProfile(pt);
    }

    @Override
    public PersonalTrainer getPTByUserId(int userId) {
        return personalTrainerDAO.findPTByUserId(userId);
    }

    @Override
    public boolean updatePTStatus(int ptId, String status) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            ((BaseDAO) personalTrainerDAO).setConnection(conn);
            ((BaseDAO) userDAO).setConnection(conn);

            PersonalTrainer pt = personalTrainerDAO.findById(ptId);
            if (pt == null) {
                conn.rollback();
                return false;
            }

            boolean ptUpdated = personalTrainerDAO.updateTrainerStatus(ptId, status, "System");

            User.AccountStatus userStatus = "Active".equalsIgnoreCase(status) ? User.AccountStatus.Active : User.AccountStatus.Locked;
            boolean userUpdated = userDAO.updateAccountStatus(pt.getUserId(), userStatus, "System");

            if (ptUpdated && userUpdated) {
                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            ((BaseDAO) personalTrainerDAO).setConnection(null);
            ((BaseDAO) userDAO).setConnection(null);
        }
    }

    @Override
    public boolean updatePersonalTrainer(PersonalTrainer pt) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            ((BaseDAO) personalTrainerDAO).setConnection(conn);
            ((BaseDAO) userDAO).setConnection(conn);

            boolean ptUpdated = personalTrainerDAO.updatePersonalTrainer(pt);

            User.AccountStatus userStatus = "Active".equalsIgnoreCase(pt.getStatus()) ? User.AccountStatus.Active : User.AccountStatus.Locked;
            boolean userUpdated = userDAO.updateAccountStatus(pt.getUserId(), userStatus, pt.getUpdatedBy());

            if (ptUpdated && userUpdated) {
                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            ((BaseDAO) personalTrainerDAO).setConnection(null);
            ((BaseDAO) userDAO).setConnection(null);
        }
    }

    @Override
    public boolean createPersonalTrainer(PersonalTrainer pt) {
        return personalTrainerDAO.insertPersonalTrainer(pt);
    }

    @Override
    public List<PersonalTrainer> getActiveTrainers() {
        return personalTrainerDAO.findActiveTrainers();
    }

    @Override
    public List<PersonalTrainer> searchActiveTrainers(String keyword, List<String> specializations) {
        return personalTrainerDAO.searchActiveTrainers(keyword, specializations);
    }

    @Override
    public List<PersonalTrainer> searchTrainersForManagement(String keyword, List<String> specializations, String status) {
        return personalTrainerDAO.searchTrainersForManagement(keyword, specializations, status);
    }

    @Override
    public List<com.mycompany.gymcentermanagement.dto.PTMemberDTO> getActiveMembersForPT(int ptId) {
        return personalTrainerDAO.getActiveMembersForPT(ptId);
    }

    @Override
    public int getActiveMembersForPTCount(int ptId) {
        return personalTrainerDAO.getActiveMembersForPTCount(ptId);
    }

    @Override
    public List<com.mycompany.gymcentermanagement.dto.PTMemberDTO> getActiveMembersForPTPaginated(int ptId, int offset, int limit) {
        return personalTrainerDAO.getActiveMembersForPTPaginated(ptId, offset, limit);
    }
}
