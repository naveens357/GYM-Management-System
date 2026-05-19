<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle"  value="My Profile"      scope="request"/>
<c:set var="pageCSS"    value="member-profile"  scope="request"/>
<c:set var="activePage" value="profile"         scope="request"/>

<%@ include file="/WEB-INF/views/shared/memberHeader.jsp" %>

<c:set var="user" value="${sessionScope.loggedUser}"/>

<!-- Font Awesome -->
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>

    .profile-container{
        display:grid;
        grid-template-columns:1fr;
        gap:1.5rem;
    }

    .profile-header{
        background:#fff;
        border-radius:20px;
        padding:2rem;
        box-shadow:0 4px 14px rgba(0,0,0,0.06);
        display:flex;
        align-items:center;
        gap:1.5rem;
        flex-wrap:wrap;
    }

    .profile-avatar-lg{
        width:90px;
        height:90px;
        border-radius:50%;
        background:#ef4444;
        color:#fff;
        display:flex;
        align-items:center;
        justify-content:center;
        font-size:2rem;
        font-weight:700;
        flex-shrink:0;
    }

    .profile-header img{
        width:90px;
        height:90px;
        border-radius:50%;
        object-fit:cover;
        border:4px solid #ef4444;
    }

    .ph-name{
        font-size:2rem;
        font-weight:800;
        color:#111827;
    }

    .ph-email{
        color:#6b7280;
        margin:.4rem 0;
        font-size:1rem;
    }

    .ph-role{
        display:flex;
        gap:.6rem;
        flex-wrap:wrap;
    }

    .badge{
        padding:.45rem .8rem;
        border-radius:999px;
        font-size:.8rem;
        font-weight:600;
        display:inline-flex;
        align-items:center;
        gap:.35rem;
    }

    .badge-info{
        background:#dbeafe;
        color:#2563eb;
    }

    .badge-success{
        background:#dcfce7;
        color:#15803d;
    }

    .profile-tabs{
        display:flex;
        gap:1rem;
        flex-wrap:wrap;
    }

    .profile-tab{
        border:none;
        background:#fff;
        padding:1rem 1.5rem;
        border-radius:12px;
        cursor:pointer;
        font-weight:600;
        transition:.3s;
        box-shadow:0 3px 10px rgba(0,0,0,0.05);
        display:flex;
        align-items:center;
        gap:.6rem;
    }

    .profile-tab.active{
        background:#ef4444;
        color:#fff;
    }

    .profile-section{
        display:none;
    }

    .profile-section.active{
        display:block;
    }

    .card{
        background:#fff;
        border-radius:18px;
        overflow:hidden;
        box-shadow:0 4px 14px rgba(0,0,0,0.06);
        border:none;
    }

    .card-header{
        padding:1.2rem 1.5rem;
        border-bottom:1px solid #f3f4f6;
    }

    .card-header h2{
        display:flex;
        align-items:center;
        gap:.6rem;
        font-size:1.3rem;
        color:#111827;
    }

    .card-body{
        padding:1.5rem;
    }

    .upload-box{
        display:flex;
        align-items:center;
        gap:1.5rem;
        flex-wrap:wrap;
    }

    .upload-content{
        flex:1;
        min-width:250px;
    }

    .form-row{
        display:grid;
        grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
        gap:1rem;
    }

    .form-group{
        margin-bottom:1rem;
    }

    .form-group label{
        display:block;
        margin-bottom:.5rem;
        font-weight:600;
        color:#374151;
    }

    .form-control{
        width:100%;
        padding:.9rem 1rem;
        border:1px solid #d1d5db;
        border-radius:10px;
        font-size:.95rem;
        outline:none;
        transition:.3s;
        background:#fff;
    }

    .form-control:focus{
        border-color:#ef4444;
        box-shadow:0 0 0 3px rgba(239,68,68,0.12);
    }

    textarea.form-control{
        resize:vertical;
        min-height:110px;
    }

    .btn{
        border:none;
        border-radius:10px;
        padding:.9rem 1.3rem;
        font-weight:600;
        cursor:pointer;
        transition:.3s;
        display:inline-flex;
        align-items:center;
        gap:.5rem;
    }

    .btn-primary{
        background:#ef4444;
        color:#fff;
    }

    .btn-primary:hover{
        background:#dc2626;
    }

    .helper-text{
        display:block;
        margin-top:.4rem;
        color:#6b7280;
        font-size:.85rem;
    }

