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
  
dbms_output.put_line(rec_empdat.empno||' '||rec_empdat.ename||' '||
      rec_empdat.job||' '||rec_empdat.mgr||' '||rec_empdat.hiredate||' '||
      rec_empdat.sal||' '||rec_empdat.comm||' '||rec_empdat.deptno);

EXCEPTION
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('Employee does not exist!');
END FIND_EMPL_DAT;
/
BEGIN
FIND_EMPL_DAT(7902);
FIND_EMPL_DAT(7935);
END;
/