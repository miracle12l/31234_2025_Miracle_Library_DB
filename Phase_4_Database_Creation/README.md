# Phase IV: Database Schema Creation & Privilege Management

## 1. Overview
This phase handles the creation of the Oracle Database schema, tablespace configuration, user role assignment, and privilege allocation for **31234_2025_Miracle_Library_DB**.

---

## 2. SQL Setup Script (`phase4_setup.sql`)

```sql
-- =========================================================
-- Project: Library Management System
-- Schema: 31234_2025_Miracle_Library_DB
-- Phase: IV - User & Privilege Setup
-- =========================================================

-- 1. Create User / Schema
CREATE USER "31234_2025_Miracle_Library_DB" IDENTIFIED BY "Library2026#";

-- 2. Allocate Quota
ALTER USER "31234_2025_Miracle_Library_DB" QUOTA UNLIMITED ON USERS;

-- 3. Grant Core System Roles & Privileges
GRANT CONNECT, RESOURCE, DBA TO "31234_2025_Miracle_Library_DB";
GRANT CREATE SESSION TO "31234_2025_Miracle_Library_DB";
GRANT CREATE TABLE TO "31234_2025_Miracle_Library_DB";
GRANT CREATE SEQUENCE TO "31234_2025_Miracle_Library_DB";
GRANT CREATE PROCEDURE TO "31234_2025_Miracle_Library_DB";
GRANT CREATE TRIGGER TO "31234_2025_Miracle_Library_DB";
GRANT CREATE VIEW TO "31234_2025_Miracle_Library_DB";

-- Verification Query
SELECT username, account_status, default_tablespace 
FROM dba_users 
WHERE username = '31234_2025_MIRACLE_LIBRARY_DB';
-- Project: Library Management System
-- Schema Setup Script for 31234_2025_Miracle_Library_DB

CREATE USER "31234_2025_Miracle_Library_DB" IDENTIFIED BY "Library2026#";

ALTER USER "31234_2025_Miracle_Library_DB" QUOTA UNLIMITED ON USERS;

GRANT CONNECT, RESOURCE, DBA TO "31234_2025_Miracle_Library_DB";
GRANT CREATE SESSION TO "31234_2025_Miracle_Library_DB";
GRANT CREATE TABLE TO "31234_2025_Miracle_Library_DB";
GRANT CREATE SEQUENCE TO "31234_2025_Miracle_Library_DB";
GRANT CREATE PROCEDURE TO "31234_2025_Miracle_Library_DB";
GRANT CREATE TRIGGER TO "31234_2025_Miracle_Library_DB";
GRANT CREATE VIEW TO "31234_2025_Miracle_Library_DB";