
<div
    class="container-fluid d-flex align-items-center hero-bg hero-search-section"
    style="min-height: 100vh;
           background-image:
               linear-gradient(rgba(0, 0, 0, 0.30), rgba(0, 0, 0, 0.45)),
               url('${pageContext.request.contextPath}/resources/images/packages/car1.png');
           background-size: cover;
           background-position: 100%;
           background-repeat: no-repeat;
           background-attachment: fixed;">">
           

	<div class="container hero-page">
		<div id="hero-badge">
			<img
				src="${pageContext.request.contextPath}/resources/images/packages/airplane.png"
				alt="Plane" class="hero-badge-img"> <span>Explore the
				Philippines with TrekTok</span>
		</div>

		<p id="hero-page-title">
			Find your next <br> unforgettable trip.
		</p>
		<p id="hero-page-subtitle">
			Discover curated travel packages, check weather updates, <br>
			and book your next destination with ease.
		</p>
		<div class="col-lg-6 col-xl-6">
			<form action="${pageContext.request.contextPath}/packages"
				method="get">
				<div class="hero-search-bar">
					<span class="hero-search-icon">&#128269;</span> <input type="text"
						name="keyword" class="hero-search-input"
						placeholder="Search destination or package">
					<button type="submit" class="hero-search-btn hero-search-btn-thin">Search</button>
				</div>
			</form>
		</div>

		<!-- DETAILS  -->

		<div
			class="hero-stats-row d-flex align-items-center gap-4 mt-4 text-white">
			<div class="hero-stat-item d-flex align-items-center gap-3">
				<div class="hero-stat-icon"></div>
				<div>
					<h5 class="mb-0">20+</h5>
					<p class="mb-0 fw-semibold">Packages</p>
					<small>Handpicked for you</small>
				</div>
			</div>

			<div class="hero-stat-divider"></div>

			<div class="hero-stat-item d-flex align-items-center gap-3">
				<div class="hero-stat-icon"></div>
				<div>
					<h5 class="mb-0">Easy</h5>
					<p class="mb-0 fw-semibold">Booking</p>
					<small>Fast &amp; secure</small>
				</div>
			</div>

			<div class="hero-stat-divider"></div>

			<div class="hero-stat-item d-flex align-items-center gap-3">
				<div class="hero-stat-icon"></div>
				<div>
					<h5 class="mb-0">Live</h5>
					<p class="mb-0 fw-semibold">Weather</p>
					<small>Real-time updates</small>
				</div>
			</div>
		</div>

		<!-- POPULAR DESTINATIONS -->
		<div class="hero-popular-panel">
			<div class="hero-popular-header">
				<h5>Popular Destinations</h5>
				<a href="${pageContext.request.contextPath}/packages">View all
					packages >></a>
			</div>

			<div class="hero-popular-grid">
				<a href="${pageContext.request.contextPath}/packages?keyword=Bohol"
					class="hero-destination-card"> <img
					src="${pageContext.request.contextPath}/resources/images/packages/bohol.jpg"
					alt="Bohol">
					<div class="hero-destination-overlay"></div>
					<div class="hero-destination-text">
						<h6>Bohol</h6>
						<p>Panglao, Bohol</p>
					</div>
				</a> <a
					href="${pageContext.request.contextPath}/packages?keyword=Palawan"
					class="hero-destination-card"> <img
					src="${pageContext.request.contextPath}/resources/images/packages/palawan.jpg"
					alt="Palawan">
					<div class="hero-destination-overlay"></div>
					<div class="hero-destination-text">
						<h6>Palawan</h6>
						<p>El Nido, Palawan</p>
					</div>
				</a> <a
					href="${pageContext.request.contextPath}/packages?keyword=Sagada"
					class="hero-destination-card"> <img
					src="${pageContext.request.contextPath}/resources/images/packages/sagada.jpg"
					alt="Sagada">
					<div class="hero-destination-overlay"></div>
					<div class="hero-destination-text">
						<h6>Sagada</h6>
						<p>Sagada</p>
					</div>
				</a> <a
					href="${pageContext.request.contextPath}/packages?keyword=Ilocos"
					class="hero-destination-card"> <img
					src="${pageContext.request.contextPath}/resources/images/packages/ilocos.jpg"
					alt="Ilocos">
					<div class="hero-destination-overlay"></div>
					<div class="hero-destination-text">
						<h6>Ilocos</h6>
						<p>Vigan, Ilocos Sur</p>
					</div>
				</a>
			</div>
		</div>

	</div>
</div>


<!-- <div class="container">
        <div class="text-center text-white hero-search-content">
            <h1 class="hero-main-title">Welcome to TrekTok</h1>
            <p class="hero-main-subtitle">
                Discover your next travel destination and find the perfect package for your trip.
            </p>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-8 col-xl-7">
                <form action="${pageContext.request.contextPath}/packages" method="get">
                    <div class="hero-search-bar hero-search-bar-thin">
                        <span class="hero-search-icon">&#128269;</span>
                        <input type="text"
                               name="keyword"
                               class="hero-search-input"
                               placeholder="Search destination or package">
                        <button type="submit" class="hero-search-btn hero-search-btn-thin">Search</button>
                    </div>
                </form>
            </div>
        </div>
    </div> 
 -->

</div>