package com.mycompany.gymcentermanagement.utils;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Utility class to manage connection sessions to the SQL Server database.
 * Loads database configuration from db.properties file.
 */
public class DBContext {
    private static final Logger LOGGER = Logger.getLogger(DBContext.class.getName());
    private static final Properties properties = new Properties();

    static {
        try (InputStream input = DBContext.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                LOGGER.severe("Unable to find db.properties in resources.");
            } else {
                properties.load(input);
                // Load database driver class
                String driverClass = properties.getProperty("db.driver");
                Class.forName(driverClass);
                LOGGER.info("Database driver loaded successfully: " + driverClass);
            }
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Failed to initialize database configuration", ex);
        }
    }

    /**
     * Obtains a new database connection.
     * Remember to close connections after use to prevent memory leaks,
     * preferably using try-with-resources.
     * 
     * @return Connection object
     * @throws SQLException if a database access error occurs
     */
    public static Connection getConnection() throws SQLException {
        String url = properties.getProperty("db.url");
        String user = properties.getProperty("db.username");
        String pass = properties.getProperty("db.password");
        
        if (url == null || user == null) {
            throw new SQLException("Database URL or credentials not configured correctly in db.properties.");
        }
        
        return DriverManager.getConnection(url, user, pass);
    }
}
