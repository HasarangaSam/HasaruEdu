package controller;

import model.User;
import util.DBConnection;
import dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.security.MessageDigest;
import java.sql.Connection;

// Handles login for Admin, Cashier, and StoreKeeper roles using hashed passwords
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    // Called when the login form is submitted (via POST method)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get username and password from the login form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Convert the plain password to a SHA-256 hash
        String hashedPassword = hashPassword(password);

        try {
            // Connect to the database using the Singleton connection
            Connection conn = DBConnection.getConnection();
            UserDAO userDAO = new UserDAO(conn);

            // Check if user credentials are valid
            User user = userDAO.validateUser(username, hashedPassword);

            if (user != null) {
                // Login successful – create session and redirect by role
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("role", user.getRole());

                // Redirect user based on their role
                switch (user.getRole()) {
                    case "Admin":
                        response.sendRedirect("dashboard_admin.jsp");
                        break;
                    case "Cashier":
                        response.sendRedirect("dashboard_cashier.jsp");
                        break;
                    case "StoreKeeper":
                        response.sendRedirect("dashboard_storekeeper.jsp");
                        break;
                    default:
                        response.sendRedirect("login.jsp?error=Unknown+user+role");
                }

            } else {
                // Login failed – invalid username or password
                response.sendRedirect("login.jsp?error=Invalid+username+or+password");
            }

        } catch (Exception e) {
            // General error handling
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Internal+server+error");
        }
    }

    // Hashes the given plain password using SHA-256 and returns hex format string
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(password.getBytes("UTF-8"));

            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b));
            }

            return sb.toString();

        } catch (Exception e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}
