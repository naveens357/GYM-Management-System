<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Dashboard"      scope="request"/>
<c:set var="pageCSS"   value="admin-dashboard" scope="request"/>
<c:set var="activePage" value="dashboard"     scope="request"/>
<%@ include file="/WEB-INF/views/shared/adminHeader.jsp" %>

<!-- Welcome Banner -->
<div class="welcome-banner">
    <div>
        <h2>Welcome back, ${sessionScope.loggedUser.fullName}!</h2>
        <p>Here's what's happening at GymPro today.</p>
    </div>
    <div class="time" id="clockDisplay"></div>
</div>

<!-- Alerts -->
<c:if test="${not empty error}">  <div class="alert alert-danger">${error}</div>  </c:if>
<c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>

<!-- Stat Cards -->
<div class="stats-grid">
    <div class="stat-card">
        <div class="stat-icon">&#x1F465;</div>
        <div class="stat-info">
            <div class="value">${totalMembers}</div>
            <div class="label">Active Members</div>
        </div>
    </div>
    <div class="stat-card green">
        <div class="stat-icon">&#x1F3CB;</div>
        <div class="stat-info">
            <div class="value">${totalTrainers}</div>
            <div class="label">Trainers</div>
        </div>
    </div>
    <div class="stat-card blue">
        <div class="stat-icon">&#x1F4C5;</div>
        <div class="stat-info">
            <div class="value">${totalClasses}</div>
            <div class="label">Upcoming Classes</div>
        </div>
    </div>
    <div class="stat-card orange">
        <div class="stat-icon">&#x1F4B0;</div>
        <div class="stat-info">
            <div class="value revenue-highlight">Rs. <fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/></div>
            <div class="label">Total Revenue</div>
        </div>
    </div>
</div>

<!-- Quick Actions -->
<div class="quick-action-grid">
    <a href="${pageContext.request.contextPath}/admin/users?filter=pending" class="quick-action">
        <div class="qa-icon">&#x23F3;</div>
        <div class="qa-label">Pending Approvals (${pendingUsers.size()})</div>
    </a>
    <a href="${pageContext.request.contextPath}/admin/trainers" class="quick-action">
        <div class="qa-icon">&#x2795;</div><div class="qa-label">Add Trainer</div>
    </a>
    <a href="${pageContext.request.contextPath}/admin/classes" class="quick-action">
        <div class="qa-icon">&#x1F4C5;</div><div class="qa-label">Schedule Class</div>
    </a>
    <a href="${pageContext.request.contextPath}/admin/memberships" class="quick-action">
        <div class="qa-icon">&#x1F4B3;</div><div class="qa-label">Assign Membership</div>
    </a>
</div>

<!-- Pending Registrations -->
<div class="card">
    <div class="card-header">
        <h2>&#x23F3; Pending Member Registrations</h2>
        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary btn-sm">View All Members</a>
    </div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty pendingUsers}">
                <p class="no-data">&#10003; No pending registrations.</p>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr><th>Name</th><th>Email</th><th>Phone</th><th>Registered</th><th>Actions</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${pendingUsers}">
                            <tr class="pending-row">
                                <td><strong>${u.fullName}</strong></td>
                                <td>${u.email}</td>
                                <td>${u.phone}</td>
                                <td><fmt:formatDate value="${u.createdAt}" pattern="dd MMM yyyy"/></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/users" method="post" style="display:inline;">
                                        <input type="hidden" name="userId" value="${u.userId}">
                                        <input type="hidden" name="action" value="approve">
                                        <button type="submit" class="btn btn-success btn-sm">&#10003; Approve</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/admin/users" method="post" style="display:inline;">
                                        <input type="hidden" name="userId" value="${u.userId}">
                                        <input type="hidden" name="action" value="reject">
                                        <button type="submit" class="btn btn-danger btn-sm">&#10007; Reject</button>
                                    </form>
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Upcoming Classes -->
<div class="card">
    <div class="card-header">
        <h2>&#x1F4C5; Upcoming Classes</h2>
        <a href="${pageContext.request.contextPath}/admin/classes" class="btn btn-secondary btn-sm">Manage Classes</a>
    </div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty upcomingClasses}">
                <p class="no-data">No upcoming classes scheduled.</p>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr><th>Class</th><th>Trainer</th><th>Date &amp; Time</th><th>Duration</th><th>Enrolled / Cap</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cls" items="${upcomingClasses}">
                            <tr>
                                <td><strong>${cls.className}</strong></td>
                                <td>${cls.trainerName}</td>
                                <td><fmt:formatDate value="${cls.scheduleDatetime}" pattern="dd MMM yyyy HH:mm"/></td>
                                <td>${cls.durationMinutes} min</td>
                                <td>${cls.enrolledCount} / ${cls.capacity}</td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
function updateClock() {
    var now = new Date();
    document.getElementById('clockDisplay').textContent =
        now.toLocaleTimeString([], {hour:'2-digit',minute:'2-digit'}) + ' | ' +
        now.toLocaleDateString([], {weekday:'short',day:'numeric',month:'short'});
}
updateClock(); setInterval(updateClock, 1000);
</script>

<%@ include file="/WEB-INF/views/shared/adminFooter.jsp" %>
