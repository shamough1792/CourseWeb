<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    <title>Edit Poll</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
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
    </style>
</head>
<body>
<!-- Navigation Bar (same as pollList.jsp) -->
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
                <i class="fas fa-edit me-2"></i>Edit Poll
            </h2>
            <div>
                <a href="<c:url value="/poll"/>" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-1"></i>Back to Polls
                </a>
            </div>
        </div>

        <form:form modelAttribute="pollForm" method="post">
            <div class="mb-3">
                <label for="question" class="form-label">Poll Question</label>
                <form:input path="question" class="form-control" id="question" required="required"/>
            </div>

            <div class="mb-3">
                <label class="form-label">Options</label>
                <form:input path="option1" class="form-control mb-2" required="required"/>
                <form:input path="option2" class="form-control mb-2" required="required"/>
                <form:input path="option3" class="form-control mb-2" required="required"/>
                <form:input path="option4" class="form-control mb-2" required="required"/>
            </div>

            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                <a href="<c:url value="/poll"/>" class="btn btn-secondary me-md-2">Cancel</a>
                <button type="submit" class="btn btn-primary">Save Changes</button>
            </div>
        </form:form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>