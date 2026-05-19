<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.fujitsu.training.codes.model.data.Booking" %>

<!DOCTYPE html>
<html>
<head>
    <title>Feedback</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/feedback.css?v=2">
</head>

<body class="feedback-page">

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <%
        Booking booking = (Booking) request.getAttribute("booking");
        Integer bookingId = (Integer) request.getAttribute("bookingId");

        String bookingImagePath = request.getContextPath() + "/resources/images/packages/";
        String bookingImageName = "booking-placeholder.jpg";

        if (booking != null && booking.getImageName() != null && !booking.getImageName().trim().isEmpty()) {
            bookingImageName = booking.getImageName();
        }

        String bookingImageUrl = bookingImagePath + bookingImageName;

        String packageName = booking != null && booking.getPackageName() != null ? booking.getPackageName() : "Travel Package";
        String optionName = booking != null && booking.getOptionName() != null ? booking.getOptionName() : "-";
        String travelDate = booking != null && booking.getTravelDate() != null ? booking.getTravelDate().toString() : "-";
        String paymentStatus = booking != null && booking.getPaymentStatus() != null ? booking.getPaymentStatus() : "-";
        Integer finalBookingId = booking != null && booking.getBookingId() != null ? booking.getBookingId() : bookingId;
    %>

    <main class="feedback-main">
        <section class="feedback-section">
            <div class="container">

                <div class="feedback-header">
                    <span class="feedback-badge">Feedback</span>

                    <h1>Share your travel experience</h1>

                    <p>
                        We’d love to hear about your trip. Your feedback helps us improve
                        and helps other travelers make the right choice.
                    </p>
                </div>

                <% if (request.getAttribute("message") != null) { %>
                    <div class="feedback-alert feedback-alert-success">
                        ${message}
                    </div>
                <% } %>

                <% if (request.getAttribute("error") != null) { %>
                    <div class="feedback-alert feedback-alert-danger">
                        ${error}
                    </div>
                <% } %>

                <div class="feedback-layout">

                    <div class="feedback-summary-card">
                        <div class="feedback-card-title">
                            <div class="feedback-title-icon">
                                <img src="${pageContext.request.contextPath}/resources/images/packages/calendar-icon.png"
                                     alt="Booking Icon">
                            </div>

                            <h3>Booking Summary</h3>
                        </div>

                        <% if (booking != null) { %>

                            <div class="feedback-booking-top">
                                <div class="feedback-booking-img">
                                    <img src="<%= bookingImageUrl %>"
                                         alt="<%= packageName %>">
                                </div>

                                <div class="feedback-booking-name">
                                    <h4><%= packageName %></h4>
                                    <span><%= paymentStatus %></span>
                                </div>
                            </div>

                            <div class="feedback-info-list">

                                <div class="feedback-info-row">
                                    <span>Booking ID</span>
                                    <strong><%= finalBookingId != null ? finalBookingId : "-" %></strong>
                                </div>

                                <div class="feedback-info-row">
                                    <span>Travel Date</span>
                                    <strong><%= travelDate %></strong>
                                </div>

                                <div class="feedback-info-row">
                                    <span>Option Chosen</span>
                                    <strong><%= optionName %></strong>
                                </div>

                                <div class="feedback-info-row">
                                    <span>Payment Status</span>
                                    <strong class="feedback-paid-status"><%= paymentStatus %></strong>
                                </div>

                            </div>

                        <% } else { %>

                            <div class="feedback-note">
                                Booking details are not available.
                            </div>

                        <% } %>
                    </div>

                    <form action="${pageContext.request.contextPath}/feedback" method="post" class="feedback-form-card">
                        <input type="hidden" name="bookingId" value="<%= finalBookingId != null ? finalBookingId : "" %>">

                        <div class="feedback-form-heading">
                            <div class="feedback-title-icon">
                                <img src="${pageContext.request.contextPath}/resources/images/packages/star-icon.png"
                                     alt="Rating Icon">
                            </div>

                            <div>
                                <h3>Rate your trip</h3>
                                <p>How would you rate your overall experience?</p>
                            </div>
                        </div>

                        <div class="feedback-stars">
                            <span>★</span>
                            <span>★</span>
                            <span>★</span>
                            <span>★</span>
                            <span class="empty-star">★</span>
                        </div>

                        <div class="feedback-field">
                            <label>Your Feedback</label>

                            <textarea name="message"
                                      class="form-control"
                                      rows="5"
                                      maxlength="1000"
                                      placeholder="Share the highlights, what you loved, or how we can improve..."
                                      required>${feedbackForm.message}</textarea>

                            <small>Tell us more about your experience.</small>
                        </div>

                        <div class="feedback-bottom-grid">
                            <div class="feedback-field">
                                <label>Overall Rating</label>

                                <select name="rating" class="form-select">
                                    <option value="1" ${feedbackForm.rating == 1 ? 'selected' : ''}>1 - Poor</option>
                                    <option value="2" ${feedbackForm.rating == 2 ? 'selected' : ''}>2 - Fair</option>
                                    <option value="3" ${feedbackForm.rating == 3 ? 'selected' : ''}>3 - Good</option>
                                    <option value="4" ${feedbackForm.rating == 4 ? 'selected' : ''}>4 - Very Good</option>
                                    <option value="5" ${feedbackForm.rating == 5 ? 'selected' : ''}>5 - Excellent</option>
                                </select>
                            </div>

                            <div class="feedback-reactions">
                                <label>Quick Reactions</label>

                                <div class="reaction-list">
                                    <span>Great service</span>
                                    <span>Clean place</span>
                                    <span>Worth it</span>
                                    <span>Friendly staff</span>
                                </div>
                            </div>
                        </div>

                        <div class="feedback-actions">
                            <button type="submit" class="feedback-submit-btn">
                                Submit Feedback
                            </button>

                            <a href="${pageContext.request.contextPath}/mybookings" class="feedback-back-btn">
                                Back to My Bookings
                            </a>
                        </div>
                    </form>

                </div>

                <div class="feedback-help-card">
                    <div class="feedback-help-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/packages/heart-icon.png"
                             alt="Heart Icon">
                    </div>

                    <div>
                        <h3>Your feedback makes a difference</h3>
                        <p>
                            Your review helps other travelers make informed decisions and helps us continue
                            delivering unforgettable travel experiences.
                        </p>
                    </div>
                </div>

            </div>
        </section>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/footer-page.jsp" />

</body>
</html>