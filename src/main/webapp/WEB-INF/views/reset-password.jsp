<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="auth-page">

    <div class="auth-shell">
        <div class="auth-card-wrap">
            <div class="auth-card shadow-sm">
                <div class="auth-card-body">

                    <div class="auth-brand text-center">
                        <h1 class="auth-title">Reset Password</h1>
                        <p class="auth-subtitle">
                            Enter your email, reset code, and new password
                        </p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger auth-alert">${error}</div>
                    </c:if>

                    <c:if test="${not empty message}">
                        <div class="alert alert-success auth-alert">${message}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/reset-password" method="post" class="auth-form">
                        <div class="mb-3">
                            <label class="form-label auth-label">Email</label>
                            <input type="email"
                                   name="email"
                                   class="form-control auth-input"
                                   placeholder="Enter your email"
                                   value="${resetPasswordForm.email}"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label auth-label">Reset Code</label>
                            <input type="text"
                                   name="resetCode"
                                   class="form-control auth-input"
                                   placeholder="Enter reset code"
                                   value="${resetPasswordForm.resetCode}"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label auth-label">New Password</label>
                            <input type="password"
                                   name="newPassword"
                                   class="form-control auth-input"
                                   placeholder="Enter new password"
                                   required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label auth-label">Confirm Password</label>
                            <input type="password"
                                   name="confirmPassword"
                                   class="form-control auth-input"
                                   placeholder="Confirm new password"
                                   required>
                        </div>

                        <div class="d-grid mb-4">
                            <button type="submit" class="btn auth-btn-primary">Reset Password</button>
                        </div>
                    </form>

                    <div class="auth-footer-text text-center">
                        Remembered your password?
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