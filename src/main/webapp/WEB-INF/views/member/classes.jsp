<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle"  value="Browse Classes" scope="request"/>
<c:set var="pageCSS"    value="member-classes" scope="request"/>
<c:set var="activePage" value="classes"        scope="request"/>
<%@ include file="/WEB-INF/views/shared/memberHeader.jsp" %>

<%-- Build a set of enrolled class IDs from session for quick lookup --%>
<c:set var="enrolledIds" value="" scope="page"/>

<div class="page-header">
    <div><h1>&#x1F4C5; Browse Classes</h1><p>View upcoming classes and enroll.</p></div>
</div>

<c:if test="${not empty error}">  <div class="alert alert-danger">${error}</div>  </c:if>
<c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>

<!-- Upcoming Classes Grid -->
<c:choose>
    <c:when test="${empty upcomingClasses}">
        <p class="no-data">No upcoming classes scheduled. Check back later.</p>
    </c:when>
    <c:otherwise>
        <div class="classes-grid">
            <c:forEach var="cls" items="${upcomingClasses}">
            <%-- Check if user is enrolled in this class --%>
            <c:set var="isEnrolled" value="false"/>
            <c:forEach var="e" items="${myEnrollments}">
                <c:if test="${e.classId eq cls.classId and e.status eq 'enrolled'}">
                    <c:set var="isEnrolled" value="true"/>
                </c:if>
            </c:forEach>
            <div class="class-tile">
                <div>
                    <h3>${cls.className}
                        <c:if test="${isEnrolled}">
                            <span class="enrolled-indicator">Enrolled</span>
                        </c:if>
                    </h3>
                    <div class="ct-trainer">&#x1F3CB; ${cls.trainerName}</div>
                    <div class="ct-meta">
                        &#x1F4C5; <fmt:formatDate value="${cls.scheduleDatetime}" pattern="dd MMM yyyy"/><br>
                        &#x23F0; <fmt:formatDate value="${cls.scheduleDatetime}" pattern="HH:mm"/> &nbsp;|&nbsp; ${cls.durationMinutes} min<br>
                        <c:if test="${not empty cls.description}">&#x2139; ${cls.description}</c:if>
                    </div>
                    <div style="margin-top:.5rem;">
                        <c:choose>
                            <c:when test="${cls.availableSpots <= 0}">
                                <span class="spots-badge spots-full">FULL</span>
                            </c:when>
                            <c:when test="${cls.availableSpots <= 3}">
                                <span class="spots-badge spots-low">${cls.availableSpots} spots left</span>
                            </c:when>
                            <c:otherwise>
                                <span class="spots-badge spots-ok">${cls.availableSpots} spots available</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="ct-actions">
                    <c:choose>
                        <c:when test="${isEnrolled}">
                            <form action="${pageContext.request.contextPath}/member/classes" method="post">
                                <input type="hidden" name="action"  value="cancel">
                                <input type="hidden" name="classId" value="${cls.classId}">
                                <button class="btn btn-secondary btn-sm">&#10007; Cancel Enrollment</button>
                            </form>
                        </c:when>
                        <c:when test="${cls.availableSpots <= 0}">
                            <button class="btn btn-secondary btn-sm" disabled>Class Full</button>
                        </c:when>
                        <c:otherwise>
                            <form action="${pageContext.request.contextPath}/member/classes" method="post">
                                <input type="hidden" name="action"  value="enroll">
                                <input type="hidden" name="classId" value="${cls.classId}">
                                <button class="btn btn-primary btn-sm">&#10003; Enroll Now</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<!-- My Attendance -->
<div class="card" style="margin-top:2rem;">
    <div class="card-header"><h2>&#x2705; My Attendance History</h2></div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty myAttendance}">
                <p class="no-data">No attendance records yet.</p>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
                    <table>
                        <thead><tr><th>Class</th><th>Date</th><th>Status</th></tr></thead>
                        <tbody>
                            <c:forEach var="att" items="${myAttendance}">
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
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="/WEB-INF/views/shared/memberFooter.jsp" %>
