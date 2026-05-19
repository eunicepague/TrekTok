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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/book.css">
</head>

<body class="book-body">

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <%
        TourPackage rec = (TourPackage) request.getAttribute("rec");
        List<PackageOption> options = (List<PackageOption>) request.getAttribute("options");
        List<NearbyPlace> nearbyPlaces = (List<NearbyPlace>) request.getAttribute("nearbyPlaces");
        WeatherInfo currentWeather = (WeatherInfo) request.getAttribute("currentWeather");
    %>

    <main class="book-shell">
        <% if (rec != null) {
            String imagePath = request.getContextPath() + "/resources/images/packages/";
            String imageName = rec.getImageName();
            String imageUrl = (imageName != null && !imageName.trim().isEmpty())
                    ? imagePath + imageName
                    : "https://via.placeholder.com/1200x650?text=No+Image";

            String packageName = rec.getPackageName() == null ? "Selected Package" : rec.getPackageName();
            String destination = rec.getDestination() == null ? "Destination" : rec.getDestination();
            String description = rec.getDescription() == null ? "No description available." : rec.getDescription();
            String packagePrice = rec.getPrice() == null ? "0.00" : rec.getPrice().toString();
        %>

        <div class="book-breadcrumbs">
            <a href="<%= request.getContextPath() %>/">Home</a>
            <span>›</span>
            <a href="<%= request.getContextPath() %>/packages">Packages</a>
            <span>›</span>
            <span><%= packageName %></span>
            <span>›</span>
            <strong>Book</strong>
        </div>

        <div class="book-title-row">
            <div>
                <h1>Book Package</h1>
                <p>Fill in the details below to secure your next TrekTok adventure.</p>
            </div>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger rounded-4 mb-4">${error}</div>
        <% } %>

        <form action="<%= request.getContextPath() %>/book" method="post" id="bookForm">
            <input type="hidden" name="packageId" value="<%= rec.getPackageId() %>">

            <div class="book-layout">
                <section class="book-main">

                    <!-- PACKAGE HERO -->
                    <div class="book-card book-package-card">
                        <div class="package-image-wrap">
                            <img src="<%= imageUrl %>" alt="<%= packageName %>">
                            <span class="package-photo-badge">Heritage & Culture</span>
                        </div>

                        <div class="package-info">
                            <h2><%= packageName %></h2>
                            <p><%= description %></p>

                            <div class="package-meta-row">
                                <span class="meta-pill">
                                    <span class="meta-icon">📍</span>
                                    <%= destination %>
                                </span>
                                <span class="meta-pill">
                                    <span class="meta-icon">🕒</span>
                                    3 Days • 2 Nights
                                </span>
                            </div>

                            <div class="package-price-row">
                                <strong>₱ <%= packagePrice %></strong>
                                <span>/ package</span>
                                <small>All-in Package</small>
                            </div>
                        </div>
                    </div>

                    <!-- TRAVEL DATE -->
                    <div class="book-step-card">
                        <div class="step-number">1</div>
                        <div class="step-content">
                            <div class="step-header">
                                <div>
                                    <h3>Select Travel Date.</h3>
                                    <p>Choose your preferred start date.</p>
                                </div>
                                <div class="date-field-wrap">
                                    <span>📅</span>
                                    <input type="text"
                                           id="travelDate"
                                           name="travelDate"
                                           class="travel-date-input"
                                           placeholder="Select your travel date"
                                           required>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- PACKAGE OPTIONS -->
                    <div class="book-step-card">
                        <div class="step-number">2</div>
                        <div class="step-content">
                            <h3>Package Options</h3>
                            <p class="step-subtext">Select an option that suits your group.</p>

                            <% if (options != null && !options.isEmpty()) { %>
                                <div class="option-grid">
                                    <%
                                        int optIndex = 0;
                                        for (PackageOption opt : options) {
                                            boolean available = opt.getAvailableSlots() != null && opt.getAvailableSlots() > 0;
                                            String optName = opt.getOptionName() == null ? "Package Option" : opt.getOptionName();
                                            String optDesc = opt.getDescription() == null ? "No description available." : opt.getDescription();
                                            String optPrice = opt.getPrice() == null ? "0.00" : opt.getPrice().toString();
                                            String optMaxPax = opt.getMaxPax() == null ? "0" : opt.getMaxPax().toString();
                                            String optSlots = opt.getAvailableSlots() == null ? "0" : opt.getAvailableSlots().toString();

                                            String icon = "👤";
                                            if (optName.toLowerCase().contains("couple")) {
                                                icon = "👥";
                                            } else if (optName.toLowerCase().contains("family")) {
                                                icon = "👨‍👩‍👧";
                                            } else if (optName.toLowerCase().contains("barkada") || optName.toLowerCase().contains("group")) {
                                                icon = "👨‍👩‍👧‍👦";
                                            }
                                    %>
                                        <% if (available) { %>
                                            <label class="option-label">
                                                <input class="package-option-input"
                                                       type="radio"
                                                       name="optionId"
                                                       value="<%= opt.getOptionId() %>"
                                                       data-name="<%= optName %>"
                                                       data-price="<%= optPrice %>"
                                                       data-pax="<%= optMaxPax %>"
                                                       <%= optIndex == 0 ? "checked" : "" %>
                                                       required>

                                                <span class="option-card">
                                                    <span class="option-check">✓</span>
                                                    <span class="option-icon"><%= icon %></span>
                                                    <strong><%= optName %></strong>
                                                    <span class="option-price">₱ <%= optPrice %> <small>/ <%= optMaxPax %> pax</small></span>
                                                    <span class="option-desc"><%= optDesc %></span>

                                                    <span class="option-divider"></span>

                                                    <span class="option-footer">
                                                        <span>Max <%= optMaxPax %> pax</span>
                                                        <span class="slots-good">Slots left: <%= optSlots %></span>
                                                    </span>
                                                </span>
                                            </label>
                                        <% } else { %>
                                            <div class="option-card option-card-disabled">
                                                <span class="option-icon"><%= icon %></span>
                                                <strong><%= optName %></strong>
                                                <span class="option-price">₱ <%= optPrice %> <small>/ <%= optMaxPax %> pax</small></span>
                                                <span class="option-desc"><%= optDesc %></span>

                                                <span class="option-divider"></span>

                                                <span class="option-footer">
                                                    <span>Max <%= optMaxPax %> pax</span>
                                                    <span class="slots-sold">Sold out</span>
                                                </span>
                                            </div>
                                        <% } %>
                                    <%
                                            if (available) {
                                                optIndex++;
                                            }
                                        }
                                    %>
                                </div>
                            <% } else { %>
                                <div class="alert alert-danger rounded-4 mb-0">No package options available.</div>
                            <% } %>
                        </div>
                    </div>

                    <!-- WEATHER -->
                    <div class="book-step-card">
                        <div class="step-number">3</div>
                        <div class="step-content">
                            <div class="weather-heading-row">
                                <div>
                                    <h3>Live Weather in <%= destination %></h3>
                                    <p class="step-subtext">Quick weather check before booking.</p>
                                </div>
                                <a href="#tripMap" class="forecast-link">View map →</a>
                            </div>

                            <% if (currentWeather != null) { %>
                                <div class="weather-row">
                                    <div class="weather-current">
                                        <div class="weather-icon">☀️</div>
                                        <div>
                                            <strong>
                                                <%= currentWeather.getTemperature() == null ? "-" : currentWeather.getTemperature() %>°C
                                            </strong>
                                            <span><%= currentWeather.getWeatherDescription() == null ? "-" : currentWeather.getWeatherDescription() %></span>
                                            <small>Wind: <%= currentWeather.getWindSpeed() == null ? "-" : currentWeather.getWindSpeed() %> km/h</small>
                                        </div>
                                    </div>

                                    <div class="weather-mini">
                                        <span>Daytime</span>
                                        <strong><%= currentWeather.getIsDay() != null && currentWeather.getIsDay() == 1 ? "Yes" : "No" %></strong>
                                    </div>

                                    <div class="weather-mini">
                                        <span>Condition</span>
                                        <strong><%= currentWeather.getWeatherDescription() == null ? "-" : currentWeather.getWeatherDescription() %></strong>
                                    </div>
                                </div>
                            <% } else { %>
                                <p class="text-muted mb-0">Live weather is not available right now.</p>
                            <% } %>
                        </div>
                    </div>

                    <!-- NEARBY PLACES -->
                    <div class="book-step-card">
                        <div class="step-number">4</div>
                        <div class="step-content">
                            <h3>Nearby Places You'll Love</h3>

                            <% if (nearbyPlaces != null && !nearbyPlaces.isEmpty()) { %>
                                <div class="nearby-grid">
                                    <% for (NearbyPlace place : nearbyPlaces) { %>
                                        <div class="nearby-card">
                                            <div class="nearby-thumb">📍</div>
                                            <div>
                                                <h4><%= place.getPlaceName() %></h4>
                                                <p><%= place.getCategory() == null ? "-" : place.getCategory() %></p>
                                                <small>Distance: <%= place.getDistanceKm() == null ? "-" : place.getDistanceKm() %> km</small>

                                                <% if (place.getMapLink() != null && !place.getMapLink().trim().isEmpty()) { %>
                                                    <a href="<%= place.getMapLink() %>" target="_blank">View Map</a>
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
                    <div class="book-step-card">
                        <div class="step-number">5</div>
                        <div class="step-content">
                            <h3>Comments / Special Requests <span>Optional</span></h3>
                            <p class="step-subtext">Tell us about your preferences or any special requests.</p>

                            <textarea name="comments"
                                      class="book-comments-input"
                                      rows="4"
                                      maxlength="300"
                                      placeholder="E.g., vegetarian meal, senior citizen, surprise celebration, etc."></textarea>
                        </div>
                    </div>

                    <!-- ACTIONS -->
                    <div class="book-step-card book-final-card">
                        <div class="step-number">6</div>
                        <div class="step-content">
                            <div>
                                <h3>Ready to book your trip?</h3>
                                <p class="step-subtext">Review your details on the right and confirm your booking.</p>
                            </div>

                            <div class="book-actions">
                                <a href="<%= request.getContextPath() %>/packages" class="book-btn book-btn-light">Back to Packages</a>
                                <button type="submit" class="book-btn book-btn-primary">Confirm Booking →</button>
                            </div>

                            <div class="secure-note">🔒 Your booking is secure and encrypted.</div>
                        </div>
                    </div>
                </section>

                <aside class="book-sidebar">

                    <!-- MAP -->
                    <div class="book-card sidebar-card" id="tripMap">
                        <h3>Trip Map</h3>

                        <% if (rec.getLatitude() != null && rec.getLongitude() != null) { %>
                            <div class="sidebar-map">
                                <iframe
                                    src="https://www.google.com/maps?q=<%= rec.getLatitude() %>,<%= rec.getLongitude() %>&output=embed"
                                    style="border:0;"
                                    allowfullscreen=""
                                    loading="lazy">
                                </iframe>
                            </div>
                        <% } else { %>
                            <div class="map-empty">Map is not available.</div>
                        <% } %>
                    </div>

                    <!-- SUMMARY -->
                    <div class="book-card sidebar-card summary-card">
                        <h3>Booking Summary</h3>

                        <div class="summary-package">
                            <img src="<%= imageUrl %>" alt="<%= packageName %>">
                            <div>
                                <strong><%= packageName %></strong>
                                <span>3 Days • 2 Nights</span>
                                <small>📍 <%= destination %></small>
                            </div>
                        </div>

                        <div class="summary-line">
                            <span>Selected Option</span>
                            <strong id="summaryOption">-</strong>
                        </div>

                        <div class="summary-subline">
                            <span></span>
                            <small id="summaryPax">Select option</small>
                        </div>

                        <div class="summary-line">
                            <span>Travel Date</span>
                            <strong id="summaryDate">Select date</strong>
                        </div>

                        <div class="summary-line">
                            <span>Package Price</span>
                            <strong id="summaryPrice">₱ <%= packagePrice %></strong>
                        </div>

                        <div class="summary-line">
                            <span>Service Fee</span>
                            <strong>₱ 250.00</strong>
                        </div>

                        <div class="summary-line">
                            <span>Taxes & Fees</span>
                            <strong>₱ 250.00</strong>
                        </div>

                        <div class="summary-total">
                            <span>Estimated Total</span>
                            <strong id="summaryTotal">₱ 0.00</strong>
                        </div>

                        <button type="submit" form="bookForm" class="book-btn book-btn-primary summary-btn">Confirm Booking</button>
                        <p class="summary-secure">🔒 Secure checkout</p>
                    </div>

                    <!-- HELP CARD -->
                    <div class="book-card sidebar-card help-card">
                        <h3>Need help planning your trip?</h3>
                        <p>Our travel experts are here to help you curate the best local experience.</p>

                        <ul>
                            <li>Custom itinerary suggestions</li>
                            <li>Group bookings</li>
                            <li>Special requests</li>
                        </ul>

                        <a href="<%= request.getContextPath() %>/contact" class="book-btn book-btn-outline">Chat with an Expert</a>
                        <small>● We typically reply in a few minutes.</small>
                    </div>
                </aside>
            </div>
        </form>

        <% } else { %>
            <div class="alert alert-danger rounded-4">Package details not found.</div>
            <a href="<%= request.getContextPath() %>/packages" class="btn btn-secondary rounded-4">Back to Packages</a>
        <% } %>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/footer-page.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script>
        const moneyFormat = new Intl.NumberFormat("en-PH", {
            style: "currency",
            currency: "PHP"
        });

        function parseAmount(value) {
            const cleaned = String(value || "0").replace(/[^0-9.]/g, "");
            const amount = parseFloat(cleaned);
            return isNaN(amount) ? 0 : amount;
        }

        function updateSummary() {
            const selected = document.querySelector(".package-option-input:checked");
            const dateInput = document.querySelector("#travelDate");

            const optionName = selected ? selected.dataset.name : "-";
            const optionPrice = selected ? parseAmount(selected.dataset.price) : 0;
            const optionPax = selected ? selected.dataset.pax : "0";
            const travelDate = dateInput && dateInput.value ? dateInput.value : "Select date";
            const serviceFee = 250;
            const taxes = 250;
            const total = optionPrice + serviceFee + taxes;

            document.querySelector("#summaryOption").textContent = optionName;
            document.querySelector("#summaryPax").textContent = selected ? "Max " + optionPax + " pax" : "Select option";
            document.querySelector("#summaryDate").textContent = travelDate;
            document.querySelector("#summaryPrice").textContent = moneyFormat.format(optionPrice);
            document.querySelector("#summaryTotal").textContent = moneyFormat.format(total);
        }

        flatpickr("#travelDate", {
            dateFormat: "Y-m-d",
            minDate: "today",
            disableMobile: true,
            onChange: updateSummary
        });

        document.querySelectorAll(".package-option-input").forEach(function(input) {
            input.addEventListener("change", updateSummary);
        });

        updateSummary();
    </script>
</body>
</html>