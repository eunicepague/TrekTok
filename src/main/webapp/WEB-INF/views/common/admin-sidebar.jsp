<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- MOBILE SIDEBAR TOGGLE -->
<div class="admin-mobile-toggle d-xl-none">
    <button class="btn admin-mobile-menu-btn"
            type="button"
            data-bs-toggle="offcanvas"
            data-bs-target="#adminSidebarMobile"
            aria-controls="adminSidebarMobile">
        Menu
    </button>
</div>

<!-- DESKTOP SIDEBAR -->
<div class="admin-sidebar d-none d-xl-flex">
    <div>
        <div class="admin-brand-wrap">
            <div class="admin-logo-circle">T</div>
            <div>
                <h3 class="admin-brand-title mb-0">TrekTok</h3>
                <small class="admin-brand-subtitle">Admin Panel</small>
            </div>
        </div>

        <div class="admin-sidebar-section">
            <div class="admin-sidebar-label">Menu</div>

            <a href="${pageContext.request.contextPath}/admin"
               class="admin-sidebar-link ${activeMenu == 'dashboard' ? 'active' : ''}">
                <span>Dashboard</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/users"
               class="admin-sidebar-link ${activeMenu == 'users' ? 'active' : ''}">
                <span>Users</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/bookings"
               class="admin-sidebar-link ${activeMenu == 'bookings' ? 'active' : ''}">
                <span>Bookings</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/payments"
               class="admin-sidebar-link ${activeMenu == 'payments' ? 'active' : ''}">
                <span>Payments</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/feedback"
               class="admin-sidebar-link ${activeMenu == 'feedback' ? 'active' : ''}">
                <span>Feedback</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/packages"
               class="admin-sidebar-link ${activeMenu == 'packages' ? 'active' : ''}">
                <span>Packages</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/package-options"
               class="admin-sidebar-link ${activeMenu == 'package-options' ? 'active' : ''}">
                <span>Package Options</span>
            </a>
<!--  
            <a href="${pageContext.request.contextPath}/admin/nearby-places"
               class="admin-sidebar-link ${activeMenu == 'nearby-places' ? 'active' : ''}">
                <span>Nearby Places</span>
            </a>
-->
        </div>
    </div>

    <div class="admin-sidebar-bottom">
        <a href="${pageContext.request.contextPath}/logout" class="admin-sidebar-link logout-link">
            <span>Logout</span>
        </a>
    </div>
</div>

<!-- MOBILE OFFCANVAS SIDEBAR -->
<div class="offcanvas offcanvas-start admin-offcanvas-sidebar d-xl-none"
     tabindex="-1"
     id="adminSidebarMobile"
     aria-labelledby="adminSidebarMobileLabel">
    
    <div class="offcanvas-header admin-offcanvas-header">
        <div class="admin-brand-wrap mb-0 border-0 pb-0">
            <div class="admin-logo-circle">T</div>
            <div>
                <h3 class="admin-brand-title mb-0" id="adminSidebarMobileLabel">TrekTok</h3>
                <small class="admin-brand-subtitle">Admin Panel</small>
            </div>
        </div>

        <button type="button"
                class="btn-close"
                data-bs-dismiss="offcanvas"
                aria-label="Close"></button>
    </div>

    <div class="offcanvas-body d-flex flex-column justify-content-between">
        <div class="admin-sidebar-section">
            <div class="admin-sidebar-label">Menu</div>

            <a href="${pageContext.request.contextPath}/admin"
               class="admin-sidebar-link ${activeMenu == 'dashboard' ? 'active' : ''}">
                <span>Dashboard</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/users"
               class="admin-sidebar-link ${activeMenu == 'users' ? 'active' : ''}">
                <span>Users</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/bookings"
               class="admin-sidebar-link ${activeMenu == 'bookings' ? 'active' : ''}">
                <span>Bookings</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/payments"
               class="admin-sidebar-link ${activeMenu == 'payments' ? 'active' : ''}">
                <span>Payments</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/feedback"
               class="admin-sidebar-link ${activeMenu == 'feedback' ? 'active' : ''}">
                <span>Feedback</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/packages"
               class="admin-sidebar-link ${activeMenu == 'packages' ? 'active' : ''}">
                <span>Packages</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/package-options"
               class="admin-sidebar-link ${activeMenu == 'package-options' ? 'active' : ''}">
                <span>Package Options</span>
            </a>

<!-- 
            <a href="${pageContext.request.contextPath}/admin/nearby-places"
               class="admin-sidebar-link ${activeMenu == 'nearby-places' ? 'active' : ''}">
                <span>Nearby Places</span>
            </a>
-->
        </div>

        <div class="admin-sidebar-bottom mt-4">
            <a href="${pageContext.request.contextPath}/logout" class="admin-sidebar-link logout-link">
                <span>Logout</span>
            </a>
        </div>
    </div>
</div>