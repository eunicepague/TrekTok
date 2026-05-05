<div class="container-fluid d-flex align-items-center hero-bg hero-search-section"
     style="min-height: calc(100vh - 88px);
            background: linear-gradient(rgba(0, 0, 0, 0.42), rgba(0, 0, 0, 0.42)),
            url('${pageContext.request.contextPath}/resources/images/packages/background.gif') center/cover no-repeat;">

    <div class="container">
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
</div>