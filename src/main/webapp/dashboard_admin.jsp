<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session == null || !"Admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp?error=Unauthorized+access");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Hasaru Edu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: url('img/background.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(15, 23, 42, 0.65);
            z-index: 1;
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
            z-index: 2;
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
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 3;
            position: relative;
        }

        .welcome-box {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 12px;
            padding: 2.5rem 3rem;
            width: 600px;
            text-align: center;
            box-shadow: 0 4px 16px rgba(0,0,0,0.2);
        }

        .welcome-box h2 {
            font-weight: 600;
            color: #1e293b;
        }

        .welcome-box p {
            color: #475569;
            margin-bottom: 0.75rem;
        }

        .welcome-box hr {
            border-top: 1px solid #e2e8f0;
            margin-top: 1.5rem;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>

<!-- Background Overlay -->
<div class="overlay"></div>

<!-- Sidebar -->
<div class="sidebar">
    <h4>📘 Hasaru Edu</h4>
    <a href="dashboard_admin.jsp" class="active">📊 Dashboard</a>
    <a href="users.jsp">👥 Manage Users</a>
    <a href="customers.jsp">📇 Manage Customers</a>
    <a href="items.jsp">📚 Manage Inventory</a>
    <a href="bills.jsp">📈 Sales Reports</a>
    <a href="help.jsp">❓ Help</a>
    <a href="logout.jsp">🚪 Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="welcome-box">
        <h2>👋 Welcome to the Admin Dashboard</h2>
        <p>This panel provides full administrative access to manage Hasaru Edu’s operations.</p>
        <p>Navigate through the left panel to manage users, customers, inventory, and view sales.</p>
        <hr>
        <p><strong>System Version:</strong> 1.0.0</p>
        <p><strong>Access:</strong> Admin Role</p>
    </div>
</div>

</body>
</html>
