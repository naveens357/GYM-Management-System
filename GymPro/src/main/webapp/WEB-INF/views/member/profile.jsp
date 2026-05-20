<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle"  value="My Profile"    scope="request"/>
<c:set var="pageCSS"    value="member-profile" scope="request"/>
<c:set var="activePage" value="profile"       scope="request"/>
<%@ include file="/WEB-INF/views/shared/memberHeader.jsp" %>

<c:set var="user" value="${sessionScope.loggedUser}"/>

<div class="profile-header">
    <div class="profile-avatar-lg">${user.fullName.charAt(0)}</div>
    <div>
        <div class="ph-name">${user.fullName}</div>
        <div class="ph-email">${user.email}</div>
        <div class="ph-role"><span class="badge badge-info">Member</span> <span class="badge badge-success">${user.status}</span></div>
    </div>
</div>

<c:if test="${not empty error}">  <div class="alert alert-danger">${error}</div>   </c:if>
<c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>

<!-- Tabs -->
<div class="profile-tabs">
    <button class="profile-tab active" onclick="showTab('editTab',this)">&#9998; Edit Profile</button>
    <button class="profile-tab"        onclick="showTab('pwdTab',this)">&#x1F512; Change Password</button>
</div>

<!-- Edit Profile Tab -->
<div id="editTab" class="profile-section active">
    <div class="card">
        <div class="card-header"><h2>Edit Profile</h2></div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/member/profile" method="post">
                <input type="hidden" name="action" value="updateProfile">
                <div class="form-row">
                    <div class="form-group">
                        <label>Full Name *</label>
                        <input type="text" name="fullName" class="form-control" value="${user.fullName}" required>
                    </div>
                    <div class="form-group">
                        <label>Phone *</label>
                        <input type="text" name="phone" class="form-control" value="${user.phone}" maxlength="10" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Date of Birth</label>
                        <input type="date" name="dateOfBirth" class="form-control"
                               value="<fmt:formatDate value='${user.dateOfBirth}' pattern='yyyy-MM-dd'/>">
                    </div>
                    <div class="form-group">
                        <label>Gender</label>
                        <select name="gender" class="form-control">
                            <option value="Male"   ${user.gender eq 'Male'   ? 'selected' : ''}>Male</option>
                            <option value="Female" ${user.gender eq 'Female' ? 'selected' : ''}>Female</option>
                            <option value="Other"  ${user.gender eq 'Other'  ? 'selected' : ''}>Other</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label>Email <span style="color:var(--gray);font-weight:400;">(read-only)</span></label>
                    <input type="email" class="form-control" value="${user.email}" disabled>
                </div>
                <div class="form-group">
                    <label>Address</label>
                    <textarea name="address" class="form-control">${user.address}</textarea>
                </div>
                <button type="submit" class="btn btn-primary">Save Changes</button>
            </form>
        </div>
    </div>
</div>

<!-- Change Password Tab -->
<div id="pwdTab" class="profile-section">
    <div class="card">
        <div class="card-header"><h2>Change Password</h2></div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/member/profile" method="post" style="max-width:420px;">
                <input type="hidden" name="action" value="changePassword">
                <div class="form-group">
                    <label>Current Password *</label>
                    <input type="password" name="currentPassword" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>New Password *</label>
                    <input type="password" name="newPassword" class="form-control"
                           placeholder="Min 8 chars, upper, lower, number, special" required>
                </div>
                <div class="form-group">
                    <label>Confirm New Password *</label>
                    <input type="password" name="confirmPassword" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary">&#x1F512; Change Password</button>
            </form>
        </div>
    </div>
</div>

<script>
function showTab(tabId, btn) {
    document.querySelectorAll('.profile-section').forEach(function(s){ s.classList.remove('active'); });
    document.querySelectorAll('.profile-tab').forEach(function(b){ b.classList.remove('active'); });
    document.getElementById(tabId).classList.add('active');
    btn.classList.add('active');
}
</script>

<%@ include file="/WEB-INF/views/shared/memberFooter.jsp" %>
