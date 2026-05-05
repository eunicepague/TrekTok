<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="auth-page">

    <div class="auth-shell">
        <div class="auth-card-wrap">
            <div class="auth-card shadow-sm">
                <div class="auth-card-body">

                    <div class="auth-brand text-center">
                        <h1 class="auth-title">Forgot Password</h1>
                        <p class="auth-subtitle">
                            Enter your email and we’ll send you a reset code
                        </p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger auth-alert">${error}</div>
                    </c:if>

                    <c:if test="${not empty message}">
                        <div class="alert alert-success auth-alert">${message}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/forgot-password" method="post" class="auth-form">
                        <div class="mb-4">
                            <label class="form-label auth-label">Email</label>
                            <input type="email"
                                   name="email"
                                   value="${forgotPasswordForm.email}"
                                   class="form-control auth-input"
                                   placeholder="Enter your email"
                                   required>
                        </div>

                        <div class="d-grid mb-4">
                            <button type="submit" class="btn auth-btn-primary">Send Reset Code</button>
                        </div>
                    </form>

                    <div class="auth-footer-text text-center">
                        Remembered your account?
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