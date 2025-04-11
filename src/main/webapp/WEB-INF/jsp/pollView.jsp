<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    <title>Poll: ${poll.question}</title>
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
        .poll-option {
            padding: 0.75rem 1rem;
            margin-bottom: 0.5rem;
            border: 1px solid #dee2e6;
            border-radius: 0.25rem;
            cursor: pointer;
            transition: all 0.2s;
        }
        .poll-option:hover {
            background-color: #f8f9fa;
        }
        .poll-option.selected {
            background-color: #e7f5ff;
            border-color: #74c0fc;
        }
        .vote-count {
            font-weight: 500;
            color: #495057;
        }
        .comment {
            padding: 1rem;
            border-bottom: 1px solid #eee;
        }
        .comment-form textarea {
            min-height: 100px;
        }
        .error-message {
            color: #dc3545;
            font-size: 0.875em;
            margin-top: 0.25rem;
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
            <h2 class="fw-bold text-primary mb-0">${poll.question}</h2>
            <a href="<c:url value="/poll" />" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-1"></i>Back to Poll
            </a>
        </div>

        <!-- In the voting form section -->
        <form action="<c:url value="/poll/vote/${poll.id}" />" method="post" id="voteForm">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div class="mb-4">
                <c:forEach items="${poll.options}" var="option" varStatus="status">
                    <div class="poll-option ${userVote != null && userVote == status.index ? 'selected' : ''}">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="option"
                                   id="option${status.index}" value="${status.index}"
                                ${userVote != null && userVote == status.index ? 'checked' : ''}>
                            <label class="form-check-label w-100" for="option${status.index}">
                                <div class="d-flex justify-content-between">
                                    <span>${option}</span>
                                    <span class="vote-count">${voteCounts[status.index]} votes</span>
                                </div>
                            </label>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${not empty voteError}">
                    <div class="error-message mt-2">
                        <i class="fas fa-exclamation-circle me-1"></i>${voteError}
                    </div>
                </c:if>
            </div>
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-vote-yea me-1"></i>
                ${userVote != null ? 'Update Vote' : 'Submit Vote'}
            </button>
        </form>

        <hr class="my-4">

        <h4 class="mb-3">Comments</h4>

        <c:if test="${not empty currentUser}">
            <form action="<c:url value="/poll/view/${poll.id}/comment" />" method="post" class="mb-4 comment-form">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <div class="mb-3">
                    <textarea name="content" class="form-control ${not empty error ? 'is-invalid' : ''}"
                              rows="3" placeholder="Add a comment..." required>${commentContent}</textarea>
                    <c:if test="${not empty error}">
                        <div class="error-message">${error}</div>
                    </c:if>
                </div>
                <button type="submit" class="btn btn-outline-primary" id="submit-comment">
                    <i class="fas fa-paper-plane me-1"></i>Post Comment
                </button>
            </form>
        </c:if>

        <div class="comments">
            <c:choose>
                <c:when test="${fn:length(comments) == 0}">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>No comments yet. Be the first to comment!
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${comments}" var="comment">
                        <div class="comment">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <div>
                                    <strong>${comment.author}</strong>
                                    <small class="text-muted ms-2">
                                        <fmt:formatDate value="${comment.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
                                    </small>
                                </div>
                                <security:authorize access="hasRole('ADMIN')">
                                    <a href="<c:url value="/poll/comment/delete/${comment.id}"/>"
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Are you sure you want to delete this comment?')">
                                        <i class="fas fa-trash-alt"></i>
                                    </a>
                                </security:authorize>
                            </div>
                            <p class="mb-0">${comment.content}</p>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Highlight selected option when clicked
    document.querySelectorAll('.poll-option').forEach(option => {
        option.addEventListener('click', function() {
            const radio = this.querySelector('input[type="radio"]');
            radio.checked = true;

            document.querySelectorAll('.poll-option').forEach(opt => {
                opt.classList.remove('selected');
            });

            this.classList.add('selected');
        });
    });

    // Client-side validation for comment form
    document.querySelector('.comment-form')?.addEventListener('submit', function(e) {
        const textarea = this.querySelector('textarea');
        if (textarea.value.trim() === '') {
            e.preventDefault();
            textarea.classList.add('is-invalid');
            const errorDiv = document.createElement('div');
            errorDiv.className = 'error-message';
            errorDiv.textContent = 'Comment cannot be empty';

            // Remove existing error message if any
            const existingError = textarea.nextElementSibling;
            if (existingError && existingError.classList.contains('error-message')) {
                existingError.remove();
            }

            textarea.after(errorDiv);
            textarea.focus();
        }
    });
</script>
</body>
</html>