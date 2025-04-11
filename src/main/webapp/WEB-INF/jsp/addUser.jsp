<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    <title>Create User</title>
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
            max-width: 600px;
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
        <a class="navbar-brand fw-bold">
            <i class="fas fa-university me-2"></i>Online Course Website
        </a>
        <div class="d-flex">
            <a href="<c:url value="/login" />" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-1"></i>Back to login
            </a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="content-container">
        <h2 class="fw-bold text-primary mb-4">
            <i class="fas fa-user-plus me-2"></i>Create User
        </h2>

        <form:form method="POST" modelAttribute="ticketUser" class="needs-validation" novalidate="novalidate">
            <div class="mb-3">
                <label for="username" class="form-label">
                    <i class="fas fa-user me-1"></i>Username
                </label>
                <form:input type="text" path="username" class="form-control" id="username" required="required"/>
                <div class="invalid-feedback">
                    Please provide a username.
                </div>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">
                    <i class="fas fa-key me-1"></i>Password
                </label>
                <form:input type="password" path="password" class="form-control" id="password" required="required"/>
                <div class="invalid-feedback">
                    Please provide a password.
                </div>
            </div>

            <div class="mb-3">
                <label for="fullName" class="form-label">
                    <i class="fas fa-id-card me-1"></i>Full Name
                </label>
                <form:input type="text" path="fullName" class="form-control" id="fullName" required="required"/>
                <div class="invalid-feedback">
                    Please provide your full name.
                </div>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">
                    <i class="fas fa-envelope me-1"></i>Email Address
                </label>
                <form:input type="email" path="email" class="form-control" id="email" required="required"/>
                <div class="invalid-feedback">
                    Please provide a valid email address.
                </div>
            </div>

            <div class="mb-4">
                <label for="phone" class="form-label">
                    <i class="fas fa-phone me-1"></i>Phone Number
                </label>
                <form:input type="tel" path="phone" class="form-control" id="phone" required="required"/>
                <div class="invalid-feedback">
                    Please provide a phone number.
                </div>
            </div>

            <!-- Hidden field for default role -->
            <form:hidden path="roles" value="ROLE_USER"/>

            <div class="d-flex justify-content-end">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-user-plus me-1"></i>Create User
                </button>
            </div>
        </form:form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Form validation script -->
<script>
    // Form validation
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