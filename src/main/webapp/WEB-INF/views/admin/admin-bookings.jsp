<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.fujitsu.training.codes.model.data.Booking" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Bookings</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="admin-body">

    <div class="admin-shell">
        <div class="admin-shell-inner">

            <%
                request.setAttribute("activeMenu", "bookings");
            %>
            <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

            <div class="admin-main">
                <div class="admin-content-area">
                    <div class="admin-page-header">
                        <div>
                            <h1 class="admin-page-heading">All Bookings</h1>
                            <p class="admin-page-subheading mb-0">
                                View all customer booking records and payment progress.
                            </p>
                        </div>
                    </div>

                    <%
                        List<Booking> records = (List<Booking>) request.getAttribute("bookings");
                        Integer currentPage = (Integer) request.getAttribute("currentPage");
                        Integer totalPages = (Integer) request.getAttribute("totalPages");

                        if (records != null && !records.isEmpty()) {
                    %>

                        <div class="dashboard-panel modern-panel">
                            <div class="table-responsive admin-table-wrap">
                                <table class="table align-middle mb-0 admin-modern-table admin-flex-table admin-bookings-modern-table">
                                    <thead>
                                        <tr>
                                            <th>Booking ID</th>
                                            <th>User ID</th>
                                            <th>Package Name</th>
                                            <th>Booking Date</th>
                                            <th>Comments</th>
                                            <th>Status</th>
                                            <th>Payment Status</th>
                                            <!-- <th>Actions</th> -->
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            for (Booking rec : records) {
                                                String bookingStatus = rec.getStatus();
                                                String bookingBadgeClass = "bg-secondary";

                                                if ("CONFIRMED".equalsIgnoreCase(bookingStatus)) {
                                                    bookingBadgeClass = "bg-primary";
                                                } else if ("CANCELLED".equalsIgnoreCase(bookingStatus)) {
                                                    bookingBadgeClass = "bg-danger";
                                                } else if ("PENDING".equalsIgnoreCase(bookingStatus)) {
                                                    bookingBadgeClass = "bg-warning text-dark";
                                                } else if ("REJECTED".equalsIgnoreCase(bookingStatus)) {
                                                    bookingBadgeClass = "bg-danger";
                                                }

                                                String paymentStatus = rec.getPaymentStatus() == null ? "NOT YET PAID" : rec.getPaymentStatus();
                                                String paymentBadgeClass = "bg-secondary";

                                                if ("PAID".equalsIgnoreCase(paymentStatus)) {
                                                    paymentBadgeClass = "bg-success";
                                                } else if ("NOT YET PAID".equalsIgnoreCase(paymentStatus)) {
                                                    paymentBadgeClass = "bg-warning text-dark";
                                                } else if ("FAILED".equalsIgnoreCase(paymentStatus)) {
                                                    paymentBadgeClass = "bg-danger";
                                                }
                                        %>
                                            <tr>
                                                <td><%= rec.getBookingId() %></td>
                                                <td><%= rec.getUserId() %></td>
                                                <td class="admin-bookings-package"><%= rec.getPackageName() %></td>
                                                <td><%= rec.getBookingDate() %></td>
                                                <td class="admin-bookings-comments">
                                                    <%= rec.getComments() == null || rec.getComments().trim().isEmpty() ? "-" : rec.getComments() %>
                                                </td>
                                                <td>
                                                    <span class="badge <%= bookingBadgeClass %>">
                                                        <%= bookingStatus == null ? "UNKNOWN" : bookingStatus %>
                                                    </span>
                                                </td>
                                                <td>
                                                    <span class="badge <%= paymentBadgeClass %>">
                                                        <%= paymentStatus %>
                                                    </span>
                                                </td>
                                                <td>
                                                    <% if ("PENDING".equalsIgnoreCase(bookingStatus)) { %>
                                                        <form action="<%= request.getContextPath() %>/admin/bookings/status" method="post" class="d-inline">
                                                            <input type="hidden" name="bookingId" value="<%= rec.getBookingId() %>">
                                                            <input type="hidden" name="status" value="CONFIRMED">
                                                            <button type="submit" class="btn btn-success btn-sm">Confirm</button>
                                                        </form>

                                                        <form action="<%= request.getContextPath() %>/admin/bookings/status" method="post" class="d-inline ms-1">
                                                            <input type="hidden" name="bookingId" value="<%= rec.getBookingId() %>">
                                                            <input type="hidden" name="status" value="REJECTED">
                                                            <button type="submit" class="btn btn-danger btn-sm">Reject</button>
                                                        </form>
                                                    <% } else { %>
                                                        
                                                    <% } %>
                                                </td>
                                            </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>

                            <div class="admin-pagination-modern">
                                <div class="admin-pagination-info">
                                    Page <%= currentPage == null ? 1 : currentPage %> of <%= totalPages == null ? 1 : totalPages %>
                                </div>

                                <div class="d-flex gap-2">
                                    <% if (currentPage != null && currentPage > 1) { %>
                                        <a href="<%= request.getContextPath() %>/admin/bookings?page=<%= currentPage - 1 %>"
                                           class="btn btn-outline-success btn-sm admin-pagination-btn">
                                            Previous
                                        </a>
                                    <% } %>

                                    <% if (currentPage != null && totalPages != null && currentPage < totalPages) { %>
                                        <a href="<%= request.getContextPath() %>/admin/bookings?page=<%= currentPage + 1 %>"
                                           class="btn btn-outline-success btn-sm admin-pagination-btn">
                                            Next
                                        </a>
                                    <% } %>
                                </div>
                            </div>
                        </div>

                    <%
                        } else {
                    %>
                        <div class="dashboard-panel modern-panel">
                            <p class="text-muted mb-0">No bookings found.</p>
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