<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.fujitsu.training.codes.model.data.Feedback" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Feedback</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="admin-body">

    <div class="admin-shell">
        <div class="admin-shell-inner">

            <%
                request.setAttribute("activeMenu", "feedback");
            %>
            <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

            <div class="admin-main">
                <div class="admin-content-area">
                    <div class="admin-page-header">
                        <div>
                            <h1 class="admin-page-heading">Admin Feedback</h1>
                            <p class="admin-page-subheading mb-0">
                                View customer feedback and update feedback records.
                            </p>
                        </div>
                    </div>

                    <% if (request.getAttribute("message") != null) { %>
                        <div class="alert alert-success">${message}</div>
                    <% } %>

                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger">${error}</div>
                    <% } %>

                    <%
                        List<Feedback> records = (List<Feedback>) request.getAttribute("feedbackList");
                        Integer currentPage = (Integer) request.getAttribute("currentPage");
                        Integer totalPages = (Integer) request.getAttribute("totalPages");

                        if (records != null && !records.isEmpty()) {
                    %>
                        <div class="dashboard-panel modern-panel">
                            <div class="table-responsive admin-table-wrap">
                                <table class="table align-middle mb-0 admin-modern-table admin-flex-table admin-feedback-modern-table">
                                    <thead>
                                        <tr>
                                            <th>Feedback ID</th>
                                            <th>Booking ID</th>
                                            <th>Package Name</th>
                                            <th>User Email</th>
                                            <th>Contact No</th>
                                            <th>Message</th>
                                            <th>Rating</th>
                                            <th>Feedback Date</th>
                                            <th>Admin Remarks</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            for (Feedback rec : records) {
                                                String status = rec.getStatus();
                                                String badgeClass = "bg-secondary";

                                                if ("OPEN".equalsIgnoreCase(status)) {
                                                    badgeClass = "bg-warning text-dark";
                                                } else if ("RESOLVED".equalsIgnoreCase(status)) {
                                                    badgeClass = "bg-success";
                                                }
                                        %>
                                            <tr>
                                                <td><%= rec.getFeedbackId() %></td>
                                                <td><%= rec.getBookingId() == null ? "-" : rec.getBookingId() %></td>
                                                <td class="admin-feedback-package"><%= rec.getPackageName() == null ? "-" : rec.getPackageName() %></td>
                                                <td class="admin-feedback-email"><%= rec.getEmail() %></td>
                                                <td><%= rec.getContactNo() %></td>
                                                <td class="admin-feedback-message"><%= rec.getMessage() %></td>
                                                <td><%= rec.getRating() %></td>
                                                <td><%= rec.getFeedbackDate() %></td>
                                                <td class="admin-feedback-remarks"><%= rec.getAdminRemarks() == null ? "-" : rec.getAdminRemarks() %></td>
                                                <td>
                                                    <span class="badge <%= badgeClass %>">
                                                        <%= status == null ? "NEW" : status %>
                                                    </span>
                                                </td>
                                                <td>
                                                    <a class="btn btn-primary btn-sm admin-feedback-action-btn"
                                                       href="<%= request.getContextPath() %>/admin/feedback/edit?feedbackId=<%= rec.getFeedbackId() %>">
                                                        Update
                                                    </a>
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
                                        <a href="<%= request.getContextPath() %>/admin/feedback?page=<%= currentPage - 1 %>"
                                           class="btn btn-outline-success btn-sm admin-pagination-btn">
                                            Previous
                                        </a>
                                    <% } %>

                                    <% if (currentPage != null && totalPages != null && currentPage < totalPages) { %>
                                        <a href="<%= request.getContextPath() %>/admin/feedback?page=<%= currentPage + 1 %>"
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
                            <p class="text-muted mb-0">No feedback records found.</p>
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