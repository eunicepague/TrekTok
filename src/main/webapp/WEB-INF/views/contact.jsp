<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Us</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/contact.css?v=2">
</head>

<body class="contact-page">

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <main class="contact-main">
        <section class="contact-section">
            <div class="container">

                <div class="contact-layout">

                    <div class="contact-left">
                        <span class="contact-badge">Contact Us</span>

                        <h1>Let’s plan your<br>next trip together</h1>

                        <p class="contact-subtitle">
                            Have questions about packages, bookings, or payments?
                            Reach out to TrekTok and we’ll be happy to assist you
                            in planning a seamless travel experience.
                        </p>

                        <div class="contact-left-bottom">
                            <div class="contact-info-list">

                                <div class="contact-info-card">
                                    <div class="contact-info-icon">
                                        <img src="${pageContext.request.contextPath}/resources/images/packages/phone-icon.png"
                                             alt="Phone Icon">
                                    </div>
                                    <div>
                                        <h5>Phone</h5>
                                        <p>0917 123 4567</p>
                                        <small>Mon - Fri, 9:00 AM - 6:00 PM</small>
                                    </div>
                                </div>

                                <div class="contact-info-card">
                                    <div class="contact-info-icon">
                                        <img src="${pageContext.request.contextPath}/resources/images/packages/email-icon.png"
                                             alt="Email Icon">
                                    </div>
                                    <div>
                                        <h5>Email</h5>
                                        <p>support@trektok.com</p>
                                        <small>We’ll get back to you ASAP</small>
                                    </div>
                                </div>

                                <div class="contact-info-card">
                                    <div class="contact-info-icon">
                                        <img src="${pageContext.request.contextPath}/resources/images/packages/location-icon.png"
                                             alt="Location Icon">
                                    </div>
                                    <div>
                                        <h5>Office</h5>
                                        <p>TrekTok Travel Solutions</p>
                                        <small>Makati City, Philippines</small>
                                    </div>
                                </div>

                            </div>

                            <div class="contact-luggage-wrap">
                                <img src="${pageContext.request.contextPath}/resources/images/packages/contact-luggage.png"
                                     alt="Travel Luggage"
                                     class="contact-luggage-img">
                            </div>
                        </div>
                    </div>

                    <div class="contact-form-card">
                        <h3>Send Us a Message</h3>

                        <form>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">First Name</label>
                                    <input type="text" class="form-control" placeholder="Enter your first name">
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Last Name</label>
                                    <input type="text" class="form-control" placeholder="Enter your last name">
                                </div>

                                <div class="col-12">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" placeholder="Enter your email">
                                </div>

                                <div class="col-12">
                                    <label class="form-label">Subject</label>
                                    <input type="text" class="form-control" placeholder="Enter subject">
                                </div>

                                <div class="col-12">
                                    <label class="form-label">Message</label>
                                    <textarea class="form-control" rows="5" placeholder="Write your message here"></textarea>
                                </div>

                                <div class="col-12">
                                    <button type="button" class="contact-submit-btn">
                                        Send Message
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>

                </div>

                <div class="contact-support-row">

                    <div class="contact-support-item">
                        <div class="contact-support-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/support-icon.png"
                                 alt="Support Icon">
                        </div>
                        <div>
                            <h5>Fast Response</h5>
                            <p>We reply within 24 hours so you can keep your travel plans on track.</p>
                        </div>
                    </div>

                    <div class="contact-support-item">
                        <div class="contact-support-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/like-icon.png"
                                 alt="Like Icon">
                        </div>
                        <div>
                            <h5>Travel Help</h5>
                            <p>From itinerary questions to special requests, we’re here to help.</p>
                        </div>
                    </div>

                    <div class="contact-support-item">
                        <div class="contact-support-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/shield-icon.png"
                                 alt="Trusted Icon">
                        </div>
                        <div>
                            <h5>Trusted Support</h5>
                            <p>Your satisfaction and safety are our top priorities.</p>
                        </div>
                    </div>

                </div>

            </div>
        </section>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/footer-page.jsp" />

</body>
</html>