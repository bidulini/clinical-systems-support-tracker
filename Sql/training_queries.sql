USE clinical_support;


-- ============================================
-- 1. Training records with employee and course
-- information
-- ============================================

SELECT
    e.employee_id,
    e.person_name,
    e.role,
    c.course_id,
    c.training_name,
    tr.assigned_date,
    tr.due_date,
    tr.completed_date,
    tr.status,
    tr.training_hours
FROM training_records tr
JOIN employees e
    ON tr.employee_id = e.employee_id
JOIN courses c
    ON tr.course_id = c.course_id
ORDER BY e.person_name;


-- ============================================
-- 2. Overdue training
-- ============================================

SELECT
    e.employee_id,
    e.person_name,
    c.training_name,
    tr.due_date,
    tr.status,
    tr.training_hours
FROM training_records tr
JOIN employees e
    ON tr.employee_id = e.employee_id
JOIN courses c
    ON tr.course_id = c.course_id
WHERE tr.status = 'Overdue'
ORDER BY tr.due_date;


-- ============================================
-- 3. Training hours by employee
-- ============================================

SELECT
    e.employee_id,
    e.person_name,
    SUM(tr.training_hours) AS total_training_hours
FROM training_records tr
JOIN employees e
    ON tr.employee_id = e.employee_id
GROUP BY
    e.employee_id,
    e.person_name
ORDER BY total_training_hours DESC;


-- ============================================
-- 4. Training records by status
-- ============================================

SELECT
    status,
    COUNT(*) AS training_records,
    SUM(training_hours) AS total_training_hours
FROM training_records
GROUP BY status
ORDER BY training_records DESC;


-- ============================================
-- 5. Training compliance classification
-- ============================================

SELECT
    e.employee_id,
    e.person_name,
    c.training_name,
    tr.status,
    tr.due_date,
    CASE
        WHEN tr.status = 'Completed'
            THEN 'Compliant'
        WHEN tr.status = 'Overdue'
            THEN 'Non-Compliant'
        ELSE 'Pending'
    END AS compliance_status
FROM training_records tr
JOIN employees e
    ON tr.employee_id = e.employee_id
JOIN courses c
    ON tr.course_id = c.course_id
ORDER BY e.person_name;


-- ============================================
-- 6. Required training by employee
-- ============================================

SELECT
    e.employee_id,
    e.person_name,
    COUNT(*) AS required_training_records,
    SUM(tr.training_hours) AS required_training_hours
FROM training_records tr
JOIN employees e
    ON tr.employee_id = e.employee_id
JOIN courses c
    ON tr.course_id = c.course_id
WHERE c.required = 'Yes'
GROUP BY
    e.employee_id,
    e.person_name
ORDER BY required_training_hours DESC;


-- ============================================
-- 7. Employees with more than one open
-- training record
-- ============================================

SELECT
    e.employee_id,
    e.person_name,
    COUNT(*) AS open_training_records
FROM training_records tr
JOIN employees e
    ON tr.employee_id = e.employee_id
WHERE tr.status <> 'Completed'
GROUP BY
    e.employee_id,
    e.person_name
HAVING COUNT(*) > 1
ORDER BY open_training_records DESC;