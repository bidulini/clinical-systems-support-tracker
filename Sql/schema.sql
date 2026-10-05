CREATE DATABASE IF NOT EXISTS clinical_support;

USE clinical_support;


-- ============================================
-- MASTER DATA
-- ============================================

CREATE TABLE employees (
    employee_id VARCHAR(20) PRIMARY KEY,
    person_name VARCHAR(100) NOT NULL,
    role VARCHAR(100),
    department VARCHAR(100)
);


CREATE TABLE courses (
    course_id VARCHAR(20) PRIMARY KEY,
    training_name VARCHAR(150) NOT NULL,
    category VARCHAR(100),
    required VARCHAR(10),
    validity_months INT
);


-- ============================================
-- OPERATIONAL DATA
-- ============================================

CREATE TABLE training_records (
    training_record_id INT AUTO_INCREMENT PRIMARY KEY,
    study_id VARCHAR(20),
    employee_id VARCHAR(20) NOT NULL,
    course_id VARCHAR(20) NOT NULL,
    assigned_date DATETIME,
    due_date DATETIME,
    completed_date DATETIME,
    status VARCHAR(30),
    started VARCHAR(10),
    training_hours INT,
    notes VARCHAR(255),

    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id),

    FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
);


CREATE TABLE tmf_documents (
    document_id VARCHAR(20) PRIMARY KEY,
    study_id VARCHAR(20),
    tmf_zone VARCHAR(100),
    artifact VARCHAR(100),
    document_name VARCHAR(150),
    version VARCHAR(20),
    document_status VARCHAR(50),
    owner VARCHAR(100),
    date_received DATETIME,
    due_date DATETIME,
    qc_status VARCHAR(50),
    notes VARCHAR(255)
);


CREATE TABLE issues (
    issue_id VARCHAR(20) PRIMARY KEY,
    study_id VARCHAR(20),
    issue_date DATETIME,
    issue_category VARCHAR(100),
    description VARCHAR(255),
    priority VARCHAR(30),
    owner VARCHAR(100),
    status VARCHAR(30),
    due_date DATETIME,
    resolution_date DATETIME,
    days_open INT,
    notes VARCHAR(255)
);


CREATE TABLE deliverables (
    deliverable_id VARCHAR(20) PRIMARY KEY,
    study_id VARCHAR(20),
    deliverable_type VARCHAR(100),
    deliverable_name VARCHAR(150),
    owner VARCHAR(100),
    planned_date DATETIME,
    due_date DATETIME,
    completion_date DATETIME,
    status VARCHAR(30),
    priority VARCHAR(30),
    days_overdue INT,
    notes VARCHAR(255)
);