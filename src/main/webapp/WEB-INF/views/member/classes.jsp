<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle"  value="Browse Classes" scope="request"/>
<c:set var="pageCSS"    value="member-classes" scope="request"/>
<c:set var="activePage" value="classes"        scope="request"/>

<%@ include file="/WEB-INF/views/shared/memberHeader.jsp" %>

<!-- Font Awesome -->
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
    .page-header{
        margin-bottom: 1.5rem;
    }

    .page-header h1{
        display:flex;
        align-items:center;
        gap:.7rem;
        font-size:2rem;
        margin-bottom:.4rem;
    }

    .page-header p{
        color:#777;
        font-size:1rem;
    }

    .classes-grid{
        display:grid;
        grid-template-columns:repeat(auto-fit,minmax(300px,1fr));
        gap:1.5rem;
        width:100%;
    }

    .class-tile{
        background:#fff;
        border-radius:16px;
        padding:1.5rem;
        box-shadow:0 4px 12px rgba(0,0,0,0.08);
        border-top:4px solid #ef4444;
        display:flex;
        flex-direction:column;
        justify-content:space-between;
        transition:.3s ease;
        min-height:280px;
    }

    .class-tile:hover{
        transform:translateY(-4px);
        box-shadow:0 8px 18px rgba(0,0,0,0.12);
    }

    .class-tile h3{
        font-size:1.4rem;
        margin-bottom:1rem;
        color:#111827;
    }

    .ct-trainer{
        margin-bottom:.8rem;
        color:#ef4444;
        font-weight:600;
        display:flex;
        align-items:center;
        gap:.5rem;
    }

    .ct-meta{
        color:#6b7280;
        line-height:1.9;
        font-size:.95rem;
    }

    .ct-meta i{
        width:18px;
        color:#ef4444;
    }

    .spots-badge{
        display:inline-block;
        padding:.45rem .85rem;
        border-radius:999px;
        font-size:.85rem;
        font-weight:600;
    }

    .spots-full{
        background:#fee2e2;
        color:#dc2626;
    }

    .spots-low{
        background:#fef3c7;
        color:#d97706;
    }

    .spots-ok{
        background:#dcfce7;
        color:#15803d;
    }

    .ct-actions{
        margin-top:1.4rem;
    }

    .btn{
        border:none;
        padding:.8rem 1.2rem;
        border-radius:10px;
        font-weight:600;
        cursor:pointer;
        transition:.3s;
    }

    .btn i{
        margin-right:.4rem;
    }

    .btn-primary{
        background:#ef4444;
        color:white;
    }

    .btn-primary:hover{
        background:#dc2626;
    }

    .btn-secondary{
        background:#e5e7eb;
        color:#374151;
    }

    .btn-secondary:hover{
        background:#d1d5db;
    }

    .btn:disabled{
        opacity:.7;
        cursor:not-allowed;
    }

    .enrolled-indicator{
        background:#dcfce7;
        color:#15803d;
        padding:.3rem .7rem;
        border-radius:999px;
        font-size:.75rem;
        margin-left:.5rem;
        vertical-align:middle;
    }

    .no-data{
        text-align:center;
        padding:3rem;
        background:#fff;
        border-radius:14px;
        color:#6b7280;
        box-shadow:0 4px 12px rgba(0,0,0,0.05);
    }
</style>

<div class="page-header">
    <div>
        <h1>
            <i class="fa-solid fa-calendar-days"></i>
            Browse Classes
        </h1>
        <p>View upcoming classes and enroll in your favorite sessions.</p>
    </div>
</div>

<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>

<c:if test="${not empty success}">
    <div class="alert alert-success">${success}</div>
</c:if>

<!-- Upcoming Classes -->
<c:choose>

    <c:when test="${empty upcomingClasses}">
        <p class="no-data">
            No upcoming classes scheduled. Check back later.
        </p>
    </c:when>

    <c:otherwise>

        <div class="classes-grid">

            <c:forEach var="cls" items="${upcomingClasses}">

                <!-- Check enrollment -->
                <c:set var="isEnrolled" value="false"/>

                <c:forEach var="e" items="${myEnrollments}">
                    <c:if test="${e.classId eq cls.classId and e.status eq 'enrolled'}">
                        <c:set var="isEnrolled" value="true"/>
                    </c:if>
                </c:forEach>

                <div class="class-tile">

                    <div>

                        <h3>
                            ${cls.className}

                            <c:if test="${isEnrolled}">
                                <span class="enrolled-indicator">
                                    Enrolled
                                </span>
                            </c:if>
                        </h3>

                        <div class="ct-trainer">
                            <i class="fa-solid fa-dumbbell"></i>
                            ${cls.trainerName}
                        </div>

                        <div class="ct-meta">

                            <div>
                                <i class="fa-solid fa-calendar"></i>
                                <fmt:formatDate value="${cls.scheduleDatetime}" pattern="dd MMM yyyy"/>
                            </div>

                            <div>
                                <i class="fa-solid fa-clock"></i>
                                <fmt:formatDate value="${cls.scheduleDatetime}" pattern="HH:mm"/>
                                &nbsp;|&nbsp;
                                ${cls.durationMinutes} min
                            </div>

                            <c:if test="${not empty cls.description}">
                                <div>
                                    <i class="fa-solid fa-circle-info"></i>
                                    ${cls.description}
                                </div>
                            </c:if>

                        </div>

                        <div style="margin-top:1rem;">

                            <c:choose>

                                <c:when test="${cls.availableSpots <= 0}">
                                    <span class="spots-badge spots-full">
                                        FULL
                                    </span>
                                </c:when>

                                <c:when test="${cls.availableSpots <= 3}">
                                    <span class="spots-badge spots-low">
                                        ${cls.availableSpots} spots left
                                    </span>
                                </c:when>

                                <c:otherwise>
                                    <span class="spots-badge spots-ok">
                                        ${cls.availableSpots} spots available
                                    </span>
                                </c:otherwise>

                            </c:choose>

                        </div>

                    </div>

                    <div class="ct-actions">

                        <c:choose>

                            <c:when test="${isEnrolled}">

                                <form action="${pageContext.request.contextPath}/member/classes" method="post">

                                    <input type="hidden" name="action" value="cancel">
                                    <input type="hidden" name="classId" value="${cls.classId}">

                                    <button class="btn btn-secondary btn-sm">
                                        <i class="fa-solid fa-xmark"></i>
                                        Cancel Enrollment
                                    </button>

                                </form>

                            </c:when>

                            <c:when test="${cls.availableSpots <= 0}">

                                <button class="btn btn-secondary btn-sm" disabled>
                                    Class Full
                                </button>

                            </c:when>

                            <c:otherwise>

                                <form action="${pageContext.request.contextPath}/member/classes" method="post">

                                    <input type="hidden" name="action" value="enroll">
                                    <input type="hidden" name="classId" value="${cls.classId}">

                                    <button class="btn btn-primary btn-sm">
                                        <i class="fa-solid fa-check"></i>
                                        Enroll Now
                                    </button>

                                </form>

                            </c:otherwise>

                        </c:choose>

                    </div>

                </div>

            </c:forEach>

        </div>

    </c:otherwise>

</c:choose>

<%@ include file="/WEB-INF/views/shared/memberFooter.jsp" %>
