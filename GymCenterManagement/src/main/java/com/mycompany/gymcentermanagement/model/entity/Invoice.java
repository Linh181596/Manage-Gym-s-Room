/**
 * =========================================================================
 * @file          : Invoice.java
 * @description   : Entity đại diện cho bảng Invoices lưu trữ thông tin hóa đơn thanh toán
 * @author        : Nguyễn Hoàng Thắng
 * @created       : 2026-06-01
 * @last_modified : 2026-06-01 bởi Nguyễn Hoàng Thắng
 * =========================================================================
 */
package com.mycompany.gymcentermanagement.model.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Entity representing the 'Invoices' table in the database.
 */
public class Invoice {
    private int invoiceId;
    private int memberId;
    private int processBy; // UserID of staff/admin who processes it
    private Integer memberPackageId; // nullable
    private Integer ptRegistrationId; // nullable
    private BigDecimal amount;
    private String paymentMethod; // 'Cash'
    private LocalDateTime paymentDate;
    private String status; // 'Paid', 'Pending', 'Cancelled'
    
    // Mapped entities (obtained via JOIN)
    private Member member;
    private MemberPackage memberPackage;
    private User processByUser;
    
    // Audit Metadata
    private String createdBy;
    private LocalDateTime createdDate;
    private String updatedBy;
    private LocalDateTime updatedDate;
    private boolean isDeleted;

    public Invoice() {
    }

    public Invoice(int invoiceId, int memberId, int processBy, Integer memberPackageId, Integer ptRegistrationId, BigDecimal amount, String paymentMethod, LocalDateTime paymentDate, String status) {
        this.invoiceId = invoiceId;
        this.memberId = memberId;
        this.processBy = processBy;
        this.memberPackageId = memberPackageId;
        this.ptRegistrationId = ptRegistrationId;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.paymentDate = paymentDate;
        this.status = status;
    }

    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public int getProcessBy() {
        return processBy;
    }

    public void setProcessBy(int processBy) {
        this.processBy = processBy;
    }

    public Integer getMemberPackageId() {
        return memberPackageId;
    }

    public void setMemberPackageId(Integer memberPackageId) {
        this.memberPackageId = memberPackageId;
    }

    public Integer getPtRegistrationId() {
        return ptRegistrationId;
    }

    public void setPtRegistrationId(Integer ptRegistrationId) {
        this.ptRegistrationId = ptRegistrationId;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public LocalDateTime getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(LocalDateTime paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Member getMember() {
        return member;
    }

    public void setMember(Member member) {
        this.member = member;
    }

    public MemberPackage getMemberPackage() {
        return memberPackage;
    }

    public void setMemberPackage(MemberPackage memberPackage) {
        this.memberPackage = memberPackage;
    }

    public User getProcessByUser() {
        return processByUser;
    }

    public void setProcessByUser(User processByUser) {
        this.processByUser = processByUser;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public LocalDateTime getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(LocalDateTime updatedDate) {
        this.updatedDate = updatedDate;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    @Override
    public String toString() {
        return "Invoice{" +
                "invoiceId=" + invoiceId +
                ", memberId=" + memberId +
                ", amount=" + amount +
                ", status='" + status + '\'' +
                '}';
    }
}
