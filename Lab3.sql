-- Joshua Membreno
-- #1
CREATE OR REPLACE 
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
-- #2
CREATE OR REPLACE FUNCTION DATE_COMPARISON 
(p_date1 IN DATE,
 p_date2 IN DATE)
RETURN INTEGER 
AS
lv_dat_hold INT;
BEGIN
--SELECT TO_DATE(p_date1) - TO_DATE(p_date2)
--INTO lv_dat_hold
--FROM DUAL;
    IF p_date1 < p_date2 THEN
        lv_dat_hold := -1;
    ELSIF p_date1 = p_date2 THEN
        lv_dat_hold := 0;
    ELSIF p_date1 > p_date2 THEN
        lv_dat_hold := 1;
    END IF;
  RETURN lv_dat_hold;
END DATE_COMPARISON;
/

ACCEPT p_date1 DATE PROMPT 'Please enter date1:'
ACCEPT p_date2 DATE PROMPT 'Please enter date2:'
DECLARE
    p_date1 DATE;
    p_date2 DATE;
BEGIN
    p_date1 := '&p_date1';
    p_date2 := '&p_date2';
    
dbms_output.put_line('If '||p_date1||' is less than '||p_date2||
                    ' the result is: '||DATE_COMPARISON(p_date1, p_date2));
dbms_output.put_line('If '||p_date1||' is equal to '||p_date1||
                    ' the result is: '||DATE_COMPARISON(p_date1, p_date1));
dbms_output.put_line('If '||p_date2||' is greater than '||p_date1||
                    ' the result is: '||DATE_COMPARISON(p_date2, p_date1));
END;
/
-- #3
CREATE OR REPLACE 
PROCEDURE CUSTOMER_ACC_INFO 
(p_accid    IN customer.account_id%TYPE,
 p_custname OUT customer.cust_name%TYPE,
 p_custid   OUT customer.cust_id%TYPE,
 p_acctype  OUT customer.account_type%TYPE,
 p_state    OUT customer.state%TYPE)
AS 
BEGIN
  SELECT cust_name, cust_id, account_type, state
  INTO p_custname, p_custid, p_acctype, p_state
  FROM customer
  WHERE account_id = p_accid;
  
  EXCEPTION
    WHEN no_data_found THEN
    dbms_output.put_line('Cust_ID not valid');
END CUSTOMER_ACC_INFO;
/
DECLARE
lv_custname  customer.cust_name%TYPE;
lv_cust_id     customer.cust_id%TYPE;
lv_acctype   customer.account_type%TYPE;
lv_state     customer.state%TYPE;
BEGIN
    CUSTOMER_ACC_INFO('A-11102', lv_custname, lv_cust_id, lv_acctype, lv_state);
     dbms_output.put_line('A-11102'||'     '||lv_custname||'     '||lv_cust_id||
                          '   '||lv_acctype||'      '||lv_state);

    CUSTOMER_ACC_INFO('J-80808', lv_custname, lv_cust_id, lv_acctype, lv_state);
     dbms_output.put_line('J-80808'||'     '||lv_custname||'     '||lv_cust_id||
                          '   '||lv_acctype||'      '||lv_state);
END;
/
-- #4
DROP TABLE pysician;
CREATE TABLE physician (
)
-- populate table
--COMMIT;
-- anon block X2
-- select * into from physicial where physician id =
-- SQL%FOUND 
-- update
-- commit;
--exception when no_data_found THEN insert
--COMMIT;