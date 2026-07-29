-- =========================================================
-- Project: 31234_2025_Miracle_Library_DB
-- Phase: VI - PL/SQL Programming (Procedures, Functions & Packages)
-- =========================================================

-- 1. FUNCTION: Calculate Late Fines
CREATE OR REPLACE FUNCTION fn_calculate_fine (
    p_due_date IN DATE,
    p_return_date IN DATE
) RETURN NUMBER IS
    v_days_overdue NUMBER := 0;
    v_daily_rate NUMBER := 500; -- RWF 500 per day
    v_total_fine NUMBER := 0;
BEGIN
    IF p_return_date > p_due_date THEN
        v_days_overdue := TRUNC(p_return_date) - TRUNC(p_due_date);
        v_total_fine := v_days_overdue * v_daily_rate;
    END IF;
    RETURN v_total_fine;
END fn_calculate_fine;
/

-- 2. PROCEDURE: Check-Out Book
CREATE OR REPLACE PROCEDURE sp_borrow_book (
    p_member_id IN NUMBER,
    p_copy_id IN NUMBER,
    p_days_allowed IN NUMBER DEFAULT 14
) IS
    v_copy_status VARCHAR2(20);
    v_member_status VARCHAR2(20);
BEGIN
    -- Verify Member Status
    SELECT status INTO v_member_status FROM MEMBERS WHERE member_id = p_member_id;
    IF v_member_status != 'ACTIVE' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Borrowing failed: Member account is suspended.');
    END IF;

    -- Verify Copy Status
    SELECT status INTO v_copy_status FROM BOOK_COPIES WHERE copy_id = p_copy_id;
    IF v_copy_status != 'AVAILABLE' THEN
        RAISE_APPLICATION_ERROR(-20002, 'Borrowing failed: Book copy is not available.');
    END IF;

    -- Record Transaction
    INSERT INTO BORROW_TRANSACTIONS (copy_id, member_id, borrow_date, due_date, status)
    VALUES (p_copy_id, p_member_id, SYSDATE, SYSDATE + p_days_allowed, 'ISSUED');

    -- Update Copy Status
    UPDATE BOOK_COPIES SET status = 'BORROWED' WHERE copy_id = p_copy_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Book copy ' || p_copy_id || ' successfully issued to member ' || p_member_id);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'Invalid Member ID or Copy ID.');
END sp_borrow_book;
/

-- 3. PACKAGE SPECIFICATION: Library Operations Package
CREATE OR REPLACE PACKAGE pkg_library_mgmt AS
    PROCEDURE sp_return_book(p_transaction_id IN NUMBER);
END pkg_library_mgmt;
/

-- 4. PACKAGE BODY: Library Operations Package
CREATE OR REPLACE PACKAGE BODY pkg_library_mgmt AS
    PROCEDURE sp_return_book(p_transaction_id IN NUMBER) IS
        v_copy_id NUMBER;
        v_due_date DATE;
        v_fine_amount NUMBER;
    BEGIN
        -- Fetch Transaction Details
        SELECT copy_id, due_date INTO v_copy_id, v_due_date
        FROM BORROW_TRANSACTIONS
        WHERE transaction_id = p_transaction_id AND status = 'ISSUED';

        -- Update Transaction Return Date & Status
        UPDATE BORROW_TRANSACTIONS
        SET return_date = SYSDATE, status = 'RETURNED'
        WHERE transaction_id = p_transaction_id;

        -- Update Physical Copy Status
        UPDATE BOOK_COPIES SET status = 'AVAILABLE' WHERE copy_id = v_copy_id;

        -- Calculate & Process Fine
        v_fine_amount := fn_calculate_fine(v_due_date, SYSDATE);
        IF v_fine_amount > 0 THEN
            INSERT INTO FINES (transaction_id, amount, status)
            VALUES (p_transaction_id, v_fine_amount, 'UNPAID');
            DBMS_OUTPUT.PUT_LINE('Book returned with fine generated: RWF ' || v_fine_amount);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Book returned successfully on time.');
        END IF;

        COMMIT;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20004, 'Active transaction not found for ID: ' || p_transaction_id);
    END sp_return_book;
END pkg_library_mgmt;
/