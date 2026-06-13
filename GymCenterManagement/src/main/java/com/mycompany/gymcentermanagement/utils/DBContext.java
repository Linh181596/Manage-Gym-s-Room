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
 * Utility class to manage database connection sessions using HikariCP connection pool.
 * Loads database configuration from db.properties file.
 */
public class DBContext {
    private static final Logger LOGGER = Logger.getLogger(DBContext.class.getName());
    private static final HikariDataSource dataSource;

    static {
        Properties properties = new Properties();
        try (InputStream input = DBContext.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                LOGGER.severe("Unable to find db.properties in resources.");
                throw new RuntimeException("db.properties configuration file is missing.");
            } else {
                properties.load(input);
                
                HikariConfig config = new HikariConfig();
                config.setDriverClassName(properties.getProperty("db.driver"));
                config.setJdbcUrl(properties.getProperty("db.url"));
                config.setUsername(properties.getProperty("db.username"));
                config.setPassword(properties.getProperty("db.password"));
                
                // HikariCP performance tuning settings
                config.setMaximumPoolSize(10); // Standard pool size for small to medium apps
                config.setMinimumIdle(2);
                config.setIdleTimeout(300000); // 5 minutes
                config.setConnectionTimeout(20000); // 20 seconds
                config.setMaxLifetime(1800000); // 30 minutes
                
                dataSource = new HikariDataSource(config);
                LOGGER.info("HikariCP Connection Pool initialized successfully.");
            }
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Failed to initialize database configuration or HikariCP", ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    /**
     * Obtains a connection from the HikariCP pool.
     * Remember to close connections after use to return them to the pool.
     * 
     * @return Connection object from the pool
     * @throws SQLException if a database access error occurs
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
