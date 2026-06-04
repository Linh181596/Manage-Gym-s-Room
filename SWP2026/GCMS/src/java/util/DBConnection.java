package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DBConnection {
    private static final String DEFAULT_URL = "jdbc:sqlserver://localhost:1433;databaseName=GymCenterManagement;encrypt=true;trustServerCertificate=true";
    private static final String DEFAULT_USER = "sa";
    private static final String DEFAULT_PASSWORD = "123";

    private DBConnection() {
    }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException ex) {
            throw new SQLException("SQL Server JDBC driver not found.", ex);
        }

        String url = firstValue(System.getProperty("gcms.db.url"), System.getenv("GCMS_DB_URL"), DEFAULT_URL);
        String user = firstValue(System.getProperty("gcms.db.user"), System.getenv("GCMS_DB_USER"), DEFAULT_USER);
        String password = firstValue(System.getProperty("gcms.db.password"), System.getenv("GCMS_DB_PASSWORD"), DEFAULT_PASSWORD);
        return DriverManager.getConnection(url, user, password);
    }

    private static String firstValue(String first, String second, String fallback) {
        if (first != null && !first.isBlank()) {
            return first;
        }
        if (second != null && !second.isBlank()) {
            return second;
        }
        return fallback;
    }
}
