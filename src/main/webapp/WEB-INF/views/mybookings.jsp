<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.fujitsu.training.codes.model.data.Booking" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Bookings</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mybookings.css?v=2">
</head>

<body class="mybookings-page">

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <main class="mybookings-main">
        <section class="mybookings-section">
            <div class="container">

                <%
                    List<Booking> records = (List<Booking>) request.getAttribute("bookings");

                    int totalBookings = records == null ? 0 : records.size();
                    int upcomingCount = 0;
                    int pendingPaymentCount = 0;
                    int completedCount = 0;

                    if (records != null) {
                        for (Booking item : records) {
                            String status = item.getStatus() == null ? "" : item.getStatus();
                            String paymentStatus = item.getPaymentStatus() == null ? "" : item.getPaymentStatus();

                            if ("PENDING".equalsIgnoreCase(status) || "CONFIRMED".equalsIgnoreCase(status)) {
                                upcomingCount++;
                            }

                            if ("NOT YET PAID".equalsIgnoreCase(paymentStatus)) {
                                pendingPaymentCount++;
                            }

                            if ("PAID".equalsIgnoreCase(paymentStatus)
                                    && !"CANCELLED".equalsIgnoreCase(status)
                                    && !"REJECTED".equalsIgnoreCase(status)) {
                                completedCount++;
                            }
                        }
                    }
                %>

                <div class="mybookings-header">
                    <div>
                        <span class="mybookings-badge">My Bookings</span>
                        <h1>Manage your trips with ease</h1>
                        <p>Track your bookings, check payment status, and get ready for your next adventure.</p>
                    </div>
                </div>

                <div class="booking-stats-row">
                    <div class="booking-stat-card">
                        <div class="booking-stat-icon blue-stat">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/calendar-icon.png"
                                 alt="Total Bookings">
                        </div>
                        <div>
                            <h3><%= totalBookings %></h3>
                            <p>Total Bookings</p>
                        </div>
                    </div>

                    <div class="booking-stat-card">
                        <div class="booking-stat-icon green-stat">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/calendar-icon.png"
                                 alt="Upcoming Trips">
                        </div>
                        <div>
                            <h3><%= upcomingCount %></h3>
                            <p>Upcoming Trips</p>
                        </div>
                    </div>

                    <div class="booking-stat-card">
                        <div class="booking-stat-icon yellow-stat">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/payment-icon.png"
                                 alt="Pending Payment">
                        </div>
                        <div>
                            <h3><%= pendingPaymentCount %></h3>
                            <p>Pending Payment</p>
                        </div>
                    </div>

                    <div class="booking-stat-card">
                        <div class="booking-stat-icon purple-stat">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/shield-icon.png"
                                 alt="Completed Trips">
                        </div>
                        <div>
                            <h3><%= completedCount %></h3>
                            <p>Completed</p>
                        </div>
                    </div>
                </div>

                <div class="booking-toolbar">
                    <h2>Your Bookings</h2>

                    <div class="booking-toolbar-actions">
                        <input type="text" placeholder="Search by package or booking ID..." disabled>
                        <select disabled>
                            <option>All Status</option>
                        </select>
                    </div>
                </div>

                <%
                    if (records != null && !records.isEmpty()) {
                %>

                <div class="booking-list">
                    <%
                        for (Booking rec : records) {
                            String bookingStatus = rec.getStatus() == null ? "UNKNOWN" : rec.getStatus();
                            String paymentStatus = rec.getPaymentStatus() == null ? "NOT YET PAID" : rec.getPaymentStatus();

                            String bookingBadgeClass = "status-default";
                            if ("PENDING".equalsIgnoreCase(bookingStatus)) {
                                bookingBadgeClass = "status-pending";
                            } else if ("CONFIRMED".equalsIgnoreCase(bookingStatus)) {
                                bookingBadgeClass = "status-confirmed";
                            } else if ("REJECTED".equalsIgnoreCase(bookingStatus)) {
                                bookingBadgeClass = "status-rejected";
                            } else if ("CANCELLED".equalsIgnoreCase(bookingStatus)) {
                                bookingBadgeClass = "status-cancelled";
                            }

                            String paymentBadgeClass = "status-default";
                            if ("PAID".equalsIgnoreCase(paymentStatus)) {
                                paymentBadgeClass = "status-paid";
                            } else if ("NOT YET PAID".equalsIgnoreCase(paymentStatus)) {
                                paymentBadgeClass = "status-pending";
                            } else if ("FAILED".equalsIgnoreCase(paymentStatus)) {
                                paymentBadgeClass = "status-rejected";
                            }

                            String bookingImagePath = request.getContextPath() + "/resources/images/packages/";
                            String bookingImageName = rec.getImageName();

                            String bookingImageUrl = (bookingImageName != null && !bookingImageName.trim().isEmpty())
                                    ? bookingImagePath + bookingImageName
                                    : bookingImagePath + "booking-placeholder.jpg";
                    %>

                    <div class="booking-card">
                        <div class="booking-card-main">

                            <div class="booking-image-box">
                                <img src="<%= bookingImageUrl %>"
                                     alt="<%= rec.getPackageName() == null ? "Booking Image" : rec.getPackageName() %>">
                            </div>

                            <div class="booking-content">
                                <div class="booking-top-row">
                                    <div>
                                        <span class="booking-id">Booking ID: <%= rec.getBookingId() %></span>
                                        <h3><%= rec.getPackageName() %></h3>
                                    </div>

                                    <div class="booking-status-group">
                                        <span class="booking-status <%= bookingBadgeClass %>"><%= bookingStatus %></span>

                                        <% if (!"CANCELLED".equalsIgnoreCase(bookingStatus)) { %>
                                            <span class="booking-status <%= paymentBadgeClass %>"><%= paymentStatus %></span>
                                        <% } %>
                                    </div>
                                </div>

                                <div class="booking-details-grid">
                                    <div>
                                        <small>Travel Date</small>
                                        <p><%= rec.getTravelDate() %></p>
                                    </div>

                                    <div>
                                        <small>Booking Date</small>
                                        <p><%= rec.getBookingDate() %></p>
                                    </div>

                                    <div>
                                        <small>Option Chosen</small>
                                        <p><%= rec.getOptionName() %></p>
                                    </div>
                                </div>

                                <div class="booking-comments">
                                    <small>Comments</small>
                                    <p><%= rec.getComments() == null || rec.getComments().trim().isEmpty() ? "-" : rec.getComments() %></p>
                                </div>

                                <% if ("PENDING".equalsIgnoreCase(bookingStatus)) { %>
                                    <div class="booking-alert warning-alert">
                                        Waiting for admin approval.
                                    </div>
                                <% } %>

                                <% if ("REJECTED".equalsIgnoreCase(bookingStatus)) { %>
                                    <div class="booking-alert danger-alert">
                                        Booking was rejected by admin.
                                    </div>
                                <% } %>

                                <% if ("PAID".equalsIgnoreCase(paymentStatus)
                                        && !"CANCELLED".equalsIgnoreCase(bookingStatus)
                                        && !"REJECTED".equalsIgnoreCase(bookingStatus)) { %>
                                    <div class="booking-alert success-alert">
                                        Payment received successfully.
                                    </div>
                                <% } %>
                            </div>

                            <div class="booking-actions">

                                <% if ("PENDING".equalsIgnoreCase(bookingStatus)) { %>
                                    <form action="<%= request.getContextPath() %>/cancel-booking" method="post">
                                        <input type="hidden" name="bookingId" value="<%= rec.getBookingId() %>">
                                        <input type="submit" value="Cancel Booking" class="booking-danger-btn">
                                    </form>
                                <% } %>

                                <% if ("CONFIRMED".equalsIgnoreCase(bookingStatus)
                                        && "NOT YET PAID".equalsIgnoreCase(paymentStatus)) { %>

                                    <a href="<%= request.getContextPath() %>/pay?bookingId=<%= rec.getBookingId() %>"
                                       class="booking-primary-btn">
                                        Pay Now
                                    </a>

                                    <form action="<%= request.getContextPath() %>/cancel-booking" method="post">
                                        <input type="hidden" name="bookingId" value="<%= rec.getBookingId() %>">
                                        <input type="submit" value="Cancel Booking" class="booking-danger-link">
                                    </form>

                                <% } %>

                                <% if ("PAID".equalsIgnoreCase(paymentStatus)
                                        && !"CANCELLED".equalsIgnoreCase(bookingStatus)
                                        && !"REJECTED".equalsIgnoreCase(bookingStatus)) { %>

                                    <a href="<%= request.getContextPath() %>/feedback?bookingId=<%= rec.getBookingId() %>"
                                       class="booking-primary-btn">
                                        Give Feedback
                                    </a>

                                <% } %>

                            </div>

                        </div>
                    </div>

                    <%
                        }
                    %>
                </div>

                <%
                    } else {
                %>

                <div class="booking-empty">
                    <h3>No bookings found.</h3>
                    <p>You have not booked any trip yet. Browse packages and start planning your next adventure.</p>
                    <a href="<%= request.getContextPath() %>/packages">Explore Packages</a>
                </div>

                <%
                    }
                %>

                <div class="booking-help-card">
                    <div>
                        <h3>Need help with your booking?</h3>
                        <p>Our support team is ready to help you with any questions or changes to your trip.</p>
                    </div>

                    <a href="<%= request.getContextPath() %>/contact">Contact Support</a>
                </div>

                <a href="<%= request.getContextPath() %>/packages" class="booking-back-link">
                    ← Back to Packages
                </a>

            </div>
        </section>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/footer-page.jsp" />

</body>
</html>