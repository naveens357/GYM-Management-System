package com.gympro.filter;

import com.gympro.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Authentication Filter — redirects unauthenticated users to the login page.
 * Also enforces role-based access: admin paths require admin role.
 */
@WebFilter(urlPatterns = {"/admin/*", "/member/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req  = (HttpServletRequest)  request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        User loggedUser = (session != null) ? (User) session.getAttribute("loggedUser") : null;

        String uri = req.getRequestURI();

        if (loggedUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login?error=session");
            return;
        }

        if (uri.contains("/admin/") && !"admin".equals(loggedUser.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/error403.jsp");
            return;
        }

        if (uri.contains("/member/") && !"member".equals(loggedUser.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/error403.jsp");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
