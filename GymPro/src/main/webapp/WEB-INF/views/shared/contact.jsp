<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle"  value="Contact Us — GymPro" scope="request"/>
<c:set var="pageCSS"    value="public"               scope="request"/>
<c:set var="activePage" value="contact"              scope="request"/>
<%@ include file="/WEB-INF/views/shared/publicHeader.jsp" %>


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

<style>
    .contact-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 2rem;
        align-items: stretch; /* makes both columns to the same height */
    }

    .contact-info-box,
    .contact-grid .card {
        height: 100%;          
        box-sizing: border-box;
    }

    .ci-item {
        display: flex;
        align-items: center;
        gap: .65rem;
    }

    .ci-icon {
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
        width: 1.25rem;
        font-size: 1rem;
        line-height: 1;
    }
</style>

<div style="background:var(--dark);color:#fff;padding:3rem 2rem;text-align:center;">
    <h1 style="font-size:2.5rem;font-weight:900;">Contact <span style="color:var(--primary);">Us</span></h1>
    <p style="color:#aaa;margin-top:.5rem;">We'd love to hear from you. Send us a message below.</p>
</div>

<section class="section">
    <div class="section-inner">
        <c:if test="${not empty error}">  <div class="alert alert-danger">${error}</div>   </c:if>
        <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>

        <div class="contact-grid">
            <!-- Info Box -->
            <div class="contact-info-box">
                <h3>Get in Touch</h3>
                <div class="ci-item"><span class="ci-icon"><i class="fa-solid fa-location-dot"></i></span><span>Thamel, Kathmandu, Nepal</span></div>
                <div class="ci-item"><span class="ci-icon"><i class="fa-solid fa-phone"></i></span><span>+977-9800000000</span></div>
                <div class="ci-item"><span class="ci-icon"><i class="fa-solid fa-envelope"></i></span><span>info@gympro.com</span></div>
                <div class="ci-item"><span class="ci-icon"><i class="fa-regular fa-clock"></i></span><span>Mon–Sat: 5:30 AM – 9:00 PM</span></div>
                <div style="margin-top:1.5rem;padding-top:1.5rem;border-top:1px solid #333;">
                    <div style="font-weight:700;color:#fff;margin-bottom:.75rem;">Why Contact Us?</div>
                    <div class="ci-item"><span class="ci-icon"><i class="fa-solid fa-circle-info"></i></span><span>Membership inquiries</span></div>
                    <div class="ci-item"><span class="ci-icon"><i class="fa-solid fa-circle-info"></i></span><span>Class scheduling questions</span></div>
                    <div class="ci-item"><span class="ci-icon"><i class="fa-solid fa-circle-info"></i></span><span>Personal training packages</span></div>
                    <div class="ci-item"><span class="ci-icon"><i class="fa-solid fa-circle-info"></i></span><span>General feedback</span></div>
                </div>
            </div>

            <!-- Contact Form -->
            <div class="card" style="margin-bottom:0;">
                <div class="card-header"><h2>Send a Message</h2></div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/contact" method="post" novalidate>
                        <div class="form-row">
                            <div class="form-group">
                                <label>Your Name *</label>
                                <input type="text" name="name" class="form-control"
                                       placeholder="Full Name" required
                                       value="${not empty param.name ? param.name : ''}">
                            </div>
                            <div class="form-group">
                                <label>Email Address *</label>
                                <input type="email" name="email" class="form-control"
                                       placeholder="you@example.com" required
                                       value="${not empty param.email ? param.email : ''}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Subject *</label>
                            <input type="text" name="subject" class="form-control"
                                   placeholder="What is this about?" required
                                   value="${not empty param.subject ? param.subject : ''}">
                        </div>
                        <div class="form-group">
                            <label>Message *</label>
                            <textarea name="message" class="form-control"
                                      placeholder="Write your message here..." required
                                      style="min-height:130px;">${not empty param.message ? param.message : ''}</textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Send Message &#x2192;</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/views/shared/publicFooter.jsp" %>
