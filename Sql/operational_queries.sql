USE clinical_support;


-- ============================================
-- 1. Open issues and overdue deliverables
-- by study
-- ============================================

SELECT
    i.study_id,
    COUNT(DISTINCT i.issue_id) AS open_issues,
    COUNT(DISTINCT d.deliverable_id) AS overdue_deliverables
FROM issues i
LEFT JOIN deliverables d
    ON i.study_id = d.study_id
   AND d.due_date < CURDATE()
   AND d.status <> 'Completed'
WHERE i.status <> 'Resolved'
GROUP BY i.study_id
ORDER BY open_issues DESC;


-- ============================================
-- 2. Raw study-level relationship
-- between issues and deliverables
-- ============================================

SELECT
    i.study_id,
    i.issue_id,
    d.deliverable_id
FROM issues i
JOIN deliverables d
    ON i.study_id = d.study_id
WHERE i.study_id = 'ST-001';


-- ============================================
-- 3. Study operational overview
-- ============================================

SELECT
    s.study_id,
    COALESCE(i.open_issues, 0) AS open_issues,
    COALESCE(d.overdue_deliverables, 0) AS overdue_deliverables,
    COALESCE(t.tmf_problems, 0) AS tmf_problems
FROM
    (
        SELECT DISTINCT study_id
        FROM issues

        UNION

        SELECT DISTINCT study_id
        FROM deliverables

        UNION

        SELECT DISTINCT study_id
        FROM tmf_documents
    ) s

LEFT JOIN
    (
        SELECT
            study_id,
            COUNT(DISTINCT issue_id) AS open_issues
        FROM issues
        WHERE status <> 'Resolved'
        GROUP BY study_id
    ) i
    ON s.study_id = i.study_id

LEFT JOIN
    (
        SELECT
            study_id,
            COUNT(DISTINCT deliverable_id) AS overdue_deliverables
        FROM deliverables
        WHERE due_date < CURDATE()
          AND status <> 'Completed'
        GROUP BY study_id
    ) d
    ON s.study_id = d.study_id

LEFT JOIN
    (
        SELECT
            study_id,
            COUNT(DISTINCT document_id) AS tmf_problems
        FROM tmf_documents
        WHERE qc_status = 'Failed'
           OR due_date < CURDATE()
        GROUP BY study_id
    ) t
    ON s.study_id = t.study_id

ORDER BY s.study_id;


-- ============================================
-- 4. Study operational status
-- ============================================

SELECT
    study_id,
    open_issues,
    overdue_deliverables,
    tmf_problems,
    CASE
        WHEN open_issues > 0
          OR overdue_deliverables > 0
          OR tmf_problems > 0
            THEN 'Attention Required'
        ELSE 'No Current Issues'
    END AS operational_status
FROM
(
    SELECT
        s.study_id,
        COALESCE(i.open_issues, 0) AS open_issues,
        COALESCE(d.overdue_deliverables, 0) AS overdue_deliverables,
        COALESCE(t.tmf_problems, 0) AS tmf_problems
    FROM
        (
            SELECT DISTINCT study_id
            FROM issues

            UNION

            SELECT DISTINCT study_id
            FROM deliverables

            UNION

            SELECT DISTINCT study_id
            FROM tmf_documents
        ) s

    LEFT JOIN
        (
            SELECT
                study_id,
                COUNT(DISTINCT issue_id) AS open_issues
            FROM issues
            WHERE status <> 'Resolved'
            GROUP BY study_id
        ) i
        ON s.study_id = i.study_id

    LEFT JOIN
        (
            SELECT
                study_id,
                COUNT(DISTINCT deliverable_id) AS overdue_deliverables
            FROM deliverables
            WHERE due_date < CURDATE()
              AND status <> 'Completed'
            GROUP BY study_id
        ) d
        ON s.study_id = d.study_id

    LEFT JOIN
        (
            SELECT
                study_id,
                COUNT(DISTINCT document_id) AS tmf_problems
            FROM tmf_documents
            WHERE qc_status = 'Failed'
               OR due_date < CURDATE()
            GROUP BY study_id
        ) t
        ON s.study_id = t.study_id
) report

ORDER BY study_id;


-- ============================================
-- 5. Conditional aggregation of issue priority
-- by study
-- ============================================

SELECT
    study_id,
    SUM(CASE
        WHEN priority = 'Critical' THEN 1
        ELSE 0
    END) AS critical_issues,

    SUM(CASE
        WHEN priority = 'High' THEN 1
        ELSE 0
    END) AS high_issues,

    SUM(CASE
        WHEN priority = 'Medium' THEN 1
        ELSE 0
    END) AS medium_issues

FROM issues
WHERE status <> 'Resolved'
GROUP BY study_id
ORDER BY study_id;


-- ============================================
-- 6. Open issues by owner with HAVING
-- ============================================

SELECT
    owner,
    COUNT(*) AS open_issues
FROM issues
WHERE status <> 'Resolved'
GROUP BY owner
HAVING COUNT(*) > 1
ORDER BY open_issues DESC;