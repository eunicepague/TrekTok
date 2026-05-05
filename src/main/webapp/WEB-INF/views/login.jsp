<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="auth-page">

    <div class="auth-shell">
        <div class="auth-card-wrap">
            <div class="auth-card shadow-sm">
                <div class="auth-card-body">

                    <div class="auth-brand text-center">
                        <h1 class="auth-title">Login</h1>
                        <p class="auth-subtitle">
                            Hey, enter your details to sign in to your account
                        </p>
                    </div>

                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger auth-alert">${error}</div>
                    <% } %>

                    <% if (request.getAttribute("message") != null) { %>
                        <div class="alert alert-success auth-alert">${message}</div>
                    <% } %>

                    <form action="${pageContext.request.contextPath}/login" method="post" class="auth-form">
                        <div class="mb-3">
                            <label class="form-label auth-label">Email</label>
                            <input type="text"
                                   name="email"
                                   class="form-control auth-input"
                                   placeholder="Enter your email"
                                   value="${loginForm.email}"
                                   required>
                        </div>

                        <div class="mb-2">
                            <label class="form-label auth-label">Password</label>
                            <input type="password"
                                   name="password"
                                   class="form-control auth-input"
                                   placeholder="Enter your password"
                                   required>
                        </div>

                        <div class="text-end mb-4">
                            <a href="${pageContext.request.contextPath}/forgot-password" class="auth-link-small">
                                Forgot Password?
                            </a>
                        </div>

                        <div class="d-grid mb-4">
                            <input type="submit" value="Sign in" class="btn auth-btn-primary">
                        </div>
                    </form>


                    <div class="auth-footer-text text-center">
                        Don’t have an account?
                        <a href="${pageContext.request.contextPath}/register" class="auth-footer-link">
                            Create now
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