<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.fujitsu.training.codes.model.data.TourPackage" %>
<%@ page import="org.fujitsu.training.codes.model.data.NearbyPlace" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Nearby Place</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="admin-body">

    <div class="admin-shell">
        <div class="admin-shell-inner">

            <%
                request.setAttribute("activeMenu", "nearby-places");
                NearbyPlace rec = (NearbyPlace) request.getAttribute("rec");
                List<TourPackage> packages = (List<TourPackage>) request.getAttribute("packages");
            %>
            <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

            <div class="admin-main">
                <div class="admin-content-area">
                    <div class="admin-page-header">
                        <div>
                            <h1 class="admin-page-heading">Edit Nearby Place</h1>
                            <p class="admin-page-subheading mb-0">
                                Update the selected nearby place details.
                            </p>
                        </div>
                    </div>

                    <%
                        if (request.getAttribute("error") != null) {
                    %>
                        <div class="alert alert-danger">${error}</div>
                    <%
                        }
                    %>

                    <div class="row justify-content-center">
                        <div class="col-lg-8">
                            <div class="dashboard-panel modern-panel">
                                <form action="<%= request.getContextPath() %>/admin/nearby-places/edit" method="post">
                                    <input type="hidden" name="placeId" value="<%= rec == null || rec.getPlaceId() == null ? "" : rec.getPlaceId() %>">

                                    <div class="mb-3">
                                        <label class="form-label">Package</label>
                                        <select name="packageId" class="form-select admin-form-control" required>
                                            <option value="">-- Select Package --</option>
                                            <%
                                                if (packages != null) {
                                                    for (TourPackage pkg : packages) {
                                                        boolean selected = rec != null && rec.getPackageId() != null
                                                                && rec.getPackageId().equals(pkg.getPackageId());
                                            %>
                                                <option value="<%= pkg.getPackageId() %>" <%= selected ? "selected" : "" %>>
                                                    <%= pkg.getPackageName() %>
                                                </option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Place Name</label>
                                        <input type="text"
                                               name="placeName"
                                               class="form-control admin-form-control"
                                               value="<%= rec == null || rec.getPlaceName() == null ? "" : rec.getPlaceName() %>"
                                               required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Category</label>
                                        <input type="text"
                                               name="category"
                                               class="form-control admin-form-control"
                                               value="<%= rec == null || rec.getCategory() == null ? "" : rec.getCategory() %>"
                                               required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Address</label>
                                        <textarea name="address"
                                                  class="form-control admin-form-control admin-form-textarea"
                                                  rows="4"><%= rec == null || rec.getAddress() == null ? "" : rec.getAddress() %></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Distance (km)</label>
                                        <input type="number"
                                               step="0.01"
                                               min="0"
                                               name="distanceKm"
                                               class="form-control admin-form-control"
                                               value="<%= rec == null || rec.getDistanceKm() == null ? "" : rec.getDistanceKm() %>">
                                    </div>
                                    
                                    <div class="row">
									    <div class="col-md-6 mb-3">
									        <label class="form-label">Latitude</label>
									        <input type="number"
									               step="0.0000001"
									               name="latitude"
									               class="form-control admin-form-control"
									               value="<%= rec == null || rec.getLatitude() == null ? "" : rec.getLatitude() %>">
									    </div>
									
									    <div class="col-md-6 mb-3">
									        <label class="form-label">Longitude</label>
									        <input type="number"
									               step="0.0000001"
									               name="longitude"
									               class="form-control admin-form-control"
									               value="<%= rec == null || rec.getLongitude() == null ? "" : rec.getLongitude() %>">
									    </div>
									</div>

                                    <div class="mb-4">
                                        <label class="form-label">Map Link</label>
                                        <input type="text"
                                               name="mapLink"
                                               class="form-control admin-form-control"
                                               value="<%= rec == null || rec.getMapLink() == null ? "" : rec.getMapLink() %>">
                                    </div>

                                    <div class="d-flex gap-2 flex-wrap">
                                        <button type="submit" class="btn btn-success admin-submit-btn">Update Nearby Place</button>
                                        <a href="<%= request.getContextPath() %>/admin/nearby-places" class="btn btn-secondary admin-back-btn">Back to Nearby Places</a>
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