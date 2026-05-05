<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Verify Account</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="auth-page">

    <div class="auth-shell">
        <div class="auth-card-wrap">
            <div class="auth-card shadow-sm">
                <div class="auth-card-body">

                    <div class="auth-brand text-center">
                        <h1 class="auth-title">Verify Account</h1>
                        <p class="auth-subtitle">
                            Enter the verification code sent to your email
                        </p>
                    </div>

                    <% if (request.getAttribute("message") != null) { %>
                        <div class="alert alert-success auth-alert">${message}</div>
                    <% } %>

                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger auth-alert">${error}</div>
                    <% } %>

                    <form action="${pageContext.request.contextPath}/verify" method="post" class="auth-form">
                        <div class="mb-3">
                            <label class="form-label auth-label">Email</label>
                            <input type="text"
                                   name="email"
                                   class="form-control auth-input"
                                   value="${empty verifyForm.email ? email : verifyForm.email}"
                                   readonly>
                        </div>

                        <div class="mb-4">
                            <label class="form-label auth-label">Verification Code</label>
                            <input type="text"
                                   name="verificationCode"
                                   class="form-control auth-input"
                                   placeholder="Enter verification code"
                                   value="${verifyForm.verificationCode}"
                                   required>
                        </div>

                        <div class="d-grid mb-4">
                            <input type="submit" value="Verify Account" class="btn auth-btn-primary">
                        </div>
                    </form>

                    <div class="auth-footer-text text-center">
                        Already verified?
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