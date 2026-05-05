<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.fujitsu.training.codes.model.data.Payment" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Payments</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="admin-body">

    <div class="admin-shell">
        <div class="admin-shell-inner">

            <%
                request.setAttribute("activeMenu", "payments");
            %>
            <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

            <div class="admin-main">
                <div class="admin-content-area">
                    <div class="admin-page-header">
                        <div>
                            <h1 class="admin-page-heading">All Payments</h1>
                            <p class="admin-page-subheading mb-0">
                                View all payment records and transaction status.
                            </p>
                        </div>
                    </div>

                    <%
                        List<Payment> records = (List<Payment>) request.getAttribute("payments");
                        Integer currentPage = (Integer) request.getAttribute("currentPage");
                        Integer totalPages = (Integer) request.getAttribute("totalPages");

                        if (records != null && !records.isEmpty()) {
                    %>
                        <div class="dashboard-panel modern-panel">
                            <div class="table-responsive admin-table-wrap">
                                <table class="table align-middle mb-0 admin-modern-table admin-flex-table admin-payments-modern-table">
                                    <thead>
                                        <tr>
                                            <th>Payment ID</th>
                                            <th>Booking ID</th>
                                            <th>Card Name</th>
                                            <th>Card Number</th>
                                            <th>Payment Type</th>
                                            <th>Amount</th>
                                            <th>Payment Date</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            for (Payment rec : records) {
                                                String cardNumber = rec.getCardNumber();
                                                String maskedCard = "****";
                                                if (cardNumber != null && cardNumber.length() >= 4) {
                                                    maskedCard = "**** **** **** " + cardNumber.substring(cardNumber.length() - 4);
                                                }

                                                String status = rec.getStatus();
                                                String badgeClass = "bg-secondary";

                                                if ("PAID".equalsIgnoreCase(status)) {
                                                    badgeClass = "bg-success";
                                                } else if ("PENDING".equalsIgnoreCase(status)) {
                                                    badgeClass = "bg-warning text-dark";
                                                } else if ("FAILED".equalsIgnoreCase(status)) {
                                                    badgeClass = "bg-danger";
                                                }
                                        %>
                                            <tr>
                                                <td><%= rec.getPaymentId() %></td>
                                                <td><%= rec.getBookingId() %></td>
                                                <td class="admin-payments-card-name"><%= rec.getCardName() %></td>
                                                <td><%= maskedCard %></td>
                                                <td><%= rec.getPaymentType() %></td>
                                                <td>₱<%= rec.getAmount() %></td>
                                                <td><%= rec.getPaymentDate() %></td>
                                                <td>
                                                    <span class="badge <%= badgeClass %>">
                                                        <%= status == null ? "UNKNOWN" : status %>
                                                    </span>
                                                </td>
                                            </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>

                            <div class="admin-pagination-modern">
                                <div class="admin-pagination-info">
                                    Page <%= currentPage == null ? 1 : currentPage %> of <%= totalPages == null ? 1 : totalPages %>
                                </div>

                                <div class="d-flex gap-2">
                                    <% if (currentPage != null && currentPage > 1) { %>
                                        <a href="<%= request.getContextPath() %>/admin/payments?page=<%= currentPage - 1 %>"
                                           class="btn btn-outline-success btn-sm admin-pagination-btn">
                                            Previous
                                        </a>
                                    <% } %>

                                    <% if (currentPage != null && totalPages != null && currentPage < totalPages) { %>
                                        <a href="<%= request.getContextPath() %>/admin/payments?page=<%= currentPage + 1 %>"
                                           class="btn btn-outline-success btn-sm admin-pagination-btn">
                                            Next
                                        </a>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    <%
                        } else {
                    %>
                        <div class="dashboard-panel modern-panel">
                            <p class="text-muted mb-0">No payments found.</p>
                        </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>