# 🏋️ GymPro — Gym Management System

A full-featured **Java EE web application** for managing gym memberships, classes, trainers, and members. Built with a clean MVC architecture using Servlets, JSP/JSTL, and MySQL.

---

## 🚀 Tech Stack

| Layer      | Technology                          |
|------------|-------------------------------------|
| Backend    | Java 11, Java EE (Servlets)         |
| View       | JSP, JSTL, Expression Language (EL) |
| Database   | MySQL (via XAMPP)                   |
| Server     | Apache Tomcat 9+                    |
| Security   | BCrypt password hashing             |
| Build      | Maven                               |
| Styling    | Pure CSS (Flexbox, media queries)   |

---

## 🏗️ Architecture

```
Controller  (Servlet)           →  handles HTTP requests/responses
    ↓
Service     (Business Logic)    →  validates and processes data
    ↓
DAO         (Data Access)       →  executes SQL queries
    ↓
Database    (MySQL)             →  persists all data
```

---

## 📁 Project Structure

```
GymPro/
├── pom.xml
├── sql/
│   └── gymPro_schema.sql
└── src/main/
    ├── java/com/gympro/
    │   ├── model/          # User, MembershipPlan, MemberMembership,
    │   │                   # Trainer, GymClass, ClassEnrollment,
    │   │                   # Attendance, ContactInquiry
    │   │
    │   ├── dao/            # UserDAO, MembershipPlanDAO, MemberMembershipDAO,
    │   │                   # TrainerDAO, ClassDAO, EnrollmentDAO,
    │   │                   # AttendanceDAO, ContactInquiryDAO
    │   │
    │   ├── service/        # UserService, MembershipService, TrainerService,
    │   │                   # ClassService, ContactService
    │   │
    │   ├── controller/     # AuthController, AdminDashboardController,
    │   │                   # AdminUserController, AdminTrainerController,
    │   │                   # AdminClassController, AdminMembershipController,
    │   │                   # MemberDashboardController, MemberProfileController,
    │   │                   # MemberClassController, ContactController
    │   │
    │   ├── filter/         # AuthFilter
    │   └── util/           # DBConnection, PasswordUtil, ValidationUtil, DateUtil
    │
    └── webapp/
        ├── index.jsp               # Landing page
        ├── about.jsp
        ├── error403.jsp / 404.jsp / 500.jsp
        ├── css/
        │   ├── style.css           # Global styles
        │   ├── auth.css
        │   ├── public.css
        │   ├── admin-dashboard.css
        │   ├── admin-users.css
        │   ├── admin-trainers.css
        │   ├── admin-classes.css
        │   ├── admin-memberships.css
        │   ├── member-dashboard.css
        │   ├── member-classes.css
        │   └── member-profile.css
        ├── js/
        │   └── main.js
        └── WEB-INF/
            ├── web.xml
            └── views/
                ├── shared/         # login.jsp, register.jsp, contact.jsp,
                │                   # adminHeader/Footer.jsp,
                │                   # memberHeader/Footer.jsp,
                │                   # publicHeader/Footer.jsp
                ├── admin/          # dashboard.jsp, users.jsp, trainers.jsp,
                │                   # classes.jsp, memberships.jsp
                └── member/         # dashboard.jsp, classes.jsp, profile.jsp
```

---

## ⚙️ Setup & Installation

### Prerequisites
- Java 11+
- Apache Tomcat 9+
- XAMPP (MySQL)
- Maven

---

### 1. Database Setup

Open **phpMyAdmin** or the MySQL CLI and run:

```sql
SOURCE sql/gymPro_schema.sql;
```

---

### 2. Configure Database Connection

Edit the file:
```
src/main/java/com/gympro/util/DBConnection.java
```

Update your MySQL password:
```java
private static final String PASSWORD = "your_mysql_password";
```

---

### 3. Build the Project

```bash
mvn clean package
```

Then copy the generated WAR file to your Tomcat webapps directory:

```bash
cp target/GymPro.war /path/to/tomcat/webapps/
```

---

### 4. Launch

Start Tomcat and navigate to:
```
http://localhost:8080/GymPro
```

---

### 5. Default Admin Login

```
Email:    admin@gympro.com
Password: Admin@123
```

> ⚠️ Change this password immediately after first login.

---

## 🗺️ URL Mapping

| URL                    | Role   | Description              |
|------------------------|--------|--------------------------|
| `/`                    | Public | Landing page             |
| `/login`               | Public | Login                    |
| `/register`            | Public | Member registration      |
| `/about`               | Public | About page               |
| `/contact`             | Public | Contact form             |
| `/admin/dashboard`     | Admin  | Admin dashboard          |
| `/admin/users`         | Admin  | Manage members           |
| `/admin/trainers`      | Admin  | Manage trainers          |
| `/admin/classes`       | Admin  | Manage classes           |
| `/admin/memberships`   | Admin  | Manage memberships       |
| `/member/dashboard`    | Member | Member dashboard         |
| `/member/classes`      | Member | Browse & enroll classes  |
| `/member/profile`      | Member | Profile & password       |

---

## 🔐 Security

- Passwords are hashed using **BCrypt** — never stored in plain text.
- Role-based access is enforced via **AuthFilter** on all `/admin/*` and `/member/*` routes.
- SQL injection is prevented through **PreparedStatements** throughout all DAO classes.

---

## 📄 License

This project was developed for educational purposes.