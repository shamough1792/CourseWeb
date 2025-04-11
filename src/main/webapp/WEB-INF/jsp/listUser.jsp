<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    <title>User Management</title>
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
            max-width: 1200px;
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
        .table th {
            background-color: #f8f9fa;
        }
        .role-badge {
            margin-right: 0.3rem;
        }
        .contact-info {
            white-space: nowrap;
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
            <a href="<c:url value="/user/comments"/>" class="btn btn-outline-info me-2">
                <i class="fas fa-comment-alt me-1"></i>My Comments
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
    <div class="content-container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold text-primary mb-0">
                <i class="fas fa-users-cog me-2"></i>User Management
            </h2>
            <div>
                <a href="<c:url value="/course" />" class="btn btn-outline-secondary me-2">
                    <i class="fas fa-arrow-left me-1"></i>Back to Courses
                </a>
            </div>
        </div>

        <c:choose>
            <c:when test="${fn:length(ticketUsers) == 0}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i>There are no users in the system.
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                        <tr>
                            <th><i class="fas fa-user me-1"></i>Username</th>
                            <th><i class="fas fa-id-card me-1"></i>Full Name</th>
                            <th><i class="fas fa-envelope me-1"></i>Email</th>
                            <th><i class="fas fa-phone me-1"></i>Phone</th>
                            <th><i class="fas fa-key me-1"></i>Password</th>
                            <th><i class="fas fa-user-tag me-1"></i>Roles</th>
                            <th><i class="fas fa-cog me-1"></i>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${ticketUsers}" var="user">
                            <tr>
                                <td>${user.username}</td>
                                <td>${user.fullName}</td>
                                <td class="contact-info">${user.email}</td>
                                <td class="contact-info">${user.phone}</td>
                                <td>${fn:substringAfter(user.password, '{noop}')}</td>
                                <td>
                                    <c:forEach items="${user.roles}" var="role">
                                        <span class="badge bg-primary role-badge">
                                                ${role.role}
                                        </span>
                                    </c:forEach>
                                </td>
                                <td>
                                    <a href="<c:url value="/user/delete/${user.username}" />" class="btn btn-sm btn-outline-danger">
                                        <i class="fas fa-trash-alt me-1"></i>Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>