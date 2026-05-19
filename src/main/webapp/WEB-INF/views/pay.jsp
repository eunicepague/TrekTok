<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.fujitsu.training.codes.model.data.Booking" %>
<%@ page import="org.fujitsu.training.codes.model.form.PaymentForm" %>

<!DOCTYPE html>
<html>
<head>
    <title>Payment</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pay.css?v=2">
</head>

<body class="payment-page">

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <%
        Booking booking = (Booking) request.getAttribute("booking");
        PaymentForm paymentForm = (PaymentForm) request.getAttribute("paymentForm");

        String bookingImagePath = request.getContextPath() + "/resources/images/packages/";
        String bookingImageName = "booking-placeholder.jpg";

        if (booking != null && booking.getImageName() != null && !booking.getImageName().trim().isEmpty()) {
            bookingImageName = booking.getImageName();
        }

        String bookingImageUrl = bookingImagePath + bookingImageName;

        Double amountValue = null;

        if (paymentForm != null && paymentForm.getAmount() != null) {
            amountValue = paymentForm.getAmount();
        } else if (booking != null && booking.getOptionPrice() != null) {
            amountValue = booking.getOptionPrice();
        }
    %>

    <main class="payment-main">
        <section class="payment-section">
            <div class="container">

                <div class="payment-header">
                    <span class="payment-badge">Payment</span>
                    <h1>Complete your booking payment</h1>
                    <p>Review your booking details and securely complete your payment.</p>
                </div>

                <% if (request.getAttribute("error") != null) { %>
                    <div class="payment-alert payment-alert-danger">
                        ${error}
                    </div>
                <% } %>

                <% if (request.getAttribute("message") != null) { %>
                    <div class="payment-alert payment-alert-success">
                        ${message}
                    </div>
                <% } %>

                <div class="payment-layout">

                    <div class="payment-summary-card">
                        <div class="payment-card-title">
                            <div class="payment-title-icon">
                                <img src="${pageContext.request.contextPath}/resources/images/packages/booking-icon.png"
                                     alt="Booking Icon">
                            </div>
                            <h3>Booking Summary</h3>
                        </div>

                        <% if (booking != null) { %>

                            <div class="payment-booking-info">
                                <div class="payment-booking-img">
                                    <img src="<%= bookingImageUrl %>"
                                         alt="<%= booking.getPackageName() == null ? "Booking Image" : booking.getPackageName() %>">
                                </div>

                                <div class="payment-booking-text">
                                    <h4><%= booking.getPackageName() == null ? "Travel Package" : booking.getPackageName() %></h4>
                                    <span>Booking ID: <%= booking.getBookingId() %></span>

                                    <div class="payment-mini-details">
                                        <div>
                                            <small>Travel Date</small>
                                            <p><%= booking.getTravelDate() == null ? "-" : booking.getTravelDate() %></p>
                                        </div>

                                        <div>
                                            <small>Option Chosen</small>
                                            <p><%= booking.getOptionName() == null ? "-" : booking.getOptionName() %></p>
                                        </div>

                                        <div>
                                            <small>Status</small>
                                            <p class="payment-status-text"><%= booking.getStatus() == null ? "-" : booking.getStatus() %></p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="payment-divider"></div>

                            <div class="payment-order-summary">
                                <h4>Order Summary</h4>

                                <div class="payment-row">
                                    <span>Package ID</span>
                                    <strong><%= booking.getPackageId() == null ? "-" : booking.getPackageId() %></strong>
                                </div>

                                <div class="payment-row">
                                    <span>Package Price</span>
                                    <strong>₱ <%= booking.getOptionPrice() == null ? "0.00" : booking.getOptionPrice() %></strong>
                                </div>

                                <div class="payment-total-row">
                                    <span>Total Amount Due</span>
                                    <strong>₱ <%= amountValue == null ? "0.00" : amountValue %></strong>
                                </div>
                            </div>

                            <div class="payment-note">
                                Please complete your payment to confirm your booking.
                                You’ll receive confirmation once payment is successful.
                            </div>

                        <% } else { %>

                            <div class="payment-note">
                                Booking details are not available.
                            </div>

                        <% } %>
                    </div>

                    <form action="<%= request.getContextPath() %>/pay" method="post" class="payment-form-card">
                        <input type="hidden" name="bookingId" value="<%= booking != null ? booking.getBookingId() : "" %>">

                        <div class="payment-form-header">
                            <div class="payment-card-title">
                                <div class="payment-title-icon">
                                    <img src="${pageContext.request.contextPath}/resources/images/packages/lock-icon.png"
                                         alt="Lock Icon">
                                </div>
                                <h3>Payment Details</h3>
                            </div>

                            <span class="secure-payment">Secure Payment</span>
                        </div>

                        <div class="payment-form-body">
                            <div class="payment-field">
                                <label>Cardholder Name</label>
                                <input type="text" name="cardName" class="form-control"
                                       placeholder="Enter name on card"
                                       value="<%= paymentForm != null && paymentForm.getCardName() != null ? paymentForm.getCardName() : "" %>"
                                       required>
                            </div>

                            <div class="payment-field">
                                <label>Card Number</label>
                                <input type="text" name="cardNumber" class="form-control"
                                       placeholder="1234 5678 9012 3456"
                                       pattern="\d{16}" maxlength="16"
                                       value="<%= paymentForm != null && paymentForm.getCardNumber() != null ? paymentForm.getCardNumber() : "" %>"
                                       required>
                            </div>

                            <div class="payment-form-grid">
                                <div class="payment-field">
                                    <label>Payment Type</label>
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

                                <div class="payment-field">
                                    <label>Amount</label>
                                    <input type="number" step="0.01" name="amount" class="form-control payment-amount-input"
                                           value="<%= amountValue != null ? amountValue : "" %>" readonly>
                                </div>
                            </div>

                            <div class="payment-secure-note">
                                Your payment information is encrypted and secure.
                            </div>

                            <div class="payment-actions">
                                <a href="<%= request.getContextPath() %>/mybookings" class="payment-back-btn">
                                    Back to My Bookings
                                </a>

                                <button type="submit" class="payment-submit-btn">
                                    Pay Now
                                </button>
                            </div>
                        </div>
                    </form>

                </div>

            </div>
        </section>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/footer-page.jsp" />

</body>
</html>