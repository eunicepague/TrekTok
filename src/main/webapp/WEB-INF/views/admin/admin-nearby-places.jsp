<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.fujitsu.training.codes.model.data.NearbyPlace" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Nearby Places</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="admin-body">

    <div class="admin-shell">
        <div class="admin-shell-inner">

            <%
                request.setAttribute("activeMenu", "nearby-places");
            %>
            <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

            <div class="admin-main">
                <div class="admin-content-area">
                    <div class="admin-page-header">
                        <div>
                            <h1 class="admin-page-heading">Manage Nearby Places</h1>
                            <p class="admin-page-subheading mb-0">
                                View, add, edit, and manage nearby places for packages.
                            </p>
                        </div>
                    </div>

                    <div class="mb-3 d-flex gap-2 flex-wrap">
                        <a class="btn btn-success admin-submit-btn"
                           href="${pageContext.request.contextPath}/admin/nearby-places/add">
                            Add Nearby Place
                        </a>
                    </div>

                    <%
                        List<NearbyPlace> records = (List<NearbyPlace>) request.getAttribute("nearbyPlaces");
                        if (records != null && !records.isEmpty()) {
                    %>
                        <div class="dashboard-panel modern-panel">
                            <div class="table-responsive admin-table-wrap">
                                <table class="table align-middle mb-0 admin-modern-table admin-flex-table admin-nearby-places-modern-table">
                                    <thead>
                                        <tr>
                                            <th>Place ID</th>
                                            <th>Package ID</th>
                                            <th>Place Name</th>
                                            <th>Category</th>
                                            <th>Address</th>
                                            <th>Distance</th>
                                            <th>Map Link</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            for (NearbyPlace rec : records) {
                                        %>
                                            <tr>
                                                <td><%= rec.getPlaceId() %></td>
                                                <td><%= rec.getPackageId() %></td>
                                                <td class="admin-nearby-places-name"><%= rec.getPlaceName() %></td>
                                                <td><%= rec.getCategory() %></td>
                                                <td class="admin-nearby-places-address">
                                                    <%= rec.getAddress() == null || rec.getAddress().trim().isEmpty() ? "-" : rec.getAddress() %>
                                                </td>
                                                <td><%= rec.getDistanceKm() == null ? "-" : rec.getDistanceKm() + " km" %></td>
                                                <td>
                                                    <%
                                                        if (rec.getMapLink() != null && !rec.getMapLink().trim().isEmpty()) {
                                                    %>
                                                        <a href="<%= rec.getMapLink() %>" target="_blank" class="btn btn-outline-primary btn-sm admin-table-action-btn">
                                                            Open
                                                        </a>
                                                    <%
                                                        } else {
                                                    %>
                                                        <span class="text-muted">No link</span>
                                                    <%
                                                        }
                                                    %>
                                                </td>
                                                <td class="admin-nearby-places-actions">
                                                    <div class="d-flex gap-2 flex-wrap">
                                                        <a class="btn btn-primary btn-sm admin-table-action-btn"
                                                           href="<%= request.getContextPath() %>/admin/nearby-places/edit?placeId=<%= rec.getPlaceId() %>">
                                                            Edit
                                                        </a>

                                                        <form class="d-inline"
                                                              action="<%= request.getContextPath() %>/admin/nearby-places/delete"
                                                              method="post">
                                                            <input type="hidden" name="placeId" value="<%= rec.getPlaceId() %>">
                                                            <button type="submit"
                                                                    class="btn btn-danger btn-sm admin-table-action-btn"
                                                                    onclick="return confirm('Delete this nearby place?');">
                                                                Delete
                                                            </button>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    <%
                        } else {
                    %>
                        <div class="dashboard-panel modern-panel">
                            <p class="text-muted mb-0">No nearby places found.</p>
                        </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>