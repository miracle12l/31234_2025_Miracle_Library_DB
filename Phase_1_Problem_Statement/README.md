# 31234_2025_Miracle_Library_DB

## Capstone Project Information
* **Course Code & Name:** DPR400210 - Database Programming
* **Academic Year:** 2025-2026
* **Institution:** UNILAK (University of Lay Adventists of Kigali)
* **Student Name:** Miracle
* **Student ID:** 31234/2025
* **Instructor:** Eric Maniraguha

---

## PHASE I: PROBLEM STATEMENT

### 1. Problem Definition & Analysis
Manual library operations create bottlenecks in tracking physical books, monitoring loan durations, and applying policy rules. Key challenges include:
* Misplaced physical ledger records for book loans and returns.
* Late returns going untracked, resulting in uncollected fines.
* Difficulty in real-time tracking of available inventory.
* Absence of automated system locks during non-working days or holidays.

### 2. Context of Use
An automated Oracle Database management system for academic libraries to manage cataloging, member subscriptions, book checkouts, returns, fine processing, and activity auditing.

### 3. Target Users
* **Librarians / System Administrators:** Book entry, user management, audit review, and reports.
* **Library Members (Students & Staff):** Searching books, issuing borrowing requests, returning books.

### 4. Project Objectives
* Design a normalized relational database (up to 3NF).
* Write PL/SQL stored procedures, functions, and packages for transactions.
* Create triggers to block dynamic operations during weekdays and public holidays.
* Implement user activity audit logging for system security.

### 5. Expected Benefits
* Real-time visibility into book availability.
* 100% policy enforcement through database triggers.
* Full transparency and security via automated auditing.