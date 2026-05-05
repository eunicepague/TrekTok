<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="bg-light">

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <jsp:include page="/WEB-INF/views/homepage/hero-section.jsp" />
    <jsp:include page="/WEB-INF/views/homepage/why-choose-trektok.jsp" />
    <!-- 
    <jsp:include page="/WEB-INF/views/homepage/how-booking-works.jsp" />
    <jsp:include page="/WEB-INF/views/homepage/transport-services.jsp" />
     -->
    <jsp:include page="/WEB-INF/views/homepage/popular-locations.jsp" />
	<jsp:include page="/WEB-INF/views/homepage/feedback-marquee.jsp" />
	<jsp:include page="/WEB-INF/views/homepage/last-minute-deals.jsp" />
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<jsp:include page="/WEB-INF/views/homepage/summer-special-trips.jsp" />
	<jsp:include page="/WEB-INF/views/homepage/hotel-deals.jsp" />
	<jsp:include page="/WEB-INF/views/homepage/travel-gallery.jsp" />
	<jsp:include page="/WEB-INF/views/common/footer-page.jsp" />
</body>
</html>