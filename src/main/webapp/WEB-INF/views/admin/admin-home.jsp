<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.fujitsu.training.codes.model.data.Booking" %>
<%@ page import="org.fujitsu.training.codes.model.data.Feedback" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="admin-body">

    <div class="admin-shell">
        <div class="admin-shell-inner">
            <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

            <div class="admin-main">
                <div class="admin-topbar">
                    <div class="admin-search-box">
                        <input type="text" class="admin-search-input" placeholder="Search here..." />
                    </div>

                    <div class="admin-topbar-right">
                        <div class="admin-top-icon">✉</div>
                        <div class="admin-top-icon">🔔</div>

                        <div class="admin-profile-box">
                            <div class="admin-profile-avatar">A</div>
                            <div>
                                <div class="admin-profile-name">Admin User</div>
                                <div class="admin-profile-email">admin@trektok.com</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="admin-content-area">
                    <div class="admin-page-header">
                        <div>
                            <h1 class="admin-page-heading">Dashboard</h1>
                            <p class="admin-page-subheading mb-0">
                                Manage users, bookings, payments, feedback, and packages.
                            </p>
                        </div>
                    </div>

                    <div class="row g-4 mb-4">
                        <div class="col-md-6 col-xl-3">
                            <div class="dashboard-stat-card">
                                <div class="dashboard-stat-title">Total Users</div>
                                <div class="dashboard-stat-value">${totalUsers}</div>
                                <div class="dashboard-stat-text">Registered accounts in the system</div>
                            </div>
                        </div>

                        <div class="col-md-6 col-xl-3">
                            <div class="dashboard-stat-card">
                                <div class="dashboard-stat-title">Total Bookings</div>
                                <div class="dashboard-stat-value">${totalBookings}</div>
                                <div class="dashboard-stat-text">All recorded customer bookings</div>
                            </div>
                        </div>

                        <div class="col-md-6 col-xl-3">
                            <div class="dashboard-stat-card">
                                <div class="dashboard-stat-title">Total Payments</div>
                                <div class="dashboard-stat-value">${totalPayments}</div>
                                <div class="dashboard-stat-text">Payment records currently stored</div>
                            </div>
                        </div>

                        <div class="col-md-6 col-xl-3">
                            <div class="dashboard-stat-card">
                                <div class="dashboard-stat-title">Total Feedback</div>
                                <div class="dashboard-stat-value">${totalFeedback}</div>
                                <div class="dashboard-stat-text">Traveler feedback and reviews</div>
                            </div>
                        </div>

                        <div class="col-md-6 col-xl-6">
                            <div class="dashboard-stat-card">
                                <div class="dashboard-stat-title">Total Packages</div>
                                <div class="dashboard-stat-value">${totalPackages}</div>
                                <div class="dashboard-stat-text">Available travel packages</div>
                            </div>
                        </div>

                        <div class="col-md-6 col-xl-6">
                            <div class="dashboard-stat-card">
                                <div class="dashboard-stat-title">Package Options</div>
                                <div class="dashboard-stat-value">${totalPackageOptions}</div>
                                <div class="dashboard-stat-text">Package options and availability</div>
                            </div>
                        </div>
                    </div>

                    <div class="row g-4">
                        <div class="col-xl-7">
                            <div class="dashboard-panel modern-panel">
                                <div class="dashboard-panel-header">
                                    <h5 class="dashboard-panel-title mb-0">Recent Bookings</h5>
                                    <a href="${pageContext.request.contextPath}/admin/bookings"
                                       class="dashboard-view-btn">View All</a>
                                </div>

                                <%
                                    List<Booking> recentBookings = (List<Booking>) request.getAttribute("recentBookings");
                                    if (recentBookings != null && !recentBookings.isEmpty()) {
                                %>
                                    <div class="table-responsive">
                                        <table class="table admin-modern-table align-middle mb-0">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>User</th>
                                                    <th>Package</th>
                                                    <th>Status</th>
                                                    <th>Travel Date</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    for (Booking rec : recentBookings) {
                                                %>
                                                    <tr>
                                                        <td><%= rec.getBookingId() %></td>
                                                        <td>User #<%= rec.getUserId() %></td>
                                                        <td>Package #<%= rec.getPackageId() %></td>
                                                        <td>
                                                            <span class="status-badge status-confirmed">
                                                                <%= rec.getStatus() %>
                                                            </span>
                                                        </td>
                                                        <td><%= rec.getTravelDate() %></td>
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
                                    <p class="text-muted mb-0">No recent bookings found.</p>
                                <%
                                    }
                                %>
                            </div>
                        </div>

                        <div class="col-xl-5">
                            <div class="dashboard-panel modern-panel mb-4">
                                <div class="dashboard-panel-header">
                                    <h5 class="dashboard-panel-title mb-0">Recent Feedback</h5>
                                    <a href="${pageContext.request.contextPath}/admin/feedback"
                                       class="dashboard-view-btn">View All</a>
                                </div>

                                <%
                                    List<Feedback> recentFeedback = (List<Feedback>) request.getAttribute("recentFeedback");
                                    if (recentFeedback != null && !recentFeedback.isEmpty()) {
                                %>
                                    <div class="table-responsive">
                                        <table class="table admin-modern-table align-middle mb-0">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Email</th>
                                                    <th>Rating</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    for (Feedback rec : recentFeedback) {
                                                %>
                                                    <tr>
                                                        <td><%= rec.getFeedbackId() %></td>
                                                        <td><%= rec.getEmail() %></td>
                                                        <td><%= rec.getRating() %></td>
                                                        <td>
                                                            <span class="status-badge status-pending">
                                                                <%= rec.getStatus() == null ? "NEW" : rec.getStatus() %>
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
                                    <p class="text-muted mb-0">No recent feedback found.</p>
                                <%
                                    }
                                %>
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