</style>

<div class="profile-container">

    <!-- Profile Header -->
    <div class="profile-header">

        <c:choose>

            <c:when test="${not empty user.profilePhoto}">

                <img src="${pageContext.request.contextPath}/uploads/profile/${user.profilePhoto}"
                     alt="Profile">

            </c:when>

            <c:otherwise>

                <div class="profile-avatar-lg">
                    ${user.fullName.charAt(0)}
                </div>

            </c:otherwise>

        </c:choose>

        <div>

            <div class="ph-name">
                ${user.fullName}
            </div>

            <div class="ph-email">

                <i class="fa-solid fa-envelope"></i>
                ${user.email}

            </div>

            <div class="ph-role">

                <span class="badge badge-info">

                    <i class="fa-solid fa-user"></i>
                    Member

                </span>

                <span class="badge badge-success">

                    <i class="fa-solid fa-circle-check"></i>
                    ${user.status}

                </span>

            </div>

        </div>

    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>

    <!-- Tabs -->
    <div class="profile-tabs">

        <button class="profile-tab active"
                onclick="showTab('editTab',this)">

            <i class="fa-solid fa-user-pen"></i>
            Edit Profile

        </button>

        <button class="profile-tab"
                onclick="showTab('pwdTab',this)">

            <i class="fa-solid fa-lock"></i>
            Change Password

        </button>

    </div>

    <!-- Edit Profile -->
    <div id="editTab" class="profile-section active">

        <!-- Photo Card -->
        <div class="card" style="margin-bottom:1.5rem;">

            <div class="card-header">

                <h2>

                    <i class="fa-solid fa-camera"></i>
                    Profile Photo

                </h2>

            </div>

            <div class="card-body">

                <form action="${pageContext.request.contextPath}/member/profile"
                      method="post"
                      enctype="multipart/form-data">

                    <input type="hidden" name="action" value="updatePhoto">

                    <div class="upload-box">

                        <c:choose>

                            <c:when test="${not empty user.profilePhoto}">

                                <img src="${pageContext.request.contextPath}/uploads/profile/${user.profilePhoto}"
                                     alt="Profile photo"
                                     style="width:110px;height:110px;border-radius:50%;object-fit:cover;border:4px solid #ef4444;">

                            </c:when>

                            <c:otherwise>

                                <div class="profile-avatar-lg"
                                     style="width:110px;height:110px;">

                                    ${user.fullName.charAt(0)}

                                </div>

                            </c:otherwise>

                        </c:choose>

                        <div class="upload-content">

                            <label>

                                <i class="fa-solid fa-upload"></i>
                                Upload New Photo

                            </label>

                            <input type="file"
                                   name="profilePhoto"
                                   accept="image/*"
                                   class="form-control"
                                   required>

                            <small class="helper-text">
                                Max 5 MB. JPG, PNG, or GIF only.
                            </small>

                            <button type="submit"
                                    class="btn btn-primary"
                                    style="margin-top:1rem;">

                                <i class="fa-solid fa-cloud-arrow-up"></i>
                                Upload Photo

                            </button>

                        </div>

                    </div>

                </form>

            </div>

        </div>

        <!-- Edit Profile Card -->
        <div class="card">

            <div class="card-header">

                <h2>

                    <i class="fa-solid fa-user-gear"></i>
                    Edit Profile

                </h2>

            </div>

            <div class="card-body">

                <form action="${pageContext.request.contextPath}/member/profile"
                      method="post">

                    <input type="hidden"
                           name="action"
                           value="updateProfile">

                    <div class="form-row">

                        <div class="form-group">

                            <label>

                                <i class="fa-solid fa-user"></i>
                                Full Name *

                            </label>

                            <input type="text"
                                   name="fullName"
                                   class="form-control"
                                   value="${user.fullName}"
                                   required>

                        </div>

                        <div class="form-group">

                            <label>

                                <i class="fa-solid fa-phone"></i>
                                Phone *

                            </label>

                            <input type="text"
                                   name="phone"
                                   class="form-control"
                                   value="${user.phone}"
                                   maxlength="10"
                                   required>

                        </div>

                    </div>

                    <div class="form-row">

                        <div class="form-group">

                            <label>

                                <i class="fa-solid fa-calendar"></i>
                                Date of Birth

                            </label>

                            <input type="date"
                                   name="dateOfBirth"
                                   class="form-control"
                                   value="<fmt:formatDate value='${user.dateOfBirth}' pattern='yyyy-MM-dd'/>">

                        </div>

                        <div class="form-group">

                            <label>

                                <i class="fa-solid fa-venus-mars"></i>
                                Gender

                            </label>

                            <select name="gender"
                                    class="form-control">

                                <option value="Male"
                                    ${user.gender eq 'Male' ? 'selected' : ''}>
                                    Male
                                </option>

                                <option value="Female"
                                    ${user.gender eq 'Female' ? 'selected' : ''}>
                                    Female
                                </option>

                                <option value="Other"
                                    ${user.gender eq 'Other' ? 'selected' : ''}>
                                    Other
                                </option>

                            </select>

                        </div>

                    </div>

                    <div class="form-group">

                        <label>

                            <i class="fa-solid fa-envelope"></i>
                            Email

                        </label>

                        <input type="email"
                               class="form-control"
                               value="${user.email}"
                               disabled>

                    </div>

                    <div class="form-group">

                        <label>

                            <i class="fa-solid fa-location-dot"></i>
                            Address

                        </label>

                        <textarea name="address"
                                  class="form-control">${user.address}</textarea>

                    </div>

                    <button type="submit"
                            class="btn btn-primary">

                        <i class="fa-solid fa-floppy-disk"></i>
                        Save Changes

                    </button>

                </form>

            </div>

        </div>

    </div>

    <!-- Password Tab -->
    <div id="pwdTab" class="profile-section">

        <div class="card">

            <div class="card-header">

                <h2>

                    <i class="fa-solid fa-lock"></i>
                    Change Password

                </h2>

            </div>

            <div class="card-body">

                <form action="${pageContext.request.contextPath}/member/profile"
                      method="post"
                      style="max-width:500px;">

                    <input type="hidden"
                           name="action"
                           value="changePassword">

                    <div class="form-group">

                        <label>

                            <i class="fa-solid fa-key"></i>
                            Current Password *

                        </label>

                        <input type="password"
                               name="currentPassword"
                               class="form-control"
                               required>

                    </div>

                    <div class="form-group">

                        <label>

                            <i class="fa-solid fa-lock"></i>
                            New Password *

                        </label>

                        <input type="password"
                               name="newPassword"
                               class="form-control"
                               placeholder="Min 8 chars, upper, lower, number, special"
                               required>

                    </div>

                    <div class="form-group">

                        <label>

                            <i class="fa-solid fa-shield-halved"></i>
                            Confirm New Password *

                        </label>

                        <input type="password"
                               name="confirmPassword"
                               class="form-control"
                               required>

                    </div>

                    <button type="submit"
                            class="btn btn-primary">

                        <i class="fa-solid fa-lock"></i>
                        Change Password

                    </button>

                </form>

            </div>

        </div>

    </div>

</div>

<script>

    function showTab(tabId, btn){

        document.querySelectorAll('.profile-section')
            .forEach(function(section){
                section.classList.remove('active');
            });

        document.querySelectorAll('.profile-tab')
            .forEach(function(tab){
                tab.classList.remove('active');
            });

        document.getElementById(tabId)
            .classList.add('active');

        btn.classList.add('active');
    }

</script>

<%@ include file="/WEB-INF/views/shared/memberFooter.jsp" %>
