<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<title>Manage Package Options</title>
<jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="admin-body">

    <div class="admin-shell">
        <div class="admin-shell-inner">

            <%
                request.setAttribute("activeMenu", "package-options");
            %>
            <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

            <div class="admin-main">
                <div class="admin-content-area">
                    <div class="admin-page-header">
                        <div>
                            <h1 class="admin-page-heading">Manage Package Options</h1>
                            <p class="admin-page-subheading mb-0">
                                View, add, edit, and manage package options.
                            </p>
                        </div>
                    </div>

                    <c:if test="${not empty success}">
                        <div class="alert alert-success">${success}</div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <div class="mb-3 d-flex gap-2 flex-wrap">
                        <a class="btn btn-success admin-submit-btn"
                           href="${pageContext.request.contextPath}/admin/package-options/add">
                            Add Package Option
                        </a>
                    </div>

                    <div class="dashboard-panel modern-panel">
                        <div class="table-responsive admin-table-wrap">
                            <table class="table align-middle mb-0 admin-modern-table admin-flex-table admin-package-options-modern-table">
                                <thead>
                                    <tr>
                                        <th>Option ID</th>
                                        <th>Package</th>
                                        <th>Option Name</th>
                                        <th>Description</th>
                                        <th>Price</th>
                                        <th>Max Pax</th>
                                        <th>Available Slots</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${empty packageOptions}">
                                        <tr>
                                            <td colspan="8" class="text-center">No package options found.</td>
                                        </tr>
                                    </c:if>

                                    <c:forEach var="rec" items="${packageOptions}">
                                        <tr>
                                            <td>${rec.optionId}</td>
                                            <td class="admin-package-options-package">${rec.packageName}</td>
                                            <td>${rec.optionName}</td>
                                            <td class="admin-package-options-description">${rec.description}</td>
                                            <td>₱ ${rec.price}</td>
                                            <td>${rec.maxPax}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${rec.availableSlots == 0}">
                                                        <span class="badge bg-danger">Sold Out</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${rec.availableSlots}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="admin-package-options-actions">
                                                <div class="d-flex gap-2 flex-wrap">
                                                    <a class="btn btn-primary btn-sm admin-table-action-btn"
                                                       href="${pageContext.request.contextPath}/admin/package-options/edit?optionId=${rec.optionId}">
                                                        Edit
                                                    </a>

                                                    <c:choose>
                                                        <c:when test="${rec.usedInBookings}">
                                                            <button type="button"
                                                                    class="btn btn-secondary btn-sm admin-table-action-btn"
                                                                    disabled
                                                                    title="Cannot delete because this option is already used in bookings.">
                                                                Delete
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <form class="d-inline"
                                                                  action="${pageContext.request.contextPath}/admin/package-options/delete"
                                                                  method="post">
                                                                <input type="hidden" name="optionId" value="${rec.optionId}">
                                                                <button type="submit"
                                                                        class="btn btn-danger btn-sm admin-table-action-btn"
                                                                        onclick="return confirm('Delete this package option?');">
                                                                    Delete
                                                                </button>
                                                            </form>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="admin-pagination-modern">
                            <div class="admin-pagination-info">
                                Page ${currentPage} of ${totalPages}
                            </div>

                            <div class="d-flex gap-2">
                                <c:if test="${currentPage > 1}">
                                    <a href="${pageContext.request.contextPath}/admin/package-options?page=${currentPage - 1}"
                                       class="btn btn-outline-success btn-sm admin-pagination-btn">
                                        Previous
                                    </a>
                                </c:if>

                                <c:if test="${currentPage < totalPages}">
                                    <a href="${pageContext.request.contextPath}/admin/package-options?page=${currentPage + 1}"
                                       class="btn btn-outline-success btn-sm admin-pagination-btn">
                                        Next
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>