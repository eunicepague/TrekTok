<section class="popular-locations-section">
    <div class="container">
        <div class="popular-locations-header">
            <div>
                <small>Traveler's Favourite</small>
                <h2>Explore All Popular Locations</h2>
                <p>
                    Plan, book, and embark on your dream adventure with our expert
                    guidance and tailored experiences.
                </p>
            </div>

            <a href="${pageContext.request.contextPath}/packages" class="popular-view-btn">
                View all destinations <span>-></span>
            </a>
        </div>

        <div class="popular-location-grid">
            <a href="${pageContext.request.contextPath}/book?packageId=2"
               class="popular-location-card popular-location-large">
                <img src="${pageContext.request.contextPath}/resources/images/packages/palawan.jpg"
                     alt="Coron, Palawan">

                <div class="popular-location-overlay"></div>

                <div class="popular-location-content">
                    <span class="popular-location-tag">Featured!</span>
                    <h3>Coron, Palawan</h3>
                    <p>Crystal lagoons, limestone cliffs, and island adventures.</p>
                </div>
            </a>

            <div class="popular-location-side">
                <a href="${pageContext.request.contextPath}/book?packageId=3"
                   class="popular-location-card popular-location-small">
                    <img src="${pageContext.request.contextPath}/resources/images/packages/bohol.jpg"
                         alt="Bohol">

                    <div class="popular-location-overlay"></div>

                    <div class="popular-location-content">
                        <h3>Bohol</h3>
                        <p>Home of the tarsiers and Chocolate Hills.</p>
                    </div>
                </a>

                <a href="${pageContext.request.contextPath}/book?packageId=10"
                   class="popular-location-card popular-location-small">
                    <img src="${pageContext.request.contextPath}/resources/images/packages/boracay.jpg"
                         alt="Boracay">

                    <div class="popular-location-overlay"></div>

                    <div class="popular-location-content">
                        <h3>Boracay</h3>
                        <p>White sand beaches and island sunsets.</p>
                    </div>
                </a>
            </div>
        </div>
    </div>
</section>