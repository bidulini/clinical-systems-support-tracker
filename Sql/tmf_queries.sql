USE clinical_support;


-- ============================================
-- 1. TMF documents with basic information
-- ============================================

SELECT
    document_id,
    study_id,
    tmf_zone,
    document_name,
    version,
    document_status,
    owner,
    qc_status,
    due_date
FROM tmf_documents
ORDER BY study_id, document_id;


-- ============================================
-- 2. Documents with QC failures
-- ============================================

SELECT
    document_id,
    study_id,
    document_name,
    version,
    owner,
    qc_status
FROM tmf_documents
WHERE qc_status = 'Failed'
ORDER BY study_id;


-- ============================================
-- 3. Overdue TMF documents
-- ============================================

SELECT
    document_id,
    study_id,
    document_name,
    owner,
    due_date,
    qc_status
FROM tmf_documents
WHERE due_date < CURDATE()
ORDER BY due_date;


-- ============================================
-- 4. TMF documents by status
-- ============================================

SELECT
    document_status,
    COUNT(*) AS document_count
FROM tmf_documents
GROUP BY document_status
ORDER BY document_count DESC;


-- ============================================
-- 5. TMF documents by study and status
-- ============================================

SELECT
    study_id,
    document_status,
    COUNT(*) AS document_count
FROM tmf_documents
GROUP BY
    study_id,
    document_status
ORDER BY
    study_id,
    document_count DESC;


-- ============================================
-- 6. Documents requiring attention
-- ============================================

SELECT
    document_id,
    study_id,
    document_name,
    qc_status,
    due_date,
    CASE
        WHEN qc_status = 'Failed'
             AND due_date < CURDATE()
            THEN 'QC Failed + Overdue'
        WHEN qc_status = 'Failed'
            THEN 'QC Failed'
        WHEN due_date < CURDATE()
            THEN 'Overdue'
        ELSE 'No Current Issue'
    END AS issue_flag
FROM tmf_documents
ORDER BY study_id, document_id;


-- ============================================
-- 7. TMF problems by study
-- ============================================

SELECT
    study_id,
    COUNT(DISTINCT document_id) AS tmf_problems
FROM tmf_documents
WHERE qc_status = 'Failed'
   OR due_date < CURDATE()
GROUP BY study_id
ORDER BY tmf_problems DESC;