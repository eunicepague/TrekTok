<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.fujitsu.training.codes.model.data.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Users</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
</head>
<body class="admin-body">

    <div class="admin-shell">
        <div class="admin-shell-inner">

            <%
                request.setAttribute("activeMenu", "users");
            %>
            <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

            <div class="admin-main">
                <div class="admin-content-area">
                    <div class="admin-page-header">
                        <div>
                            <h1 class="admin-page-heading">All Users</h1>
                            <p class="admin-page-subheading mb-0">
                                View and manage registered users, roles, and account status.
                            </p>
                        </div>
                    </div>

                    <%
                        List<User> records = (List<User>) request.getAttribute("users");
                        User sessionUser = (User) request.getAttribute("sessionUser");
                        boolean isSuperAdmin = sessionUser != null && "SUPER_ADMIN".equals(sessionUser.getRole());
                    %>

                    <%
                        if (records != null && !records.isEmpty()) {
                    %>
                        <div class="dashboard-panel modern-panel">
                            <div class="table-responsive admin-table-wrap">
                                <table class="table align-middle mb-0 admin-modern-table admin-users-modern-table">
                                    <thead>
                                        <tr>
                                            <th>User ID</th>
                                            <th>First Name</th>
                                            <th>Last Name</th>
                                            <th>Email</th>
                                            <th>Contact No</th>
                                            <th>Verified</th>
                                            <th>Role</th>
                                            <th>Account Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            for (User rec : records) {
                                                String role = rec.getRole();
                                                String roleBadgeClass = "bg-secondary";

                                                if ("SUPER_ADMIN".equals(role)) {
                                                    roleBadgeClass = "bg-dark";
                                                } else if ("ADMIN".equals(role)) {
                                                    roleBadgeClass = "bg-primary";
                                                } else if ("CUSTOMER".equals(role)) {
                                                    roleBadgeClass = "bg-info text-dark";
                                                }

                                                String accountStatus = rec.getAccountStatus();
                                                String statusBadgeClass = "bg-secondary";

                                                if ("ACTIVE".equals(accountStatus)) {
                                                    statusBadgeClass = "bg-success";
                                                } else if ("INACTIVE".equals(accountStatus)) {
                                                    statusBadgeClass = "bg-danger";
                                                }
                                        %>
                                            <tr>
                                                <td><%= rec.getUserId() %></td>
                                                <td><%= rec.getFirstName() %></td>
                                                <td><%= rec.getLastName() %></td>
                                                <td class="admin-users-email"><%= rec.getEmail() %></td>
                                                <td><%= rec.getContactNo() %></td>
                                                <td>
                                                    <span class="badge bg-success">
                                                        <%= Boolean.TRUE.equals(rec.getIsVerified()) ? "Verified" : "Not Verified" %>
                                                    </span>
                                                </td>
                                                <td>
                                                    <span class="badge <%= roleBadgeClass %>"><%= role %></span>
                                                </td>
                                                <td>
                                                    <span class="badge <%= statusBadgeClass %>"><%= accountStatus %></span>
                                                </td>
                                                <td class="admin-users-actions">
                                                    <% if (isSuperAdmin && !sessionUser.getUserId().equals(rec.getUserId()) && !"SUPER_ADMIN".equals(rec.getRole())) { %>

                                                        <form action="<%= request.getContextPath() %>/admin/users/role" method="post" class="admin-users-action-form">
                                                            <input type="hidden" name="userId" value="<%= rec.getUserId() %>">

                                                            <% if ("CUSTOMER".equals(rec.getRole())) { %>
                                                                <input type="hidden" name="role" value="ADMIN">
                                                                <input type="submit" value="Promote" class="btn btn-primary btn-sm admin-users-action-btn">
                                                            <% } else if ("ADMIN".equals(rec.getRole())) { %>
                                                                <input type="hidden" name="role" value="CUSTOMER">
                                                                <input type="submit" value="Demote" class="btn btn-warning btn-sm admin-users-action-btn">
                                                            <% } %>
                                                        </form>

                                                        <form action="<%= request.getContextPath() %>/admin/users/status" method="post" class="admin-users-action-form">
                                                            <input type="hidden" name="userId" value="<%= rec.getUserId() %>">

                                                            <% if ("ACTIVE".equals(rec.getAccountStatus())) { %>
                                                                <input type="hidden" name="accountStatus" value="INACTIVE">
                                                                <input type="submit" value="Deactivate" class="btn btn-danger btn-sm admin-users-action-btn">
                                                            <% } else { %>
                                                                <input type="hidden" name="accountStatus" value="ACTIVE">
                                                                <input type="submit" value="Activate" class="btn btn-success btn-sm admin-users-action-btn">
                                                            <% } %>
                                                        </form>

                                                    <% } else { %>
                                                        <span class="text-muted">No actions available</span>
                                                    <% } %>
                                                </td>
                                            </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    <%
                        } else {
                    %>
                        <div class="dashboard-panel modern-panel">
                            <p class="text-muted mb-0">No users found.</p>
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