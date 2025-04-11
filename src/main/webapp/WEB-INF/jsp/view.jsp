<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    <title>Course ${ticket.subject}</title>
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
        .attachment-item {
            padding: 0.5rem;
            background-color: #f8f9fa;
            border-radius: 4px;
            margin-bottom: 0.5rem;
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
            <h2 class="fw-bold text-primary">
                <i class="fas fa-book me-2"></i>${ticket.subject}
            </h2>
            <div>
                <security:authorize access="hasRole('ADMIN') or principal.username=='${ticket.customerName}'">
                    <a href="<c:url value="/course/edit/${ticket.id}" />" class="btn btn-outline-secondary me-2">
                        <i class="fas fa-edit me-1"></i>Edit Course
                    </a>
                </security:authorize>
                <security:authorize access="hasRole('ADMIN')">
                    <a href="<c:url value="/course/delete/${ticket.id}" />" class="btn btn-outline-danger">
                        <i class="fas fa-trash-alt me-1"></i>Delete Course
                    </a>
                </security:authorize>
                <div class="d-flex justify-content-end">
                    <a href="<c:url value="/course" />" class="btn btn-outline-primary">
                        <i class="fas fa-arrow-left me-1"></i>Return to courses list
                    </a>
                </div>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title text-muted">Course Description</h5>
                <p class="card-text">${ticket.body}</p>
                <small class="text-muted">
                    <i class="fas fa-user me-1"></i>Created by: ${ticket.customerName}
                </small>
            </div>
        </div>

        <c:if test="${!empty ticket.attachments}">
        <div class="mb-4">
            <h5 class="fw-bold mb-3">
                <i class="fas fa-paperclip me-2"></i>Lecture Notes
            </h5>
            <div class="list-group">
                <c:forEach items="${ticket.attachments}" var="attachment" varStatus="status">
                    <div class="list-group-item attachment-item d-flex justify-content-between align-items-center">
                        <div>
                            <i class="fas fa-file me-2"></i>
                            <a href="<c:url value="/course/${ticketId}/attachment/${attachment.id}" />" class="text-decoration-none">
                                    ${attachment.name}
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        </c:if>

        <!-- Add this after the attachments section and before the return button -->
        <div class="mb-4">
            <h5 class="fw-bold mb-3">
                <i class="fas fa-comments me-2"></i>Comments
            </h5>

            <!-- Comment list -->
            <div class="mb-4">
                <c:forEach items="${comments}" var="comment">
                    <div class="card mb-2">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h6 class="card-subtitle mb-2 text-muted">
                                    <i class="fas fa-user me-1"></i>${comment.author}
                                </h6>
                                <small class="text-muted">
                                    <fmt:formatDate value="${comment.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
                                </small>
                            </div>
                            <p class="card-text">${comment.content}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Comment form -->
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Add a comment</h5>
                    <form:form modelAttribute="newComment" method="post"
                               action="${pageContext.request.contextPath}/course/view/${ticket.id}/comment"
                               onsubmit="return validateCommentForm()">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <div class="mb-3">
                            <form:textarea path="content" class="form-control" rows="3"
                                           placeholder="Write your comment here..." id="commentContent"></form:textarea>
                            <form:errors path="content" cssClass="text-danger small" />
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-paper-plane me-1"></i>Submit
                        </button>
                    </form:form>
                </div>
            </div>

            <script>
                function validateCommentForm() {
                    const content = document.getElementById('commentContent').value.trim();
                    if (content === '') {
                        alert('Comment cannot be empty');
                        return false;
                    }
                    return true;
                }
            </script>

            <br>

        </div>


        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>