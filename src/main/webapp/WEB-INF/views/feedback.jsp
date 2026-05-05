<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.fujitsu.training.codes.model.data.Booking" %>
<!DOCTYPE html>
<html>
<head>
    <title>Feedback</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <div class="container mt-4">
        <h2 class="mb-4">Feedback Form</h2>

        <%
            Booking booking = (Booking) request.getAttribute("booking");
            Integer bookingId = (Integer) request.getAttribute("bookingId");
        %>

        <% if (booking != null) { %>
            <div class="card mb-4 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Booking Details</h5>
                    <p class="mb-1"><strong>Booking ID:</strong> <%= booking.getBookingId() %></p>
                    <p class="mb-1"><strong>Package Name:</strong> <%= booking.getPackageName() %></p>
                    <p class="mb-1"><strong>Option Chosen:</strong> <%= booking.getOptionName() %></p>
                    <p class="mb-1"><strong>Travel Date:</strong> <%= booking.getTravelDate() %></p>
                    <p class="mb-0"><strong>Payment Status:</strong> <%= booking.getPaymentStatus() %></p>
                </div>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/feedback" method="post" class="card shadow-sm">
            <div class="card-body">
                <input type="hidden" name="bookingId" value="<%= bookingId != null ? bookingId : "" %>">

                <div class="mb-3">
				    <label class="form-label"><strong>Your Feedback</strong></label>
				    <textarea name="message" class="form-control" rows="4" required>${feedbackForm.message}</textarea>
				</div>

                <div class="mb-3">
                    <label class="form-label"><strong>Rating</strong></label>
                    <select name="rating" class="form-select">
                        <option value="1" ${feedbackForm.rating == 1 ? 'selected' : ''}>1</option>
                        <option value="2" ${feedbackForm.rating == 2 ? 'selected' : ''}>2</option>
                        <option value="3" ${feedbackForm.rating == 3 ? 'selected' : ''}>3</option>
                        <option value="4" ${feedbackForm.rating == 4 ? 'selected' : ''}>4</option>
                        <option value="5" ${feedbackForm.rating == 5 ? 'selected' : ''}>5</option>
                    </select>
                </div>

                <% if (request.getAttribute("message") != null) { %>
                    <div class="alert alert-success">${message}</div>
                <% } %>

                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger">${error}</div>
                <% } %>

                <div class="d-flex gap-2">
                    <input type="submit" value="Submit Feedback" class="btn btn-primary">
                    <a href="${pageContext.request.contextPath}/mybookings" class="btn btn-secondary">Back to My Bookings</a>
                </div>
            </div>
        </form>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/footer-page.jsp" />
</body>
</html>