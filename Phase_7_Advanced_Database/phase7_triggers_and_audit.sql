-- =========================================================
-- Project: 31234_2025_Miracle_Library_DB
-- Phase: VII - Advanced Database Features (Triggers & Audit Log)
-- =========================================================

-- 1. CREATE AUDIT LOG TABLE & SEQUENCE
CREATE SEQUENCE SEQ_AUDIT_ID START WITH 1 INCREMENT BY 1;

CREATE TABLE AUDIT_LOGS (
    audit_id NUMBER DEFAULT SEQ_AUDIT_ID.NEXTVAL PRIMARY KEY,
    table_name VARCHAR2(50) NOT NULL,
    operation_type VARCHAR2(20) NOT NULL,
    user_id VARCHAR2(50) DEFAULT USER NOT NULL,
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    details VARCHAR2(4000)
);

-- 2. TRIGGER 1: Restrict Borrowing Operations Outside Business Schedule (Weekends)
CREATE OR REPLACE TRIGGER trg_enforce_operating_schedule
BEFORE INSERT OR UPDATE OR DELETE ON BORROW_TRANSACTIONS
BEGIN
    -- Restrict operations on Saturday (7) and Sunday (1)
    IF TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH') IN ('SAT', 'SUN') THEN
        RAISE_APPLICATION_ERROR(-20005, 'Database Policy: Borrowing operations are restricted on weekends.');
    END IF;
END;
/

-- 3. TRIGGER 2: Automatic Audit Logging for Book Inventory Updates
CREATE OR REPLACE TRIGGER trg_audit_books_changes
AFTER INSERT OR UPDATE OR DELETE ON BOOKS
FOR EACH ROW
DECLARE
    v_op VARCHAR2(20);
    v_info VARCHAR2(4000);
BEGIN
    IF INSERTING THEN
        v_op := 'INSERT';
        v_info := 'Added new book ID: ' || :NEW.book_id || ' - Title: ' || :NEW.title;
    ELSIF UPDATING THEN
        v_op := 'UPDATE';
        v_info := 'Updated book ID: ' || :NEW.book_id || ' - Old Title: ' || :OLD.title || ' | New Title: ' || :NEW.title;
    ELSIF DELETING THEN
        v_op := 'DELETE';
        v_info := 'Deleted book ID: ' || :OLD.book_id || ' - Title: ' || :OLD.title;
    END IF;

    INSERT INTO AUDIT_LOGS (table_name, operation_type, details)
    VALUES ('BOOKS', v_op, v_info);
END;
/