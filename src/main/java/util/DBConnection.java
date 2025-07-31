package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection is a Singleton class that provides a single, shared
 * connection to the MySQL database for the entire application.
 */
public class DBConnection {

    // Holds the one and only instance of this class
    private static Connection connection = null;

    // Database connection details 
    private static final String URL = "jdbc:mysql://localhost:3306/hasaru_edu_db";
    private static final String USERNAME = "root";         
    private static final String PASSWORD = "";              

    /**
     * Private constructor to prevent creating objects of this class from outside.
     */
    private DBConnection() {}

    //Provides a single shared database connection.//

    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                // Load the MySQL JDBC driver 
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish the connection
                connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            }
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found. Include it in your lib folder.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Error connecting to the database. Check URL, username, or password.");
            e.printStackTrace();
        }

        return connection;
    }
}
