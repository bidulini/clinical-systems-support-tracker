# Clinical Systems Support Tracker — Data Model

## Overview

The project uses a relational data model to separate stable master data from operational data.

The main entities are:

- Employees
- Courses
- Training Records
- TMF Documents
- Issues
- Deliverables

This structure supports data quality checks, reporting, SQL analysis, Power Query transformations, API integration, and automation.

---

## Master Data

### Employees

Stores stable information about people working within the clinical operations environment.

| Field | Description |
|---|---|
| Employee ID | Unique employee identifier |
| Person Name | Employee name |
| Role | Employee role |
| Department | Functional department |

Employee ID is the primary identifier.

---

### Courses

Stores the master list of available training courses.

| Field | Description |
|---|---|
| Course ID | Unique course identifier |
| Training Name | Name of the training |
| Category | Training category |
| Required | Whether the training is mandatory |
| Validity Months | Training validity period |

Course ID is the primary identifier.

---

## Operational Data

### Training Records

Connects employees with training courses and stores assignment, completion, and status information.

Key relationships:

```text
Employees
    │
    │ Employee ID
    ▼
Training Records
    ▲
    │ Course ID
    │
Courses