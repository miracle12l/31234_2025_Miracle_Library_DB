# 31234_2025_Miracle_Library_DB

## Miracle Library Database Management System

### Project Overview
The **31234_2025_Miracle_Library_DB** is a Library Management Information System (MIS) designed to automate and manage the daily operations of a library. The system enables librarians to manage books, members, borrowing, returns, and fine payments while enforcing business rules through database constraints, triggers, and stored procedures.

---

# Objectives

- Automate library operations.
- Improve accuracy of borrowing and return records.
- Enforce business policies using database rules.
- Reduce manual work for librarians.
- Maintain secure and reliable records.

---

# Business Processes

## 1. Book Acquisition and Cataloging
- Librarian registers new books.
- System validates ISBN uniqueness.
- Book status is automatically set to **AVAILABLE**.
- Available copy count is recorded.

---

## 2. Member Registration
- Register students and staff.
- Generate a unique Member ID.
- Set account status to **ACTIVE**.
- Assign borrowing limits:
  - Student: Maximum 3 books
  - Staff: Maximum 5 books

---

## 3. Book Borrowing
Before issuing a book, the system verifies:

- Book is available.
- Member has not exceeded borrowing limit.
- Member has no unpaid fines.
- Borrowing is performed during allowed working hours.

If all conditions are satisfied:

- Borrow transaction is recorded.
- Due date is automatically set to 14 days.
- Available copies decrease.

---

## 4. Book Return
When a member returns a book:

- Return date is recorded.
- Due date is compared with return date.
- If overdue, the system calculates the fine.
- Available copies increase.
- Book status becomes AVAILABLE.

---

## 5. Fine Payment
- Member pays outstanding fine.
- Payment is recorded.
- Outstanding balance is updated.
- Receipt/payment history is maintained.

---

# Business Rules

The system enforces the following rules:

- Every ISBN must be unique.
- Members cannot borrow unavailable books.
- Students can borrow a maximum of 3 books.
- Staff can borrow a maximum of 5 books.
- Members with unpaid fines cannot borrow books.
- Borrowing transactions are not allowed during weekends or holidays.
- Every borrowing, return, and administrative update is recorded in the audit log.
- Due date is automatically generated as 14 days after borrowing.
- Overdue fine is RWF 500 ($0.50 equivalent in project specification) per overdue day.

---

# Database Features

The project includes:

- Tables
- Primary Keys
- Foreign Keys
- Constraints
- Views
- Stored Procedures
- Functions
- Triggers
- Audit Logging
- Sample Data

---

# Main Modules

- Book Management
- Member Management
- Borrowing Management
- Return Management
- Fine Management
- Audit Management

---

# Technologies Used

- MySQL
- SQL
- phpMyAdmin (or MySQL Workbench)

---

# Expected Output

The system allows librarians to:

- Register books
- Register members
- Borrow books
- Return books
- Calculate fines automatically
- Record fine payments
- Generate reports
- Maintain audit history

---

# Author

Project Title:
**31234_2025_Miracle_Library_DB**

Course:
**Management Information Systems (MIS)**

Academic Year:
**2025**
