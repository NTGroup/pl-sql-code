select * from dual
select * from c##tagan.t_version


select * from geo


select 
    t.name tbs,
    ((sum(f.blocks)*t.blocksize)/1024)/1024 Mbytes
from 
    sys.ts$ t,
    sys.file$ f
where
    f.ts#=t.ts#
group by 
    t.name, t.blocksize
    
    
    
    select lpad(' ',2*(level-1)) || to_char(nls_name) s, geo.object_type, iata
from geo 
where nls_name is not null
start with parent_id = -1 --and iata = 'MOW'
connect by prior id = parent_id;


select 
   con_id, 
   tablespace_name, 
   file_Name 
from 
   cdb_data_files

select 
*
from 
   cdb_data_files
   
   
 show con_name
 
 select 
*
from 
   v$active_services 
order by 
   name;
   
   select
 *
from
   dba_services;
   
   
   SELECT
 'DB_NAME: ' ||sys_context('userenv', 'db_name')||
 ' / CDB?: ' ||(select cdb from v$database)||
 ' / AUTH_ID: ' ||sys_context('userenv', 'authenticated_identity')||
 ' / USER: ' ||sys_context('userenv', 'current_user')||
 ' / CONTAINER: '||nvl(sys_Context('userenv', 'con_Name'), 'NON-CDB')
 "DB DETAILS"
 FROM DUAL
 
 
 select * from v$pdbs
 
 
 select 
   v.name, 
   v.open_mode, 
   nvl(v.restricted, 'n/a') "RESTRICTED", 
   d.status
from 
   v$pdbs     v 
inner join 
   dba_pdbs d
using (GUID)
order by v.create_scn;

 select 
*
from 
   v$pdbs     v 
inner join 
   dba_pdbs d
using (GUID)
order by v.create_scn;


/* name of tablespace */
select 
   con_id, 
   tablespace_name, 
   file_Name 
from 
   cdb_data_files
where 
   file_name like '%/c01p/pdbseed/%'
or 
   file_name like '%PDBN%'
order by 1, 2;



create pluggable database 
  cont01_plug01
admin user 
   app_admin identified by mypass
file_name_convert = ('/pdbseed/', '/cont01plug01/');

alter pluggable database rpepdb3 open;
-- alter pluggable database ALL open;


CREATE PLUGGABLE DATABASE rpepdb4 ADMIN USER rpeadm4 IDENTIFIED BY RPEpdb4  ROLES=(DBA)
  STORAGE (MAXSIZE 2G MAX_SHARED_TEMP_SIZE 100M)
  DEFAULT TABLESPACE USERS 
    DATAFILE '/home/oracle/app/oracle/oradata/ORCL/datafile/pdb/rpepdb04.dbf' SIZE 250M AUTOEXTEND ON;
    

select * from DBA_USERS



select NAME, CDB, CON_ID, OPEN_MODE from V$DATABASE;  

 alter pluggable database pdbn1 open read write; 
  alter pluggable database SALESPDB open read write; 
 SALESPDB
 
 
 select * from c##ntg.geo
 
 create table test (
 id number,
 name varchar2(256)
 )
 
 
 
 
 create user database2 identified by cccCCC111;

alter user rpeadm3 
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users
ACCOUNT UNLOCK;

GRANT 
create session,
CONNECT, 
--RESOURCE,    
--DBA,
--CREATE DATABASE LINK,
--CREATE MATERIALIZED VIEW,
CREATE PROCEDURE,
--CREATE PUBLIC SYNONYM,
--CREATE ROLE,
CREATE SEQUENCE,
--CREATE SYNONYM,
CREATE TABLE,    
CREATE TRIGGER,
CREATE TYPE, 
CREATE VIEW
to pdbun1;

