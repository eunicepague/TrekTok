<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.fujitsu.training.codes.model.data.User" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    User user = (User) session.getAttribute("user");
    String displayName = "";

    if (user != null && user.getFirstName() != null && !user.getFirstName().isBlank()) {
        String firstName = user.getFirstName().trim();
        displayName = firstName.substring(0, 1).toUpperCase() + firstName.substring(1).toLowerCase();
    }

    request.setAttribute("displayName", displayName);
%>

<nav class="navbar navbar-expand-lg trektok-navbar py-3">
    <div class="container">

        <a class="navbar-brand trektok-navbar-brand" href="${pageContext.request.contextPath}/home">
            Trek<span>Tok</span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#mainNavbar" aria-controls="mainNavbar"
            aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="mainNavbar">

            <ul class="navbar-nav mx-auto gap-lg-3">
                <li class="nav-item">
                    <a class="nav-link px-2" href="${pageContext.request.contextPath}/packages">Packages</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link px-2" href="${pageContext.request.contextPath}/myfeedbacks">Review</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link px-2" href="${pageContext.request.contextPath}/about">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link px-2" href="${pageContext.request.contextPath}/contact">Contact Us</a>
                </li>
            </ul>

            <div class="d-flex align-items-center">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="dropdown">
                            <button class="btn navbar-login-btn dropdown-toggle"
                                type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Hi, ${displayName}
                            </button>

                            <ul class="dropdown-menu dropdown-menu-end navbar-dropdown shadow border-0">
                                <li>
                                    <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/mybookings">
                                        My Bookings
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/myfeedbacks">
                                        My Feedbacks
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item text-danger py-2" href="${pageContext.request.contextPath}/logout">
                                        Logout
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <a class="btn navbar-login-btn" href="${pageContext.request.contextPath}/login">
                            Sign in
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </div>
</nav>