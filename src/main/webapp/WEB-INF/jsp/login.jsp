<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    <title>Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
        }
        .login-container {
            max-width: 500px;
            margin: 0 auto;
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            margin-top: 5rem;
        }
        .navbar-brand {
            font-weight: 600;
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold">
            <i class="fas fa-university me-2"></i>Online Course Website
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a href="<c:url value="/user/create" />" class="nav-link text-dark">
                        <i class="fas fa-user-plus me-1"></i>Register
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <div class="login-container">
        <h2 class="fw-bold text-primary mb-4">
            <i class="fas fa-sign-in-alt me-2"></i>Online Course Website
        </h2>

        <c:if test="${param.error != null}">
            <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>Login failed. Please check your credentials.
            </div>
        </c:if>
        <c:if test="${param.logout != null}">
            <div class="alert alert-success" role="alert">
                <i class="fas fa-check-circle me-2"></i>You have been logged out successfully.
            </div>
        </c:if>

        <form action="login" method="POST">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="remember-me" name="remember-me">
                <label class="form-check-label" for="remember-me">Remember me</label>
            </div>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-primary w-100">
                <i class="fas fa-sign-in-alt me-2"></i>Log In
            </button>
        </form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>