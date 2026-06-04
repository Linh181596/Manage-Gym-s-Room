package context;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {
    public static Connection getConnection() throws Exception {
        // Thay đổi thông tin kết nối phù hợp với SQL Server của bạn
        String url = "jdbc:sqlserver://localhost:1433;databaseName=GymCenterManagement;encrypt=true;trustServerCertificate=true;";
        String username = "sa"; 
        String password = "123"; // Mật khẩu SQL Server của bạn
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, username, password);
    }
}