<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>About Us</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="bg-light">

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <div class="container py-5">
        <div class="text-center mb-5">
            <h1 class="fw-bold">About Us</h1>
            <p class="text-muted mb-0" style="max-width: 700px; margin: 0 auto;">
                TrekTok is a simple tour and travel management system designed to help travelers
                explore destinations, view package options, book trips, make payments, and share feedback
                in one convenient platform.
            </p>
        </div>

        <div class="row g-4 align-items-center mb-5">
            <div class="col-lg-6">
                <img src="${pageContext.request.contextPath}/resources/images/packages/bg.jpg"
                     alt="About TrekTok"
                     class="img-fluid rounded-4 shadow-sm w-100"
                     style="object-fit: cover; max-height: 420px;">
            </div>

            <div class="col-lg-6">
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-4">
                        <h3 class="fw-bold mb-3">Who We Are</h3>
                        <p class="text-muted">
                            TrekTok was created to make travel planning easier and more organized for users
                            who want to discover destinations and book packages with ease.
                        </p>

                        <h3 class="fw-bold mb-3 mt-4">Our Goal</h3>
                        <p class="text-muted">
                            Our goal is to provide a user-friendly system where travelers can search for
                            destinations, explore available packages, choose suitable options, and manage
                            their bookings in a smooth and simple way.
                        </p>

                        <h3 class="fw-bold mb-3 mt-4">What We Offer</h3>
                        <ul class="text-muted mb-0">
                            <li>Destination and package browsing</li>
                            <li>Simple booking process</li>
                            <li>Online payment recording</li>
                            <li>Feedback and review sharing</li>
                            <li>Admin management for records and packages</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/footer-page.jsp" />
</body>
</html>