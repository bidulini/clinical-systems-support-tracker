# Clinical Systems Support Tracker

A practical clinical operations data-management project combining Excel, Power Query, SQL, simulated API integration, and Node.js automation.

The project was designed as a portfolio system to demonstrate how operational clinical data can be captured, validated, transformed, analyzed, and monitored across multiple technical layers.

---

## Project Overview

The Clinical Systems Support Tracker is a simulated clinical operations environment covering:

- Training and compliance tracking
- TMF document tracking
- Issue management
- Deliverables and milestones
- Data quality monitoring
- KPI reporting
- Dashboard development
- Relational database design
- SQL analytics
- API data validation
- Node.js automation

The project follows a layered approach, moving from operational data capture toward structured reporting and automated data validation.

---

## Business Problem

Clinical operations generate data across multiple operational areas.

Without structured processes, common problems can include:

- Missing or invalid records
- Overdue training
- Incomplete documentation
- Failed QC checks
- Open operational issues
- Delayed deliverables
- Inconsistent reporting
- Manual data validation

This project demonstrates a small-scale system for organizing and monitoring this information.

The goal is not to replicate a production clinical system, but to demonstrate the technical concepts and workflows used in clinical data and systems-support environments.

---

## System Architecture

```text
Master Data
     ↓
Operational Trackers
     ↓
Data Quality
     ↓
Power Query
     ↓
SQL Database
     ↓
SQL Reporting
     ↓
Simulated API
     ↓
Node.js Automation
     ↓
Validated Outputs
```

---

## Data Model

The project separates stable master data from operational data.

### Master Data

- Employees
- Courses

### Operational Data

- Training Records
- TMF Documents
- Issues
- Deliverables

Several operational entities are connected through `Study ID`, while training records connect employees and courses through their respective identifiers.

See [data-model.md](documentation/data-model.md) for the detailed data model.

---

## Excel Implementation

Excel is used as the operational and reporting layer.

The workbook includes:

### Master Data

- Employees
- Courses

### Operational Trackers

- Training Tracker
- TMF Document Tracker
- Issue Log
- Deliverables & Milestones

### Data Quality

- Training Data Quality
- TMF Data Quality

### KPI Reporting

- Training KPIs
- TMF KPIs
- Issue KPIs
- Deliverables KPIs

### Dashboards

- Training Dashboard
- TMF Dashboard

The Excel layer demonstrates structured tables, formulas, validation logic, conditional formatting, PivotTables, KPI calculations, and dashboard reporting.

---

## Data Quality

Data quality checks are applied across the system to identify issues such as:

- Invalid Employee IDs
- Invalid Course IDs
- Missing due dates
- Invalid date sequences
- Missing completion dates
- Failed TMF QC
- Overdue documents
- Operational records requiring review

The project applies the principle:

**Bad data → bad reporting → bad decisions.**

---

## Power Query

Power Query is used as the repeatable data-preparation layer.

Transformations include:

- Data type standardization
- Text cleaning
- Trimming whitespace
- Cleaning text values
- Merging master data
- Expanding related fields
- Validation checks
- Overdue classification
- Refreshable output tables

The Power Query layer demonstrates an ETL-style workflow:

```text
Extract → Transform → Load
```

---

## SQL Database

A MySQL relational database was created to store the operational data model.

The database contains:

- `employees`
- `courses`
- `training_records`
- `tmf_documents`
- `issues`
- `deliverables`

The SQL layer demonstrates:

- Relational table design
- Primary keys
- Foreign keys
- JOINs
- Filtering
- Aggregation
- GROUP BY
- HAVING
- CASE expressions
- Subqueries
- UNION
- COUNT(DISTINCT)
- Conditional aggregation
- Cross-domain operational reporting

SQL queries are organized in the `sql/` directory.

---

## API Integration

The project includes a simulated external training-system API response represented as JSON.

Example data fields include:

```text
employeeId
courseCode
trainingStatus
completedAt
```

The simulated API data is mapped to the internal data model:

```text
employeeId     → employee_id
courseCode     → course_id
trainingStatus → status
completedAt    → completed_date
```

Validation rules check whether:

- The employee exists
- The course exists
- Completed training has a completion date

The API component is intentionally presented as a **simulated API integration**, rather than a production external API.

---

## Node.js Automation

Node.js is used to automate processing of incoming training records.

The automation workflow is:

```text
JSON Input
    ↓
Read Records
    ↓
Validate Records
    ↓
PASS / FAIL
    ↓
Accepted / Rejected
    ↓
Generate JSON Outputs
    ↓
Generate Processing Summary
```

Validation includes:

- Employee ID validation
- Course ID validation
- Completion-date validation

The automation produces:

- `accepted_training.json`
- `rejected_training.json`
- `processing_summary.json`

Rejected records include a validation reason, allowing problematic records to be reviewed rather than silently discarded.

---

## Project Structure

```text
clinical-systems-support-tracker/
│
├── README.md
│
├── excel/
│   └── Clinical-Systems-Support-Tracker.xlsx
│
├── sql/
│   ├── schema.sql
│   ├── training_queries.sql
│   ├── tmf_queries.sql
│   ├── issue_queries.sql
│   └── operational_queries.sql
│
├── api/
│   └── api_training_data.json
│
├── automation/
│   ├── process_training.js
│   ├── accepted_training.json
│   ├── rejected_training.json
│   └── processing_summary.json
│
├── documentation/
│   └── data-model.md
│
└── screenshots/
    ├── training-dashboard.png
    ├── tmf-dashboard.png
    └── data-quality.png
```

---

## Screenshots

### Training Dashboard

![Training Dashboard](screenshots/training-dashboard.png)

### TMF Dashboard

![TMF Dashboard](screenshots/tmf-dashboard.png)

### Data Quality

![Data Quality](screenshots/data-quality.png)

---

## Key Skills Demonstrated

### Excel

- Advanced formulas
- Data validation
- Conditional formatting
- PivotTables
- KPI calculations
- Dashboard development

### Power Query

- Data cleaning
- Transformation
- Merging datasets
- Data validation
- Refreshable workflows

### SQL

- Relational database design
- JOINs
- Aggregations
- GROUP BY / HAVING
- CASE logic
- Subqueries
- Cross-domain reporting

### API / Data Integration

- JSON data structures
- Field mapping
- Validation rules
- External-to-internal data transformation

### JavaScript / Node.js

- JSON processing
- Array operations
- Validation functions
- Automated routing
- File generation
- Processing summaries

---

## Key Learnings

This project demonstrates how different technologies can work together rather than replacing one another.

Excel provides operational tracking and visualization.

Power Query provides repeatable data preparation.

SQL provides structured storage and analytical querying.

API integration demonstrates how external data can enter the system.

Node.js automation demonstrates how validation and data-routing processes can be automated.

Together, these components form a small but complete data-management workflow.

---

## Project Status

**Completed**

The project covers the full workflow from operational data capture and quality control through SQL reporting, simulated API integration, and automated data validation.
