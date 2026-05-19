<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle"  value="Manage Classes" scope="request"/>
<c:set var="pageCSS"    value="admin-classes"  scope="request"/>
<c:set var="activePage" value="classes"        scope="request"/>
<%@ include file="/WEB-INF/views/shared/adminHeader.jsp" %>

<div class="page-header">
    <div><h1>&#x1F4C5; Manage Classes</h1><p>Schedule and manage gym classes.</p></div>
    <button class="btn btn-primary" onclick="openModal('addClassModal')">&#x2795; Schedule Class</button>
</div>

<c:if test="${not empty error}">  <div class="alert alert-danger">${error}</div>  </c:if>
<c:if test="${not empty param.success}"><div class="alert alert-success">Operation completed successfully.</div></c:if>

<!-- Attendance View -->
<c:if test="${not empty viewClass}">
<div class="attendance-section">
    <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:1rem;">
        <h2>&#x1F4CB; Attendance — ${viewClass.className}</h2>
        <a href="${pageContext.request.contextPath}/admin/classes" class="btn btn-secondary btn-sm">&#8592; Back</a>
    </div>
    <c:choose>
        <c:when test="${empty attendanceList}">
            <p class="no-data">No attendance records for this class.</p>
        </c:when>
        <c:otherwise>
            <div class="table-wrap">
                <table>
                    <thead><tr><th>Member</th><th>Date</th><th>Status</th></tr></thead>
                    <tbody>
                        <c:forEach var="att" items="${attendanceList}">
                        <tr>
                            <td>${att.userName}</td>
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
</c:if>

<!-- Classes Table -->
<div class="card">
    <div class="card-header"><h2>All Classes</h2></div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty classes}">
                <p class="no-data">No classes found. Schedule your first class.</p>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
                    <table class="class-schedule-table">
                        <thead>
                            <tr><th>Class</th><th>Trainer</th><th>Date &amp; Time</th><th>Duration</th><th>Capacity</th><th>Status</th><th>Actions</th></tr>
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
                                <td>${cls.durationMinutes} min</td>
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
                                        <c:when test="${cls.active}"><span class="badge badge-success">Active</span></c:when>
                                        <c:otherwise><span class="badge badge-secondary">Inactive</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-btns">
                                        <a href="${pageContext.request.contextPath}/admin/classes?editId=${cls.classId}"
                                           class="btn btn-info btn-sm">&#9998;</a>
                                        <a href="${pageContext.request.contextPath}/admin/classes?viewAttendance=${cls.classId}"
                                           class="btn btn-secondary btn-sm">&#x1F4CB;</a>
                                        <form action="${pageContext.request.contextPath}/admin/classes" method="post" style="display:inline;"
                                              onsubmit="return confirm('Delete class ${cls.className}?')">
                                            <input type="hidden" name="action"  value="delete">
                                            <input type="hidden" name="classId" value="${cls.classId}">
                                            <button class="btn btn-danger btn-sm">&#x1F5D1;</button>
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

<!-- Add Class Modal -->
<div class="modal-overlay" id="addClassModal">
    <div class="modal-box">
        <div class="modal-header">
            <h3>&#x2795; Schedule New Class</h3>
            <button class="modal-close" onclick="closeModal('addClassModal')">&times;</button>
        </div>
        <form action="${pageContext.request.contextPath}/admin/classes" method="post">
            <input type="hidden" name="action" value="add">
            <div class="form-group">
                <label>Class Name *</label>
                <input type="text" name="className" class="form-control" placeholder="e.g. Morning HIIT" required>
            </div>
            <div class="form-group">
                <label>Trainer *</label>
                <select name="trainerId" class="form-control" required>
                    <option value="">-- Select Trainer --</option>
                    <c:forEach var="t" items="${trainers}">
                        <option value="${t.trainerId}">${t.fullName} — ${t.specialization}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>Date &amp; Time *</label>
                <input type="datetime-local" name="scheduleDatetime" class="form-control" required>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Duration (minutes)</label>
                    <input type="number" name="durationMinutes" class="form-control" value="60" min="15" max="180">
                </div>
                <div class="form-group">
                    <label>Capacity</label>
                    <input type="number" name="capacity" class="form-control" value="20" min="1" max="100">
                </div>
            </div>
            <div class="form-group">
                <label>Description</label>
                <textarea name="description" class="form-control" placeholder="Class description..."></textarea>
            </div>
            <div style="display:flex;gap:.75rem;justify-content:flex-end;">
                <button type="button" class="btn btn-secondary" onclick="closeModal('addClassModal')">Cancel</button>
                <button type="submit" class="btn btn-primary">Schedule Class</button>
            </div>
        </form>
    </div>
</div>

<!-- Edit Class Modal -->
<c:if test="${not empty editClass}">
<div class="modal-overlay open" id="editClassModal">
    <div class="modal-box">
        <div class="modal-header">
            <h3>&#9998; Edit Class</h3>
            <a href="${pageContext.request.contextPath}/admin/classes" class="modal-close">&times;</a>
        </div>
        <form action="${pageContext.request.contextPath}/admin/classes" method="post">
            <input type="hidden" name="action"  value="update">
            <input type="hidden" name="classId" value="${editClass.classId}">
            <div class="form-group">
                <label>Class Name *</label>
                <input type="text" name="className" class="form-control" value="${editClass.className}" required>
            </div>
            <div class="form-group">
                <label>Trainer *</label>
                <select name="trainerId" class="form-control" required>
                    <c:forEach var="t" items="${trainers}">
                        <option value="${t.trainerId}" ${t.trainerId eq editClass.trainerId ? 'selected' : ''}>${t.fullName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>Date &amp; Time *</label>
                <input type="datetime-local" name="scheduleDatetime" class="form-control" required>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Duration (min)</label>
                    <input type="number" name="durationMinutes" class="form-control" value="${editClass.durationMinutes}" min="15">
                </div>
                <div class="form-group">
                    <label>Capacity</label>
                    <input type="number" name="capacity" class="form-control" value="${editClass.capacity}" min="1">
                </div>
            </div>
            <div class="form-group">
                <label>Description</label>
                <textarea name="description" class="form-control">${editClass.description}</textarea>
            </div>
            <div class="form-group">
                <label>Status</label>
                <select name="isActive" class="form-control">
                    <option value="1" ${editClass.active ? 'selected' : ''}>Active</option>
                    <option value="0" ${not editClass.active ? 'selected' : ''}>Inactive</option>
                </select>
            </div>
            <div style="display:flex;gap:.75rem;justify-content:flex-end;">
                <a href="${pageContext.request.contextPath}/admin/classes" class="btn btn-secondary">Cancel</a>
                <button type="submit" class="btn btn-primary">Save Changes</button>
            </div>
        </form>
    </div>
</div>
</c:if>

<%@ include file="/WEB-INF/views/shared/adminFooter.jsp" %>
