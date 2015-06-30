--SET SQLPROMPT ON;
--SET SERVEROUTPUT ON
--SET SQLBLANKLINES ON
--set echo off
--SET TERMOUT OFF
--SET HEADING OFF
--SET SQLBLANKLINES OFF
SET LONG 2000000
SET PAGESIZE 0
--set long 0
--set sqlnumber on
--SET LONG 2000000000
SPOOL c:\temp\test.txt;
--SELECT text FROM DBA_SOURCE WHERE OWNER IN ('BLNG','NTG','ORD') and type like '%PQACKAGE%' order by owner, name, type, line;
SELECT dbms_metadata.get_ddl( 'PACKAGE', 'ORD_API', 'ORD') FROM dual;
spool off;


SELECT trim(replace(replace(TEXT,chr(10),''),chr(13),'')) FROM DBA_SOURCE WHERE OWNER IN ('BLNG','NTG','ORD') and type like '%PACKAGE%' order by owner, name, type, line;


select owner, object_name, object_type from all_objects



select * from v_geo


