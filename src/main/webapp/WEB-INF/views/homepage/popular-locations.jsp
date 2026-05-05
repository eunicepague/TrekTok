<div class="container py-5">
    <div class="mb-4">
        <small class="text-uppercase text-muted fw-semibold">Traveler's Favourite</small>
        <h2 class="fw-bold mt-2">Explore All Popular Locations</h2>
        <p class="text-muted mb-0" style="max-width: 500px;">
            Plan, book, and embark on your dream adventure with our expert guidance and tailored experiences.
        </p>
    </div>

    <div class="row g-3">
        <div class="col-md-6">
            <a href="${pageContext.request.contextPath}/book?packageId=2"
               class="text-decoration-none d-block">
                <div class="position-relative rounded-4 overflow-hidden shadow-sm">
                    <img src="${pageContext.request.contextPath}/resources/images/packages/palawan.jpg"
                         class="img-fluid w-100"
                         style="height: 430px; object-fit: cover;"
                         alt="Palawan">
                    <div class="position-absolute bottom-0 start-0 p-4 text-white">
                        <h2 class="fw-bold mb-0">Coron, Palawan</h2>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-6">
            <div class="row g-3">
                <div class="col-12">
                    <a href="${pageContext.request.contextPath}/book?packageId=3"
                       class="text-decoration-none d-block">
                        <div class="position-relative rounded-4 overflow-hidden shadow-sm">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/bohol.jpg"
                                 class="img-fluid w-100"
                                 style="height: 205px; object-fit: cover;"
                                 alt="Bohol">
                            <div class="position-absolute bottom-0 start-0 p-4 text-white">
                                <h2 class="fw-bold mb-0">Bohol</h2>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-12">
                    <a href="${pageContext.request.contextPath}/book?packageId=10"
                       class="text-decoration-none d-block">
                        <div class="position-relative rounded-4 overflow-hidden shadow-sm">
                            <img src="${pageContext.request.contextPath}/resources/images/packages/boracay.jpg"
                                 class="img-fluid w-100"
                                 style="height: 205px; object-fit: cover;"
                                 alt="Boracay">
                            <div class="position-absolute bottom-0 start-0 p-4 text-white">
                                <h2 class="fw-bold mb-0">Boracay</h2>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>