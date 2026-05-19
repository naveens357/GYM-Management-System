<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle"  value="My Attendance"   scope="request"/>
<c:set var="pageCSS"    value="member-dashboard" scope="request"/>
<c:set var="activePage" value="attendance"      scope="request"/>
<%@ include file="/WEB-INF/views/shared/memberHeader.jsp" %>

<div class="page-header">
    <div><h1>&#x1F4C5; My Attendance</h1>
         <p>Mark your daily gym attendance and view your history.</p></div>
</div>

<c:if test="${not empty error}">  <div class="alert alert-danger">${error}</div>   </c:if>
<c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>

<!-- Mark Attendance Card -->
<div class="card" style="margin-bottom:1.5rem;">
    <div class="card-header"><h2>Today's Attendance</h2></div>
    <div class="card-body">
        <c:choose>
            <c:when test="${markedToday}">
                <p style="margin-bottom:1rem;">
                    You marked attendance today at
                    <strong><fmt:formatDate value="${today.checkInTime}" pattern="hh:mm a"/></strong>.
                </p>
                <p>
                    Status:
                    <c:choose>
                        <c:when test="${today.status eq 'verified'}"><span class="badge badge-success">Verified by Admin</span></c:when>
                        <c:when test="${today.status eq 'rejected'}"><span class="badge badge-danger">Rejected by Admin</span></c:when>
                        <c:otherwise><span class="badge badge-warning">Pending Admin Verification</span></c:otherwise>
                    </c:choose>
                </p>
                <c:if test="${not empty today.note}">
                    <p style="margin-top:.75rem;color:var(--gray);"><em>Your note: ${today.note}</em></p>
                </c:if>
            </c:when>
            <c:otherwise>
                <form action="${pageContext.request.contextPath}/member/attendance" method="post">
                    <div class="form-group">
                        <label>Note (optional)</label>
                        <input type="text" name="note" class="form-control" maxlength="255"
                               placeholder="E.g. Morning workout, leg day, etc.">
                    </div>
                    <button type="submit" class="btn btn-primary">&#10003; Mark My Attendance</button>
                </form>
                <p style="margin-top:.75rem;color:var(--gray);font-size:.85rem;">
                    Your attendance will be sent to the admin for verification.
                </p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- History Card -->
<div class="card">
    <div class="card-header"><h2>Attendance History</h2></div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty history}">
                <p class="no-data">No attendance records yet.</p>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr><th>Date</th><th>Time</th><th>Note</th><th>Status</th><th>Verified By</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="a" items="${history}">
                            <tr>
                                <td><fmt:formatDate value="${a.attendanceDate}" pattern="dd MMM yyyy"/></td>
                                <td><fmt:formatDate value="${a.checkInTime}"    pattern="hh:mm a"/></td>
                                <td>${empty a.note ? '—' : a.note}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${a.status eq 'verified'}"><span class="badge badge-success">Verified</span></c:when>
                                        <c:when test="${a.status eq 'rejected'}"><span class="badge badge-danger">Rejected</span></c:when>
                                        <c:otherwise><span class="badge badge-warning">Pending</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${empty a.verifierName ? '—' : a.verifierName}</td>
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