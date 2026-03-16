/* =========================================================
   MYSQL SAFE MODES & RESTRICTIONS CHEAT SHEET
   =========================================================
*/

-- ---------------------------------------------------------
-- 1. SAFE UPDATE MODE (Error 1175 fix)
-- Controls if UPDATE/DELETE requires a KEY in the WHERE clause.
-- ---------------------------------------------------------

-- Check current status (1 = ON, 0 = OFF)
SELECT @@SQL_SAFE_UPDATES AS 'Safe_Update_Status';

-- TURN OFF: Allows updating without a Primary Key
SET SQL_SAFE_UPDATES = 0;

-- TURN ON: Re-enables the safety net (Recommended)
SET SQL_SAFE_UPDATES = 1;


-- ---------------------------------------------------------
-- 2. READ ONLY MODE (Server-wide)
-- Controls if the entire DB is locked for maintenance/replication.
-- ---------------------------------------------------------

-- Check current status
SHOW VARIABLES LIKE 'read_only';

-- TURN ON: Locks the DB (Requires SUPER privileges)
-- SET GLOBAL read_only = ON; 

-- TURN OFF: Unlocks the DB
-- SET GLOBAL read_only = OFF;


-- ---------------------------------------------------------
-- 3. SQL MODE (Strict Mode)
-- Controls how MySQL handles "bad" or "imperfect" data.
-- ---------------------------------------------------------

-- Check current SQL Mode settings
SELECT @@sql_mode AS 'Current_SQL_Mode';

-- SET TO STRICT: Fails if data is invalid (Best for data integrity)
SET sql_mode = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';

-- SET TO LOOSE: Allows data truncation/warnings instead of errors
-- SET sql_mode = '';


-- ---------------------------------------------------------
-- 4. FILE PRIVILEGES (Import/Export)
-- Shows where you are allowed to save/load files.
-- ---------------------------------------------------------

-- View the allowed directory (This cannot be changed via SQL)
SHOW VARIABLES LIKE 'secure_file_priv';