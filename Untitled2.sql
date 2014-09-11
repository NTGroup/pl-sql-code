INSERT INTO department VALUES (
'Operations', 
employee_nlist_typ (
employee_typ ('Scott', 'Manager',1),
employee_typ ('Smith', 'Salesman',2)
)
);
commit

SELECT * FROM TABLE(SELECT emps FROM department);

SELECT 
CAST (MULTISET(SELECT ename, job, id FROM emp) AS employee_nlist_typ) 
FROM DUAL;


 SELECT id, group_id, UNIX_TIMESTAMP(date_added) AS date_added, title, content FROM documents

select id,parent_id,name,nls_name,nvl(iata,code) code,object_type,trunc((sysdate - to_date('01011970','ddmmyyyy')) * (86400)) AS date_added from c##ntg.geo


select column_id id, 2 parent_id, trunc((sysdate - to_date('01011970','ddmmyyyy')) * (86400)) AS date_added from help


select seq id, 2 group_id, info from help where topic = 'CONNECT'



select id,parent_id,name,nls_name,nvl(iata,code) code,object_type,trunc((sysdate - to_date('01011970','ddmmyyyy')) * (86400)) AS date_added from ntg.geo

select * from c##tagan.

SELECT * FROM CONTAINERS(gogo);



CREATE PLUGGABLE DATABASE rpepdb ADMIN USER rpeadm IDENTIFIED BY RPEpdb1
  STORAGE (MAXSIZE 2G MAX_SHARED_TEMP_SIZE 100M)
  DEFAULT TABLESPACE sales 
    DATAFILE '/home/oracle/app/oracle/oradata/ORCL/datafile/pdb/rpepdb01.dbf' SIZE 250M AUTOEXTEND ON
  PATH_PREFIX = '/home/oracle/app/oracle/oradata/ORCL/datafile/pdb/'
  FILE_NAME_CONVERT = ('/home/oracle/app/oracle/oradata/ORCL/datafile/', '/home/oracle/app/oracle/oradata/ORCL/datafile/pdb');


select id,parent_id,name,nls_name,nvl(iata,code) code,object_type,trunc((sysdate - to_date('01011970','ddmmyyyy')) * (86400)) AS date_added from geo@dblntg

