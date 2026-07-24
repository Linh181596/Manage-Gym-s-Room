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

    /**
     * Lấy thông tin huấn luyện viên cá nhân theo ID.
     * Luồng nghiệp vụ: Gọi DAO để tìm PT dựa trên PTID, bỏ qua các bản ghi bị xóa mềm.
     * 
     * @param id PTID
     * @return Đối tượng PersonalTrainer
     */
    @Override
    public PersonalTrainer getPersonalTrainerById(int id) {
        return personalTrainerDAO.findById(id);
    }

    /**
     * Cập nhật hồ sơ công khai của PT (bởi chính PT).
     * Luồng nghiệp vụ: Lấy dữ liệu cũ, so sánh avatar. Nếu không cập nhật avatar mới thì giữ nguyên avatar cũ.
     * [BR-ACT-44]: Personal Trainers can update their public profile, including their avatar, description, and specialization.
     * 
     * @param pt Đối tượng PersonalTrainer chứa thông tin cập nhật
     * @return true nếu thành công
     * @throws SQLException
     */
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

    /**
     * Lấy thông tin PT dựa trên UserID.
     * Luồng nghiệp vụ: Mỗi PT liên kết với 1 tài khoản User. Truy vấn DAO bằng UserID.
     * 
     * @param userId UserID của tài khoản đăng nhập
     * @return Đối tượng PersonalTrainer
     */
    @Override
    public PersonalTrainer getPTByUserId(int userId) {
        return personalTrainerDAO.findPTByUserId(userId);
    }

    /**
     * Cập nhật trạng thái hoạt động của PT (bởi Admin/Staff).
     * Luồng nghiệp vụ: Sử dụng Transaction. Cập nhật Status trong bảng PersonalTrainers.
     * Đồng thời đồng bộ AccountStatus trong bảng Users.
     * [BR-CONS-28]: If the PT status is set to Inactive, the system must automatically lock the corresponding User account.
     * [BR-ACT-20], [BR-ACT-21]: Admin can manage PT status.
     * 
     * @param ptId PTID cần cập nhật
     * @param status Trạng thái mới (Active/Inactive)
     * @return true nếu thành công
     */
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

    /**
     * Cập nhật toàn bộ thông tin PT (bởi Admin).
     * Luồng nghiệp vụ: Sử dụng Transaction cập nhật thông tin PT và đồng bộ trạng thái User.
     * [BR-CONS-28]: If the PT status is set to Inactive, the system must automatically lock the corresponding User account.
     * 
     * @param pt Thông tin PT cần cập nhật
     * @return true nếu cập nhật thành công
     */
    @Override
    public boolean updatePersonalTrainer(PersonalTrainer pt) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            ((BaseDAO) personalTrainerDAO).setConnection(conn);

            boolean ptUpdated = personalTrainerDAO.updatePersonalTrainer(pt);

            if (ptUpdated) {
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
        }
    }

    /**
     * Thêm mới một hồ sơ PT.
     * Luồng nghiệp vụ: Gọi DAO insert thông tin PT vào hệ thống.
     * [BR-ACT-08]: Admin can create a new Personal Trainer profile linked to an existing User account.
     * 
     * @param pt Đối tượng PersonalTrainer
     * @return true nếu thêm thành công
     */
    @Override
    public boolean createPersonalTrainer(PersonalTrainer pt) {
        return personalTrainerDAO.insertPersonalTrainer(pt);
    }

    /**
     * Lấy danh sách PT đang hoạt động để hiển thị công khai (Guest/Member xem).
     * 
     * @return Danh sách PT Active
     */
    @Override
    public List<PersonalTrainer> getActiveTrainers() {
        return personalTrainerDAO.findActiveTrainers();
    }

    /**
     * Tìm kiếm PT đang hoạt động theo từ khóa và chuyên môn (Guest/Member tìm kiếm).
     * 
     * @param keyword Từ khóa
     * @param specializations Danh sách chuyên môn
     * @return Danh sách PT
     */
    @Override
    public List<PersonalTrainer> searchActiveTrainers(String keyword, List<String> specializations) {
        return personalTrainerDAO.searchActiveTrainers(keyword, specializations);
    }

    /**
     * Tìm kiếm PT để quản lý (Admin/Staff xem).
     * Bao gồm tất cả trạng thái.
     * 
     * @param keyword Từ khóa
     * @param specializations Danh sách chuyên môn
     * @param status Trạng thái
     * @return Danh sách PT
     */
    @Override
    public List<PersonalTrainer> searchTrainersForManagement(String keyword, List<String> specializations, String status) {
        return personalTrainerDAO.searchTrainersForManagement(keyword, specializations, status);
    }

    /**
     * Lấy danh sách thành viên đang theo học PT.
     * [BR-ACT-45], [BR-ACT-46]: Personal Trainers can view their enrolled members and their progress.
     * 
     * @param ptId PTID
     * @return Danh sách PTMemberDTO
     */
    @Override
    public List<com.mycompany.gymcentermanagement.dto.PTMemberDTO> getActiveMembersForPT(int ptId) {
        return personalTrainerDAO.getActiveMembersForPT(ptId);
    }

    /**
     * Đếm tổng số lượng học viên đang active của PT.
     * 
     * @param ptId PTID
     * @return Tổng số học viên
     */
    @Override
    public int getActiveMembersForPTCount(int ptId) {
        return personalTrainerDAO.getActiveMembersForPTCount(ptId);
    }

    /**
     * Lấy danh sách học viên theo học PT, có phân trang.
     * 
     * @param ptId PTID
     * @param offset Vị trí bắt đầu
     * @param limit Số bản ghi mỗi trang
     * @return Danh sách học viên
     */
    @Override
    public List<com.mycompany.gymcentermanagement.dto.PTMemberDTO> getActiveMembersForPTPaginated(int ptId, int offset, int limit) {
        return personalTrainerDAO.getActiveMembersForPTPaginated(ptId, offset, limit);
    }
}
