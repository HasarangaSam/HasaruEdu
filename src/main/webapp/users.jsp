<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session == null || !"Admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp?error=Unauthorized+access");
        return;
    }

    model.User editUser = (model.User) request.getAttribute("editUser");
    java.util.List<model.User> users = (java.util.List<model.User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Users - Pahana Edu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 240px;
            height: 100vh;
            background-color: #0f172a;
            color: white;
            padding-top: 2rem;
        }

        .sidebar h4 {
            text-align: center;
            margin-bottom: 2rem;
            font-weight: 600;
        }

        .sidebar a {
            display: block;
            padding: 12px 24px;
            color: #cbd5e1;
            text-decoration: none;
            transition: all 0.2s ease;
            font-size: 15px;
        }

        .sidebar a:hover,
        .sidebar a.active {
            background-color: #334155;
            color: #ffffff;
        }

        .main-content {
            margin-left: 240px;
            padding: 2rem;
        }

        .card {
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .table th, .table td {
            vertical-align: middle;
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h4>📘 Pahana Edu</h4>
    <a href="dashboard_admin.jsp">📊 Dashboard</a>
    <a href="users.jsp" class="active">👥 Manage Users</a>
    <a href="customers.jsp">📇 Manage Customers</a>
    <a href="items.jsp">📚 Manage Inventory</a>
    <a href="bills.jsp">📈 Sales Reports</a>
    <a href="help.jsp">❓ Help</a>
    <a href="logout.jsp">🚪 Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <h3 class="mb-4">👥 Manage Users (Cashiers & Store Keepers)</h3>

    <div class="card p-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="mb-0">User List</h5>
            <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#addUserModal">+ Add User</button>
        </div>

        <table class="table table-bordered table-hover">
            <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Role</th>
                    <th style="width: 120px;">Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                if (users != null) {
                    for (model.User user : users) {
            %>
                <tr>
                    <td><%= user.getUserId() %></td>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getRole() %></td>
                    <td>
                        <form action="UserServlet" method="get" style="display:inline;">
                            <input type="hidden" name="edit" value="<%= user.getUserId() %>"/>
                            <button type="submit" class="btn btn-warning btn-sm">Edit</button>
                        </form>
                        <form action="UserServlet" method="post" style="display:inline;" onsubmit="return confirm('Delete this user?');">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="userId" value="<%= user.getUserId() %>"/>
                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                        </form>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="4" class="text-center text-muted">No users found.</td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<!-- Add User Modal -->
<div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form class="modal-content" action="UserServlet" method="post">
            <input type="hidden" name="action" value="add" />
            <div class="modal-header">
                <h5 class="modal-title" id="addUserModalLabel">Add New User</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <input type="text" class="form-control" name="username" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" class="form-control" name="password" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Role</label>
                    <select class="form-select" name="role" required>
                        <option value="Cashier">Cashier</option>
                        <option value="StoreKeeper">StoreKeeper</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary">Add User</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
            </div>
        </form>
    </div>
</div>

<!-- Edit User Modal (only shown if editUser != null) -->
<%
    if (editUser != null) {
%>
<div class="modal fade show" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" style="display:block;" aria-modal="true" role="dialog">
    <div class="modal-dialog">
        <form class="modal-content" action="UserServlet" method="post">
            <input type="hidden" name="action" value="update" />
            <input type="hidden" name="userId" value="<%= editUser.getUserId() %>" />
            <div class="modal-header">
                <h5 class="modal-title" id="editUserModalLabel">Edit User</h5>
                <a href="UserServlet" class="btn-close" aria-label="Close"></a>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <input type="text" class="form-control" name="username" value="<%= editUser.getUsername() %>" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Role</label>
                    <select class="form-select" name="role" required>
                        <option value="Cashier" <%= "Cashier".equals(editUser.getRole()) ? "selected" : "" %>>Cashier</option>
                        <option value="StoreKeeper" <%= "StoreKeeper".equals(editUser.getRole()) ? "selected" : "" %>>StoreKeeper</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary">Update User</button>
                <a href="UserServlet" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>
<%
    }
%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<%-- Force modal show if editing --%>
<%
    if (editUser != null) {
%>
<script>
    const modal = new bootstrap.Modal(document.getElementById('editUserModal'));
    modal.show();
</script>
<%
    }
%>

</body>
</html>
