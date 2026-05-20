<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle"  value="GymPro — Your Fitness Journey"  scope="request"/>
<c:set var="pageCSS"    value="public"                          scope="request"/>
<c:set var="activePage" value="home"                            scope="request"/>
<%@ include file="/WEB-INF/views/shared/publicHeader.jsp" %>

<!-- Hero -->
<section class="hero">
    <h1>Transform Your Body<br>with <span>GymPro</span></h1>
    <p>State-of-the-art facilities, expert trainers, and flexible membership plans designed for your goals.</p>
    <div class="hero-btns">
        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Join Now — It's Free</a>
        <a href="${pageContext.request.contextPath}/about"    class="btn btn-outline" style="color:#fff;border-color:#fff;">Learn More</a>
    </div>
    <div class="hero-stats">
        <div class="hero-stat"><span class="hs-num">500+</span><span class="hs-lbl">Members</span></div>
        <div class="hero-stat"><span class="hs-num">10+</span><span class="hs-lbl">Expert Trainers</span></div>
        <div class="hero-stat"><span class="hs-num">30+</span><span class="hs-lbl">Weekly Classes</span></div>
        <div class="hero-stat"><span class="hs-num">5&#x2605;</span><span class="hs-lbl">Rated</span></div>
    </div>
</section>

<!-- Features -->
<section class="section" style="background:#fff;">
    <div class="section-inner">
        <h2 class="section-heading">Everything You Need</h2>
        <p class="section-sub">GymPro brings your entire fitness experience into one platform.</p>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">&#x1F3CB;</div>
                <h3>Expert Trainers</h3>
                <p>Certified professionals specializing in strength, yoga, cardio and more.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">&#x1F4C5;</div>
                <h3>Class Scheduling</h3>
                <p>Browse and enroll in upcoming classes directly from your member portal.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">&#x1F4B3;</div>
                <h3>Flexible Plans</h3>
                <p>Monthly, quarterly, and annual membership options to suit your lifestyle.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">&#x1F4CA;</div>
                <h3>Progress Tracking</h3>
                <p>View your attendance history and class records from your personal dashboard.</p>
            </div>
        </div>
    </div>
</section>

<!-- CTA -->
<section class="section" style="background:var(--dark);text-align:center;padding:4rem 2rem;">
    <h2 style="color:#fff;font-size:2rem;font-weight:800;margin-bottom:1rem;">Ready to Start?</h2>
    <p style="color:#aaa;margin-bottom:1.5rem;">Join GymPro today and take the first step toward a healthier you.</p>
    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary" style="padding:.85rem 2rem;font-size:1rem;">
        Get Started &rarr;
    </a>
</section>

<%@ include file="/WEB-INF/views/shared/publicFooter.jsp" %>
