<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.fujitsu.training.codes.model.data.Feedback" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Feedback</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="admin-body">

    <div class="admin-shell">
        <div class="admin-shell-inner">

            <%
                request.setAttribute("activeMenu", "feedback");
            %>
            <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

            <div class="admin-main">
                <div class="admin-content-area">
                    <div class="admin-page-header">
                        <div>
                            <h1 class="admin-page-heading">Update Feedback</h1>
                            <p class="admin-page-subheading mb-0">
                                Review customer feedback and update admin remarks and status.
                            </p>
                        </div>
                    </div>

                    <%
                        Feedback rec = (Feedback) request.getAttribute("feedback");
                    %>

                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger">${error}</div>
                    <% } %>

                    <% if (rec != null) { %>

                        <div class="dashboard-panel modern-panel mb-4">
                            <h5 class="mb-3 fw-bold">Feedback Details</h5>

                            <div class="row g-3">
                                <div class="col-md-6">
                                    <p class="mb-2"><strong>Feedback ID:</strong> <%= rec.getFeedbackId() %></p>
                                    <p class="mb-2"><strong>Booking ID:</strong> <%= rec.getBookingId() == null ? "-" : rec.getBookingId() %></p>
                                    <p class="mb-2"><strong>Package Name:</strong> <%= rec.getPackageName() == null ? "-" : rec.getPackageName() %></p>
                                </div>

                                <div class="col-md-6">
                                    <p class="mb-2"><strong>User Email:</strong> <%= rec.getEmail() == null ? "-" : rec.getEmail() %></p>
                                    <p class="mb-2"><strong>Message:</strong> <%= rec.getMessage() == null ? "-" : rec.getMessage() %></p>
                                    <p class="mb-0"><strong>Rating:</strong> <%= rec.getRating() %></p>
                                </div>
                            </div>
                        </div>

                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="dashboard-panel modern-panel">
                                    <form action="<%= request.getContextPath() %>/admin/feedback/edit" method="post">
                                        <input type="hidden" name="feedbackId" value="<%= rec.getFeedbackId() %>">

                                        <div class="mb-3">
                                            <label class="form-label">Admin Remarks</label>
                                            <textarea name="adminRemarks" rows="5" class="form-control admin-form-control admin-form-textarea" required><%= rec.getAdminRemarks() == null ? "" : rec.getAdminRemarks() %></textarea>
                                        </div>

                                        <div class="mb-4">
                                            <label class="form-label">Status</label>
                                            <select name="status" class="form-select admin-form-control" required>
                                                <option value="">-- Select Status --</option>
                                                <option value="OPEN" <%= "OPEN".equalsIgnoreCase(rec.getStatus()) ? "selected" : "" %>>OPEN</option>
                                                <option value="RESOLVED" <%= "RESOLVED".equalsIgnoreCase(rec.getStatus()) ? "selected" : "" %>>RESOLVED</option>
                                            </select>
                                        </div>

                                        <div class="d-flex gap-2 flex-wrap">
                                            <button type="submit" class="btn btn-primary admin-submit-btn">Save Update</button>
                                            <a href="<%= request.getContextPath() %>/admin/feedback" class="btn btn-secondary admin-back-btn">Back to Admin Feedback</a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                    <% } else { %>

                        <div class="alert alert-warning">Feedback record not found.</div>
                        <a href="<%= request.getContextPath() %>/admin/feedback" class="btn btn-secondary admin-back-btn">Back to Admin Feedback</a>

                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>