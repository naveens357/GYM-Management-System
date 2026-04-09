<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle"  value="My Memberships"  scope="request"/>
<c:set var="pageCSS"    value="member-dashboard" scope="request"/>
<c:set var="activePage" value="memberships"     scope="request"/>
<%@ include file="/WEB-INF/views/shared/memberHeader.jsp" %>

<div class="page-header">
    <div><h1>&#x1F4B3; My Memberships</h1><p>Your membership history and current plan.</p></div>
</div>

<c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

<!-- Available Plans -->
<div class="card">
    <div class="card-header"><h2>Available Plans</h2></div>
    <div class="card-body">
        <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(200px,1fr));gap:1rem;">
            <c:forEach var="plan" items="${plans}">
            <div style="background:var(--light);border-radius:var(--radius);padding:1.25rem;border-top:3px solid var(--primary);text-align:center;">
                <div style="font-size:1.05rem;font-weight:700;">${plan.planName}</div>
                <div style="font-size:1.6rem;font-weight:900;color:var(--primary);margin:.4rem 0;">
                    Rs. <fmt:formatNumber value="${plan.price}" pattern="#,##0"/>
                </div>
                <div style="font-size:.82rem;color:var(--gray);">${plan.durationMonths} month(s)</div>
                <div style="font-size:.8rem;color:var(--gray);margin-top:.4rem;">${plan.description}</div>
            </div>
            </c:forEach>
        </div>
        <p style="font-size:.85rem;color:var(--gray);margin-top:1rem;">
            &#x2139; To purchase a plan, contact an admin or visit the front desk.
        </p>
    </div>
</div>

<!-- My Membership History -->
<div class="card">
    <div class="card-header"><h2>My Membership History</h2></div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty memberships}">
                <p class="no-data">No membership records found. Contact admin to get started.</p>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr><th>Plan</th><th>Start Date</th><th>End Date</th><th>Amount</th><th>Payment</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="m" items="${memberships}">
                            <tr>
                                <td><strong>${m.planName}</strong></td>
                                <td><fmt:formatDate value="${m.startDate}" pattern="dd MMM yyyy"/></td>
                                <td><fmt:formatDate value="${m.endDate}"   pattern="dd MMM yyyy"/></td>
                                <td>Rs. <fmt:formatNumber value="${not empty m.amountPaid ? m.amountPaid : m.planPrice}" pattern="#,##0"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${m.paymentStatus eq 'paid'}">   <span class="badge badge-success">&#10003; Paid</span></c:when>
                                        <c:when test="${m.paymentStatus eq 'pending'}"><span class="badge badge-warning">&#9201; Pending</span></c:when>
                                        <c:otherwise>                                  <span class="badge badge-danger">&#9888; Overdue</span></c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="/WEB-INF/views/shared/memberFooter.jsp" %>
