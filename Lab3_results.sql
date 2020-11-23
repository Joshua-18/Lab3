SQL> @ C:\Users\Joshua\Documents\itse1345\competency_3\Lab3\Lab3.sql
SQL> -- Joshua Membreno
SQL> -- #1
SQL> CREATE OR REPLACE 
  2  PROCEDURE FIND_EMPL_DAT
  3  (p_empnum IN emp.empno%TYPE)
  4  AS
  5  rec_empdat emp%ROWTYPE;
  6  BEGIN
  7    SELECT *
  8    INTO rec_empdat
  9    FROM emp
 10    WHERE empno = p_empnum;
 11  
 12  dbms_output.put_line(rec_empdat.empno||' '||rec_empdat.ename||' '||
 13        rec_empdat.job||' '||rec_empdat.mgr||' '||rec_empdat.hiredate||' '||
 14        rec_empdat.sal||' '||rec_empdat.comm||' '||rec_empdat.deptno);
 15  
 16  EXCEPTION
 17      WHEN no_data_found THEN
 18          DBMS_OUTPUT.PUT_LINE('Employee does not exist!');
 19  END FIND_EMPL_DAT;
 20  /

Procedure FIND_EMPL_DAT compiled

SQL> BEGIN
  2  FIND_EMPL_DAT(7902);
  3  FIND_EMPL_DAT(7935);
  4  END;
  5  /
7902 FORD ANALYST 7566 03-DEC-95 3000  20
Employee does not exist!


PL/SQL procedure successfully completed.

SQL> -- #2
SQL> CREATE OR REPLACE FUNCTION DATE_COMPARISON 
  2  (p_date1 IN DATE,
  3   p_date2 IN DATE)
  4  RETURN INTEGER 
  5  AS
  6  lv_dat_hold INT;
  7  BEGIN
  8  --SELECT TO_DATE(p_date1) - TO_DATE(p_date2)
  9  --INTO lv_dat_hold
 10  --FROM DUAL;
 11      IF p_date1 < p_date2 THEN
 12          lv_dat_hold := -1;
 13      ELSIF p_date1 = p_date2 THEN
 14          lv_dat_hold := 0;
 15      ELSIF p_date1 > p_date2 THEN
 16          lv_dat_hold := 1;
 17      END IF;
 18    RETURN lv_dat_hold;
 19  END DATE_COMPARISON;
 20  /

Function DATE_COMPARISON compiled

SQL> 
SQL> ACCEPT p_date1 DATE PROMPT 'Please enter date1:'
SQL> ACCEPT p_date2 DATE PROMPT 'Please enter date2:'
SQL> DECLARE
  2      p_date1 DATE;
  3      p_date2 DATE;
  4  BEGIN
  5      p_date1 := '&p_date1';
  6      p_date2 := '&p_date2';
  7  
  8  dbms_output.put_line('If '||p_date1||' is less than '||p_date2||
  9                      ' the result is: '||DATE_COMPARISON(p_date1, p_date2));
 10  dbms_output.put_line('If '||p_date1||' is equal to '||p_date1||
 11                      ' the result is: '||DATE_COMPARISON(p_date1, p_date1));
 12  dbms_output.put_line('If '||p_date2||' is greater than '||p_date1||
 13                      ' the result is: '||DATE_COMPARISON(p_date2, p_date1));
 14  END;
 15  /
old:DECLARE
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

new:DECLARE
    p_date1 DATE;
    p_date2 DATE;
BEGIN
    p_date1 := '01-jan-11';
    p_date2 := '02-feb-22';

dbms_output.put_line('If '||p_date1||' is less than '||p_date2||
                    ' the result is: '||DATE_COMPARISON(p_date1, p_date2));
dbms_output.put_line('If '||p_date1||' is equal to '||p_date1||
                    ' the result is: '||DATE_COMPARISON(p_date1, p_date1));
dbms_output.put_line('If '||p_date2||' is greater than '||p_date1||
                    ' the result is: '||DATE_COMPARISON(p_date2, p_date1));
END;
If 01-JAN-11 is less than 02-FEB-22 the result is: -1
If 01-JAN-11 is equal to 01-JAN-11 the result is: 0
If 02-FEB-22 is greater than 01-JAN-11 the result is: 1


PL/SQL procedure successfully completed.

