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

<!-- Font Awesome (add in <head> if not already there) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet" />

<section style="padding: 60px 24px; text-align: center; background: #1a0000; font-family: 'DM Sans', sans-serif;">

  <span style="display: inline-block; font-size: 11px; font-weight: 600; letter-spacing: 0.12em; text-transform: uppercase; color: #ff6b6b; background: #3a0a0a; padding: 4px 14px; border-radius: 20px; margin-bottom: 16px; border: 1px solid #7a1a1a;">
    Platform
  </span>

  <h2 style="font-family: 'Bebas Neue', sans-serif; font-size: 52px; font-weight: 400; letter-spacing: 0.02em; color: #ffffff; margin: 0 0 10px; line-height: 1.1;">
    Everything You Need
  </h2>

  <p style="font-size: 15px; color: #cc8888; margin: 0 auto 40px; max-width: 440px; line-height: 1.6;">
    GymPro brings your entire fitness experience into one platform.
  </p>

  <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px; max-width: 960px; margin: 0 auto;">

    <div style="background: #2a0505; border: 1px solid #5a1010; border-radius: 16px; padding: 32px 20px 28px; text-align: center;">
      <div style="width: 64px; height: 64px; border-radius: 50%; background: #3a0808; color: #ff4444; display: flex; align-items: center; justify-content: center; margin: 0 auto 18px; font-size: 24px;">
        <i class="fa-solid fa-dumbbell"></i>
      </div>
      <p style="font-size: 16px; font-weight: 600; color: #ffffff; margin: 0 0 10px;">Expert Trainers</p>
      <p style="font-size: 13px; color: #aa6666; line-height: 1.65; margin: 0;">Certified professionals specializing in strength, yoga, cardio and more.</p>
    </div>

    <div style="background: #2a0505; border: 1px solid #5a1010; border-radius: 16px; padding: 32px 20px 28px; text-align: center;">
      <div style="width: 64px; height: 64px; border-radius: 50%; background: #3d0a0a; color: #ff6666; display: flex; align-items: center; justify-content: center; margin: 0 auto 18px; font-size: 24px;">
        <i class="fa-solid fa-calendar-check"></i>
      </div>
      <p style="font-size: 16px; font-weight: 600; color: #ffffff; margin: 0 0 10px;">Class Scheduling</p>
      <p style="font-size: 13px; color: #aa6666; line-height: 1.65; margin: 0;">Browse and enroll in upcoming classes directly from your member portal.</p>
    </div>

    <div style="background: #2a0505; border: 1px solid #5a1010; border-radius: 16px; padding: 32px 20px 28px; text-align: center;">
      <div style="width: 64px; height: 64px; border-radius: 50%; background: #350606; color: #ff5555; display: flex; align-items: center; justify-content: center; margin: 0 auto 18px; font-size: 24px;">
        <i class="fa-solid fa-layer-group"></i>
      </div>
      <p style="font-size: 16px; font-weight: 600; color: #ffffff; margin: 0 0 10px;">Flexible Plans</p>
      <p style="font-size: 13px; color: #aa6666; line-height: 1.65; margin: 0;">Monthly, quarterly, and annual membership options to suit your lifestyle.</p>
    </div>

    <div style="background: #2a0505; border: 1px solid #5a1010; border-radius: 16px; padding: 32px 20px 28px; text-align: center;">
      <div style="width: 64px; height: 64px; border-radius: 50%; background: #3a0505; color: #ff3333; display: flex; align-items: center; justify-content: center; margin: 0 auto 18px; font-size: 24px;">
        <i class="fa-solid fa-chart-line"></i>
      </div>
      <p style="font-size: 16px; font-weight: 600; color: #ffffff; margin: 0 0 10px;">Progress Tracking</p>
      <p style="font-size: 13px; color: #aa6666; line-height: 1.65; margin: 0;">View your attendance history and class records from your personal dashboard.</p>
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
