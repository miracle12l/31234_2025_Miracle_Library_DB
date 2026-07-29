# Phase VI: PL/SQL Programming (Procedures, Functions & Packages)

## 1. Overview
This phase encapsulates core business transactional logic using Oracle PL/SQL for **31234_2025_Miracle_Library_DB**.

## 2. Components Created
* **`fn_calculate_fine`**: Autonomous function calculating overdue penalties (RWF 500/day).
* **`sp_borrow_book`**: Stored procedure handling book checkout validation and stock status update.
* **`pkg_library_mgmt`**: PL/SQL package encapsulating return transactions and automated fine generation (`sp_return_book`).

## 3. Execution & Testing
Run `phase6_plsql_scripts.sql` inside Oracle SQL Developer while logged into the `31234_2025_Miracle_Library_DB` account.