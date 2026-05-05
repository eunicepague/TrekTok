<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.fujitsu.training.codes.model.data.TourPackage" %>
<%@ page import="java.util.List" %>
<%@ page import="org.fujitsu.training.codes.model.data.PackageOption" %>
<%@ page import="org.fujitsu.training.codes.model.data.NearbyPlace" %>
<%@ page import="org.fujitsu.training.codes.model.data.WeatherInfo" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Package</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
</head>
<body class="bg-light">

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <div class="container py-4 book-page-modern">
        <%
            TourPackage rec = (TourPackage) request.getAttribute("rec");
            List<PackageOption> options = (List<PackageOption>) request.getAttribute("options");
            List<NearbyPlace> nearbyPlaces = (List<NearbyPlace>) request.getAttribute("nearbyPlaces");
            WeatherInfo currentWeather = (WeatherInfo) request.getAttribute("currentWeather");
        %>

        <% if (rec != null) {
            String imagePath = request.getContextPath() + "/resources/images/packages/";
            String imageName = rec.getImageName();
            String imageUrl = (imageName != null && !imageName.trim().isEmpty())
                    ? imagePath + imageName
                    : "https://via.placeholder.com/1200x500?text=No+Image";
        %>

        <h2 class="fw-bold mb-4">Book Package</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger rounded-4 mb-4">${error}</div>
        <% } %>

        <!-- HERO -->
        <div class="book-hero-card mb-4">
            <div class="book-hero-image-wrap">
                <img src="<%= imageUrl %>" alt="<%= rec.getPackageName() %>" class="book-hero-image">
            </div>

            <div class="book-hero-bottom">
                <div class="book-hero-info">
                    <h1 class="book-hero-title"><%= rec.getPackageName() %></h1>
                    <p class="book-hero-desc">
                        <%= rec.getDescription() == null ? "No description available." : rec.getDescription() %>
                    </p>
                </div>

                <div class="book-hero-side">
                    <div class="book-location-pill">
                        <span class="book-location-dot"></span>
                        <span><%= rec.getDestination() == null ? "Destination" : rec.getDestination() %></span>
                    </div>
                    <div class="book-price-pill">₱ <%= rec.getPrice() %></div>
                </div>
            </div>
        </div>

        <form action="<%= request.getContextPath() %>/book" method="post">
            <input type="hidden" name="packageId" value="<%= rec.getPackageId() %>">
				
				
			  <!-- TRAVEL DATE -->
            <div class="mb-4">
                <h4 class="book-subtitle mb-3">Select Your Travel Date</h4>
                <div class="book-card book-date-card">
                    <input type="text"
                           id="travelDate"
                           name="travelDate"
                           class="form-control travel-date-modern"
                           placeholder="Select your travel date"
                           required>
                </div>
            </div>
            	
            <!-- WEATHER + MAP -->
            <div class="row g-4 mb-4 align-items-stretch">
                <div class="col-lg-4">
                    <div class="book-card weather-card-modern h-100">
                        <h3 class="book-section-heading mt-5">Live Weather</h4>

                        <% if (currentWeather != null) { %>
                            <div class="weather-modern-content">
                                <div class="weather-modern-left">
                                    <p><strong>Temperature:</strong> <%= currentWeather.getTemperature() == null ? "-" : currentWeather.getTemperature() %> °C</p>
                                    <p><strong>Condition:</strong> <%= currentWeather.getWeatherDescription() == null ? "-" : currentWeather.getWeatherDescription() %></p>
                                    <p><strong>Wind Speed:</strong> <%= currentWeather.getWindSpeed() == null ? "-" : currentWeather.getWindSpeed() %> km/h</p>
                                    <p class="mb-0"><strong>Daytime:</strong> <%= currentWeather.getIsDay() != null && currentWeather.getIsDay() == 1 ? "Yes" : "No" %></p>
                                </div>
                                <div class="weather-modern-icon">
                                    ☀
                                </div>
                            </div>
                        <% } else { %>
                            <p class="text-muted mb-0">Live weather is not available right now.</p>
                        <% } %>

                    </div>
                </div>

                <div class="col-lg-8">
                    <% if (rec.getLatitude() != null && rec.getLongitude() != null) { %>
                        <div class="book-card map-card-modern h-100">
                            <div class="book-map-wrap-small">
                                <iframe
                                    src="https://www.google.com/maps?q=<%= rec.getLatitude() %>,<%= rec.getLongitude() %>&output=embed"
                                    style="border:0;"
                                    allowfullscreen=""
                                    loading="lazy">
                                </iframe>
                            </div>
                        </div>
                    <% } else { %>
                        <div class="book-card h-100 d-flex align-items-center justify-content-center text-muted">
                            Map is not available.
                        </div>
                    <% } %>
                </div>
            </div>

          

            <!-- PACKAGE OPTIONS -->
            <div class="mb-4">
                <h4 class="book-subtitle mb-3">Select Package Option</h4>

                <% if (options != null && !options.isEmpty()) { %>
                    <div class="row g-4">
                        <%
                            for (PackageOption opt : options) {
                                boolean available = opt.getAvailableSlots() != null && opt.getAvailableSlots() > 0;
                        %>
                            <div class="col-12 col-md-6">
                                <% if (available) { %>
                                    <label class="d-block h-100 mb-0">
                                        <input class="package-option-input"
                                               type="radio"
                                               name="optionId"
                                               value="<%= opt.getOptionId() %>"
                                               required>

                                        <div class="book-option-card h-100">
                                            <div class="book-option-top">
                                                <div>
                                                    <h5 class="book-option-title"><%= opt.getOptionName() %></h5>
                                                    <div class="book-option-meta">
                                                        Good for up to <%= opt.getMaxPax() %> traveler<%= opt.getMaxPax() != null && opt.getMaxPax() > 1 ? "s" : "" %>
                                                    </div>
                                                </div>
                                                <div class="book-option-price">₱ <%= opt.getPrice() %></div>
                                            </div>

                                            <p class="book-option-description">
                                                <%= opt.getDescription() == null ? "No description available." : opt.getDescription() %>
                                            </p>

                                            <div class="book-option-bottom">
                                                <span class="book-badge-soft">Max Pax: <%= opt.getMaxPax() %></span>
                                                <span class="book-badge-green"><%= opt.getAvailableSlots() %> slots available</span>
                                            </div>
                                        </div>
                                    </label>
                                <% } else { %>
                                    <div class="book-option-card book-option-card-disabled h-100">
                                        <div class="book-option-top">
                                            <div>
                                                <h5 class="book-option-title"><%= opt.getOptionName() %></h5>
                                                <div class="book-option-meta">
                                                    Good for up to <%= opt.getMaxPax() %> traveler<%= opt.getMaxPax() != null && opt.getMaxPax() > 1 ? "s" : "" %>
                                                </div>
                                            </div>
                                            <div class="book-option-price">₱ <%= opt.getPrice() %></div>
                                        </div>

                                        <p class="book-option-description">
                                            <%= opt.getDescription() == null ? "No description available." : opt.getDescription() %>
                                        </p>

                                        <div class="book-option-bottom">
                                            <span class="book-badge-soft">Max Pax: <%= opt.getMaxPax() %></span>
                                            <span class="book-badge-red">Sold Out</span>
                                        </div>
                                    </div>
                                <% } %>
                            </div>
                        <% } %>
                    </div>
                <% } else { %>
                    <div class="alert alert-danger rounded-4">No package options available.</div>
                <% } %>
            </div>

            <!-- NEARBY PLACES -->
            <div class="mb-4">
                <div class="book-card">
                    <h4 class="book-section-heading">Nearby Places</h4>

                    <% if (nearbyPlaces != null && !nearbyPlaces.isEmpty()) { %>
                        <div class="row g-3">
                            <% for (NearbyPlace place : nearbyPlaces) { %>
                                <div class="col-12 col-md-6">
                                    <div class="nearby-place-card">
                                        <h6 class="fw-bold mb-1"><%= place.getPlaceName() %></h6>
                                        <div class="text-muted mb-1"><%= place.getCategory() == null ? "-" : place.getCategory() %></div>
                                        <div class="mb-1"><%= place.getAddress() == null ? "-" : place.getAddress() %></div>
                                        <div class="mb-2">Distance: <%= place.getDistanceKm() == null ? "-" : place.getDistanceKm() %> km</div>

                                        <% if (place.getMapLink() != null && !place.getMapLink().trim().isEmpty()) { %>
                                            <a href="<%= place.getMapLink() %>" target="_blank" class="btn btn-outline-primary btn-sm rounded-pill px-3">
                                                View on Map
                                            </a>
                                        <% } %>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    <% } else { %>
                        <p class="text-muted mb-0">No nearby places available.</p>
                    <% } %>
                </div>
            </div>

            <!-- COMMENTS -->
            <div class="mb-4">
                <div class="book-card">
                    <label class="form-label fw-semibold mb-2">Comments</label>
                    <textarea name="comments"
                              class="form-control book-comments-input"
                              rows="4"
                              placeholder="Enter comments (optional)"></textarea>
                </div>
            </div>

            <!-- ACTIONS -->
            <div class="book-action-wrap mb-4">
                <input type="submit" value="Confirm Booking" class="btn book-btn-primary">
                <a href="<%= request.getContextPath() %>/packages" class="btn book-btn-secondary">Back to Packages</a>
            </div>
        </form>

        <% } else { %>
            <div class="alert alert-danger rounded-4">Package details not found.</div>
            <a href="<%= request.getContextPath() %>/packages" class="btn btn-secondary rounded-4">Back to Packages</a>
        <% } %>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/footer-page.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script>
        flatpickr("#travelDate", {
            dateFormat: "Y-m-d",
            minDate: "today",
            disableMobile: true
        });
    </script>
</body>
</html>