SQL> -- #3
SQL> CREATE OR REPLACE 
  2  PROCEDURE CUSTOMER_ACC_INFO 
  3  (p_accid    IN customer.account_id%TYPE,
  4   p_custname OUT customer.cust_name%TYPE,
  5   p_custid   OUT customer.cust_id%TYPE,
  6   p_acctype  OUT customer.account_type%TYPE,
  7   p_state    OUT customer.state%TYPE)
  8  AS 
  9  BEGIN
 10    SELECT cust_name, cust_id, account_type, state
 11    INTO p_custname, p_custid, p_acctype, p_state
 12    FROM customer
 13    WHERE account_id = p_accid;
 14  
 15    EXCEPTION
 16      WHEN no_data_found THEN
 17      dbms_output.put_line('Cust_ID not valid');
 18  END CUSTOMER_ACC_INFO;
 19  /

Procedure CUSTOMER_ACC_INFO compiled

SQL> DECLARE
  2  lv_custname  customer.cust_name%TYPE;
  3  lv_cust_id     customer.cust_id%TYPE;
  4  lv_acctype   customer.account_type%TYPE;
  5  lv_state     customer.state%TYPE;
  6  BEGIN
  7      CUSTOMER_ACC_INFO('A-11102', lv_custname, lv_cust_id, lv_acctype, lv_state);
  8       dbms_output.put_line('A-11102'||'     '||lv_custname||'     '||lv_cust_id||
  9                            '   '||lv_acctype||'      '||lv_state);
 10  
 11      CUSTOMER_ACC_INFO('J-80808', lv_custname, lv_cust_id, lv_acctype, lv_state);
 12       dbms_output.put_line('J-80808'||'     '||lv_custname||'     '||lv_cust_id||
 13                            '   '||lv_acctype||'      '||lv_state);
 14  END;
 15  /
A-11102     XYZ     90002   CM      NJ
Cust_ID not valid
J-80808                   


PL/SQL procedure successfully completed.

SQL> -- #4
SQL> DROP TABLE physician;

Table PHYSICIAN dropped.

SQL> CREATE TABLE physician (
  2  Phys_ID             NUMBER(3),
  3  Phys_Name           VARCHAR2(15),
  4  Phys_Phone          VARCHAR2(12),
  5  Phys_Specialty      VARCHAR2(20));

Table PHYSICIAN created.

SQL> -- populate table
SQL> DECLARE
  2  BEGIN
  3  INSERT ALL
  4      INTO physician (Phys_ID, Phys_Name, Phys_Phone, Phys_Specialty)
  5      VALUES(101,'Wilcox, Chris','512-329-1848','Eyes, Ears, Throat')
  6      INTO physician (Phys_ID, Phys_Name, Phys_Phone, Phys_Specialty)
  7      VALUES(102,'Nusca, Jane','512-516-3947','Cardiovascular')
  8      INTO physician (Phys_ID, Phys_Name, Phys_Phone, Phys_Specialty)
  9      VALUES(103,'Gomez, Juan','512-382-4987','Orthopedics')
 10      INTO physician (Phys_ID, Phys_Name, Phys_Phone, Phys_Specialty)
 11      VALUES(104,'Li, Jan','512-516-3948','Cardiovascular')
 12      INTO physician (Phys_ID, Phys_Name, Phys_Phone, Phys_Specialty)
 13      VALUES(105,'Simmons, Alex','512-442-5700','Hemotology')
 14  SELECT * FROM dual;
 15  COMMIT;
 16  END;
 17  /

PL/SQL procedure successfully completed.

SQL> -- anon block
SQL> DECLARE
  2  lv_pid      physician.phys_id%TYPE :='&Phys_ID';
  3  lv_pname    physician.phys_name%TYPE :='&Phys_Name';
  4  lv_pphone   physician.phys_phone%TYPE :='&Phys_Phone';
  5  lv_pspec    physician.phys_specialty%TYPE :='&Phys_Specialty';
  6  record_p    physician%ROWTYPE;    
  7  BEGIN
  8  -- select * into from physician where physician id =
  9  SELECT *
 10  INTO record_p
 11  FROM physician
 12  WHERE Phys_ID = lv_pid;
 13  -- SQL%FOUND
 14  IF SQL%FOUND THEN
 15  -- update
 16  UPDATE physician
 17    SET Phys_Name = lv_pname,
 18        Phys_Phone = lv_pphone,
 19        Phys_Specialty = lv_pspec
 20    WHERE Phys_ID = lv_pid;
 21    dbms_output.put_line('Physician ID: '||lv_pid||' updated!');
 22  --COMMIT;
 23  COMMIT;
 24  END IF;
 25  
 26  --exception when no_data_found THEN insert
 27  EXCEPTION
 28      WHEN no_data_found THEN
 29      INSERT INTO physician (Phys_ID, Phys_Name, Phys_Phone, Phys_Specialty)
 30      VALUES (lv_pid, lv_pname, lv_pphone, lv_pspec);
 31      dbms_output.put_line('Physician ID: '||lv_pid||' added!');
 32  COMMIT;
 33  END;
 34  /
