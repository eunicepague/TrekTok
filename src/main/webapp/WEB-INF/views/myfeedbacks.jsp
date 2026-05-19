<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.fujitsu.training.codes.model.data.Feedback" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Feedbacks</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myfeedbacks.css?v=1">
</head>

<body class="myfeedbacks-page">

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <%
        List<Feedback> records = (List<Feedback>) request.getAttribute("feedbackList");
        int totalFeedbacks = records == null ? 0 : records.size();
    %>

    <main class="myfeedbacks-main">
        <section class="myfeedbacks-section">
            <div class="container">

                <div class="myfeedbacks-header">
                    <span class="myfeedbacks-badge">Feedbacks</span>

                    <h1>My Feedbacks</h1>

                    <p>
                        View and manage the feedback you’ve submitted for your completed travel experiences.
                    </p>
                </div>

                <div class="myfeedbacks-card">

                    <div class="myfeedbacks-card-header">
                        <div>
                            <h3>All Feedbacks</h3>
                            <p>Here’s a list of all your submitted feedbacks.</p>
                        </div>

                        <div class="myfeedbacks-search">
                            <input type="text" placeholder="Search feedback..." disabled>
                        </div>
                    </div>

                    <%
                        if (records != null && !records.isEmpty()) {
                    %>

                    <div class="myfeedbacks-table-wrap">
                        <table class="myfeedbacks-table">
                            <thead>
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
                                        String statusClass = "feedback-status-default";

                                        if ("PENDING".equalsIgnoreCase(status)) {
                                            statusClass = "feedback-status-pending";
                                        } else if ("OPEN".equalsIgnoreCase(status)) {
                                            statusClass = "feedback-status-open";
                                        } else if ("RESOLVED".equalsIgnoreCase(status)) {
                                            statusClass = "feedback-status-resolved";
                                        }

                                        String packageName = rec.getPackageName() == null ? "-" : rec.getPackageName();
                                        String message = rec.getMessage() == null ? "-" : rec.getMessage();
                                        String adminRemarks = rec.getAdminRemarks() == null ? "-" : rec.getAdminRemarks();
                                %>

                                <tr>
                                    <td>
                                        <span class="feedback-id"><%= rec.getFeedbackId() %></span>
                                    </td>

                                    <td>
                                        <%= rec.getBookingId() == null ? "-" : rec.getBookingId() %>
                                    </td>

                                    <td>
                                        <div class="feedback-package-cell">
                                            <div>
                                                <strong><%= packageName %></strong>
                                                <small>Travel package</small>
                                            </div>
                                        </div>
                                    </td>

                                    <td>
                                        <div class="feedback-message-cell">
                                            <%= message %>
                                        </div>
                                    </td>

                                    <td>
                                        <div class="feedback-rating-cell">
                                            <span>★</span>
                                            <strong><%= rec.getRating() %></strong>
                                        </div>
                                    </td>

                                    <td>
                                        <%= rec.getFeedbackDate() == null ? "-" : rec.getFeedbackDate() %>
                                    </td>

                                    <td>
                                        <%= adminRemarks %>
                                    </td>

                                    <td>
                                        <span class="feedback-status <%= statusClass %>">
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

                    <div class="myfeedbacks-card-footer">
                        <p>Showing 1 to <%= totalFeedbacks %> of <%= totalFeedbacks %> feedback<%= totalFeedbacks > 1 ? "s" : "" %></p>

                        <div class="feedback-pagination">
                            <button type="button" disabled>‹</button>
                            <button type="button" class="active">1</button>
                            <button type="button" disabled>›</button>
                        </div>
                    </div>

                    <%
                        } else {
                    %>

                    <div class="myfeedbacks-empty">
                        <h3>No feedback submitted yet.</h3>
                        <p>You have not submitted any feedback yet. Once you finish a trip, you can leave a review from My Bookings.</p>
                        <a href="<%= request.getContextPath() %>/mybookings">Go to My Bookings</a>
                    </div>

                    <%
                        }
                    %>

                    <div class="myfeedbacks-actions">
                        <a href="<%= request.getContextPath() %>/home" class="myfeedbacks-back-btn">
                            ← Back to Home
                        </a>
                    </div>

                </div>

            </div>
        </section>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/footer-page.jsp" />

</body>
</html>