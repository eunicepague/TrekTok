<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.fujitsu.training.codes.model.data.TourPackage"%>
<%@ page import="org.fujitsu.training.codes.model.data.NearbyPlace"%>
<%@ page import="org.fujitsu.training.codes.model.data.WeatherInfo"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tour Packages</title>
<jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="bg-light">

	<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

	<section class="py-5">
		<div class="container">
			<div class="text-center mb-4">
				<span
					class="badge rounded-pill text-bg-primary-subtle text-primary px-3 py-2 mb-3">
					Explore Destinations </span>
				<h2 class="fw-bold mb-2">Find Your Next Adventure</h2>
				<p class="text-muted mx-auto" style="max-width: 650px;">Browse
					our featured travel packages and choose the perfect getaway for
					your next trip.</p>
			</div>

			<div class="row justify-content-center mb-4">
				<div class="col-lg-8">
					<form action="${pageContext.request.contextPath}/packages"
						method="get" class="d-flex gap-2 flex-column flex-md-row">
						<input type="text" name="keyword"
							class="form-control form-control-lg rounded-4"
							placeholder="Search destination or package..."
							value="<%=request.getAttribute("keyword") == null ? "" : request.getAttribute("keyword")%>">
						<button type="submit"
							class="btn btn-primary btn-lg rounded-4 px-4">Search</button>
					</form>
				</div>
			</div>

			<div class="d-flex justify-content-center flex-wrap gap-2 mb-4">
				<a href="${pageContext.request.contextPath}/packages"
					class="btn <%= request.getAttribute("selectedType") == null ? "btn-primary" : "btn-light border" %> rounded-pill px-4">
					All </a> <a
					href="${pageContext.request.contextPath}/packages?type=TRAVEL_PACKAGE"
					class="btn <%= "TRAVEL_PACKAGE".equals(request.getAttribute("selectedType")) ? "btn-primary" : "btn-light border" %> rounded-pill px-4">
					Travel Packages </a> <a
					href="${pageContext.request.contextPath}/packages?type=HOTEL"
					class="btn <%= "HOTEL".equals(request.getAttribute("selectedType")) ? "btn-primary" : "btn-light border" %> rounded-pill px-4">
					Hotels </a> <a
					href="${pageContext.request.contextPath}/packages?type=DESTINATION"
					class="btn <%= "DESTINATION".equals(request.getAttribute("selectedType")) ? "btn-primary" : "btn-light border" %> rounded-pill px-4">
					Destinations </a> <a
					href="${pageContext.request.contextPath}/packages?type=TRANSPORT"
					class="btn <%= "TRANSPORT".equals(request.getAttribute("selectedType")) ? "btn-primary" : "btn-light border" %> rounded-pill px-4">
					Transport </a>
			</div>

			<%
			List<TourPackage> records = (List<TourPackage>) request.getAttribute("packages");
			Map<Integer, WeatherInfo> weatherMap = (Map<Integer, WeatherInfo>) request.getAttribute("weatherMap");
			Map<Integer, List<NearbyPlace>> nearbyPlacesMap = (Map<Integer, List<NearbyPlace>>) request
					.getAttribute("nearbyPlacesMap");

			if (records != null && !records.isEmpty()) {
			%>
			<div class="row g-4">
				<%
				for (TourPackage rec : records) {
					String imagePath = request.getContextPath() + "/resources/images/packages/";
					String imageName = rec.getImageName();
					String imageUrl = (imageName != null && !imageName.trim().isEmpty()) ? imagePath + imageName
					: "https://via.placeholder.com/600x400?text=No+Image";

					String mapUrl = null;
					if (rec.getLatitude() != null && rec.getLongitude() != null) {
						mapUrl = "https://www.google.com/maps?q=" + rec.getLatitude() + "," + rec.getLongitude();
					}

					WeatherInfo weather = weatherMap == null ? null : weatherMap.get(rec.getPackageId());
					List<NearbyPlace> nearbyPlaces = nearbyPlacesMap == null ? null : nearbyPlacesMap.get(rec.getPackageId());
				%>
				<div class="col-md-6 col-xl-4">
					<div class="card border-0 shadow-sm rounded-4 package-card-min">
						<img src="<%=imageUrl%>" class="card-img-top package-card-img"
							alt="<%=rec.getPackageName()%>">

						<div
							class="card-body p-4 d-flex flex-column justify-content-between">
							<div class="mb-2">
								<span
									class="badge text-bg-light border text-secondary rounded-pill px-3 py-2">
									<%=rec.getDestination()%>
								</span>
							</div>

							<p class="card-title fw-bold mb-2"><%=rec.getPackageName()%></p>

							<p
								class="card-text text-muted small package-card-desc text-truncate">
								<%=rec.getDescription()%>
							</p>

							<div class="mb-3">
								<div class="small text-muted mb-1">Live Weather</div>
								<%
								if (weather != null) {
								%>
								<div class="fw-medium">
									<%=weather.getTemperature() == null ? "-" : weather.getTemperature()%>
									°C •
									<%=weather.getWeatherDescription() == null ? "Weather info not available" : weather.getWeatherDescription()%>
								</div>
								<%
								} else {
								%>
								<div class="fw-medium">Weather info not available</div>
								<%
								}
								%>
							</div>



							<div class="d-flex justify-content-between border-top pt-3 mt-2">
								<div>
									<div class="text-muted small">Duration</div>
									<div class="fw-semibold">
										<%=rec.getDuration() == null ? "-" : rec.getDuration()%>
									</div>
								</div>

								<div class="text-end">
									<div class="text-muted small">Price</div>
									<div class="fw-bold text-primary">
										₱
										<%=rec.getPrice()%>
									</div>
								</div>
							</div>

							<div class="mt-3">
								<%
								if (rec.getAvailableSlots() != null && rec.getAvailableSlots() > 0) {
								%>
								<span
									class="badge rounded-pill text-bg-success-subtle text-success">
									<%=rec.getAvailableSlots()%> slots available
								</span>
								<%
								} else {
								%>
								<span
									class="badge rounded-pill text-bg-danger-subtle text-danger py-2">
									Sold Out </span>
								<%
								}
								%>
							</div>

							<div class="mt-4 d-grid gap-2">
								<a
									href="<%=request.getContextPath()%>/book?packageId=<%=rec.getPackageId()%>"
									class="btn btn-primary rounded-4 py-2"> Book Now </a>

								
							</div>
						</div>
					</div>
				</div>
				<%
				}
				%>
			</div>
			<%
			} else {
			%>
			<div class="alert alert-info text-center mt-4">No tour packages
				available.</div>
			<%
			}
			%>
		</div>
	</section>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<jsp:include page="/WEB-INF/views/common/footer-page.jsp" />
</body>
</html>