DECLARE
  --deptid        employees.department_id%TYPE;
  --jobid         employees.job_id%TYPE;
  --emp_rec       markup%ROWTYPE;
  TYPE markup_tab IS TABLE OF markup%ROWTYPE;
  all_markup      markup_tab;
BEGIN
 /* SELECT department_id, job_id INTO deptid, jobid 
     FROM employees WHERE employee_id = 140;
  IF SQL%FOUND THEN 
    DBMS_OUTPUT.PUT_LINE('Dept Id: ' || deptid || ', Job Id: ' || jobid);
  END IF;
  SELECT * INTO emp_rec FROM employees WHERE employee_id = 105;*/
  SELECT * BULK COLLECT INTO all_markup FROM markup;
  DBMS_OUTPUT.PUT_LINE('Number of rows: ' || SQL%ROWCOUNT);
  
/*  for l_row IN 1 .. all_markup.COUNT
  loop
  DBMS_OUTPUT.put_line (all_markup (l_row).*);
  end loop;
*/
   FOR i IN all_markup.FIRST..all_markup.LAST LOOP
      all_markup(i).id := null;
      INSERT INTO markup VALUES all_markup(i);
   END LOOP;
   
/*   FORALL i IN all_markup.FIRST..all_markup.LAST 
      INSERT INTO markup VALUES all_markup(i);*/
commit;
END;
/




--select max(id) from markup 14


delete from markup where id > 14;
commit;


select * from markup




DECLARE
  --deptid        employees.department_id%TYPE;
  --jobid         employees.job_id%TYPE;
  --emp_rec       markup%ROWTYPE;
  TYPE markup_tab IS TABLE OF markup%ROWTYPE;
  all_markup      markup_tab;
  v_results SYS_REFCURSOR; 
BEGIN


    OPEN v_results FOR
      SELECT *
      FROM markup;
      
      
      
      
 /* SELECT department_id, job_id INTO deptid, jobid 
     FROM employees WHERE employee_id = 140;
  IF SQL%FOUND THEN 
    DBMS_OUTPUT.PUT_LINE('Dept Id: ' || deptid || ', Job Id: ' || jobid);
  END IF;
  SELECT * INTO emp_rec FROM employees WHERE employee_id = 105;*/
  SELECT * BULK COLLECT INTO all_markup FROM markup;
  DBMS_OUTPUT.PUT_LINE('Number of rows: ' || SQL%ROWCOUNT);
  
/*  for l_row IN 1 .. all_markup.COUNT
  loop
  DBMS_OUTPUT.put_line (all_markup (l_row).*);
  end loop;
*/
 /*  FOR i IN all_markup.FIRST..all_markup.LAST LOOP
      all_markup(i).id := null;
      INSERT INTO markup VALUES all_markup(i);
   END LOOP;
   */
/*   FORALL i IN all_markup.FIRST..all_markup.LAST 
      INSERT INTO markup VALUES all_markup(i);*/
commit;
END;
/

select * from v_markup

DECLARE
  --deptid        employees.department_id%TYPE;
  --jobid         employees.job_id%TYPE;
  --emp_rec       markup%ROWTYPE;
  TYPE markup_tab IS TABLE OF markup%ROWTYPE;
  all_markup      markup_tab;
BEGIN
 /* SELECT department_id, job_id INTO deptid, jobid 
     FROM employees WHERE employee_id = 140;
  IF SQL%FOUND THEN 
    DBMS_OUTPUT.PUT_LINE('Dept Id: ' || deptid || ', Job Id: ' || jobid);
  END IF;
  SELECT * INTO emp_rec FROM employees WHERE employee_id = 105;*/
  SELECT * INTO all_markup FROM markup;
  DBMS_OUTPUT.PUT_LINE('Number of rows: ' || SQL%ROWCOUNT);
  
/*  for l_row IN 1 .. all_markup.COUNT
  loop
  DBMS_OUTPUT.put_line (all_markup (l_row).*);
  end loop;
*/

   
/*   FORALL i IN all_markup.FIRST..all_markup.LAST 
      INSERT INTO markup VALUES all_markup(i);*/
commit;
END;
/


    SELECT m.*, 'table' "type"
      FROM markup m
      





