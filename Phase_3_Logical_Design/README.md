# Phase III: Logical Database Design & 3NF Normalization

## 1. Entity-Relationship (ER) Overview & Entities

The **31234_2025_Miracle_Library_DB** database is designed with normalized tables to ensure data integrity, eliminate duplicate records, and support transaction auditing.

### Key Entities:
1. **MEMBERS:** Stores library user details (Students and Staff).
2. **BOOKS:** Core book catalog information.
3. **BOOK_COPIES:** Tracks physical copies of books available in inventory.
4. **BORROW_TRANSACTIONS:** Records borrowing and return transactions.
5. **FINES:** Tracks penalty calculations for late returns.
6. **AUDIT_LOGS:** Records database-level activity for compliance and security.

---

## 2. Relational Schema in Third Normal Form (3NF)

### 🟢 `MEMBERS`
* `member_id` (PK, NUMBER) — Unique member identifier
* `first_name` (VARCHAR2(50)) — First name
* `last_name` (VARCHAR2(50)) — Last name
* `email` (VARCHAR2(100), UNIQUE) — Email address
* `phone` (VARCHAR2(20)) — Contact number
* `member_type` (VARCHAR2(20)) — 'STUDENT' or 'STAFF'
* `registration_date` (DATE) — Date account was created
* `status` (VARCHAR2(20)) — 'ACTIVE' or 'SUSPENDED'

### 🟢 `BOOKS`
* `book_id` (PK, NUMBER) — Unique book title identifier
* `isbn` (VARCHAR2(20), UNIQUE) — International Standard Book Number
* `title` (VARCHAR2(200)) — Title of the book
* `author` (VARCHAR2(100)) — Author name
* `publisher` (VARCHAR2(100)) — Publishing company
* `publication_year` (NUMBER(4)) — Year published
* `category` (VARCHAR2(50)) — Genre/Subject classification

### 🟢 `BOOK_COPIES`
* `copy_id` (PK, NUMBER) — Unique physical copy barcode identifier
* `book_id` (FK, NUMBER) — References `BOOKS(book_id)`
* `status` (VARCHAR2(20)) — 'AVAILABLE', 'BORROWED', or 'MAINTENANCE'

### 🟢 `BORROW_TRANSACTIONS`
* `transaction_id` (PK, NUMBER) — Unique transaction identifier
* `copy_id` (FK, NUMBER) — References `BOOK_COPIES(copy_id)`
* `member_id` (FK, NUMBER) — References `MEMBERS(member_id)`
* `borrow_date` (DATE) — Date book was checked out
* `due_date` (DATE) — Required return date
* `return_date` (DATE, NULLABLE) — Actual return date
* `status` (VARCHAR2(20)) — 'ISSUED' or 'RETURNED'

### 🟢 `FINES`
* `fine_id` (PK, NUMBER) — Unique fine record
* `transaction_id` (FK, NUMBER) — References `BORROW_TRANSACTIONS(transaction_id)`
* `amount` (NUMBER(8,2)) — Fine total (RWF/USD)
* `status` (VARCHAR2(20)) — 'UNPAID' or 'PAID'

---

## 3. Normalization Justification (1NF ➔ 2NF ➔ 3NF)

* **1NF (First Normal Form):** All columns contain atomic values; no multi-valued attributes or repeating groups.
* **2NF (Second Normal Form):** All non-key attributes are fully functionally dependent on the primary key (e.g., separating physical `BOOK_COPIES` from abstract `BOOKS`).
* **3NF (Third Normal Form):** No transitive dependencies exist. Fine amounts and borrow status depend directly on their primary transaction keys.