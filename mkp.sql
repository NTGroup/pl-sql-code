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
      


select * from v_markup



create PACKAGE GEO_api
IS
type GEO_api_rec
IS
  record
  (
    ID GEO.ID%type ,
    PARENT_ID GEO.PARENT_ID%type ,
    NAME GEO.NAME%type ,
    NLS_NAME GEO.NLS_NAME%type ,
    IATA GEO.IATA%type ,
    CODE GEO.CODE%type ,
    OBJECT_TYPE GEO.OBJECT_TYPE%type ,
    COUNTRY_ID GEO.COUNTRY_ID%type ,
    CITY_ID GEO.CITY_ID%type ,
    IS_ACTIVE GEO.IS_ACTIVE%type,
    NEW_PARENT_ID GEO.NEW_PARENT_ID%type ,
    UTC_OFFSET GEO.UTC_OFFSET%type );
type GEO_tapi_tab
IS
  TABLE OF GEO_tapi_rec;

END GEO_api;

create  PACKAGE body GEO_api
IS
END GEO_api;


declare
cur sys_refcursor;
begin


end;


ntg.geo_api.get_utc_offset



declare
  v_results SYS_REFCURSOR; 
   iata_list geo_tapi.iata3;
   iata_list_m geo_tapi.iata3;
   
   /* 
    first u must declare pkg types
      and then call it.
      declaration local types is wrong
      
   */
begin

  SELECT iata BULK COLLECT INTO iata_list FROM geo where iata is not null and  rownum < 11;
   FOR i IN iata_list.FIRST..iata_list.LAST LOOP
      DBMS_OUTPUT.put_line (i||':'||to_char(iata_list(i).iata));
   END LOOP;
   
--    OPEN v_results FOR
      SELECT a.iata||'h' BULK COLLECT INTO iata_list_m from table(iata_list) a ;
      
    FOR i IN iata_list_m.FIRST..iata_list_m.LAST LOOP
      DBMS_OUTPUT.put_line (i||':'||to_char(iata_list_m(i).iata));
   END LOOP;     
end;