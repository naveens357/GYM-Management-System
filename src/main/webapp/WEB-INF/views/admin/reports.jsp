<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%-- Page setup --%>
<c:set var="pageTitle"  value="Reports & Analytics" scope="request"/>
<c:set var="pageCSS"    value="admin-reports" scope="request"/>
<c:set var="activePage" value="reports" scope="request"/>

<%@ include file="/WEB-INF/views/shared/adminHeader.jsp" %>

<!-- Font Awesome icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<!-- Header -->
<div class="page-header">
    <div>
        <h1><i class="fa-solid fa-chart-line"></i> Reports & Analytics</h1>
        <p>System-wide performance overview</p>
    </div>
</div>

<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>

<!-- ================= KPI SECTION ================= -->
<div class="kpi-row">

    <div class="kpi-box">
        <div class="kpi-num"><i class="fa-solid fa-users"></i> ${totalMembers}</div>
        <div class="kpi-lbl">Active Members</div>
    </div>

    <div class="kpi-box green">
        <div class="kpi-num"><i class="fa-solid fa-user-tie"></i> ${totalTrainers}</div>
        <div class="kpi-lbl">Trainers</div>
    </div>

    <div class="kpi-box blue">
        <div class="kpi-num"><i class="fa-solid fa-dumbbell"></i> ${totalClasses}</div>
        <div class="kpi-lbl">Classes</div>
    </div>

    <div class="kpi-box orange">
        <div class="kpi-num">
            <i class="fa-solid fa-indian-rupee-sign"></i>
            <fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/>
        </div>
        <div class="kpi-lbl">Total Revenue</div>
    </div>

    <div class="kpi-box" style="border-bottom-color:var(--danger);">
        <div class="kpi-num" style="color:var(--danger);">
            <i class="fa-solid fa-triangle-exclamation"></i> ${pendingPayments}
        </div>
        <div class="kpi-lbl">Pending Payments</div>
    </div>

</div>

<!-- Main dashboard content -->
<div class="report-grid">

    <!-- Revenue section -->
    <div class="card">
        <div class="card-header">
            <h2><i class="fa-solid fa-coins"></i> Revenue by Plan</h2>
        </div>

        <div class="card-body">

            <c:choose>
                <c:when test="${empty revenueByPlan}">
                    <p class="no-data">No revenue data available yet.</p>
                </c:when>

                <c:otherwise>

                    <%-- calculate max value for bar scaling --%>
                    <c:set var="maxRev" value="1"/>
                    <c:forEach var="r" items="${revenueByPlan}">
                        <c:if test="${r.revenue > maxRev}">
                            <c:set var="maxRev" value="${r.revenue}"/>
                        </c:if>
                    </c:forEach>

                    <div class="chart-bar-wrap">

                        <c:forEach var="r" items="${revenueByPlan}">
                            <div class="chart-bar-row">

                                <span class="chart-bar-label" title="${r.planName}">
                                    ${r.planName}
                                </span>

                                <div class="chart-bar-track">
                                    <div class="chart-bar-fill green"
                                         style="width:${maxRev > 0 ? (r.revenue * 100 / maxRev) : 0}%">
                                    </div>
                                </div>

                                <span class="chart-bar-value">
                                    <fmt:formatNumber value="${r.revenue}" pattern="#,##0"/>
                                </span>

                            </div>
                        </c:forEach>

                    </div>

                </c:otherwise>
            </c:choose>

        </div>
    </div>

    <!-- Class popularity section -->
    <div class="card">
        <div class="card-header">
            <h2><i class="fa-solid fa-dumbbell"></i> Class Popularity</h2>
        </div>

        <div class="card-body">

            <c:choose>
                <c:when test="${empty classPop}">
                    <p class="no-data">No class enrollment data available yet.</p>
                </c:when>

                <c:otherwise>

                    <%-- find max enrollment for scaling --%>
                    <c:set var="maxEnroll" value="1"/>
                    <c:forEach var="c" items="${classPop}">
                        <c:if test="${c.enrolledCount > maxEnroll}">
                            <c:set var="maxEnroll" value="${c.enrolledCount}"/>
                        </c:if>
                    </c:forEach>

                    <div class="chart-bar-wrap">

                        <c:forEach var="c" items="${classPop}">
                            <div class="chart-bar-row">

                                <span class="chart-bar-label" title="${c.className}">
                                    ${c.className}
                                </span>

                                <div class="chart-bar-track">
                                    <div class="chart-bar-fill blue"
                                         style="width:${maxEnroll > 0 ? (c.enrolledCount * 100 / maxEnroll) : 0}%">
                                    </div>
                                </div>

                                <span class="chart-bar-value">
                                    ${c.enrolledCount}/${c.capacity}
                                </span>

                            </div>
                        </c:forEach>

                    </div>

                </c:otherwise>
            </c:choose>

        </div>
    </div>

</div>

<!-- Attendance summary -->
<div class="card">

    <div class="card-header">
        <h2><i class="fa-solid fa-circle-check"></i> Attendance Summary</h2>
    </div>

    <div class="card-body">

        <c:choose>
            <c:when test="${empty attendanceSummary}">
                <p class="no-data">No attendance records available yet.</p>
            </c:when>

            <c:otherwise>

                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>Class</th>
                                <th>Present</th>
                                <th>Absent</th>
                                <th>Total</th>
                                <th>Rate</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="a" items="${attendanceSummary}">
                                <tr>
                                    <td><strong>${a.className}</strong></td>

                                    <td><span class="badge badge-success">${a.presentCount}</span></td>
                                    <td><span class="badge badge-danger">${a.absentCount}</span></td>
                                    <td>${a.total}</td>

                                    <td>
                                        <div class="attendance-rate-circle
                                            ${a.attendanceRate >= 75 ? 'rate-high' : a.attendanceRate >= 50 ? 'rate-medium' : 'rate-low'}">
                                            ${a.attendanceRate}%
                                        </div>
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

<%@ include file="/WEB-INF/views/shared/adminFooter.jsp" %>
