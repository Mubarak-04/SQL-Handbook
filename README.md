# 📘 SQL Handbook — Complete Interview & Revision Guide

A structured, hands-on SQL repository covering **core SQL → advanced performance → real-world data engineering concepts**.

This handbook is designed for:

✔ Interview revision
✔ Data Analyst / Data Engineer preparation
✔ Quick SQL concept lookup
✔ Real-world query practice
✔ GitHub portfolio demonstration

---

# 📂 Repository Structure

```
SQL-Handbook
 ├── 01_SQL_Basics.sql
 ├── 02_Joins.sql
 ├── 03_Window_Functions.sql
 ├── 04_Performance.sql
 ├── 05_Advanced.sql
 └── README.md
```

---

# 🚀 01_SQL_Basics.sql

### 🔹 Covers

* DDL & DML
* CTAS (Create Table As Select)
* Temporary tables
* CTE (WITH clause)
* ALTER operations
* WHERE filtering
* Constraints (PK, FK, UNIQUE)
* Aggregations
* CASE statements
* NULL handling
* String functions
* Subqueries
* Views

### 🧠 Why important

This file builds the **foundation of SQL thinking**:

* Data creation & manipulation
* Filtering logic
* Handling messy real-world data
* Reusable query design

---

# 🔗 02_Joins.sql

### 🔹 Covers

* Inner Join
* Left Join
* Right Join
* Cross Join
* Aggregated joins
* Self Join (interview favorite)
* Full outer join simulation (MySQL trick)

### 🧠 Why important

Joins represent **real-world data modeling**:

* Connecting multiple business entities
* Reporting pipelines
* Relationship-based analytics

Interviewers heavily test joins.

---

# 📊 03_Window_Functions.sql

### 🔹 Covers

* Running totals
* ROW_NUMBER (deduplication)
* RANK / DENSE_RANK
* PERCENT_RANK
* NTILE (bucketing)
* LAG / LEAD
* FIRST_VALUE / LAST_VALUE
* NTH_VALUE

### 🧠 Why important

Window functions are **analytical SQL superpowers**:

* De-duplication pipelines
* Trend analysis
* Session analytics
* Ranking dashboards
* Time-based comparison

Highly valued in analytics & data engineering roles.

---

# ⚡ 04_Performance.sql

### 🔹 Covers

* Index creation
* Query plan inspection (EXPLAIN)
* JSON execution plan
* Range partitioning
* List partitioning
* Hash partitioning
* Subpartitioning
* Partition pruning
* Index + partition optimization

### 🧠 Why important

This file shows **production-level SQL maturity**:

* Query optimization
* Large dataset handling
* Storage-level design
* Performance debugging

This is what separates **junior vs strong SQL developers**.

---

# 🧠 05_Advanced.sql

### 🔹 Covers

* Date & time operations
* Regular expressions (data validation)
* Transactions (ACID concepts)
* Savepoints
* Grant & revoke (security)
* Normalization (1NF → 3NF)
* Slowly Changing Dimensions (Type 1/2/3)
* Triggers

### 🧠 Why important

These concepts are critical for:

* Data warehouse modeling
* ETL pipeline correctness
* Data governance
* Historical tracking
* Automation inside databases

---

# 🛠 How to Run

```sql
CREATE DATABASE de_project;
USE de_project;
```

Then execute files in order:

```
01_SQL_Basics.sql
02_Joins.sql
03_Window_Functions.sql
04_Performance.sql
05_Advanced.sql
```

---

# 🎯 Key Interview Concepts Covered

✔ Deduplication using ROW_NUMBER
✔ Soft delete design
✔ Partition pruning
✔ Full outer join simulation
✔ Slowly changing dimensions
✔ Transaction rollback logic
✔ Regex data validation
✔ Trigger-based automation

---

# 📈 Learning Outcomes

After completing this repository you will understand:

* Writing production-ready SQL
* Designing normalized schemas
* Optimizing queries for large datasets
* Implementing historical data tracking
* Analytical SQL patterns used in industry

---

# ⭐ Future Improvements (Planned)

* Stored procedures
* Dynamic SQL
* Advanced indexing strategies
* Query tuning case studies
* Real-world analytics interview questions

---

# 🙌 Author Notes

This repository is built as a **personal SQL mastery notebook** and continuously expanded with:

* Interview learnings
* Performance experiments
* Real-world data modeling patterns

If this helps you — ⭐ the repo.

---

