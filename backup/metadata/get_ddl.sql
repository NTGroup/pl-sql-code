SET LONG 2000000
SET ECHO OFF
SET TERMOUT OFF
SET PAGESIZE 0
set head off
---set VERIFY OFF
set feed off
--set trimspool on
trimout ON
trimspool ON
set linesize 200
set feedback off
--set sqlblanklines OFF
--set term off;
set wrap off
--column text format a80
SPOOL ./metadata/out.html;
--SELECT dbms_metadata.get_ddl( 'PACKAGE', 'ORD_API', 'ORD') FROM dual;
select '<!DOCTYPE html><html><head><meta charset="utf-8"><title>hello-backbonejs</title></head><body>'|| chr(13) || chr(10) text from dual

union all

SELECT 

case 
when text like '$pkg:%' then '<hr><h1>'||trim(replace(replace(text,'$pkg:',''),chr(13) || chr(10),''))||'</h1>'|| chr(13) || chr(10) 
when text like '$obj_type:%' then '<br><br><br><i>'||trim(replace(replace(text,'$obj_type:',''),chr(13) || chr(10),''))||'</i>'|| chr(13) || chr(10) 
when text like '$obj_name:%' then '<b>'||trim(replace(replace(text,'$obj_name:',''),chr(13) || chr(10),''))||'</b><br>'|| chr(13) || chr(10) 
when text like '$obj_desc:%' then '<i>description:</i><br>'||trim(replace(replace(text,'$obj_desc:',''),chr(13) || chr(10),''))||'<br>'|| chr(13) || chr(10) 
when text like '$obj_param:%' then '<i>parameters:</i><br><b>'||regexp_replace(trim(replace(replace(text,'$obj_param:',''),chr(13) || chr(10),'')),':',':</b>',1,1)||'</b><br>'|| chr(13) || chr(10) 
when text like '$obj_return:%' then '<i>return:</i><br>'||trim(replace(replace(text,'$obj_return:',''),chr(13) || chr(10),''))||'<br>'|| chr(13) || chr(10) 
else trim(text)|| chr(13) || chr(10) 
end
text 

FROM DBA_SOURCE WHERE OWNER IN ('BLNG','NTG','ORD') and type like 'PACKAGE%' 
and (text like '$obj%' or text like '$pkg%')
--order by owner, name, type, line

union all
select '</body></html>'  text from dual;
spool off;
exit;
