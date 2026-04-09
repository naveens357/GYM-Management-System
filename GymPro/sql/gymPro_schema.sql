-- ============================================================
-- GymPro - Gym Management System | Database Schema
-- ============================================================
CREATE DATABASE IF NOT EXISTS gymprodb;
USE gymprodb;

CREATE TABLE IF NOT EXISTS users (
    user_id       INT AUTO_INCREMENT PRIMARY KEY,
    full_name     VARCHAR(100)  NOT NULL,
    email         VARCHAR(100)  NOT NULL UNIQUE,
    phone         VARCHAR(15)   NOT NULL UNIQUE,
    password      VARCHAR(255)  NOT NULL,
    date_of_birth DATE          NOT NULL,
    gender        ENUM('Male','Female','Other') NOT NULL,
    address       TEXT,
    role          ENUM('admin','member') NOT NULL DEFAULT 'member',
    status        ENUM('pending','approved','rejected') NOT NULL DEFAULT 'pending',
    created_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email(email), INDEX idx_phone(phone), INDEX idx_role(role), INDEX idx_status(status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS membership_plans (
    plan_id         INT AUTO_INCREMENT PRIMARY KEY,
    plan_name       VARCHAR(100) NOT NULL,
    duration_months INT          NOT NULL,
    price           DECIMAL(10,2) NOT NULL,
    description     TEXT,
    is_active       TINYINT(1)   DEFAULT 1,
    created_at      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS member_memberships (
    membership_id  INT AUTO_INCREMENT PRIMARY KEY,
    user_id        INT           NOT NULL,
    plan_id        INT           NOT NULL,
    start_date     DATE          NOT NULL,
    end_date       DATE          NOT NULL,
    payment_status ENUM('paid','pending','overdue') NOT NULL DEFAULT 'pending',
    payment_date   DATE,
    amount_paid    DECIMAL(10,2),
    created_at     TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (plan_id) REFERENCES membership_plans(plan_id) ON DELETE RESTRICT,
    INDEX idx_user_id(user_id), INDEX idx_payment_status(payment_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS trainers (
    trainer_id       INT AUTO_INCREMENT PRIMARY KEY,
    full_name        VARCHAR(100) NOT NULL,
    email            VARCHAR(100) NOT NULL UNIQUE,
    phone            VARCHAR(15)  NOT NULL UNIQUE,
    specialization   VARCHAR(150) NOT NULL,
    experience_years INT          DEFAULT 0,
    bio              TEXT,
    schedule         VARCHAR(255),
    is_active        TINYINT(1)   DEFAULT 1,
    created_at       TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS classes (
    class_id          INT AUTO_INCREMENT PRIMARY KEY,
    class_name        VARCHAR(100) NOT NULL,
    trainer_id        INT          NOT NULL,
    schedule_datetime DATETIME     NOT NULL,
    duration_minutes  INT          NOT NULL DEFAULT 60,
    capacity          INT          NOT NULL DEFAULT 20,
    enrolled_count    INT          NOT NULL DEFAULT 0,
    description       TEXT,
    is_active         TINYINT(1)   DEFAULT 1,
    created_at        TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id) ON DELETE RESTRICT,
    INDEX idx_schedule(schedule_datetime)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS class_enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id       INT NOT NULL,
    class_id      INT NOT NULL,
    enrolled_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status        ENUM('enrolled','cancelled') DEFAULT 'enrolled',
    UNIQUE KEY uq_user_class(user_id, class_id),
    FOREIGN KEY (user_id)  REFERENCES users(user_id)    ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id       INT  NOT NULL,
    class_id      INT  NOT NULL,
    attended_date DATE NOT NULL,
    status        ENUM('present','absent') DEFAULT 'present',
    FOREIGN KEY (user_id)  REFERENCES users(user_id)    ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE,
    INDEX idx_date(attended_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS contact_inquiries (
    inquiry_id   INT AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(100) NOT NULL,
    email        VARCHAR(100) NOT NULL,
    subject      VARCHAR(200) NOT NULL,
    message      TEXT         NOT NULL,
    submitted_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    is_read      TINYINT(1)   DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Admin (password = Admin@123)
INSERT INTO users (full_name,email,phone,password,date_of_birth,gender,address,role,status) VALUES
('GymPro Admin','admin@gympro.com','9800000000',
 '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW',
 '1990-01-01','Male','Kathmandu, Nepal','admin','approved');

INSERT INTO membership_plans(plan_name,duration_months,price,description) VALUES
('Basic',1,1500.00,'Gym floor and basic equipment.'),
('Standard',3,4000.00,'Gym access + 1 group class per week.'),
('Premium',6,7500.00,'Unlimited classes + trainer session.'),
('Annual',12,13000.00,'Full year with all premium benefits.');

INSERT INTO trainers(full_name,email,phone,specialization,experience_years,bio,schedule) VALUES
('Raj Sharma','raj@gympro.com','9801111111','Strength & Conditioning',5,'Certified weight training coach.','Mon-Fri 6AM-2PM'),
('Sita Thapa','sita@gympro.com','9802222222','Yoga & Flexibility',4,'Mindfulness yoga instructor.','Mon-Sat 7AM-1PM'),
('Bikash Rai','bikash@gympro.com','9803333333','Cardio & HIIT',6,'High-energy HIIT coach.','Tue-Sun 8AM-4PM');

INSERT INTO classes(class_name,trainer_id,schedule_datetime,duration_minutes,capacity,description) VALUES
('Morning HIIT',3,DATE_ADD(NOW(),INTERVAL 1 DAY),45,20,'Burn calories fast with HIIT.'),
('Power Yoga',2,DATE_ADD(NOW(),INTERVAL 2 DAY),60,15,'Strength and flexibility flow.'),
('Weight Training 101',1,DATE_ADD(NOW(),INTERVAL 3 DAY),60,10,'Beginner weight training guide.'),
('Cardio Blast',3,DATE_ADD(NOW(),INTERVAL 4 DAY),30,25,'Fast-paced cardio for all levels.');
