<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="org.fujitsu.training.codes.model.data.TourPackage"%>
<%@ page import="org.fujitsu.training.codes.model.data.NearbyPlace"%>
<%@ page import="org.fujitsu.training.codes.model.data.WeatherInfo"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tour Packages</title>
<jsp:include page="/WEB-INF/views/common/head.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/package.css?v=2">
</head>

<body class="package-page">

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <%
    List<TourPackage> records = (List<TourPackage>) request.getAttribute("packages");
    Map<Integer, WeatherInfo> weatherMap = (Map<Integer, WeatherInfo>) request.getAttribute("weatherMap");
    Map<Integer, List<NearbyPlace>> nearbyPlacesMap =
            (Map<Integer, List<NearbyPlace>>) request.getAttribute("nearbyPlacesMap");

    Object selectedTypeObj = request.getAttribute("selectedType");
    String selectedType = selectedTypeObj == null ? null : selectedTypeObj.toString();

    Object keywordObj = request.getAttribute("keyword");
    String keyword = keywordObj == null ? "" : keywordObj.toString();

    int pageSize = 9;
    int currentPage = 1;

    String pageParam = request.getParameter("page");
    if (pageParam != null) {
        try {
            currentPage = Integer.parseInt(pageParam);
        } catch (NumberFormatException e) {
            currentPage = 1;
        }
    }

    int totalRecords = records == null ? 0 : records.size();
    int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

    if (currentPage < 1) {
        currentPage = 1;
    }

    if (totalPages > 0 && currentPage > totalPages) {
        currentPage = totalPages;
    }

    int startIndex = (currentPage - 1) * pageSize;
    int endIndex = Math.min(startIndex + pageSize, totalRecords);

    String pageQuery = "";

    if (keyword != null && !keyword.isBlank()) {
        pageQuery += "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
    }

    if (selectedType != null && !selectedType.isBlank()) {
        pageQuery += "&type=" + URLEncoder.encode(selectedType, "UTF-8");
    }
    %>

    <main class="package-main">

        <section class="package-header-section">
            <div class="container">

                <div class="package-breadcrumb">
                    <a href="${pageContext.request.contextPath}/home">Home</a>
                    <span>›</span>
                    <p>Packages</p>
                </div>

                <div class="package-heading">
                    <h1>Travel Packages</h1>
                    <p>Browse our handpicked packages and find the perfect getaway for your next trip.</p>
                </div>

                <form action="${pageContext.request.contextPath}/packages" method="get" class="package-search-row">
                    <div class="package-search-input">
                        <span>⌕</span>
                        <input type="text" name="keyword"
                            placeholder="Search destination or package..."
                            value="<%=keyword%>">
                    </div>

                    <div class="package-search-input package-date-input">
                        <img src="${pageContext.request.contextPath}/resources/images/packages/calendar-icon.png"
                             alt="Calendar Icon"
                             class="package-search-icon">
                        <input type="text" placeholder="Select dates" disabled>
                    </div>

                    <div class="package-search-input package-guest-input">
                        <img src="${pageContext.request.contextPath}/resources/images/packages/gray-user-icon.png"
                             alt="Guest Icon"
                             class="package-search-icon">
                        <input type="text" placeholder="2 Guests, 1 Room" disabled>
                    </div>

                    <button type="submit" class="package-search-btn">Search</button>
                </form>

                <div class="package-filter-tabs">
                    <a href="${pageContext.request.contextPath}/packages"
                        class="<%= selectedType == null ? "active" : "" %>">
                        <img src="${pageContext.request.contextPath}/resources/images/packages/grid-icon.png"
                             alt="All Icon"
                             class="package-tab-icon">
                        All Packages
                    </a>

                    <a href="${pageContext.request.contextPath}/packages?type=TRAVEL_PACKAGE"
                        class="<%= "TRAVEL_PACKAGE".equals(selectedType) ? "active" : "" %>">
                        <img src="${pageContext.request.contextPath}/resources/images/packages/package-icon.png"
                             alt="Package Icon"
                             class="package-tab-icon">
                        Travel Packages
                    </a>

                    <a href="${pageContext.request.contextPath}/packages?type=HOTEL"
                        class="<%= "HOTEL".equals(selectedType) ? "active" : "" %>">
                        <img src="${pageContext.request.contextPath}/resources/images/packages/hotels-icon.png"
                             alt="Hotel Icon"
                             class="package-tab-icon">
                        Hotels
                    </a>

                    <a href="${pageContext.request.contextPath}/packages?type=DESTINATION"
                        class="<%= "DESTINATION".equals(selectedType) ? "active" : "" %>">
                        <img src="${pageContext.request.contextPath}/resources/images/packages/destinations-icon.png"
                             alt="Destination Icon"
                             class="package-tab-icon">
                        Destinations
                    </a>

                    <a href="${pageContext.request.contextPath}/packages?type=TRANSPORT"
                        class="<%= "TRANSPORT".equals(selectedType) ? "active" : "" %>">
                        <img src="${pageContext.request.contextPath}/resources/images/packages/transport-icon.png"
                             alt="Transport Icon"
                             class="package-tab-icon">
                        Transport
                    </a>
                </div>

            </div>
        </section>

        <section class="popular-destinations-section">
            <div class="container">

                <div class="package-section-title-row">
                    <h2>Popular Destinations</h2>
                    <a href="${pageContext.request.contextPath}/packages">View all destinations →</a>
                </div>

                <div class="destination-strip">
                    <a href="${pageContext.request.contextPath}/packages?keyword=Boracay" class="destination-card">
                        <img src="${pageContext.request.contextPath}/resources/images/packages/boracay.jpg" alt="Boracay">
                        <div>
                            <h5>Boracay</h5>
                            <p>Philippines</p>
                        </div>
                    </a>

                    <a href="${pageContext.request.contextPath}/packages?keyword=Bohol" class="destination-card">
                        <img src="${pageContext.request.contextPath}/resources/images/packages/panglao.jpg" alt="Bohol">
                        <div>
                            <h5>Bohol</h5>
                            <p>Philippines</p>
                        </div>
                    </a>

                    <a href="${pageContext.request.contextPath}/packages?keyword=Palawan" class="destination-card">
                        <img src="${pageContext.request.contextPath}/resources/images/packages/palawan.jpg" alt="Palawan">
                        <div>
                            <h5>Palawan</h5>
                            <p>Philippines</p>
                        </div>
                    </a>

                    <a href="${pageContext.request.contextPath}/packages?keyword=Siargao" class="destination-card">
                        <img src="${pageContext.request.contextPath}/resources/images/packages/siargao.jpg" alt="Siargao">
                        <div>
                            <h5>Siargao</h5>
                            <p>Philippines</p>
                        </div>
                    </a>

                    <a href="${pageContext.request.contextPath}/packages?keyword=Cebu" class="destination-card">
                        <img src="${pageContext.request.contextPath}/resources/images/packages/cebu.jpg" alt="Cebu">
                        <div>
                            <h5>Cebu</h5>
                            <p>Philippines</p>
                        </div>
                    </a>

                    <a href="${pageContext.request.contextPath}/packages?keyword=Batanes" class="destination-card">
                        <img src="${pageContext.request.contextPath}/resources/images/packages/batanes.jpg" alt="Batanes">
                        <div>
                            <h5>Batanes</h5>
                            <p>Philippines</p>
                        </div>
                    </a>
                </div>

            </div>
        </section>

        <section class="featured-packages-section">
            <div class="container">

                <div class="package-section-title-row">
                    <h2>Featured Packages</h2>

                    <div class="package-tools">
                        <button type="button">Sort by ▾</button>
                        <button type="button">Filter ▾</button>
                    </div>
                </div>

                <%
                if (records != null && !records.isEmpty()) {
                %>

                <div class="package-grid">
                    <%
                    for (TourPackage rec : records.subList(startIndex, endIndex)) {
                        String imagePath = request.getContextPath() + "/resources/images/packages/";
                        String imageName = rec.getImageName();

                        String imageUrl = (imageName != null && !imageName.trim().isEmpty())
                                ? imagePath + imageName
                                : "https://via.placeholder.com/600x400?text=No+Image";

                        WeatherInfo weather = weatherMap == null ? null : weatherMap.get(rec.getPackageId());

                        String weatherText = "Weather not available";
                        if (weather != null) {
                            String temp = weather.getTemperature() == null ? "-" : weather.getTemperature().toString();
                            String desc = weather.getWeatherDescription() == null ? "Weather info not available" : weather.getWeatherDescription();
                            weatherText = temp + " °C • " + desc;
                        }

                        String slotsText = rec.getAvailableSlots() == null ? "0" : rec.getAvailableSlots().toString();
                        boolean hasSlots = rec.getAvailableSlots() != null && rec.getAvailableSlots() > 0;
                    %>

                    <div class="package-card">
                        <div class="package-image-wrap">
                            <img src="<%=imageUrl%>" alt="<%=rec.getPackageName()%>">

                            <span class="package-location-pill">
                                <%=rec.getDestination() == null ? "Travel" : rec.getDestination()%>
                            </span>

                            <button type="button" class="package-heart">♡</button>
                        </div>

                        <div class="package-card-body">

                            <div class="package-meta-row">
                                <span>▣ <%=rec.getDuration() == null ? "-" : rec.getDuration()%></span>
                                <span>☁ <%=weatherText%></span>
                            </div>

                            <h3><%=rec.getPackageName()%></h3>

                            <p class="package-desc">
                                <%=rec.getDescription() == null ? "" : rec.getDescription()%>
                            </p>

                            <div class="package-bottom-row">
                                <div>
                                    <span class="package-price-label">From</span>
                                    <strong>₱ <%=rec.getPrice()%></strong>
                                </div>

                                <div class="package-rating">
                                    <span>★ 4.8</span>
                                    <small>(<%=slotsText%>)</small>
                                </div>

                                <a href="<%=request.getContextPath()%>/book?packageId=<%=rec.getPackageId()%>"
                                   class="package-book-btn">
                                    Book Now <span>→</span>
                                </a>
                            </div>

                            <%
                            if (hasSlots) {
                            %>
                                <p class="package-slot available"><%=slotsText%> slots left</p>
                            <%
                            } else {
                            %>
                                <p class="package-slot soldout">Sold out</p>
                            <%
                            }
                            %>

                        </div>
                    </div>

                    <%
                    }
                    %>
                </div>

                <%
                if (totalPages > 1) {
                %>

                <div class="package-pagination">

                    <a class="<%= currentPage == 1 ? "disabled" : "" %>"
                       href="${pageContext.request.contextPath}/packages?page=<%=currentPage - 1%><%=pageQuery%>">
                        ‹ Previous
                    </a>

                    <%
                    for (int i = 1; i <= totalPages; i++) {
                    %>
                        <a class="<%= currentPage == i ? "active" : "" %>"
                           href="${pageContext.request.contextPath}/packages?page=<%=i%><%=pageQuery%>">
                            <%=i%>
                        </a>
                    <%
                    }
                    %>

                    <a class="<%= currentPage == totalPages ? "disabled" : "" %>"
                       href="${pageContext.request.contextPath}/packages?page=<%=currentPage + 1%><%=pageQuery%>">
                        Next ›
                    </a>

                </div>

                <%
                }
                %>

                <%
                } else {
                %>

                <div class="package-empty">
                    No tour packages available.
                </div>

                <%
                }
                %>

            </div>
        </section>

        <section class="package-help-section">
            <div class="container">
                <div class="package-help-card">
                    <div class="package-help-icon">
                        <img src="${pageContext.request.contextPath}/resources/images/packages/package-icon.png"
                             alt="Package Icon">
                    </div>

                    <div>
                        <h3>Can't find what you're looking for?</h3>
                        <p>Let our travel experts plan your perfect trip. Custom itineraries, group packages, and more.</p>
                    </div>

                    <a href="${pageContext.request.contextPath}/contact">
                        Contact Us <span>→</span>
                    </a>
                </div>
            </div>
        </section>

    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/footer-page.jsp" />

</body>
</html>