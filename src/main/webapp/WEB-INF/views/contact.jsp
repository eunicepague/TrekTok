<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Us</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="bg-light">

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <div class="container py-5">
        <div class="text-center mb-5">
            <h1 class="fw-bold">Contact Us</h1>
            <p class="text-muted mb-0" style="max-width: 620px; margin: 0 auto;">
                Have questions about packages, bookings, or payments? Reach out to TrekTok and we’ll be happy to assist you.
            </p>
        </div>

        <div class="row g-4">
            <div class="col-lg-5">
                <div class="contact-card h-100 p-0 overflow-hidden">
                    <img src="${pageContext.request.contextPath}/resources/images/packages/phone.jpg"
                         alt="Contact TrekTok"
                         class="img-fluid w-100 h-100"
                         style="object-fit: cover; min-height: 100%;">
                </div>
            </div>

            <div class="col-lg-7">
                <div class="contact-card h-100">
                    <h4 class="fw-bold mb-4">Send Us a Message</h4>

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
                                <button type="button" class="btn btn-primary rounded-pill px-4">
                                    Send Message
                                </button>
                            </div>
                        </div>
                    </form>

                    
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/footer-page.jsp" />
</body>
</html>