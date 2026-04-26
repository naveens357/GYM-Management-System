<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle"  value="About Us — GymPro" scope="request"/>
<c:set var="pageCSS"    value="public"             scope="request"/>
<c:set var="activePage" value="about"              scope="request"/>
<%@ include file="/WEB-INF/views/shared/publicHeader.jsp" %>

<div style="background:var(--dark);color:#fff;padding:3rem 2rem;text-align:center;">
    <h1 style="font-size:2.5rem;font-weight:900;">About <span style="color:var(--primary);">GymPro</span></h1>
    <p style="color:#aaa;margin-top:.5rem;max-width:550px;margin-inline:auto;">We are more than a gym — we are a community built around your goals.</p>
</div>

<section class="section">
    <div class="section-inner">
        <div class="about-grid">
            <div class="about-img-box">&#x1F3CB;</div>
            <div class="about-text">
                <h2>Our Story</h2>
                <p>GymPro was founded in 2018 with a simple mission: make professional fitness accessible to everyone in Kathmandu. What started as a small studio has grown into a full-featured fitness management platform.</p>
                <p>We believe that fitness is not a destination — it's a lifelong journey. Our team of dedicated trainers and state-of-the-art facilities are here to support every step of that journey.</p>
                <div class="about-values">
                    <div class="value-item"><h4>&#x1F3AF; Focus</h4><p>Goal-oriented training for measurable results.</p></div>
                    <div class="value-item"><h4>&#x1F91D; Community</h4><p>A welcoming space for all fitness levels.</p></div>
                    <div class="value-item"><h4>&#x1F4AA; Excellence</h4><p>World-class trainers and equipment.</p></div>
                    <div class="value-item"><h4>&#x1F4A1; Innovation</h4><p>Technology-driven fitness management.</p></div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="section" style="background:#fff;">
    <div class="section-inner">
        <h2 class="section-heading">Our Team</h2>
        <p class="section-sub">Expert trainers committed to your success.</p>
        <div class="team-grid">
            <div class="trainer-card">
                <div class="trainer-avatar">R</div>
                <h3>Nishan Bhusal</h3>
                <p style="color:var(--primary);font-size:.85rem;font-weight:600;">Strength &amp; Conditioning</p>
                <p style="font-size:.83rem;color:var(--gray);margin-top:.5rem;">5 years experience. Certified personal trainer.</p>
            </div>
            <div class="trainer-card">
                <div class="trainer-avatar">S</div>
                <h3>Ayush Dhimal</h3>
                <p style="color:var(--primary);font-size:.85rem;font-weight:600;">Yoga &amp; Flexibility</p>
                <p style="font-size:.83rem;color:var(--gray);margin-top:.5rem;">4 years experience. Mindfulness yoga specialist.</p>
            </div>
            <div class="trainer-card">
                <div class="trainer-avatar">B</div>
                <h3> Sachin Bashyal</h3>
                <p style="color:var(--primary);font-size:.85rem;font-weight:600;">Cardio &amp; HIIT</p>
                <p style="font-size:.83rem;color:var(--gray);margin-top:.5rem;">6 years experience. High-energy HIIT expert.</p>
            </div>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/views/shared/publicFooter.jsp" %>
