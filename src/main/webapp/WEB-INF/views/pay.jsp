<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.fujitsu.training.codes.model.data.Booking" %>
<%@ page import="org.fujitsu.training.codes.model.form.PaymentForm" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <div class="container mt-4">
        <h2 class="mb-4">Payment Page</h2>

        <%
            Booking booking = (Booking) request.getAttribute("booking");
            PaymentForm paymentForm = (PaymentForm) request.getAttribute("paymentForm");
        %>

        <% if (booking != null) { %>
            <div class="card mb-4 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Booking Details</h5>
                    <p class="mb-1"><strong>Booking ID:</strong> <%= booking.getBookingId() %></p>
                    <p class="mb-1"><strong>Package ID:</strong> <%= booking.getPackageId() %></p>
                    <p class="mb-1"><strong>Status:</strong> <%= booking.getStatus() %></p>
                    <p class="mb-1"><strong>Option Chosen:</strong> <%= booking.getOptionName() %></p>
                    <p class="mb-0"><strong>Option Price:</strong> ₱ <%= booking.getOptionPrice() %></p>
                </div>
            </div>
        <% } %>

        <form action="<%= request.getContextPath() %>/pay" method="post" class="card shadow-sm">
            <div class="card-body">
                <input type="hidden" name="bookingId" value="<%= booking != null ? booking.getBookingId() : "" %>">

                <div class="mb-3">
                    <label class="form-label"><strong>Card Name</strong></label>
                    <input type="text" name="cardName" class="form-control"
                           value="<%= paymentForm != null && paymentForm.getCardName() != null ? paymentForm.getCardName() : "" %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label"><strong>Card Number</strong></label>
                    <input type="text" name="cardNumber" class="form-control"
                           pattern="\d{16}" maxlength="16"
                           value="<%= paymentForm != null && paymentForm.getCardNumber() != null ? paymentForm.getCardNumber() : "" %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label"><strong>Payment Type</strong></label>
                    <select name="paymentType" class="form-select">
                        <option value="CREDIT CARD"
                            <%= paymentForm != null && "CREDIT CARD".equalsIgnoreCase(paymentForm.getPaymentType()) ? "selected" : "" %>>
                            Credit Card
                        </option>
                        <option value="DEBIT CARD"
                            <%= paymentForm != null && "DEBIT CARD".equalsIgnoreCase(paymentForm.getPaymentType()) ? "selected" : "" %>>
                            Debit Card
                        </option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label"><strong>Amount</strong></label>
                    <input type="number" step="0.01" name="amount" class="form-control bg-light text-secondary border-secondary-subtle"
                           value="<%= paymentForm != null && paymentForm.getAmount() != null ? paymentForm.getAmount() : "" %>" readonly>
                </div>

                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger">${error}</div>
                <% } %>

                <% if (request.getAttribute("message") != null) { %>
                    <div class="alert alert-success">${message}</div>
                <% } %>

                <div class="d-flex gap-2">
                    <input type="submit" value="Pay Now" class="btn btn-success">
                    <a href="<%= request.getContextPath() %>/mybookings" class="btn btn-secondary">Back to My Bookings</a>
                </div>
            </div>
        </form>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/footer-page.jsp" />
</body>
</html>