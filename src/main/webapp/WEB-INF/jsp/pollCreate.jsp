<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    <title>Create Poll</title>
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
        <h2 class="fw-bold text-primary mb-4">
            <i class="fas fa-plus-circle me-2"></i>Create New Poll
        </h2>

        <form action="<c:url value="/poll/create" />" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div class="mb-3">
                <label for="question" class="form-label">Poll Question</label>
                <input type="text" class="form-control" id="question" name="question" required>
            </div>

            <h5 class="mt-4 mb-3">Options</h5>

            <div class="mb-3">
                <label for="option1" class="form-label">Option 1</label>
                <input type="text" class="form-control" id="option1" name="option1" required>
            </div>

            <div class="mb-3">
                <label for="option2" class="form-label">Option 2</label>
                <input type="text" class="form-control" id="option2" name="option2" required>
            </div>

            <div class="mb-3">
                <label for="option3" class="form-label">Option 3</label>
                <input type="text" class="form-control" id="option3" name="option3" required>
            </div>

            <div class="mb-3">
                <label for="option4" class="form-label">Option 4</label>
                <input type="text" class="form-control" id="option4" name="option4" required>
            </div>

            <button type="submit" class="btn btn-primary">
                <i class="fas fa-save me-1"></i>Create Poll
            </button>
            <a href="<c:url value="/poll" />" class="btn btn-outline-secondary ms-2">
                Cancel
            </a>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>