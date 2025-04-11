<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    <title>Error</title>
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
        .content-container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            margin-top: 2rem;
        }
        .navbar-brand {
            font-weight: 600;
        }
        .error-details {
            background-color: #f8f9fa;
            border-radius: 6px;
            padding: 1.5rem;
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
        <div class="d-flex">
            <a href="<c:url value="/poll"/>" class="btn btn-outline-success me-2">
                <i class="fas fa-poll me-1"></i>Poll
            </a>
            <a href="<c:url value="/user/edit"/>" class="btn btn-outline-primary me-2">
                <i class="fas fa-user-edit me-1"></i>Edit Profile
            </a>
            <c:url var="logoutUrl" value="/logout"/>
            <form action="${logoutUrl}" method="post" class="d-flex align-items-center">
                <button type="submit" class="btn btn-outline-danger">
                    <i class="fas fa-sign-out-alt me-1"></i>Log out
                </button>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </form>
        </div>
    </div>
</nav>

<div class="container">
    <div class="content-container text-center">
        <div class="mb-4">
            <i class="fas fa-exclamation-triangle fa-4x text-danger mb-3"></i>
            <h2 class="fw-bold text-danger">
                <i class="fas fa-exclamation-circle me-2"></i>Error Occurred
            </h2>
        </div>

        <div class="error-details mb-4">
            <c:choose>
                <c:when test="${empty message}">
                    <p class="lead">Something went wrong</p>
                    <ul class="list-unstyled">
                        <li class="mb-2">
                            <strong>Status Code:</strong>
                            <span class="badge bg-danger">${status}</span>
                        </li>
                        <li>
                            <strong>Exception:</strong>
                            <code>${exception}</code>
                        </li>
                    </ul>
                </c:when>
                <c:otherwise>
                    <p class="lead">${message}</p>
                </c:otherwise>
            </c:choose>
        </div>

        <a href="<c:url value="/course" />" class="btn btn-primary">
            <i class="fas fa-arrow-left me-1"></i>Return to Courses
        </a>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>