old:DECLARE
lv_pid      physician.phys_id%TYPE :='&Phys_ID';
lv_pname    physician.phys_name%TYPE :='&Phys_Name';
lv_pphone   physician.phys_phone%TYPE :='&Phys_Phone';
lv_pspec    physician.phys_specialty%TYPE :='&Phys_Specialty';
record_p    physician%ROWTYPE;    
BEGIN
-- select * into from physician where physician id =
SELECT *
INTO record_p
FROM physician
WHERE Phys_ID = lv_pid;
-- SQL%FOUND
IF SQL%FOUND THEN
-- update
UPDATE physician
  SET Phys_Name = lv_pname,
      Phys_Phone = lv_pphone,
      Phys_Specialty = lv_pspec
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

new:DECLARE
lv_pid      physician.phys_id%TYPE :='101';
lv_pname    physician.phys_name%TYPE :='WONKA, WILLY';
lv_pphone   physician.phys_phone%TYPE :='512-662-4971';
lv_pspec    physician.phys_specialty%TYPE :='CANDY,CHOCO,APPLE';
record_p    physician%ROWTYPE;    
BEGIN
-- select * into from physician where physician id =
SELECT *
INTO record_p
FROM physician
WHERE Phys_ID = lv_pid;
-- SQL%FOUND
IF SQL%FOUND THEN
-- update
UPDATE physician
  SET Phys_Name = lv_pname,
      Phys_Phone = lv_pphone,
      Phys_Specialty = lv_pspec
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
Physician ID: 101 updated!


PL/SQL procedure successfully completed.

SQL> DECLARE
  2  lv_pid      physician.phys_id%TYPE :='&Phys_ID';
  3  lv_pname    physician.phys_name%TYPE :='&Phys_Name';
  4  lv_pphone   physician.phys_phone%TYPE :='&Phys_Phone';
  5  lv_pspec    physician.phys_specialty%TYPE :='&Phys_Specialty';
  6  record_p    physician%ROWTYPE;    
  7  BEGIN
  8  -- select * into from physician where physician id =
  9  SELECT *
 10  INTO record_p
 11  FROM physician
 12  WHERE Phys_ID = lv_pid;
 13  -- SQL%FOUND
 14  IF SQL%FOUND THEN
 15  -- update
 16  UPDATE physician
 17    SET Phys_Name = lv_pname,
 18        Phys_Phone = lv_pphone,
 19        Phys_Specialty = lv_pspec
 20    WHERE Phys_ID = lv_pid;
 21    dbms_output.put_line('Physician ID: '||lv_pid||' updated!');
 22  --COMMIT;
 23  COMMIT;
 24  END IF;
 25  
 26  --exception when no_data_found THEN insert
 27  EXCEPTION
 28      WHEN no_data_found THEN
 29      INSERT INTO physician (Phys_ID, Phys_Name, Phys_Phone, Phys_Specialty)
 30      VALUES (lv_pid, lv_pname, lv_pphone, lv_pspec);
 31      dbms_output.put_line('Physician ID: '||lv_pid||' added!');
 32  COMMIT;
 33  END;
 34  /
old:DECLARE
lv_pid      physician.phys_id%TYPE :='&Phys_ID';
lv_pname    physician.phys_name%TYPE :='&Phys_Name';
lv_pphone   physician.phys_phone%TYPE :='&Phys_Phone';
lv_pspec    physician.phys_specialty%TYPE :='&Phys_Specialty';
record_p    physician%ROWTYPE;    
BEGIN
-- select * into from physician where physician id =
SELECT *
INTO record_p
FROM physician
WHERE Phys_ID = lv_pid;
-- SQL%FOUND
IF SQL%FOUND THEN
-- update
UPDATE physician
  SET Phys_Name = lv_pname,
      Phys_Phone = lv_pphone,
      Phys_Specialty = lv_pspec
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

