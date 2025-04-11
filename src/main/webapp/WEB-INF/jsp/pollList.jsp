<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    <title>Polls</title>
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
        .poll-item {
            padding: 1rem;
            border-bottom: 1px solid #eee;
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
                <i class="fas fa-poll me-2"></i>Polls
            </h2>
            <div>
                <a href="<c:url value="/course" />" class="btn btn-outline-secondary me-2">
                    <i class="fas fa-arrow-left me-1"></i>Back to Courses
                </a>
                <a href="<c:url value="/poll/history"/>" class="btn btn-outline-info me-2">
                    <i class="fas fa-history me-1"></i>My Voting History
                </a>
                <security:authorize access="hasRole('ADMIN')">
                    <a href="<c:url value="/poll/create" />" class="btn btn-primary">
                        <i class="fas fa-plus me-1"></i>Create Poll
                    </a>
                </security:authorize>
            </div>
        </div>

        <c:choose>
            <c:when test="${fn:length(polls) == 0}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i>There are no polls in the system.
                </div>
            </c:when>
            <c:otherwise>
                <div class="list-group">
                    <c:forEach items="${polls}" var="poll">
                        <div class="list-group-item poll-item">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">${poll.question}</h5>
                                </div>
                                <div>
                                    <a href="<c:url value="/poll/view/${poll.id}" />" class="btn btn-sm btn-outline-primary me-1">
                                        <i class="fas fa-eye me-1"></i>View
                                    </a>
                                    <security:authorize access="hasRole('ADMIN')">
                                        <a href="<c:url value="/poll/edit/${poll.id}" />" class="btn btn-sm btn-outline-warning me-1">
                                            <i class="fas fa-edit me-1"></i>Edit
                                        </a>
                                        <a href="<c:url value="/poll/delete/${poll.id}" />" class="btn btn-sm btn-outline-danger">
                                            <i class="fas fa-trash-alt me-1"></i>Delete
                                        </a>
                                    </security:authorize>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>