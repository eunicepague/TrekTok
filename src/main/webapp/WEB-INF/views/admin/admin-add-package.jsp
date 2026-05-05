<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Package</title>
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
                            <h1 class="admin-page-heading">Add Package</h1>
                            <p class="admin-page-subheading mb-0">
                                Create a new travel package for your customers.
                            </p>
                        </div>
                    </div>

                    <div class="row justify-content-center">
                        <div class="col-lg-8">
                            <div class="dashboard-panel modern-panel">
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">${error}</div>
                                </c:if>

                                <form action="${pageContext.request.contextPath}/admin/packages/add"
                                      method="post"
                                      enctype="multipart/form-data">

                                    <div class="mb-3">
                                        <label class="form-label">Package Name</label>
                                        <input type="text" name="packageName" class="form-control admin-form-control"
                                               value="${packageForm.packageName}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Destination</label>
                                        <input type="text" name="destination" class="form-control admin-form-control"
                                               value="${packageForm.destination}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Description</label>
                                        <textarea name="description" rows="5" class="form-control admin-form-control admin-form-textarea" required>${packageForm.description}</textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Price</label>
                                        <input type="number" step="0.01" name="price" class="form-control admin-form-control"
                                               value="${packageForm.price}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Duration</label>
                                        <input type="text" name="duration" class="form-control admin-form-control"
                                               value="${packageForm.duration}" required>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Latitude</label>
                                            <input type="number" step="0.0000001" name="latitude" class="form-control admin-form-control"
                                                   value="${packageForm.latitude}" placeholder="Example: 25.197197">
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Longitude</label>
                                            <input type="number" step="0.0000001" name="longitude" class="form-control admin-form-control"
                                                   value="${packageForm.longitude}" placeholder="Example: 55.2743764">
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
									    <label class="form-label">Package Type</label>
									    <select name="packageType" class="form-select admin-form-control" required>
									        <option value="">-- Select Type --</option>
									        <option value="TRAVEL_PACKAGE" ${packageForm.packageType == 'TRAVEL_PACKAGE' ? 'selected' : ''}>Travel Package</option>
									        <option value="HOTEL" ${packageForm.packageType == 'HOTEL' ? 'selected' : ''}>Hotel</option>
									        <option value="DESTINATION" ${packageForm.packageType == 'DESTINATION' ? 'selected' : ''}>Destination</option>
									        <option value="TRANSPORT" ${packageForm.packageType == 'TRANSPORT' ? 'selected' : ''}>Transport</option>
									    </select>
									</div>

                                    <div class="mb-4">
                                        <label class="form-label">Package Image</label>
                                        <input type="file" name="imageFile" class="form-control admin-form-control" accept="image/*">
                                        <div class="form-text">Optional. Allowed: JPG, JPEG, PNG, WEBP</div>
                                    </div>

                                    <div class="d-flex gap-2 flex-wrap">
                                        <button type="submit" class="btn btn-success admin-submit-btn">Add Package</button>
                                        <a href="${pageContext.request.contextPath}/admin/packages" class="btn btn-secondary admin-back-btn">Back to Packages</a>
                                    </div>
                                </form>
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