package com.mycompany.gymcentermanagement.service;

import com.mycompany.gymcentermanagement.model.entity.Member;
import com.mycompany.gymcentermanagement.model.entity.Invoice;
import java.sql.SQLException;
import java.util.List;

public interface MemberPackageService {
    List<Member> getActiveMembers() throws SQLException;
    Invoice registerMemberPackage(int memberId, int packageId, int staffUserId) throws SQLException;
}