new:DECLARE
lv_pid      physician.phys_id%TYPE :='100';
lv_pname    physician.phys_name%TYPE :='WAYNE,BRUCE';
lv_pphone   physician.phys_phone%TYPE :='512-123-1234';
lv_pspec    physician.phys_specialty%TYPE :='HERO,CRIME,NIGHT';
record_p    physician%ROWTYPE;    
BEGIN
-- select * into from physician where physician id =
SELECT *
INTO record_p
FROM physician
WHERE Phys_ID = lv_pid;
-- SQL%FOUND
IF SQL%FOUND THEN
-- update
UPDATE physician
  SET Phys_Name = lv_pname,
      Phys_Phone = lv_pphone,
      Phys_Specialty = lv_pspec
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
Physician ID: 100 added!


PL/SQL procedure successfully completed.

SQL> SELECT *
  2  FROM physician;

   PHYS_ID PHYS_NAME       PHYS_PHONE   PHYS_SPECIALTY      
---------- --------------- ------------ --------------------
       101 WONKA, WILLY    512-662-4971 CANDY,CHOCO,APPLE   
       102 Nusca, Jane     512-516-3947 Cardiovascular      
       103 Gomez, Juan     512-382-4987 Orthopedics         
       104 Li, Jan         512-516-3948 Cardiovascular      
       105 Simmons, Alex   512-442-5700 Hemotology          
       100 WAYNE,BRUCE     512-123-1234 HERO,CRIME,NIGHT    

6 rows selected. 

SQL> -- #5
SQL> create or replace FUNCTION STRING_ADJUST
  2  (p_string   IN VARCHAR2,
  3   p_lenght   IN NUMBER)
  4  RETURN VARCHAR2
  5  AS
  6  lv_string VARCHAR2(35);
  7  BEGIN
  8  lv_string := LTRIM(p_string);
  9  IF length(lv_string) < p_lenght THEN
 10      lv_string := rpad(lv_string, p_lenght);
 11  ELSIF length(lv_string) > p_lenght THEN
 12          lv_string := substr(lv_string, 1, p_lenght);
 13  END IF;
 14   RETURN lv_string;
 15  END STRING_ADJUST;
 16  /

Function STRING_ADJUST compiled

SQL> -- test1
SQL> DECLARE
  2  lv_string VARCHAR2(20) := 'What is the Time.';
  3  lv_lenght NUMBER(3) := 8;
  4  lv_return VARCHAR2(10);
  5  BEGIN
  6  lv_return := STRING_ADJUST(lv_string, lv_lenght);
  7  dbms_output.put_line('ORIGINAL STRING: '|| lv_string);
  8  dbms_output.put_line('ADJUSTED STRING: '|| lv_return);
  9  dbms_output.put_line('ADJUSTED STRING LENGHT: '|| length(lv_return));
 10  END;
 11  /
ORIGINAL STRING: What is the Time.
ADJUSTED STRING: What is 
ADJUSTED STRING LENGHT: 8


PL/SQL procedure successfully completed.

SQL> -- test2
SQL> DECLARE
  2  lv_string VARCHAR2(35) := 'What is the Time.';
  3  lv_lenght NUMBER(3) := 25;
  4  lv_return VARCHAR2(35);
  5  BEGIN
  6  lv_return := STRING_ADJUST(lv_string, lv_lenght);
  7  dbms_output.put_line('ORIGINAL STRING: '|| lv_string);
  8  dbms_output.put_line('ADJUSTED STRING: '|| lv_return);
  9  dbms_output.put_line('ADJUSTED STRING LENGHT: '|| length(lv_return));
 10  END;
 11  /
ORIGINAL STRING: What is the Time.
ADJUSTED STRING: What is the Time.        
ADJUSTED STRING LENGHT: 25


PL/SQL procedure successfully completed.

SQL> -- test3
SQL> DECLARE
  2  lv_string VARCHAR2(40) := '    What is the Time.         ';
  3  lv_lenght NUMBER(3) := 16;
  4  lv_return VARCHAR2(40);
  5  BEGIN
  6  lv_return := STRING_ADJUST(lv_string, lv_lenght);
  7  dbms_output.put_line('ORIGINAL STRING: '|| lv_string);
  8  dbms_output.put_line('ADJUSTED STRING: '|| lv_return);
  9  dbms_output.put_line('ADJUSTED STRING LENGHT: '|| length(lv_return));
 10  END;
 11  /
ORIGINAL STRING:     What is the Time.         
ADJUSTED STRING: What is the Time
ADJUSTED STRING LENGHT: 16


PL/SQL procedure successfully completed.

SQL> spool off
