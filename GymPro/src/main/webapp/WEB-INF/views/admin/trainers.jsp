<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle"  value="Manage Trainers" scope="request"/>
<c:set var="pageCSS"    value="admin-trainers"  scope="request"/>
<c:set var="activePage" value="trainers"        scope="request"/>
<%@ include file="/WEB-INF/views/shared/adminHeader.jsp" %>

<div class="page-header">
    <div><h1>&#x1F3CB; Manage Trainers</h1><p>Add, edit and manage gym trainers.</p></div>
    <button class="btn btn-primary" onclick="openModal('addTrainerModal')">&#x2795; Add Trainer</button>
</div>

<c:if test="${not empty error}">  <div class="alert alert-danger">${error}</div>  </c:if>
<c:if test="${not empty param.success}"><div class="alert alert-success">Operation completed successfully.</div></c:if>

<!-- Trainer Cards -->
<c:choose>
    <c:when test="${empty trainers}">
        <p class="no-data">No trainers found. Add your first trainer.</p>
    </c:when>
    <c:otherwise>
        <div class="trainer-grid-admin">
            <c:forEach var="t" items="${trainers}">
            <div class="trainer-card-admin ${not t.active ? 'plan-inactive' : ''}">
                <c:if test="${not t.active}">
                    <span class="badge badge-secondary inactive-badge">Inactive</span>
                </c:if>
                <div class="tc-avatar">${t.fullName.charAt(0)}</div>
                <h3>${t.fullName}</h3>
                <div class="tc-spec">${t.specialization}</div>
                <div class="tc-detail">&#x1F4DE; ${t.phone}</div>
                <div class="tc-detail">&#x1F4E7; ${t.email}</div>
                <div class="tc-detail">&#x23F0; ${t.schedule}</div>
                <div class="tc-detail">&#x1F3C6; ${t.experienceYears} yrs experience</div>
                <div class="tc-actions">
                    <a href="${pageContext.request.contextPath}/admin/trainers?editId=${t.trainerId}"
                       class="btn btn-info btn-sm">&#9998; Edit</a>
                    <form action="${pageContext.request.contextPath}/admin/trainers" method="post" style="display:inline;"
                          onsubmit="return confirm('Delete trainer ${t.fullName}?')">
                        <input type="hidden" name="action"    value="delete">
                        <input type="hidden" name="trainerId" value="${t.trainerId}">
                        <button class="btn btn-danger btn-sm">&#x1F5D1;</button>
                    </form>
                </div>
            </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<!-- Add Trainer Modal -->
<div class="modal-overlay" id="addTrainerModal">
    <div class="modal-box">
        <div class="modal-header">
            <h3>&#x2795; Add New Trainer</h3>
            <button class="modal-close" onclick="closeModal('addTrainerModal')">&times;</button>
        </div>
        <form action="${pageContext.request.contextPath}/admin/trainers" method="post">
            <input type="hidden" name="action" value="add">
            <div class="form-row">
                <div class="form-group">
                    <label>Full Name *</label>
                    <input type="text" name="fullName" class="form-control" placeholder="Trainer Name" required>
                </div>
                <div class="form-group">
                    <label>Specialization *</label>
                    <input type="text" name="specialization" class="form-control" placeholder="e.g. Yoga & Flexibility" required>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Email *</label>
                    <input type="email" name="email" class="form-control" placeholder="trainer@gym.com" required>
                </div>
                <div class="form-group">
                    <label>Phone *</label>
                    <input type="text" name="phone" class="form-control" placeholder="10-digit" maxlength="10" required>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Experience (Years)</label>
                    <input type="number" name="experienceYears" class="form-control" min="0" max="50" value="0">
                </div>
                <div class="form-group">
                    <label>Schedule</label>
                    <input type="text" name="schedule" class="form-control" placeholder="e.g. Mon-Fri 6AM-2PM">
                </div>
            </div>
            <div class="form-group">
                <label>Bio</label>
                <textarea name="bio" class="form-control" placeholder="Short trainer biography..."></textarea>
            </div>
            <div style="display:flex;gap:.75rem;justify-content:flex-end;">
                <button type="button" class="btn btn-secondary" onclick="closeModal('addTrainerModal')">Cancel</button>
                <button type="submit" class="btn btn-primary">Add Trainer</button>
            </div>
        </form>
    </div>
</div>

<!-- Edit Trainer Modal (shown if editTrainer is set) -->
<c:if test="${not empty editTrainer}">
<div class="modal-overlay open" id="editTrainerModal">
    <div class="modal-box">
        <div class="modal-header">
            <h3>&#9998; Edit Trainer</h3>
            <a href="${pageContext.request.contextPath}/admin/trainers" class="modal-close">&times;</a>
        </div>
        <form action="${pageContext.request.contextPath}/admin/trainers" method="post">
            <input type="hidden" name="action"    value="update">
            <input type="hidden" name="trainerId" value="${editTrainer.trainerId}">
            <div class="form-row">
                <div class="form-group">
                    <label>Full Name *</label>
                    <input type="text" name="fullName" class="form-control" value="${editTrainer.fullName}" required>
                </div>
                <div class="form-group">
                    <label>Specialization *</label>
                    <input type="text" name="specialization" class="form-control" value="${editTrainer.specialization}" required>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Email *</label>
                    <input type="email" name="email" class="form-control" value="${editTrainer.email}" required>
                </div>
                <div class="form-group">
                    <label>Phone *</label>
                    <input type="text" name="phone" class="form-control" value="${editTrainer.phone}" maxlength="10" required>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Experience (Years)</label>
                    <input type="number" name="experienceYears" class="form-control" value="${editTrainer.experienceYears}" min="0">
                </div>
                <div class="form-group">
                    <label>Schedule</label>
                    <input type="text" name="schedule" class="form-control" value="${editTrainer.schedule}">
                </div>
            </div>
            <div class="form-group">
                <label>Bio</label>
                <textarea name="bio" class="form-control">${editTrainer.bio}</textarea>
            </div>
            <div class="form-group">
                <label>Status</label>
                <select name="isActive" class="form-control">
                    <option value="1" ${editTrainer.active ? 'selected' : ''}>Active</option>
                    <option value="0" ${not editTrainer.active ? 'selected' : ''}>Inactive</option>
                </select>
            </div>
            <div style="display:flex;gap:.75rem;justify-content:flex-end;">
                <a href="${pageContext.request.contextPath}/admin/trainers" class="btn btn-secondary">Cancel</a>
                <button type="submit" class="btn btn-primary">Save Changes</button>
            </div>
        </form>
    </div>
</div>
</c:if>

<%@ include file="/WEB-INF/views/shared/adminFooter.jsp" %>
