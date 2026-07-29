# Phase VII: Advanced Database Features (Triggers & Audit Logging)

## 1. Overview
This phase implements proactive policy enforcement and automated system-wide auditing for **31234_2025_Miracle_Library_DB**.

## 2. Advanced Features Implemented
* **`AUDIT_LOGS` Table & Sequence**: Maintains secure records of critical database DML changes.
* **`trg_enforce_operating_schedule` Trigger**: Enforces system security rules by preventing checkout modifications on non-working days (weekends).
* **`trg_audit_books_changes` Trigger**: Automatically captures `INSERT`, `UPDATE`, and `DELETE` operations on the catalog, logging user details and action timestamps.

## 3. Execution & Verification
Run `phase7_triggers_and_audit.sql` in Oracle SQL Developer under the `31234_2025_Miracle_Library_DB` connection.