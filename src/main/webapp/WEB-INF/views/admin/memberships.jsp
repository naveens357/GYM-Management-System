<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle"  value="Memberships"       scope="request"/>
<c:set var="pageCSS"    value="admin-memberships" scope="request"/>
<c:set var="activePage" value="memberships"       scope="request"/>
<%@ include file="/WEB-INF/views/shared/adminHeader.jsp" %>

<div class="page-header">
    <div><h1>&#x1F4B3; Memberships</h1><p>Manage plans and member subscriptions.</p></div>
    <div style="display:flex;gap:.5rem;">
        <button class="btn btn-secondary" onclick="openModal('addPlanModal')">&#x2795; Add Plan</button>
        <button class="btn btn-primary"   onclick="openModal('assignModal')">&#x1F4CB; Assign Membership</button>
    </div>
</div>

<c:if test="${not empty error}">  <div class="alert alert-danger">${error}</div>  </c:if>
<c:if test="${not empty param.success}"><div class="alert alert-success">Operation completed successfully.</div></c:if>

<!-- Plan Cards -->
<h2 style="font-size:1.1rem;font-weight:700;margin-bottom:1rem;">Membership Plans</h2>
<div class="plan-cards">
    <c:forEach var="plan" items="${plans}">
    <div class="plan-card ${not plan.active ? 'plan-inactive' : ''}">
        <h3>${plan.planName}</h3>
        <div class="plan-price">Rs. <fmt:formatNumber value="${plan.price}" pattern="#,##0"/></div>
        <div class="plan-duration">${plan.durationMonths} month(s)</div>
        <p style="font-size:.82rem;color:var(--gray);">${plan.description}</p>
        <div class="plan-actions">
            <form action="${pageContext.request.contextPath}/admin/memberships" method="post"
                  onsubmit="return confirm('Delete plan ${plan.planName}?')">
                <input type="hidden" name="action" value="deletePlan">
                <input type="hidden" name="planId" value="${plan.planId}">
                <button class="btn btn-danger btn-sm">&#x1F5D1; Delete</button>
            </form>
        </div>
        <c:if test="${not plan.active}">
            <span class="badge badge-secondary" style="margin-top:.5rem;">Inactive</span>
        </c:if>
    </div>
    </c:forEach>
</div>

<!-- Member Memberships Table -->
<div class="card">
    <div class="card-header"><h2>Member Subscriptions</h2></div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty memberships}">
                <p class="no-data">No memberships assigned yet.</p>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr><th>Member</th><th>Plan</th><th>Start</th><th>End</th><th>Amount</th><th>Payment</th><th>Actions</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="m" items="${memberships}">
                            <tr>
                                <td><strong>${m.userName}</strong></td>
                                <td>${m.planName}</td>
                                <td><fmt:formatDate value="${m.startDate}" pattern="dd MMM yyyy"/></td>
                                <td><fmt:formatDate value="${m.endDate}"   pattern="dd MMM yyyy"/></td>
                                <td>Rs. <fmt:formatNumber value="${not empty m.amountPaid ? m.amountPaid : m.planPrice}" pattern="#,##0"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${m.paymentStatus eq 'paid'}">   <span class="payment-paid">&#10003; Paid</span></c:when>
                                        <c:when test="${m.paymentStatus eq 'pending'}"><span class="payment-pending">&#9201; Pending</span></c:when>
                                        <c:otherwise>                                  <span class="payment-overdue">&#9888; Overdue</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${m.paymentStatus ne 'paid'}">
                                        <form action="${pageContext.request.contextPath}/admin/memberships" method="post" style="display:inline;">
                                            <input type="hidden" name="action"        value="updatePayment">
                                            <input type="hidden" name="membershipId"  value="${m.membershipId}">
                                            <input type="hidden" name="paymentStatus" value="paid">
                                            <button class="btn btn-success btn-sm">&#10003; Mark Paid</button>
                                        </form>
                                    </c:if>
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

<!-- Adding Plan Modal -->
<div class="modal-overlay" id="addPlanModal">
    <div class="modal-box">
        <div class="modal-header">
            <h3>&#x2795; Add Membership Plan</h3>
            <button class="modal-close" onclick="closeModal('addPlanModal')">&times;</button>
        </div>
        <form action="${pageContext.request.contextPath}/admin/memberships" method="post">
            <input type="hidden" name="action" value="addPlan">
            <div class="form-group">
                <label>Plan Name *</label>
                <input type="text" name="planName" class="form-control" placeholder="e.g. Premium" required>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Duration (Months) *</label>
                    <input type="number" name="durationMonths" class="form-control" min="1" max="24" required>
                </div>
                <div class="form-group">
                    <label>Price (Rs.) *</label>
                    <input type="number" name="price" class="form-control" min="0" step="0.01" required>
                </div>
            </div>
            <div class="form-group">
                <label>Description</label>
                <textarea name="description" class="form-control" placeholder="What does this plan include?"></textarea>
            </div>
            <div style="display:flex;gap:.75rem;justify-content:flex-end;">
                <button type="button" class="btn btn-secondary" onclick="closeModal('addPlanModal')">Cancel</button>
                <button type="submit" class="btn btn-primary">Add Plan</button>
            </div>
        </form>
    </div>
</div>

<!-- Assigning Membership Modal -->
<div class="modal-overlay" id="assignModal">
    <div class="modal-box">
        <div class="modal-header">
            <h3>&#x1F4CB; Assign Membership</h3>
            <button class="modal-close" onclick="closeModal('assignModal')">&times;</button>
        </div>
        <form action="${pageContext.request.contextPath}/admin/memberships" method="post">
            <input type="hidden" name="action" value="assign">
            <div class="form-group">
                <label>Member *</label>
                <select name="userId" class="form-control" required>
                    <option value="">-- Select Member --</option>
                    <c:forEach var="m" items="${members}">
                        <c:if test="${m.status eq 'approved'}">
                            <option value="${m.userId}">${m.fullName} (${m.email})</option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>Membership Plan *</label>
                <select name="planId" class="form-control" required>
                    <option value="">-- Select Plan --</option>
                    <c:forEach var="plan" items="${plans}">
                        <c:if test="${plan.active}">
                            <option value="${plan.planId}">${plan.planName} — Rs. <fmt:formatNumber value="${plan.price}" pattern="#,##0"/> (${plan.durationMonths} mo)</option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>Start Date *</label>
                <input type="date" name="startDate" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Payment Status</label>
                <select name="paymentStatus" class="form-control">
                    <option value="paid">Paid</option>
                    <option value="pending">Pending</option>
                </select>
            </div>
            <div style="display:flex;gap:.75rem;justify-content:flex-end;">
                <button type="button" class="btn btn-secondary" onclick="closeModal('assignModal')">Cancel</button>
                <button type="submit" class="btn btn-primary">Assign</button>
            </div>
        </form>
    </div>
</div>

<%@ include file="/WEB-INF/views/shared/adminFooter.jsp" %>
