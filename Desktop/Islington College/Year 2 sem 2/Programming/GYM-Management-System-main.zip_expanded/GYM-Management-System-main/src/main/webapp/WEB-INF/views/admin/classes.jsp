<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle"  value="Manage Classes" scope="request"/>
<c:set var="pageCSS"    value="admin-classes"  scope="request"/>
<c:set var="activePage" value="classes"        scope="request"/>

<%@ include file="/WEB-INF/views/shared/adminHeader.jsp" %>

<div class="page-header">
    <div>
        <h1><i class="fa-solid fa-calendar-days"></i> Manage Classes</h1>
        <p>Schedule and manage gym classes.</p>
    </div>

    <button class="btn btn-primary" onclick="openModal('addClassModal')">
        <i class="fa-solid fa-plus"></i> Schedule Class
    </button>
</div>

<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>

<c:if test="${not empty param.success}">
    <div class="alert alert-success">
        <i class="fa-solid fa-circle-check"></i> Operation completed successfully.
    </div>
</c:if>

<!-- Attendance -->
<c:if test="${not empty viewClass}">
<div class="attendance-section">

    <div class="attendance-header">
        <h2><i class="fa-solid fa-clipboard-list"></i> Attendance — ${viewClass.className}</h2>
        <a href="${pageContext.request.contextPath}/admin/classes" class="btn btn-secondary btn-sm">
            <i class="fa-solid fa-arrow-left"></i> Back
        </a>
    </div>

    <c:choose>
        <c:when test="${empty attendanceList}">
            <p class="no-data">
                <i class="fa-solid fa-circle-info"></i> No attendance records for this class.
            </p>
        </c:when>

        <c:otherwise>
            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th><i class="fa-solid fa-user"></i> Member</th>
                            <th><i class="fa-solid fa-calendar"></i> Date</th>
                            <th><i class="fa-solid fa-circle-check"></i> Status</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="att" items="${attendanceList}">
                            <tr>
                                <td>${att.userName}</td>
                                <td><fmt:formatDate value="${att.attendedDate}" pattern="dd MMM yyyy"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${att.status eq 'present'}">
                                            <span class="badge badge-success">
                                                <i class="fa-solid fa-check"></i> Present
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-danger">
                                                <i class="fa-solid fa-xmark"></i> Absent
                                            </span>
                                        </c:otherwise>
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
</c:if>

<!-- Classes Table -->
<div class="card">

    <div class="card-header">
        <h2><i class="fa-solid fa-dumbbell"></i> All Classes</h2>
    </div>

    <div class="card-body">

        <c:choose>

            <c:when test="${empty classes}">
                <p class="no-data">
                    <i class="fa-solid fa-circle-info"></i> No classes found. Schedule your first class.
                </p>
            </c:when>

            <c:otherwise>

                <div class="table-wrap">

                    <table class="class-schedule-table">

                        <thead>
                            <tr>
                                <th>Class</th>
                                <th>Trainer</th>
                                <th>Date &amp; Time</th>
                                <th>Duration</th>
                                <th>Capacity</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>

                        <tbody>

                            <c:forEach var="cls" items="${classes}">

                                <c:set var="fillPct" value="${cls.capacity > 0 ? (cls.enrolledCount * 100 / cls.capacity) : 0}"/>

                                <tr>

                                    <td>
                                        <div class="schedule-name">${cls.className}</div>
                                        <div class="schedule-time">${cls.description}</div>
                                    </td>

                                    <td>${cls.trainerName}</td>

                                    <td><fmt:formatDate value="${cls.scheduleDatetime}" pattern="dd MMM yyyy HH:mm"/></td>

                                    <td><i class="fa-regular fa-clock"></i> ${cls.durationMinutes} min</td>

                                    <td>
                                        <div>${cls.enrolledCount} / ${cls.capacity}</div>

                                        <div class="capacity-bar">
                                            <div class="capacity-fill ${fillPct >= 100 ? 'full' : fillPct >= 75 ? 'warn' : ''}"
                                                 style="width:${fillPct > 100 ? 100 : fillPct}%"></div>
                                        </div>

                                        <div class="capacity-text">${cls.availableSpots} spots left</div>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${cls.active}">
                                                <span class="badge badge-success">
                                                    <i class="fa-solid fa-circle-check"></i> Active
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-secondary">
                                                    <i class="fa-solid fa-circle-xmark"></i> Inactive
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <div class="action-btns">

                                            <a href="${pageContext.request.contextPath}/admin/classes?editId=${cls.classId}"
                                               class="btn btn-info btn-sm">
                                                <i class="fa-solid fa-pen"></i>
                                            </a>

                                            <a href="${pageContext.request.contextPath}/admin/classes?viewAttendance=${cls.classId}"
                                               class="btn btn-secondary btn-sm">
                                                <i class="fa-solid fa-clipboard-list"></i>
                                            </a>

                                            <form action="${pageContext.request.contextPath}/admin/classes"
                                                  method="post"
                                                  onsubmit="return confirm('Delete class ${cls.className}?')">

                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="classId" value="${cls.classId}">

                                                <button class="btn btn-danger btn-sm">
                                                    <i class="fa-solid fa-trash"></i>
                                                </button>

                                            </form>

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
