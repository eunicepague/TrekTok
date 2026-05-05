<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.fujitsu.training.codes.model.data.Feedback" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Feedbacks</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <div class="container mt-4">
        <h2 class="mb-4">My Feedbacks</h2>

        <%
            List<Feedback> records = (List<Feedback>) request.getAttribute("feedbackList");
            if (records != null && !records.isEmpty()) {
        %>
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>Feedback ID</th>
                            <th>Booking ID</th>
                            <th>Package Name</th>
                            <th>Message</th>
                            <th>Rating</th>
                            <th>Feedback Date</th>
                            <th>Admin Remarks</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Feedback rec : records) {
                                String status = rec.getStatus();
                                String badgeClass = "bg-secondary";

                                if ("PENDING".equalsIgnoreCase(status)) {
                                    badgeClass = "bg-warning text-dark";
                                } else if ("OPEN".equalsIgnoreCase(status)) {
                                    badgeClass = "bg-primary";
                                } else if ("RESOLVED".equalsIgnoreCase(status)) {
                                    badgeClass = "bg-success";
                                }
                        %>
                            <tr>
                                <td><%= rec.getFeedbackId() %></td>
                                <td><%= rec.getBookingId() == null ? "-" : rec.getBookingId() %></td>
                                <td><%= rec.getPackageName() == null ? "-" : rec.getPackageName() %></td>
                                <td><%= rec.getMessage() %></td>
                                <td><%= rec.getRating() %></td>
                                <td><%= rec.getFeedbackDate() %></td>
                                <td><%= rec.getAdminRemarks() == null ? "-" : rec.getAdminRemarks() %></td>
                                <td>
                                    <span class="badge <%= badgeClass %>">
                                        <%= status == null ? "NEW" : status %>
                                    </span>
                                </td>
                            </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        <%
            } else {
        %>
            <div class="alert alert-info">You have not submitted any feedback yet.</div>
        <%
            }
        %>

        <a href="<%= request.getContextPath() %>/home" class="btn btn-secondary">Back to Home</a>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/footer-page.jsp" />
</body>
</html>