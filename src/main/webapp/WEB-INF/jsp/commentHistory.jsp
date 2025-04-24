<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    <title>Comment History - ${username}</title>
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
        .comment-item {
            padding: 1rem;
            border-bottom: 1px solid #eee;
        }
        .comment-subject {
            font-weight: 500;
            color: #0d6efd;
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
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold text-primary mb-0">
                <i class="fas fa-comment-alt me-2"></i>Comment History for ${username}
            </h2>
            <div>
                <a href="<c:url value="/course" />" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-1"></i>Back to Courses
                </a>
            </div>
        </div>

        <h4 class="mt-4">
            <i class="fas fa-book me-2"></i>Course Comments
        </h4>
        <c:choose>
            <c:when test="${empty courseComments}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i>No course comments found.
                </div>
            </c:when>
            <c:otherwise>
                <div class="list-group mt-3">
                    <c:forEach items="${courseComments}" var="commentWithSubject">
                        <div class="list-group-item comment-item">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <p class="mb-1">${commentWithSubject.comment.content}</p>
                                    <small class="text-muted">
                                        <i class="far fa-calendar-alt me-1"></i>
                                        <fmt:formatDate value="${commentWithSubject.comment.createdAt}" pattern="yyyy-MM-dd HH:mm" /> |
                                        <span class="comment-subject">${commentWithSubject.subject}</span>
                                    </small>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

        <h4 class="mt-4">
            <i class="fas fa-poll me-2"></i>Poll Comments
        </h4>
        <c:choose>
            <c:when test="${empty pollComments}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i>No poll comments found.
                </div>
            </c:when>
            <c:otherwise>
                <div class="list-group mt-3">
                    <c:forEach items="${pollComments}" var="comment">
                        <div class="list-group-item comment-item">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <p class="mb-1">${comment.content}</p>
                                    <small class="text-muted">
                                        <i class="far fa-calendar-alt me-1"></i>
                                        <fmt:formatDate value="${comment.createdAt}" pattern="yyyy-MM-dd HH:mm" /> |
                                        <span class="comment-subject">"${comment.poll.question}"</span>
                                    </small>
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