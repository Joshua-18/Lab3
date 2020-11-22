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
DROP TABLE physician;
CREATE TABLE physician (
Phys_ID             NUMBER(3),
Phys_Name           VARCHAR2(15),
Phys_Phone          VARCHAR2(12),
Phys_Specialty      VARCHAR2(20));
-- populate table
DECLARE
BEGIN
INSERT ALL
    INTO physician (Phys_ID, Phys_Name, Phys_Phone, Phys_Specialty)
    VALUES(101,'Wilcox, Chris','512-329-1848','Eyes, Ears, Throat')
    INTO physician (Phys_ID, Phys_Name, Phys_Phone, Phys_Specialty)
    VALUES(102,'Nusca, Jane','512-516-3947','Cardiovascular')
    INTO physician (Phys_ID, Phys_Name, Phys_Phone, Phys_Specialty)
    VALUES(103,'Gomez, Juan','512-382-4987','Orthopedics')
    INTO physician (Phys_ID, Phys_Name, Phys_Phone, Phys_Specialty)
    VALUES(104,'Li, Jan','512-516-3948','Cardiovascular')
    INTO physician (Phys_ID, Phys_Name, Phys_Phone, Phys_Specialty)
    VALUES(105,'Simmons, Alex','512-442-5700','Hemotology')
SELECT * FROM dual;
COMMIT;
END;
/
-- anon block
DECLARE
lv_pid      physician.phys_id%TYPE :='&Phys_ID';
lv_pname    physician.phys_name%TYPE :='&Phys_Name';
lv_pphone   physician.phys_phone%TYPE :='&Phys_Phone';
lv_pspec    physician.phys_specialty%TYPE :='&Phys_Specialty';
BEGIN
-- select * into from physician where physician id =
SELECT *
INTO lv_pid, lv_pname, lv_pphone, lv_pspec
FROM physician
WHERE Phys_ID = lv_pid;
-- SQL%FOUND
IF SQL%FOUND THEN
-- update
UPDATE physician
  SET Phys_Name = lv_pname,
      Phys_Phone = lv_pphone,
      Phys_Specialty = phys_specialty
  WHERE Phys_ID = lv_pid;
  dbms_output.put_line('Physician ID: '||lv_pid||' updated!');
--COMMIT;
COMMIT;
END IF;
--exception when no_data_found THEN insert
EXCEPTION
    WHEN no_data_found THEN
    INSERT INTO physician (Phys_ID, Phys_Name, Phys_Phone, Phys_Specialty)
    VALUES (lv_pid, lv_pname, lv_pphone, lv_pspec);
    dbms_output.put_line('Physician ID: '||lv_pid||' added!');
COMMIT;
END;
/
