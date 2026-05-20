package com.gympro.controller;

import com.gympro.model.User;
import com.gympro.service.UserService;
import com.gympro.util.ValidationUtil;
import com.gympro.util.DateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Controller for member profile viewing and editing.
 */
@WebServlet("/member/profile")
public class MemberProfileController extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/member/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession(false);
        User sessionUser = (User) session.getAttribute("loggedUser");

        try {
            if ("updateProfile".equals(action)) {
                String fullName = ValidationUtil.safeTrim(req.getParameter("fullName"));
                String phone    = ValidationUtil.safeTrim(req.getParameter("phone"));
                String gender   = req.getParameter("gender");
                String address  = ValidationUtil.safeTrim(req.getParameter("address"));
                String dob      = req.getParameter("dateOfBirth");

                if (!ValidationUtil.isValidName(fullName)) {
                    req.setAttribute("error", "Name must contain letters only.");
                    doGet(req, resp); return;
                }
                if (!ValidationUtil.isValidPhone(phone)) {
                    req.setAttribute("error", "Phone must be 10 digits.");
                    doGet(req, resp); return;
                }

                sessionUser.setFullName(fullName);
                sessionUser.setPhone(phone);
                sessionUser.setGender(gender);
                sessionUser.setAddress(address);
                sessionUser.setDateOfBirth(DateUtil.parseDate(dob));

                if (userService.updateProfile(sessionUser)) {
                    session.setAttribute("loggedUser", userService.getUserById(sessionUser.getUserId()));
                    req.setAttribute("success", "Profile updated successfully.");
                } else {
                    req.setAttribute("error", "Profile update failed.");
                }

            } else if ("changePassword".equals(action)) {
                String currentPwd = req.getParameter("currentPassword");
                String newPwd     = req.getParameter("newPassword");
                String confirmPwd = req.getParameter("confirmPassword");

                if (!com.gympro.util.PasswordUtil.verifyPassword(currentPwd, sessionUser.getPassword())) {
                    req.setAttribute("error", "Current password is incorrect.");
                    doGet(req, resp); return;
                }
                if (!ValidationUtil.isValidPassword(newPwd)) {
                    req.setAttribute("error", "New password does not meet complexity requirements.");
                    doGet(req, resp); return;
                }
                if (!newPwd.equals(confirmPwd)) {
                    req.setAttribute("error", "Passwords do not match.");
                    doGet(req, resp); return;
                }
                if (userService.changePassword(sessionUser.getUserId(), newPwd)) {
                    session.setAttribute("loggedUser", userService.getUserById(sessionUser.getUserId()));
                    req.setAttribute("success", "Password changed successfully.");
                } else {
                    req.setAttribute("error", "Password change failed.");
                }
            }
        } catch (Exception e) {
            req.setAttribute("error", "System error: " + e.getMessage());
        }
        doGet(req, resp);
    }
}
