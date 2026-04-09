<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer style="background:var(--dark);color:#aaa;padding:2.5rem 2rem;margin-top:3rem;">
    <div style="max-width:1100px;margin:0 auto;display:flex;flex-wrap:wrap;gap:2rem;justify-content:space-between;">
        <div>
            <div style="font-size:1.4rem;font-weight:800;color:#fff;margin-bottom:0.5rem;">Gym<span style="color:var(--primary);">Pro</span></div>
            <div style="font-size:0.85rem;">Your fitness journey starts here.</div>
        </div>
        <div>
            <div style="font-weight:700;color:#fff;margin-bottom:0.5rem;">Quick Links</div>
            <div style="display:flex;flex-direction:column;gap:0.3rem;font-size:0.85rem;">
                <a href="${pageContext.request.contextPath}/"       style="color:#aaa;">Home</a>
                <a href="${pageContext.request.contextPath}/about"  style="color:#aaa;">About</a>
                <a href="${pageContext.request.contextPath}/contact"style="color:#aaa;">Contact</a>
                <a href="${pageContext.request.contextPath}/login"  style="color:#aaa;">Login</a>
            </div>
        </div>
        <div>
            <div style="font-weight:700;color:#fff;margin-bottom:0.5rem;">Contact</div>
            <div style="font-size:0.85rem;display:flex;flex-direction:column;gap:0.3rem;">
                <span>&#x1F4CD; Kathmandu, Nepal</span>
                <span>&#x1F4DE; +977-9800000000</span>
                <span>&#x1F4E7; info@gympro.com</span>
            </div>
        </div>
    </div>
    <div style="text-align:center;margin-top:2rem;padding-top:1.25rem;border-top:1px solid #333;font-size:0.82rem;">
        &copy; 2025 <span style="color:var(--primary);">GymPro</span>. All rights reserved.
    </div>
</footer>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
