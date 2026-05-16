# GymPro - Gym Management System

An advanced web application designed to streamline gym operations, member subscriptions, and trainer scheduling. This project was developed as part of the 4th-semester **Advanced Programming** curriculum.

## 🚀 Features

### Member Management
* **Secure Authentication**: Dedicated registration and login portals for members and admins.
* **Subscription Tracking**: Real-time monitoring of membership status, renewals, and expiration dates.
* **Profile Dashboards**: Personalized user profiles tracking attendance and assigned trainers.

### Administrative Controls
* **Trainer Scheduling**: Assign trainers to specific time slots and manage allocations.
* **Billing & Invoicing**: Automated generation of digital receipts for membership payments.
* **Operational Analytics**: High-level dashboard metrics displaying active memberships and monthly revenue.

---

## 🛠️ Tech Stack

* **Backend**: Java (Servlet API, JSP)
* **Frontend**: HTML5, CSS3, JavaScript
* **Database**: MySQL
* **Server**: Apache Tomcat (v9.0 or higher)
* **Architecture**: Model-View-Controller (MVC)
* **Build Tool**: Maven

---

## 📋 Prerequisites

Ensure you have the following installed before running the project:
* Java Development Kit (JDK 11 or higher)
* Apache Tomcat Server
* MySQL Server & MySQL Workbench
* An IDE (Eclipse)

---

## 🔧 Installation & Setup

### 1. Database Configuration
1. Open your MySQL terminal or Workbench.
2. Create a new database named `gympro_db`.
3. Import the database schema located in the repository:
   ```bash
   mysql -u root -p gympro_db < src/main/resources/database.sql
   ```
4. Update the database credentials in `src/main/java/com/gympro/util/DBConnection.java` to match your local MySQL configuration.

### 2. Project Deployment
1. Clone this repository to your local machine:
   ```bash
   git clone <your-repository-url>
   ```
2. Open your preferred Java IDE and import the project as a **Maven Project**.
3. Right-click the project root and select **Run As > Run on Server**.
4. Select your **Apache Tomcat** server and click **Finish**.
5. Access the application in your browser at: `http://localhost:8080/GymPro/`

---

## 📐 Architecture & Design Patterns

This system is built using the **Model-View-Controller (MVC)** architectural design pattern to ensure clean separation of concerns:
* **Model**: Handles data persistence, entities, and database interactions (DAO classes).
* **View**: Handles the user interface via JSP pages (`WEB-INF/views/`).
* **Controller**: Handles HTTP requests, business logic, and routing via Java Servlets.

---

## 🧑‍💻 Academic Credit
* **Course**: Advanced Programming (4th Semester)
* **Developer**: Naveen
