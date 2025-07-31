package dao;

import model.User;
import java.sql.*;

/**
 * Handles user-related database operations such as login validation.
 */
public class UserDAO {

    private Connection conn;

    // Constructor to accept DB connection
    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    // Checks if a user with the given username and hashed password exists
    public User validateUser(String username, String hashedPassword) {
        User user = null;

        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, hashedPassword);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password")); // hashed password
                user.setRole(rs.getString("role"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }
}
