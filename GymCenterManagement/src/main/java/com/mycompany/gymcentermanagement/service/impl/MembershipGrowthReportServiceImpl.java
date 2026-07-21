/**
 * =========================================================================
 * @file          : MembershipGrowthReportServiceImpl.java
 * @description   : Implementation of MembershipGrowthReportService
 * @author        : Nguyễn Trí Linh (linhnt)
 * @created       : 2026-07-08
 * @last_modified : 2026-07-08 bởi Nguyễn Trí Linh (linhnt)
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service.impl;

import com.mycompany.gymcentermanagement.dao.MembershipGrowthReportDAO;
import com.mycompany.gymcentermanagement.dao.impl.MembershipGrowthReportDAOImpl;
import com.mycompany.gymcentermanagement.dto.MembershipGrowthChartPoint;
import com.mycompany.gymcentermanagement.dto.MembershipGrowthMember;
import com.mycompany.gymcentermanagement.dto.MembershipGrowthSummary;
import com.mycompany.gymcentermanagement.service.MembershipGrowthReportService;
import java.sql.SQLException;
import java.util.List;

public class MembershipGrowthReportServiceImpl implements MembershipGrowthReportService {

    private final MembershipGrowthReportDAO reportDAO = new MembershipGrowthReportDAOImpl();

    /**
     * Lấy danh sách các năm có dữ liệu phát triển hội viên.
     * Luồng nghiệp vụ: Truy vấn CSDL để lấy tất cả các năm có hội viên đăng ký hoặc kích hoạt.
     * 
     * @return Danh sách các năm
     * @throws SQLException Nếu có lỗi truy xuất CSDL
     */
    @Override
    public List<Integer> getAvailableYears() throws SQLException {
        return reportDAO.getAvailableYears();
    }

    /**
     * Lấy thông tin tóm tắt về phát triển hội viên trong một khoảng thời gian.
     * Luồng nghiệp vụ: Tính toán tổng số hội viên mới, số hội viên đang hoạt động, số hội viên hết hạn theo năm và tháng (nếu có).
     * 
     * @param year Năm cần xem
     * @param month Tháng cần xem (có thể null nếu xem cả năm)
     * @return Đối tượng chứa dữ liệu tóm tắt
     * @throws SQLException Nếu có lỗi truy xuất CSDL
     */
    @Override
    public MembershipGrowthSummary getSummary(int year, Integer month) throws SQLException {
        return reportDAO.getSummary(year, month);
    }

    /**
     * Lấy dữ liệu cho biểu đồ phát triển hội viên.
     * Luồng nghiệp vụ: 
     * - Nếu xem theo năm, trả về dữ liệu tổng hợp theo từng tháng.
     * - Nếu xem theo tháng, trả về dữ liệu tổng hợp theo từng ngày trong tháng đó.
     * 
     * @param year Năm cần xem
     * @param month Tháng cần xem (có thể null nếu xem theo năm)
     * @return Danh sách các điểm dữ liệu trên biểu đồ
     * @throws SQLException Nếu có lỗi truy xuất CSDL
     */
    @Override
    public List<MembershipGrowthChartPoint> getGrowthChart(int year, Integer month) throws SQLException {
        return reportDAO.getGrowthChart(year, month);
    }

    /**
     * Lấy danh sách hội viên theo trạng thái phát triển (mới, đang hoạt động, hết hạn).
     * Luồng nghiệp vụ: Lấy danh sách phân trang các hội viên phù hợp với bộ lọc thời gian và từ khóa.
     * 
     * @param year Năm cần lọc
     * @param month Tháng cần lọc (có thể null)
     * @param status Trạng thái cần lọc (NEW, ACTIVE, EXPIRED)
     * @param searchKeyword Từ khóa tìm kiếm
     * @param offset Vị trí bắt đầu
     * @param limit Số lượng tối đa
     * @return Danh sách hội viên
     * @throws SQLException Nếu có lỗi truy xuất CSDL
     */
    @Override
    public List<MembershipGrowthMember> getMemberGrowthList(int year, Integer month, String status,
            String searchKeyword, int offset, int limit) throws SQLException {
        return reportDAO.getMemberGrowthList(year, month, status, searchKeyword, offset, limit);
    }

    /**
     * Đếm tổng số hội viên dựa trên bộ lọc.
     * Luồng nghiệp vụ: Phục vụ cho việc tính toán tổng số trang trong tính năng phân trang.
     * 
     * @param year Năm cần lọc
     * @param month Tháng cần lọc (có thể null)
     * @param status Trạng thái cần lọc (NEW, ACTIVE, EXPIRED)
     * @param searchKeyword Từ khóa tìm kiếm
     * @return Tổng số lượng hội viên
     * @throws SQLException Nếu có lỗi truy xuất CSDL
     */
    @Override
    public int countMembers(int year, Integer month, String status, String searchKeyword) throws SQLException {
        return reportDAO.countMembers(year, month, status, searchKeyword);
    }

    /**
     * Lấy danh sách hội viên mới.
     * Luồng nghiệp vụ: Lấy các hội viên bắt đầu đăng ký gói trong khoảng thời gian được chọn.
     */
    @Override
    public List<MembershipGrowthMember> getNewMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException {
        return reportDAO.getNewMembers(year, month, searchKeyword, offset, limit);
    }

    /**
     * Lấy danh sách hội viên đang hoạt động.
     * Luồng nghiệp vụ: Lấy các hội viên có gói tập đang trong thời gian hiệu lực tại thời điểm xét.
     */
    @Override
    public List<MembershipGrowthMember> getActiveMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException {
        return reportDAO.getActiveMembers(year, month, searchKeyword, offset, limit);
    }

    /**
     * Lấy danh sách hội viên đã hết hạn.
     * Luồng nghiệp vụ: Lấy các hội viên có gói tập đã kết thúc trong khoảng thời gian được chọn.
     */
    @Override
    public List<MembershipGrowthMember> getExpiredMembers(int year, Integer month, String searchKeyword,
            int offset, int limit) throws SQLException {
        return reportDAO.getExpiredMembers(year, month, searchKeyword, offset, limit);
    }
}
