<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hasaru Edu - Login</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Google Font (optional) -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(120deg, #f0f4ff, #dfefff);
            font-family: 'Poppins', sans-serif;
        }

        .login-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .login-card .card-header {
            background: #0d6efd;
            color: white;
            text-align: center;
            padding: 1.5rem;
        }

        .login-card .card-body {
            padding: 2rem;
        }

        .login-card .form-control {
            border-radius: 0.5rem;
        }

        .login-card .btn-primary {
            border-radius: 0.5rem;
            background: #0d6efd;
            transition: background 0.3s ease;
        }

        .login-card .btn-primary:hover {
            background: #0b5ed7;
        }

        .footer-text {
            font-size: 0.85rem;
            color: #888;
            text-align: center;
            padding: 1rem 0;
        }
    </style>
</head>
<body>

<div class="login-container">
    <div class="card login-card col-md-5 col-lg-4">
        <div class="card-header">
            <h3 class="mb-0">Hasaru Edu</h3>
            <p class="mb-0">Web-Based Billing System</p>
        </div>
        <div class="card-body">
            <!-- Login form -->
            <form action="login" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">👤 Username</label>
                    <input type="text" class="form-control" name="username" id="username" required>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">🔒 Password</label>
                    <input type="password" class="form-control" name="password" id="password" required>
                </div>

                <% 
                    String error = request.getParameter("error");
                    if (error != null) {
                %>
                    <div class="alert alert-danger" role="alert">
                        <%= error %>
                    </div>
                <% } %>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Login</button>
                </div>
            </form>
        </div>
        <div class="footer-text">
            &copy; 2025 Hasaru Edu Bookshop • All rights reserved
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS (optional) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
