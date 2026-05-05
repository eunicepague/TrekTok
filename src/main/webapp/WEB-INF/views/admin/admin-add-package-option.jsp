<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Package Option</title>
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
                            <h1 class="admin-page-heading">Add Package Option</h1>
                            <p class="admin-page-subheading mb-0">
                                Create a new option for an existing travel package.
                            </p>
                        </div>
                    </div>

                    <div class="row justify-content-center">
                        <div class="col-lg-8">
                            <div class="dashboard-panel modern-panel">

                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">${error}</div>
                                </c:if>

                                <form action="${pageContext.request.contextPath}/admin/package-options/add" method="post">
                                    <div class="mb-3">
                                        <label class="form-label">Package</label>
                                        <select name="packageId" id="packageId" class="form-select admin-form-control" required>
                                            <option value="">-- Select Package --</option>
                                            <c:forEach var="pkg" items="${packages}">
                                                <option value="${pkg.packageId}" ${pkg.packageId == packageOptionForm.packageId ? 'selected' : ''}>
                                                    ${pkg.packageName}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <p class="mb-1">
                                            Package not listed?
                                            <a href="${pageContext.request.contextPath}/admin/packages/add">Create New Package</a>
                                        </p>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Option Name</label>
                                        <select name="optionName" id="optionName" class="form-select admin-form-control" onchange="setOptionTemplate()" required>
                                            <option value="">-- Select Option --</option>
                                            <option value="Solo" ${packageOptionForm.optionName == 'Solo' ? 'selected' : ''}>Solo</option>
                                            <option value="Couple" ${packageOptionForm.optionName == 'Couple' ? 'selected' : ''}>Couple</option>
                                            <option value="Family" ${packageOptionForm.optionName == 'Family' ? 'selected' : ''}>Family</option>
                                            <option value="Barkada" ${packageOptionForm.optionName == 'Barkada' ? 'selected' : ''}>Barkada</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Description</label>
                                        <textarea name="description" id="description" rows="4" class="form-control admin-form-control admin-form-textarea" required>${packageOptionForm.description}</textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Price</label>
                                        <input type="number" step="0.01" min="0" name="price" class="form-control admin-form-control"
                                               value="${packageOptionForm.price}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Max Pax</label>
                                        <input type="number" id="maxPax" name="maxPax" min="1" class="form-control admin-form-control"
                                               value="${packageOptionForm.maxPax}" readonly required>
                                    </div>

                                    <div class="mb-4">
                                        <label class="form-label">Available Slots</label>
                                        <input type="number" name="availableSlots" min="0" class="form-control admin-form-control"
                                               value="${packageOptionForm.availableSlots}" required>
                                    </div>

                                    <div class="d-flex gap-2 flex-wrap">
                                        <button type="submit" class="btn btn-success admin-submit-btn">Add Package Option</button>
                                        <a href="${pageContext.request.contextPath}/admin/package-options" class="btn btn-secondary admin-back-btn">Back to Package Options</a>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/package-option.js"></script>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>