package com.mycompany.gymcentermanagement.utils;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Utility class để quản lý các phiên kết nối cơ sở dữ liệu (Database) 
 * bằng cách sử dụng connection pool của HikariCP.
 * Cấu hình database được đọc từ file db.properties.
 */
public class DBContext {
    private static final Logger LOGGER = Logger.getLogger(DBContext.class.getName());
    private static final HikariDataSource dataSource;

    // Khối static khởi tạo DataSource một lần duy nhất khi class được load
    static {
        Properties properties = new Properties();
        try (InputStream input = DBContext.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                LOGGER.severe("Unable to find db.properties in resources.");
                throw new RuntimeException("db.properties configuration file is missing.");
            } else {
                // Tải cấu hình từ file properties
                properties.load(input);
                
                HikariConfig config = new HikariConfig();
                config.setDriverClassName(properties.getProperty("db.driver"));
                config.setJdbcUrl(properties.getProperty("db.url"));
                config.setUsername(properties.getProperty("db.username"));
                config.setPassword(properties.getProperty("db.password"));
                
                // Cấu hình tối ưu hóa hiệu suất cho HikariCP connection pool
                // Giới hạn pool size là 10 (phù hợp với các ứng dụng vừa và nhỏ)
                config.setMaximumPoolSize(10); 
                // Số lượng connection rảnh (idle) tối thiểu trong pool
                config.setMinimumIdle(2);
                // Thời gian (ms) một connection được phép rảnh rỗi trước khi bị đóng (5 phút)
                config.setIdleTimeout(300000); 
                // Thời gian (ms) tối đa chờ lấy 1 connection từ pool, nếu quá thời gian sẽ ném lỗi (20s)
                config.setConnectionTimeout(20000); 
                // Tuổi thọ (ms) tối đa của 1 connection trong pool (30 phút)
                config.setMaxLifetime(1800000); 
                
                dataSource = new HikariDataSource(config);
                LOGGER.info("HikariCP Connection Pool initialized successfully.");
            }
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Failed to initialize database configuration or HikariCP", ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    /**
     * Lấy một connection từ HikariCP pool.
     * Lưu ý: Luôn luôn phải gọi .close() cho connection này sau khi dùng xong (VD: dùng try-with-resources)
     * để trả connection về lại pool.
     * 
     * @return Đối tượng Connection đã kết nối với database
     * @throws SQLException nếu có lỗi xảy ra hoặc hết thời gian chờ
     */
    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            throw new SQLException("HikariCP datasource is not initialized.");
        }
        return dataSource.getConnection();
    }

    /**
     * Closes the HikariCP DataSource.
     */
    public static void shutdown() {
        if (dataSource != null) {
            dataSource.close();
            LOGGER.info("HikariCP Connection Pool shut down successfully.");
        }
    }
}
