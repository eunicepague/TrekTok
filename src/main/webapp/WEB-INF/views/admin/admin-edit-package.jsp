<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.fujitsu.training.codes.model.form.PackageForm"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Package</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="admin-body">

    <div class="admin-shell">
        <div class="admin-shell-inner">

            <%
                request.setAttribute("activeMenu", "packages");
                PackageForm packageForm = (PackageForm) request.getAttribute("packageForm");
            %>
            <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

            <div class="admin-main">

                <div class="admin-content-area">
                    <div class="admin-page-header">
                        <div>
                            <h1 class="admin-page-heading">Edit Package</h1>
                            <p class="admin-page-subheading mb-0">
                                Update the selected travel package details.
                            </p>
                        </div>
                    </div>

                    <div class="row justify-content-center">
                        <div class="col-lg-8">
                            <div class="dashboard-panel modern-panel">

                                <% if (request.getAttribute("error") != null) { %>
                                    <div class="alert alert-danger">
                                        <%= request.getAttribute("error") %>
                                    </div>
                                <% } %>

                                <form action="<%= request.getContextPath() %>/admin/packages/edit" 
                                      method="post" 
                                      enctype="multipart/form-data">
                                      
                                    <input type="hidden" name="packageId"
                                           value="<%= packageForm != null && packageForm.getPackageId() != null ? packageForm.getPackageId() : "" %>">

                                    <input type="hidden" name="imageName"
                                           value="<%= packageForm != null && packageForm.getImageName() != null ? packageForm.getImageName() : "" %>">

                                    <div class="mb-3">
                                        <label class="form-label">Package Name</label>
                                        <input type="text" name="packageName" class="form-control admin-form-control"
                                               value="<%= packageForm != null && packageForm.getPackageName() != null ? packageForm.getPackageName() : "" %>" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Destination</label>
                                        <input type="text" name="destination" class="form-control admin-form-control"
                                               value="<%= packageForm != null && packageForm.getDestination() != null ? packageForm.getDestination() : "" %>" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Description</label>
                                        <textarea name="description" class="form-control admin-form-control admin-form-textarea" rows="5" required><%= packageForm != null && packageForm.getDescription() != null ? packageForm.getDescription() : "" %></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Price</label>
                                        <input type="number" step="0.01" name="price" class="form-control admin-form-control"
                                               value="<%= packageForm != null && packageForm.getPrice() != null ? packageForm.getPrice() : "" %>" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Duration</label>
                                        <input type="text" name="duration" class="form-control admin-form-control"
                                               value="<%= packageForm != null && packageForm.getDuration() != null ? packageForm.getDuration() : "" %>" required>
                                    </div>


                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Latitude</label>
                                            <input type="number" step="0.0000001" name="latitude" class="form-control admin-form-control"
                                                   value="<%= packageForm != null && packageForm.getLatitude() != null ? packageForm.getLatitude() : "" %>"
                                                   placeholder="Example: 25.197197">
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Longitude</label>
                                            <input type="number" step="0.0000001" name="longitude" class="form-control admin-form-control"
                                                   value="<%= packageForm != null && packageForm.getLongitude() != null ? packageForm.getLongitude() : "" %>"
                                                   placeholder="Example: 55.2743764">
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
									    <label class="form-label">Package Type</label>
									    <select name="packageType" class="form-select admin-form-control" required>
									        <option value="">-- Select Type --</option>
									        <option value="TRAVEL_PACKAGE" <%= packageForm != null && "TRAVEL_PACKAGE".equals(packageForm.getPackageType()) ? "selected" : "" %>>Travel Package</option>
									        <option value="HOTEL" <%= packageForm != null && "HOTEL".equals(packageForm.getPackageType()) ? "selected" : "" %>>Hotel</option>
									        <option value="DESTINATION" <%= packageForm != null && "DESTINATION".equals(packageForm.getPackageType()) ? "selected" : "" %>>Destination</option>
									        <option value="TRANSPORT" <%= packageForm != null && "TRANSPORT".equals(packageForm.getPackageType()) ? "selected" : "" %>>Transport</option>
									    </select>
									</div>

                                    <div class="mb-3">
                                        <label class="form-label">Current Image</label>
                                        <% if (packageForm != null && packageForm.getImageName() != null && !packageForm.getImageName().isBlank()) { %>
                                            <div class="mb-2">
                                                <img src="<%= request.getContextPath() %>/resources/images/packages/<%= packageForm.getImageName() %>"
                                                     alt="Package Image"
                                                     style="max-width: 220px; border-radius: 8px; border: 1px solid #ddd;">
                                            </div>
                                            <small class="text-muted">Current file: <%= packageForm.getImageName() %></small>
                                        <% } else { %>
                                            <p class="text-muted mb-1">No image uploaded.</p>
                                        <% } %>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Change Image</label>
                                        <input type="file" name="imageFile" class="form-control admin-form-control" accept=".jpg,.jpeg,.png,.webp">
                                        <small class="text-muted">Leave blank if you want to keep the current image.</small>
                                    </div>

                                    <div class="d-flex gap-2 flex-wrap">
                                        <button type="submit" class="btn btn-success admin-submit-btn">Update Package</button>
                                        <a href="<%= request.getContextPath() %>/admin/packages" class="btn btn-secondary admin-back-btn">Back to Packages</a>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>