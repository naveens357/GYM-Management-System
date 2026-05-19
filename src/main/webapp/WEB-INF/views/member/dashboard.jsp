<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle"  value="My Dashboard"    scope="request"/>
<c:set var="pageCSS"    value="member-dashboard" scope="request"/>
<c:set var="activePage" value="dashboard"       scope="request"/>
<%@ include file="/WEB-INF/views/shared/memberHeader.jsp" %>

<div class="page-header">
    <div><h1>Welcome, ${sessionScope.loggedUser.fullName}!</h1>
         <p>Your fitness overview for today.</p></div>
</div>

<c:if test="${not empty error}">  <div class="alert alert-danger">${error}</div>  </c:if>

<!-- Membership Status -->
<c:choose>
    <c:when test="${not empty memberships}">
        <c:set var="latest" value="${memberships[0]}"/>
        <div class="membership-status-card">
            <h3>Current Membership</h3>
            <div class="plan-name">${latest.planName}</div>
            <div class="expiry">
                Valid: <fmt:formatDate value="${latest.startDate}" pattern="dd MMM yyyy"/>
                &nbsp;&rarr;&nbsp;
                <fmt:formatDate value="${latest.endDate}" pattern="dd MMM yyyy"/>
            </div>
            <div class="expiry" style="margin-top:.3rem;">
                Payment: <strong>${latest.paymentStatus}</strong>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="no-membership">
            <div style="font-size:2.5rem;margin-bottom:.75rem;"><i class="fa-solid fa-dumbbell"></i></div>
            <strong>No active membership</strong>
            <p style="margin-top:.4rem;font-size:.88rem;">Contact the admin to get a membership plan assigned.</p>
        </div>
    </c:otherwise>
</c:choose>

<!-- Stats Row -->
<div class="stats-grid" style="grid-template-columns:repeat(auto-fit,minmax(160px,1fr));margin-bottom:2rem;">
    <div class="stat-card">
        <div class="stat-icon"><i class="fa-solid fa-calendar-days"></i></div>
        <div class="stat-info">
            <div class="value">${enrollments.size()}</div>
            <div class="label">Enrolled Classes</div>
        </div>
    </div>
    <div class="stat-card green">
        <div class="stat-icon"><i class="fa-solid fa-circle-check"></i></div>
        <div class="stat-info">
            <div class="value">${attendance.size()}</div>
            <div class="label">Sessions Attended</div>
        </div>
    </div>
    <div class="stat-card blue">
        <div class="stat-icon"><i class="fa-solid fa-clipboard-list"></i></div>
        <div class="stat-info">
            <div class="value">${upcomingClasses.size()}</div>
            <div class="label">Upcoming Classes</div>
        </div>
    </div>
</div>

<!-- My Enrollments -->
<div class="card">
    <div class="card-header">
        <h2><i class="fa-solid fa-calendar-days"></i> My Class Enrollments</h2>
        <a href="${pageContext.request.contextPath}/member/classes" class="btn btn-primary btn-sm">Browse Classes</a>
    </div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty enrollments}">
                <p class="no-data">You have not enrolled in any classes yet. <a href="${pageContext.request.contextPath}/member/classes">Browse available classes</a>.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="e" items="${enrollments}">
                <div class="class-enrollment-card">
                    <div>
                        <div class="ce-name">${e.className}</div>
                        <div class="ce-meta">
                            <i class="fa-solid fa-dumbbell"></i> ${e.trainerName} &nbsp;|&nbsp;
                            <i class="fa-solid fa-clock"></i> <fmt:formatDate value="${e.scheduleDatetime}" pattern="dd MMM yyyy, HH:mm"/> &nbsp;|&nbsp;
                            ${e.durationMinutes} min
                        </div>
                    </div>
                    <div>
                        <span class="badge badge-${e.status eq 'enrolled' ? 'success' : 'secondary'}">${e.status}</span>
                    </div>
                </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Recent Attendance -->
<div class="card">
    <div class="card-header"><h2><i class="fa-solid fa-circle-check"></i> Recent Attendance</h2></div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty attendance}">
                <p class="no-data">No attendance records yet.</p>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
                    <table>
                        <thead><tr><th>Class</th><th>Date</th><th>Status</th></tr></thead>
                        <tbody>
                            <c:forEach var="att" items="${attendance}" varStatus="vs">
                                <c:if test="${vs.index < 10}">
                                <tr>
                                    <td>${att.className}</td>
                                    <td><fmt:formatDate value="${att.attendedDate}" pattern="dd MMM yyyy"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${att.status eq 'present'}"><span class="badge badge-success">Present</span></c:when>
                                            <c:otherwise><span class="badge badge-danger">Absent</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="/WEB-INF/views/shared/memberFooter.jsp" %>
