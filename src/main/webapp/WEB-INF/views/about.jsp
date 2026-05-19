<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>About Us</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/about.css?v=3">
</head>

<body class="about-page">

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <main class="about-main">

        <section class="about-hero-section">
            <div class="container">

                <div class="about-hero-grid">

                    <div class="about-hero-content">
                        <span class="about-badge">About Us</span>

                        <h1>
                            We make travel planning <span>simple.</span>
                        </h1>

                        <p>
                            TrekTok is a modern tour and travel platform built to help travelers
                            explore the Philippines with ease. From discovering destinations to booking
                            the perfect trip, everything you need is in one place.
                        </p>

                        <div class="about-actions">
                            <a href="${pageContext.request.contextPath}/packages" class="about-primary-btn">
                                Explore Packages
                            </a>

                            <a href="#about-details" class="about-text-btn">
                                Learn more about us <span>→</span>
                            </a>
                        </div>
                    </div>

                    <div class="about-hero-image-wrap">
                        <img src="${pageContext.request.contextPath}/resources/images/packages/bg.jpg"
                             alt="About TrekTok"
                             class="about-hero-image">

                        <div class="about-floating-card">
                            <div class="about-floating-icon">
                                <img src="${pageContext.request.contextPath}/resources/images/packages/image-icon.png"
                                     alt="Explore Icon">
                            </div>

                            <div>
                                <h6>Explore the country</h6>
                                <p>One trip at a time</p>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </section>

        <section class="about-details-section" id="about-details">
            <div class="container">

                <div class="about-info-grid">

                    <div class="about-info-card">
                        <div class="about-card-icon blue-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/who-icon.png"
                                 alt="Who We Are Icon">
                        </div>

                        <h4>Who We Are</h4>

                        <p>
                            TrekTok was created to make travel planning easier and more organized
                            for users who want to discover destinations and book packages with confidence.
                        </p>
                    </div>

                    <div class="about-info-card">
                        <div class="about-card-icon green-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/mission-icon.png"
                                 alt="Mission Icon">
                        </div>

                        <h4>Our Mission</h4>

                        <p>
                            Our mission is to simplify travel planning by providing a reliable,
                            user-friendly platform that connects travelers with the best destinations
                            and experiences.
                        </p>
                    </div>

                    <div class="about-info-card">
                        <div class="about-card-icon purple-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/goal-icon.png"
                                 alt="Goal Icon">
                        </div>

                        <h4>Our Goal</h4>

                        <p>
                            Our goal is to provide a seamless experience where travelers can search,
                            compare, and book packages that match their preferences quickly and affordably.
                        </p>
                    </div>

                    <div class="about-info-card">
                        <div class="about-card-icon yellow-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/gift-icon.png"
                                 alt="Gift Icon">
                        </div>

                        <h4>What We Offer</h4>

                        <ul class="about-offer-list">
                            <li>Destination and package browsing</li>
                            <li>Simple booking process</li>
                            <li>Secure payment options</li>
                            <li>Feedback and review sharing</li>
                            <li>24/7 customer support</li>
                        </ul>
                    </div>

                </div>

                <div class="about-stats-panel">

                    <div class="about-stat-item">
                        <div class="about-stat-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/users-icon.png"
                                 alt="Travelers Icon">
                        </div>
                        <div>
                            <h3>15K+</h3>
                            <p>Happy Travelers</p>
                        </div>
                    </div>

                    <div class="about-stat-item">
                        <div class="about-stat-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/package-icon.png"
                                 alt="Package Icon">
                        </div>
                        <div>
                            <h3>850+</h3>
                            <p>Travel Packages</p>
                        </div>
                    </div>

                    <div class="about-stat-item">
                        <div class="about-stat-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/sched-icon.png"
                                 alt="Sched Icon">
                        </div>
                        <div>
                            <h3>8K+</h3>
                            <p>Successful Bookings</p>
                        </div>
                    </div>

                    <div class="about-stat-item">
                        <div class="about-stat-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/rating-icon.png"
                                 alt="Rating Icon">
                        </div>
                        <div>
                            <h3>4.8/5</h3>
                            <p>Average Rating</p>
                        </div>
                    </div>

                </div>

            </div>
        </section>

        <section class="about-trust-section">
            <div class="container">

                <div class="about-section-heading text-center">
                    <span>Why travelers choose TrekTok</span>
                    <h2>Travel better with confidence</h2>
                </div>

                <div class="about-trust-grid">

                    <div class="about-trust-item">
                        <div class="about-trust-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/shield-icon.png"
                                 alt="Trusted Icon">
                        </div>
                        <div>
                            <h5>Trusted & Secure</h5>
                            <p>
                                Your safety and data security are our top priority.
                                Book with peace of mind every time.
                            </p>
                        </div>
                    </div>

                    <div class="about-trust-item">
                        <div class="about-trust-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/support-icon.png"
                                 alt="Support Icon">
                        </div>
                        <div>
                            <h5>Support That Cares</h5>
                            <p>
                                Our support team is always here to help you before,
                                during, and after your trip.
                            </p>
                        </div>
                    </div>

                    <div class="about-trust-item">
                        <div class="about-trust-icon">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/like-icon.png"
                                 alt="Curated Icon">
                        </div>
                        <div>
                            <h5>Curated Experiences</h5>
                            <p>
                                We pick the best destinations and partners to deliver
                                unforgettable travel experiences.
                            </p>
                        </div>
                    </div>

                </div>

            </div>
        </section>

        <section class="about-cta-section">
            <div class="container">

                <div class="about-cta-card">
                    <div class="about-cta-content">
                        <h2>Ready to explore the Philippines?</h2>
                        <p>
                            Find the perfect package or reach out to our team.
                            Your next adventure starts here.
                        </p>

                        <div class="about-cta-actions">
                            <a href="${pageContext.request.contextPath}/packages" class="about-primary-btn">
                                Explore Packages
                            </a>

                            <a href="${pageContext.request.contextPath}/contact" class="about-outline-btn">
                                Contact Us <span>→</span>
                            </a>
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