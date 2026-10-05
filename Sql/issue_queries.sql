USE clinical_support;


-- ============================================
-- 1. All issues
-- ============================================

SELECT
    issue_id,
    study_id,
    issue_category,
    priority,
    owner,
    status,
    due_date,
    resolution_date
FROM issues
ORDER BY issue_date;


-- ============================================
-- 2. Open issues
-- ============================================

SELECT
    issue_id,
    study_id,
    issue_category,
    priority,
    owner,
    status,
    due_date
FROM issues
WHERE status <> 'Resolved'
ORDER BY priority, due_date;


-- ============================================
-- 3. Critical and high-priority open issues
-- ============================================

SELECT
    issue_id,
    study_id,
    issue_category,
    priority,
    owner,
    status,
    due_date
FROM issues
WHERE status <> 'Resolved'
  AND priority IN ('Critical', 'High')
ORDER BY
    priority,
    due_date;


-- ============================================
-- 4. Issues by status
-- ============================================

SELECT
    status,
    COUNT(*) AS issue_count
FROM issues
GROUP BY status
ORDER BY issue_count DESC;


-- ============================================
-- 5. Open issues by owner
-- ============================================

SELECT
    owner,
    COUNT(*) AS open_issues
FROM issues
WHERE status <> 'Resolved'
GROUP BY owner
ORDER BY open_issues DESC;


-- ============================================
-- 6. Owners with more than one open issue
-- ============================================

SELECT
    owner,
    COUNT(*) AS open_issues
FROM issues
WHERE status <> 'Resolved'
GROUP BY owner
HAVING COUNT(*) > 1
ORDER BY open_issues DESC;


-- ============================================
-- 7. Issues requiring attention
-- ============================================

SELECT
    issue_id,
    study_id,
    issue_category,
    priority,
    owner,
    status,
    due_date,
    CASE
        WHEN priority = 'Critical'
             AND status <> 'Resolved'
            THEN 'Critical Open Issue'
        WHEN status <> 'Resolved'
             AND due_date < CURDATE()
            THEN 'Overdue Open Issue'
        WHEN status <> 'Resolved'
            THEN 'Open Issue'
        ELSE 'Resolved'
    END AS issue_flag
FROM issues
ORDER BY priority, due_date;


-- ============================================
-- 8. Open issues by study and priority
-- ============================================

SELECT
    study_id,
    priority,
    COUNT(*) AS open_issues
FROM issues
WHERE status <> 'Resolved'
GROUP BY
    study_id,
    priority
ORDER BY
    study_id,
    open_issues DESC;