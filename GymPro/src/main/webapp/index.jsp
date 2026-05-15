<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />

<c:set var="pageTitle"  value="GymPro — Your Fitness Journey"  scope="request"/>
<c:set var="pageCSS"    value="public"                          scope="request"/>
<c:set var="activePage" value="home"                            scope="request"/>
<%@ include file="/WEB-INF/views/shared/publicHeader.jsp" %>


<style>
    html, body          { margin: 0; padding: 0; }
    main                { margin: 0 !important; padding: 0 !important; }
    main > section      { margin: 0 !important; }
    footer              { margin-top: 0 !important; }
</style>

<%-- Hero Section --%>
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

<%-- Features Section --%>
<section class="section" style="background:#fff;margin:0;padding:4rem 2rem;">
    <div class="section-inner">
        <h2 class="section-heading">Everything You Need</h2>
        <p class="section-sub">GymPro brings your entire fitness experience into one platform.</p>
        <div class="features-grid">

            <div class="feature-card">
                <div class="feature-icon" style="width:64px;height:64px;border-radius:50%;background:#fde8e8;display:flex;align-items:center;justify-content:center;margin:0 auto 16px;font-size:26px;color:#c0392b;">
                    <i class="fa-solid fa-dumbbell"></i>
                </div>
                <h3>Expert Trainers</h3>
                <p>Our certified trainers aren't just coaches — they're your personal cheerleaders. Whether you're picking up a barbell for the first time or pushing past a plateau, they'll build a plan around your goals, your schedule, and your body. From strength and HIIT to yoga and mobility, there's someone here who gets you.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon" style="width:64px;height:64px;border-radius:50%;background:#fde8e8;display:flex;align-items:center;justify-content:center;margin:0 auto 16px;font-size:26px;color:#c0392b;">
                    <i class="fa-solid fa-calendar-check"></i>
                </div>
                <h3>Class Scheduling</h3>
                <p>No more guessing when your favorite class runs. Browse the full weekly schedule, grab a spot in seconds, and get a reminder before it starts — all from your member portal. Life gets busy, so if plans change, cancelling is just as easy. Your time matters, and we treat it that way.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon" style="width:64px;height:64px;border-radius:50%;background:#fde8e8;display:flex;align-items:center;justify-content:center;margin:0 auto 16px;font-size:26px;color:#c0392b;">
                    <i class="fa-solid fa-layer-group"></i>
                </div>
                <h3>Flexible Plans</h3>
                <p>We know one size doesn't fit all — especially when it comes to budgets and lifestyles. Pick from monthly, quarterly, or annual memberships with no hidden fees and no pressure. Need to pause for a holiday or a hectic month at work? We've got options for that too. Your membership, your way.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon" style="width:64px;height:64px;border-radius:50%;background:#fde8e8;display:flex;align-items:center;justify-content:center;margin:0 auto 16px;font-size:26px;color:#c0392b;">
                    <i class="fa-solid fa-chart-line"></i>
                </div>
                <h3>Progress Tracking</h3>
                <p>Seeing your progress laid out in front of you is one of the best motivators out there. Your personal dashboard logs every class attended, every milestone hit, and every streak kept alive. Look back at how far you've come — and use it as fuel to keep going. Growth looks good on you.</p>
            </div>

        </div>
    </div>
</section>


<section style="background:#2a2a2a;text-align:center;padding:4rem 2rem;margin:0;">
    <h2 style="color:#fff;font-size:2rem;font-weight:800;margin-bottom:1rem;">Ready to Start?</h2>
    <p style="color:#bbb;margin-bottom:1.5rem;">Join GymPro today and take the first step toward a healthier you.</p>
    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary" style="padding:.85rem 2rem;font-size:1rem;">
        Get Started &rarr;
    </a>
</section>

<%@ include file="/WEB-INF/views/shared/publicFooter.jsp" %>
