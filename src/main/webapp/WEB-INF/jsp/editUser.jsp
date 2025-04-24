<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    <title>Edit User Information</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
        }
        .content-container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            margin-top: 2rem;
        }
        .error-message {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
        .editable-field {
            border-left: 3px solid #0d6efd;
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a href="<c:url value="/course" />" class="navbar-brand fw-bold">
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
        <h2 class="fw-bold text-primary mb-4">
            <i class="fas fa-user-edit me-2"></i>Edit User Information
        </h2>

        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form:form method="POST" modelAttribute="user" action="${pageContext.request.contextPath}/user/edit">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <c:choose>
                    <c:when test="${isAdmin}">
                        <form:input path="username" class="form-control editable-field" id="username"/>
                    </c:when>
                    <c:otherwise>
                        <form:input path="username" class="form-control" id="username" readonly="true"/>
                    </c:otherwise>
                </c:choose>
                <form:errors path="username" cssClass="error-message"/>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">New Password (leave blank to keep current)</label>
                <input type="password" class="form-control" id="password" name="password"/>
                <small class="text-muted">Password must be at least 6 characters</small>
            </div>

            <div class="mb-3">
                <label for="fullName" class="form-label">Full Name</label>
                <form:input path="fullName" class="form-control" id="fullName" required="true"/>
                <form:errors path="fullName" cssClass="error-message"/>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <form:input path="email" type="email" class="form-control" id="email" required="true"/>
                <form:errors path="email" cssClass="error-message"/>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label">Phone</label>
                <form:input path="phone" class="form-control" id="phone" required="true"/>
                <form:errors path="phone" cssClass="error-message"/>
            </div>

            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div class="d-flex justify-content-between">
                <a href="<c:url value="/"/>" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-1"></i>Back
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save me-1"></i>Save Changes
                </button>
            </div>
        </form:form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>