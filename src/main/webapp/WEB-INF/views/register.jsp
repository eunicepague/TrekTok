<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="auth-page">

    <div class="auth-shell">
        <div class="auth-card-wrap">
            <div class="auth-card shadow-sm">
                <div class="auth-card-body">

                    <div class="auth-brand text-center">
                        <h1 class="auth-title">Create Account</h1>
                        <p class="auth-subtitle">
                            Fill in your details to create your TrekTok account
                        </p>
                    </div>

                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger auth-alert">${error}</div>
                    <% } %>

                    <form action="${pageContext.request.contextPath}/register" method="post" class="auth-form">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label auth-label">First Name</label>
                                <input type="text"
                                       name="firstName"
                                       class="form-control auth-input"
                                       placeholder="Enter first name"
                                       value="${registerForm.firstName}"
                                       required>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label auth-label">Last Name</label>
                                <input type="text"
                                       name="lastName"
                                       class="form-control auth-input"
                                       placeholder="Enter last name"
                                       value="${registerForm.lastName}"
                                       required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label auth-label">Email</label>
                            <input type="email"
                                   name="email"
                                   class="form-control auth-input"
                                   placeholder="Enter your email"
                                   value="${registerForm.email}"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label auth-label">Contact No</label>
                            <input type="text"
                                   name="contactNo"
                                   class="form-control auth-input"
                                   placeholder="Enter 11-digit contact number"
                                   value="${registerForm.contactNo}"
                                   pattern="\d{11}"
                                   maxlength="11"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label auth-label">Password</label>
                            <input type="password"
                                   name="password"
                                   class="form-control auth-input"
                                   placeholder="Enter your password"
                                   required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label auth-label">Confirm Password</label>
                            <input type="password"
                                   name="confirmPassword"
                                   class="form-control auth-input"
                                   placeholder="Confirm your password"
                                   required>
                        </div>

                        <div class="d-grid mb-4">
                            <input type="submit" value="Create Account" class="btn auth-btn-primary">
                        </div>
                    </form>

                    <div class="auth-footer-text text-center">
                        Already have an account?
                        <a href="${pageContext.request.contextPath}/login" class="auth-footer-link">
                            Back to Login
                        </a>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/footer-page.jsp" />
</body>
</html>