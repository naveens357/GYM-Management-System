<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%-- Reusable Member Header/Navbar + Sidebar fragment --%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty pageTitle ? pageTitle : 'Member'} — GymPro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/${not empty pageCSS ? pageCSS : 'member-dashboard'}.css">
</head>
<body>

<nav class="navbar">
    <a href="${pageContext.request.contextPath}/member/dashboard" class="navbar-brand">Gym<span>Pro</span></a>
    <button class="navbar-toggle" onclick="toggleNav()" aria-label="Menu">
        <span></span><span></span><span></span>
    </button>
    <ul class="navbar-nav">
        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
        <li><a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm" style="margin-left:0.5rem;">Logout</a></li>
    </ul>
</nav>

<div class="layout">
    <aside class="sidebar" id="sidebar">
        <div style="padding:1.25rem 1.5rem;border-bottom:1px solid #3a3a3a;margin-bottom:0.5rem;">
            <div style="color:#fff;font-weight:700;font-size:0.95rem;">${sessionScope.loggedUser.fullName}</div>
            <div style="color:#888;font-size:0.78rem;margin-top:0.2rem;">Member</div>
        </div>
        <div class="sidebar-title">My Portal</div>
        <a href="${pageContext.request.contextPath}/member/dashboard" class="${activePage eq 'dashboard' ? 'active' : ''}"><span class="icon">&#x1F3E0;</span> Dashboard</a>
        <a href="${pageContext.request.contextPath}/member/classes"   class="${activePage eq 'classes'   ? 'active' : ''}"><span class="icon">&#x1F4C5;</span> Browse Classes</a>
        <a href="${pageContext.request.contextPath}/member/memberships" class="${activePage eq 'memberships' ? 'active' : ''}"><span class="icon">&#x1F4B3;</span> My Memberships</a>
        <a href="${pageContext.request.contextPath}/member/profile"   class="${activePage eq 'profile'   ? 'active' : ''}"><span class="icon">&#x1F464;</span> My Profile</a>
        <div class="sidebar-title" style="margin-top:1rem;">Info</div>
        <a href="${pageContext.request.contextPath}/about"><span class="icon">&#x2139;</span> About Us</a>
        <a href="${pageContext.request.contextPath}/contact"><span class="icon">&#x2709;</span> Contact</a>
        <a href="${pageContext.request.contextPath}/logout"><span class="icon">&#x1F511;</span> Logout</a>
    </aside>

    <main class="main-content">
