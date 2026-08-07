package com.mycompany.gymcentermanagement.utils;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Utility class để quản lý các phiên kết nối cơ sở dữ liệu (Database) 
 * bằng cách sử dụng connection pool của HikariCP với cơ chế Lazy-loading & Fallback an toàn.
 * Cấu hình database được đọc từ file db.properties.
 */
public class DBContext {
    private static final Logger LOGGER = Logger.getLogger(DBContext.class.getName());
    private static volatile HikariDataSource dataSource = null;
    private static String dbDriver;
    private static String dbUrl;
    private static String dbUsername;
    private static String dbPassword;
    private static Throwable initError = null;

    private static synchronized void initDataSource() {
        if (dataSource != null && !dataSource.isClosed()) {
            return;
        }

        try (InputStream input = DBContext.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                throw new RuntimeException("Không tìm thấy file db.properties trong resources.");
            }

            Properties properties = new Properties();
            properties.load(input);

            dbDriver = properties.getProperty("db.driver", "com.microsoft.sqlserver.jdbc.SQLServerDriver");
            dbUrl = properties.getProperty("db.url");
            dbUsername = properties.getProperty("db.username");
            dbPassword = properties.getProperty("db.password");

            // Nạp JDBC Driver
            Class.forName(dbDriver);

            HikariConfig config = new HikariConfig();
            config.setDriverClassName(dbDriver);
            config.setJdbcUrl(dbUrl);
            config.setUsername(dbUsername);
            config.setPassword(dbPassword);

            // Cấu hình pool HikariCP
            config.setMaximumPoolSize(10);
            config.setMinimumIdle(2);
            config.setIdleTimeout(300000);
            config.setConnectionTimeout(10000);
            config.setMaxLifetime(1800000);
            
            // Không chặn hoặc ném ngoại lệ làm hỏng ClassLoader nếu DB tạm thời rớt khi startup
            config.setInitializationFailTimeout(0);

            dataSource = new HikariDataSource(config);
            initError = null;
            LOGGER.info("HikariCP Connection Pool initialized successfully.");
        } catch (Throwable ex) {
            initError = ex;
            LOGGER.log(Level.SEVERE, "Lỗi khi khởi tạo HikariCP Connection Pool: " + ex.getMessage(), ex);
        }
    }

    /**
     * Lấy một connection kết nối CSDL.
     * Tự động khởi tạo HikariCP pool hoặc fallback kết nối trực tiếp nếu pool gặp sự cố.
     * 
     * @return Connection
     * @throws SQLException nếu không thể kết nối tới SQL Server
     */
    public static Connection getConnection() throws SQLException {
        if (dataSource == null || dataSource.isClosed()) {
            initDataSource();
        }

        if (dataSource != null && !dataSource.isClosed()) {
            try {
                return dataSource.getConnection();
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Không thể lấy connection từ HikariCP pool, thử kết nối qua DriverManager: " + e.getMessage());
            }
        }

        // Fallback kết nối trực tiếp thông qua DriverManager nếu HikariCP gặp sự cố
        try {
            if (dbDriver != null) {
                Class.forName(dbDriver);
            }
            return DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
        } catch (Exception ex) {
            String errorMsg = "Không thể kết nối đến cơ sở dữ liệu SQL Server! Vui lòng kiểm tra dịch vụ SQL Server và thông tin trong db.properties.";
            if (initError != null) {
                errorMsg += " (Lỗi chi tiết: " + initError.getMessage() + ")";
            }
            throw new SQLException(errorMsg, ex);
        }
    }

    /**
     * Closes the HikariCP DataSource.
     */
    public static void shutdown() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
            LOGGER.info("HikariCP Connection Pool shut down successfully.");
        }
    }
}
