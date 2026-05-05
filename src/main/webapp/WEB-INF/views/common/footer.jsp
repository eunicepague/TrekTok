<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const dealsSwiper = document.querySelector(".dealsSwiper");

    if (dealsSwiper) {
        new Swiper(".dealsSwiper", {
            slidesPerView: 1.2,
            spaceBetween: 16,
            grabCursor: true,
            pagination: {
                el: ".swiper-pagination",
                clickable: true
            },
            breakpoints: {
                576: {
                    slidesPerView: 1.5
                },
                768: {
                    slidesPerView: 2.2
                },
                992: {
                    slidesPerView: 3
                }
            }
        });
    }
});
</script>