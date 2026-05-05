<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Packages</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="admin-body">

    <div class="admin-shell">
        <div class="admin-shell-inner">

            <%
                request.setAttribute("activeMenu", "packages");
            %>
            <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

            <div class="admin-main">
  
                <div class="admin-content-area">
                    <div class="admin-page-header">
                        <div>
                            <h1 class="admin-page-heading">Manage Packages</h1>
                            <p class="admin-page-subheading mb-0">
                                View, add, edit, and manage travel packages.
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
                           href="${pageContext.request.contextPath}/admin/packages/add">
                            Add Package
                        </a>

                        <a class="btn btn-info text-white admin-back-btn"
                           href="${pageContext.request.contextPath}/admin/package-options">
                            View Package Options
                        </a>
                    </div>

                    <div class="dashboard-panel modern-panel">
                        <div class="table-responsive admin-table-wrap">
                            <table class="table align-middle mb-0 admin-modern-table admin-flex-table admin-packages-modern-table">
                                <thead>
                                    <tr>
                                        <th>Package ID</th>
                                        <th>Package Name</th>
                                        <th>Destination</th>
                                        <th>Description</th>
                                        <th>Price</th>
                                        <th>Duration</th>
                                        <th>Weather</th>
                                        <th>Latitude</th>
                                        <th>Longitude</th>
                                        <th>Image</th>
                                        <th>Available Slots</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${empty packages}">
                                        <tr>
                                            <td colspan="12" class="text-center">No packages found.</td>
                                        </tr>
                                    </c:if>

                                    <c:forEach var="rec" items="${packages}">
                                        <tr>
                                            <td>${rec.packageId}</td>
                                            <td class="admin-packages-name">${rec.packageName}</td>
                                            <td>${rec.destination}</td>
                                            <td class="admin-packages-description">
                                                <c:choose>
                                                    <c:when test="${not empty rec.description and fn:length(rec.description) > 100}">
                                                        ${fn:substring(rec.description, 0, 100)}...
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${rec.description}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>₱ ${rec.price}</td>
                                            <td>${rec.duration}</td>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty rec.weatherInfo}">
                                                        <span class="badge bg-success">Configured</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Missing</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${rec.latitude != null}">
                                                        ${rec.latitude}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Not set</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${rec.longitude != null}">
                                                        ${rec.longitude}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Not set</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td class="text-center admin-packages-image-cell">
                                                <c:choose>
                                                    <c:when test="${not empty rec.imageName}">
                                                        <img
                                                            src="${pageContext.request.contextPath}/resources/images/packages/${rec.imageName}"
                                                            alt="${rec.packageName}"
                                                            class="img-thumbnail admin-packages-image">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">No image</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

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

                                            <td class="admin-packages-actions">
                                                <div class="d-flex gap-2 flex-wrap">
                                                    <a class="btn btn-primary btn-sm admin-table-action-btn"
                                                       href="${pageContext.request.contextPath}/admin/packages/edit?packageId=${rec.packageId}">
                                                        Edit
                                                    </a>

                                                    <c:choose>
                                                        <c:when test="${rec.hasOptions}">
                                                            <button type="button"
                                                                    class="btn btn-secondary btn-sm admin-table-action-btn"
                                                                    disabled
                                                                    title="Cannot delete because this package has package options.">
                                                                Delete
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <form class="d-inline"
                                                                  action="${pageContext.request.contextPath}/admin/packages/delete"
                                                                  method="post">
                                                                <input type="hidden" name="packageId" value="${rec.packageId}">
                                                                <button type="submit"
                                                                        class="btn btn-danger btn-sm admin-table-action-btn"
                                                                        onclick="return confirm('Delete this package?');">
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
                                    <a href="${pageContext.request.contextPath}/admin/packages?page=${currentPage - 1}"
                                       class="btn btn-outline-success btn-sm admin-pagination-btn">
                                        Previous
                                    </a>
                                </c:if>

                                <c:if test="${currentPage < totalPages}">
                                    <a href="${pageContext.request.contextPath}/admin/packages?page=${currentPage + 1}"
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