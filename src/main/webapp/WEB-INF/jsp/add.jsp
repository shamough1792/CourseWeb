<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    <title>Add Course</title>
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
        .form-label {
            font-weight: 500;
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
            <i class="fas fa-plus-circle me-2"></i>Create a Course
        </h2>

        <form:form method="POST" enctype="multipart/form-data" modelAttribute="ticketForm" class="needs-validation" novalidate="novalidate">
            <div class="mb-3">
                <label for="subject" class="form-label">
                    <i class="fas fa-tag me-1"></i>Course Code
                </label>
                <form:input type="text" path="subject" class="form-control" id="subject" required="required"/>
                <div class="invalid-feedback">
                    Please provide a course code.
                </div>
            </div>

            <div class="mb-3">
                <label for="body" class="form-label">
                    <i class="fas fa-align-left me-1"></i>Course Description
                </label>
                <form:textarea path="body" class="form-control" id="body" rows="5" required="required"/>
                <div class="invalid-feedback">
                    Please provide a course description.
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label fw-bold">
                    <i class="fas fa-paperclip me-1"></i>Upload Lecture Notes
                </label>
                <input type="file" name="attachments" class="form-control" multiple="multiple"/>
                <div class="form-text">
                    You can upload multiple files at once.
                </div>
            </div>

            <div class="d-flex justify-content-between">
                <a href="<c:url value="/course" />" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-1"></i>Cancel
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-check me-1"></i>Submit
                </button>
            </div>
        </form:form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Form validation script -->
<script>
    (function () {
        'use strict'

        var forms = document.querySelectorAll('.needs-validation')

        Array.prototype.slice.call(forms)
            .forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }

                    form.classList.add('was-validated')
                }, false)
            })
    })()
</script>
</body>
</html>