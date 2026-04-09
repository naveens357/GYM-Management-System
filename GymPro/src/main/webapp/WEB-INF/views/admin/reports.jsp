<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle"  value="Reports & Analytics" scope="request"/>
<c:set var="pageCSS"    value="admin-reports"        scope="request"/>
<c:set var="activePage" value="reports"              scope="request"/>
<%@ include file="/WEB-INF/views/shared/adminHeader.jsp" %>

<div class="page-header">
    <div><h1>&#x1F4CA; Reports &amp; Analytics</h1>
         <p>System-wide performance overview.</p></div>
</div>

<c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

<!-- KPI Row -->
<div class="kpi-row">
    <div class="kpi-box">
        <div class="kpi-num">${totalMembers}</div>
        <div class="kpi-lbl">Active Members</div>
    </div>
    <div class="kpi-box green">
        <div class="kpi-num">${totalTrainers}</div>
        <div class="kpi-lbl">Trainers</div>
    </div>
    <div class="kpi-box blue">
        <div class="kpi-num">${totalClasses}</div>
        <div class="kpi-lbl">Classes</div>
    </div>
    <div class="kpi-box orange">
        <div class="kpi-num">Rs. <fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/></div>
        <div class="kpi-lbl">Total Revenue</div>
    </div>
    <div class="kpi-box" style="border-bottom-color:var(--danger);">
        <div class="kpi-num" style="color:var(--danger);">${pendingPayments}</div>
        <div class="kpi-lbl">Pending Payments</div>
    </div>
</div>

<div class="report-grid">

    <!-- Revenue by Plan -->
    <div class="card" style="margin-bottom:0;">
        <div class="card-header"><h2>&#x1F4B0; Revenue by Plan</h2></div>
        <div class="card-body">
            <c:choose>
                <c:when test="${empty revenueByPlan}">
                    <p class="no-data">No revenue data yet.</p>
                </c:when>
                <c:otherwise>
                    <%-- Find max revenue for bar scaling --%>
                    <c:set var="maxRev" value="1"/>
                    <c:forEach var="r" items="${revenueByPlan}">
                        <c:if test="${r.revenue > maxRev}"><c:set var="maxRev" value="${r.revenue}"/></c:if>
                    </c:forEach>
                    <div class="chart-bar-wrap">
                        <c:forEach var="r" items="${revenueByPlan}">
                        <div class="chart-bar-row">
                            <span class="chart-bar-label" title="${r.planName}">${r.planName}</span>
                            <div class="chart-bar-track">
                                <div class="chart-bar-fill green"
                                     style="width:${maxRev > 0 ? (r.revenue * 100 / maxRev) : 0}%"></div>
                            </div>
                            <span class="chart-bar-value">Rs.<fmt:formatNumber value="${r.revenue}" pattern="#,##0"/></span>
                        </div>
                        </c:forEach>
                    </div>
                    <div style="margin-top:1rem;">
                        <div class="table-wrap">
                            <table>
                                <thead><tr><th>Plan</th><th>Sold</th><th>Revenue</th></tr></thead>
                                <tbody>
                                    <c:forEach var="r" items="${revenueByPlan}">
                                    <tr>
                                        <td>${r.planName}</td>
                                        <td>${r.totalSold}</td>
                                        <td><strong>Rs. <fmt:formatNumber value="${r.revenue}" pattern="#,##0"/></strong></td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Class Popularity -->
    <div class="card" style="margin-bottom:0;">
        <div class="card-header"><h2>&#x1F3CB; Class Popularity</h2></div>
        <div class="card-body">
            <c:choose>
                <c:when test="${empty classPop}">
                    <p class="no-data">No class enrollment data yet.</p>
                </c:when>
                <c:otherwise>
                    <c:set var="maxEnroll" value="1"/>
                    <c:forEach var="c" items="${classPop}">
                        <c:if test="${c.enrolledCount > maxEnroll}"><c:set var="maxEnroll" value="${c.enrolledCount}"/></c:if>
                    </c:forEach>
                    <div class="chart-bar-wrap">
                        <c:forEach var="c" items="${classPop}">
                        <div class="chart-bar-row">
                            <span class="chart-bar-label" title="${c.className}">${c.className}</span>
                            <div class="chart-bar-track">
                                <div class="chart-bar-fill blue"
                                     style="width:${maxEnroll > 0 ? (c.enrolledCount * 100 / maxEnroll) : 0}%"></div>
                            </div>
                            <span class="chart-bar-value">${c.enrolledCount}/${c.capacity}</span>
                        </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</div><!-- /report-grid -->

<!-- Attendance Summary -->
<div class="card">
    <div class="card-header"><h2>&#x2705; Attendance Summary by Class</h2></div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty attendanceSummary}">
                <p class="no-data">No attendance data recorded yet.</p>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr><th>Class</th><th>Present</th><th>Absent</th><th>Total</th><th>Rate</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="a" items="${attendanceSummary}">
                            <tr>
                                <td><strong>${a.className}</strong></td>
                                <td><span class="badge badge-success">${a.presentCount}</span></td>
                                <td><span class="badge badge-danger">${a.absentCount}</span></td>
                                <td>${a.total}</td>
                                <td>
                                    <div class="attendance-rate-circle ${a.attendanceRate >= 75 ? 'rate-high' : a.attendanceRate >= 50 ? 'rate-medium' : 'rate-low'}">
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

<!-- Member Registration Trend -->
<div class="card">
    <div class="card-header"><h2>&#x1F4C8; Member Growth (Last 6 Months)</h2></div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty memberTrend}">
                <p class="no-data">No member registration data in the last 6 months.</p>
            </c:when>
            <c:otherwise>
                <c:set var="maxNew" value="1"/>
                <c:forEach var="t" items="${memberTrend}">
                    <c:if test="${t.newMembers > maxNew}"><c:set var="maxNew" value="${t.newMembers}"/></c:if>
                </c:forEach>
                <div class="trend-bar-row">
                    <c:forEach var="t" items="${memberTrend}">
                    <div class="trend-bar-col">
                        <div class="trend-bar-count">${t.newMembers}</div>
                        <div class="trend-bar"
                             style="height:${maxNew > 0 ? (t.newMembers * 90 / maxNew) : 4}px"></div>
                        <div class="trend-bar-label">${t.month}</div>
                    </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="/WEB-INF/views/shared/adminFooter.jsp" %>
