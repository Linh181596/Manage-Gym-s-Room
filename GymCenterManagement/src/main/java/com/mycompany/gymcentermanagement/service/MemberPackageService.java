/**
 * =========================================================================
 * @file          : MemberPackageService.java
 * @description   : Interface dinh nghia cac dich vu dang ky goi tap va lay danh sach khach hang
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-03 boi Nguyen Hoang Thang
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.Invoice;
import com.mycompany.gymcentermanagement.model.entity.MemberPackage;
import java.sql.SQLException;
import java.util.List;

public interface MemberPackageService {
    List<Member> getActiveMembers() throws SQLException;
    Invoice registerMemberPackage(int memberId, int packageId, int staffUserId) throws SQLException;
    MemberPackage getActivePackageByMemberId(int memberId) throws SQLException;
    MemberPackage getLatestPackageByMemberId(int memberId) throws SQLException;
    List<MemberPackage> findAllActivePackagesByMemberId(int memberId) throws SQLException;
    Invoice renewMemberPackage(int memberId, int packageId, int staffUserId) throws SQLException;
    Invoice transferMemberPackage(int senderPkgId, int receiverMemberId, double transferFee, int staffUserId, String note) throws SQLException;
}
