package controller;

import dao.UserDAO;
import model.User;
import util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.security.MessageDigest;
import java.sql.Connection;
import java.util.List;

// Servlet that handles add/edit/delete operations for users (Admin only)
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ensure only Admin can access
        HttpSession session = request.getSession(false);
        if (session == null || !"Admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp?error=Unauthorized+access");
            return;
        }

        try {
            Connection conn = DBConnection.getConnection();
            UserDAO userDAO = new UserDAO(conn);

            // Load all users to display in users.jsp
            List<User> users = userDAO.getAllUsers();
            request.setAttribute("users", users);

            // Optional: check if editing
            String editId = request.getParameter("edit");
            if (editId != null) {
                int userId = Integer.parseInt(editId);
                User editUser = userDAO.getUserById(userId);
                request.setAttribute("editUser", editUser);
            }

            // Forward to users.jsp
            request.getRequestDispatcher("users.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("users.jsp?error=Failed+to+load+users");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        Connection conn = DBConnection.getConnection();
        UserDAO userDAO = new UserDAO(conn);

        try {
            if ("add".equals(action)) {
                // Add user
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String role = request.getParameter("role");

                User newUser = new User();
                newUser.setUsername(username);
                newUser.setPassword(hashPassword(password));
                newUser.setRole(role);

                boolean added = userDAO.addUser(newUser);
                response.sendRedirect("UserServlet?success=" + (added ? "User+added" : "Failed+to+add+user"));

            } else if ("update".equals(action)) {
                // Update user (excluding password)
                int userId = Integer.parseInt(request.getParameter("userId"));
                String username = request.getParameter("username");
                String role = request.getParameter("role");

                User user = new User();
                user.setUserId(userId);
                user.setUsername(username);
                user.setRole(role);

                boolean updated = userDAO.updateUser(user);
                response.sendRedirect("UserServlet?success=" + (updated ? "User+updated" : "Failed+to+update+user"));

            } else if ("delete".equals(action)) {
                // Delete user
                int userId = Integer.parseInt(request.getParameter("userId"));
                boolean deleted = userDAO.deleteUser(userId);
                response.sendRedirect("UserServlet?success=" + (deleted ? "User+deleted" : "Failed+to+delete+user"));

            } else {
                response.sendRedirect("UserServlet?error=Invalid+action");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("UserServlet?error=Something+went+wrong");
        }
    }

    // Hash password using SHA-256
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

