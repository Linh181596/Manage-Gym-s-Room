/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gcms.model;

import java.sql.Timestamp;

/**
 *
 * @author daiduong
 */
public class Staff {
    private int staffId;           // Khớp khóa chính [StaffID] int IDENTITY
    private int userId;            // Khớp khóa ngoại [UserID] int
    private String position;       // [Position] nvarchar(100) - Chức vụ nhân viên
    private String status;         // [Status] varchar(20)
    private String createdBy;      // [CreatedBy] nvarchar(50)
    private Timestamp createdDate; // [CreatedDate] datetime2(7)
    private String updatedBy;      // [UpdatedBy] nvarchar(50)
    private Timestamp updatedDate; // [UpdatedDate] datetime2(7)
    private boolean isDeleted;     // [IsDeleted] bit

    public Staff() {
    }
    
    

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Timestamp getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Timestamp updatedDate) {
        this.updatedDate = updatedDate;
    }

    public boolean isIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }
    
    
}
