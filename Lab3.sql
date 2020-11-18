-- Joshua Membreno
-- #1
create or replace 
PROCEDURE FIND_EMPL_DAT
(p_empnum IN emp.empno%TYPE)
AS
rec_empdat emp%ROWTYPE;
BEGIN
  SELECT *
  INTO rec_empdat
  FROM emp
  WHERE empno = p_empnum;
  
  EXCEPTION
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('Employee does not exist!');
END FIND_EMPL_DAT;
/
BEGIN

END;
/