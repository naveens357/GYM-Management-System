# GymPro — Gym Management System

A full Java EE web application built with MVC architecture, JSTL/EL, MySQL, and BCrypt.

## Tech Stack
| Layer        | Technology                        |
|-------------|-----------------------------------|
| Backend     | Java 11, Java EE (Servlets)       |
| View        | JSP, JSTL, Expression Language    |
| Database    | MySQL (XAMPP)                     |
| Server      | Apache Tomcat 9+                  |
| Security    | BCrypt password hashing           |
| Build       | Maven                             |
| CSS         | Pure CSS (Flexbox, media queries) |

## Architecture
```
Controller (Servlet)
    ↓
Service (Business Logic)
    ↓
DAO (Data Access Object)
    ↓
Database (MySQL)
```

## Project Structure
```
GymPro/
├── pom.xml
├── sql/gymPro_schema.sql
└── src/main/
    ├── java/com/gympro/
    │   ├── model/          User, MembershipPlan, MemberMembership,
    │   │                   Trainer, GymClass, ClassEnrollment,
    │   │                   Attendance, ContactInquiry
    │   ├── dao/            UserDAO, MembershipPlanDAO, MemberMembershipDAO,
    │   │                   TrainerDAO, ClassDAO, EnrollmentDAO,
    │   │                   AttendanceDAO, ContactInquiryDAO
    │   ├── service/        UserService, MembershipService, TrainerService,
    │   │                   ClassService, ContactService
    │   ├── controller/     AuthController, AdminDashboardController,
    │   │                   AdminUserController, AdminTrainerController,
    │   │                   AdminClassController, AdminMembershipController,
    │   │                   MemberDashboardController, MemberProfileController,
    │   │                   MemberClassController, ContactController
    │   ├── filter/         AuthFilter
    │   └── util/           DBConnection, PasswordUtil, ValidationUtil, DateUtil
    └── webapp/
        ├── index.jsp       (Landing page)
        ├── about.jsp
        ├── error403/404/500.jsp
        ├── css/            style.css (global), auth.css, public.css,
        │                   admin-dashboard.css, admin-users.css,
        │                   admin-trainers.css, admin-classes.css,
        │                   admin-memberships.css, member-dashboard.css,
        │                   member-classes.css, member-profile.css
        ├── js/main.js
        └── WEB-INF/
            ├── web.xml
            └── views/
                ├── shared/ login.jsp, register.jsp, contact.jsp,
                │           adminHeader.jsp, adminFooter.jsp,
                │           memberHeader.jsp, memberFooter.jsp,
                │           publicHeader.jsp, publicFooter.jsp
                ├── admin/  dashboard.jsp, users.jsp, trainers.jsp,
                │           classes.jsp, memberships.jsp
                └── member/ dashboard.jsp, classes.jsp, profile.jsp
```

## Setup Instructions

### 1. Database
```sql
-- In XAMPP phpMyAdmin or MySQL CLI:
SOURCE sql/gymPro_schema.sql;
```

### 2. Configure DB Connection
Edit `src/main/java/com/gympro/util/DBConnection.java`:
```java
private static final String PASSWORD = "your_mysql_password";
```

### 3. Build & Deploy
```bash
mvn clean package
# Copy GymPro.war to Tomcat/webapps/
```

### 4. Default Admin Login
```
Email:    admin@gympro.com
Password: Admin@123
```

## URL Mapping
| URL                        | Description              |
|---------------------------|--------------------------|
| /                          | Landing page             |
| /login                     | Login                    |
| /register                  | Member registration      |
| /about                     | About page               |
| /contact                   | Contact form             |
| /admin/dashboard           | Admin dashboard          |
| /admin/users               | Manage members           |
| /admin/trainers            | Manage trainers          |
| /admin/classes             | Manage classes           |
| /admin/memberships         | Manage memberships       |
| /member/dashboard          | Member dashboard         |
| /member/classes            | Browse & enroll classes  |
| /member/profile            | Profile & password       |
