package com.mycompany.gymcentermanagement.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Base DAO class containing helper methods for closing SQL resources.
 * Supports running within an active transaction by wrapping a shared Connection.
 */
public abstract class BaseDAO {
    protected Connection connection;
    private static final Logger LOGGER = Logger.getLogger(BaseDAO.class.getName());

    public BaseDAO() {
    }

    /**
     * Initializes the DAO with a shared Connection, enabling active transactions.
     * 
     * @param connection The database Connection to use.
     */
    public BaseDAO(Connection connection) {
        this.connection = connection;
    }

    public Connection getConnection() {
        return connection;
    }

    public void setConnection(Connection connection) {
        this.connection = connection;
    }

    /**
     * Closes DB resources safely. If this DAO is holding a shared connection
     * (used in transaction), it will NOT close that connection, leaving lifecycle
     * management to the service layer.
     * 
     * @param conn The connection used in query execution.
     * @param stmt The Statement (or PreparedStatement) used.
     * @param rs   The ResultSet obtained.
     */
    protected void closeResource(Connection conn, Statement stmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.WARNING, "Error closing ResultSet", ex);
        }
        
        try {
            if (stmt != null) {
                stmt.close();
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.WARNING, "Error closing Statement", ex);
        }
        
        // Only close connection if it was not passed from service layer as shared.
        if (this.connection == null && conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                LOGGER.log(Level.WARNING, "Error closing Connection", ex);
            }
        }
    }
}
