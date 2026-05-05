<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.fujitsu.training.codes.model.data.Booking" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Bookings</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <div class="container mt-4">
        <h2 class="mb-4">My Bookings</h2>

        <%
            List<Booking> records = (List<Booking>) request.getAttribute("bookings");
            if (records != null && !records.isEmpty()) {
                for (Booking rec : records) {
                    String bookingStatus = rec.getStatus() == null ? "UNKNOWN" : rec.getStatus();
                    String bookingBadgeClass = "bg-secondary";

                    if ("PENDING".equalsIgnoreCase(bookingStatus)) {
                        bookingBadgeClass = "bg-warning text-dark";
                    } else if ("CONFIRMED".equalsIgnoreCase(bookingStatus)) {
                        bookingBadgeClass = "bg-primary";
                    } else if ("REJECTED".equalsIgnoreCase(bookingStatus)) {
                        bookingBadgeClass = "bg-danger";
                    } else if ("CANCELLED".equalsIgnoreCase(bookingStatus)) {
                        bookingBadgeClass = "bg-secondary";
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
            <div class="card mb-4 shadow-sm border-0 rounded-4">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-3">
                        <h5 class="card-title mb-0 fw-bold">Booking ID: <%= rec.getBookingId() %></h5>

                        <div class="d-flex gap-2 flex-wrap">
                            <span class="badge <%= bookingBadgeClass %> px-3 py-2">
                                <%= bookingStatus %>
                            </span>

                            <% if (!"CANCELLED".equalsIgnoreCase(bookingStatus)) { %>
                                <span class="badge <%= paymentBadgeClass %> px-3 py-2">
                                    <%= paymentStatus %>
                                </span>
                            <% } %>
                        </div>
                    </div>

                    <p class="mb-1"><strong>Package Name:</strong> <%= rec.getPackageName() %></p>
                    <p class="mb-1"><strong>Booking Date:</strong> <%= rec.getBookingDate() %></p>
                    <p class="mb-1"><strong>Comments:</strong> <%= rec.getComments() == null || rec.getComments().trim().isEmpty() ? "-" : rec.getComments() %></p>
                    <p class="mb-1"><strong>Option Chosen:</strong> <%= rec.getOptionName() %></p>
                    <p class="mb-3"><strong>Travel Date:</strong> <%= rec.getTravelDate() %></p>

                    <% if ("PENDING".equalsIgnoreCase(bookingStatus)) { %>
                        <div class="alert alert-warning py-2 mb-3">
                            Waiting for admin approval.
                        </div>

                        <form action="<%= request.getContextPath() %>/cancel-booking" method="post" class="d-inline">
                            <input type="hidden" name="bookingId" value="<%= rec.getBookingId() %>">
                            <input type="submit" value="Cancel Booking" class="btn btn-danger btn-sm rounded-3">
                        </form>
                    <% } %>

                    <% if ("REJECTED".equalsIgnoreCase(bookingStatus)) { %>
                        <div class="alert alert-danger py-2 mb-3">
                            Booking was rejected by admin.
                        </div>
                    <% } %>

                    <% if ("CONFIRMED".equalsIgnoreCase(bookingStatus)
                            && "NOT YET PAID".equalsIgnoreCase(paymentStatus)) { %>

                        <form action="<%= request.getContextPath() %>/cancel-booking" method="post" class="d-inline">
                            <input type="hidden" name="bookingId" value="<%= rec.getBookingId() %>">
                            <input type="submit" value="Cancel Booking" class="btn btn-danger btn-sm rounded-3">
                        </form>

                        <a href="<%= request.getContextPath() %>/pay?bookingId=<%= rec.getBookingId() %>"
                           class="btn btn-success btn-sm ms-2 rounded-3">Pay Now</a>

                    <% } %>

                    <% if ("PAID".equalsIgnoreCase(paymentStatus)
                            && !"CANCELLED".equalsIgnoreCase(bookingStatus)
                            && !"REJECTED".equalsIgnoreCase(bookingStatus)) { %>

                        <a href="<%= request.getContextPath() %>/feedback?bookingId=<%= rec.getBookingId() %>"
                           class="btn btn-primary btn-sm rounded-3">Give Feedback</a>

                    <% } %>
                </div>
            </div>
        <%
                }
            } else {
        %>
            <div class="alert alert-info">No bookings found.</div>
        <%
            }
        %>

        <a href="<%= request.getContextPath() %>/packages" class="btn btn-secondary rounded-3">Back to Packages</a>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/footer-page.jsp" />
</body>
</html>