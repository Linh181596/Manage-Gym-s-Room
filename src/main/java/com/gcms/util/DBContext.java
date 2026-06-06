/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gcms.util;

/**
 *
 * @author daiduong
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    public Connection getConnection() throws SQLException, ClassNotFoundException {
        String url = "jdbc:sqlserver://127.0.0.1:1433;databaseName=GymCenterManagement;encrypt=true;trustServerCertificate=true;";
        String user = "sa"; 
        String password = "123"; 
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, user, password);
    }
    
    public static void main(String[] args) {
        try {
            System.out.println("Đang kiểm tra kết nối tới SQL Server...");
            DBContext db = new DBContext();
            Connection conn = db.getConnection();
            if (conn != null) {
                System.out.println("=========================================");
                System.out.println("🎉 CHÚC MỪNG! KẾT NỐI DATABASE THÀNH CÔNG 🎉");
                System.out.println("=========================================");
            }
        } catch (Exception e) {
            System.out.println("=========================================");
            System.out.println("❌ KẾT NỐI THẤT BẠI! LỖI CHI TIẾT DƯỚI ĐÂY:");
            System.out.println("=========================================");
            e.printStackTrace();
        }
    }
}
