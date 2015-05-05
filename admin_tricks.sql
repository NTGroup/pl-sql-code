-- get tablespaces
SELECT dd.tablespace_name tablespace_name, dd.file_name file_name, dd.bytes/1024 TABLESPACE_KB, SUM(fs.bytes)/1024 KBYTES_FREE, MAX(fs.bytes)/1024 NEXT_FREE
FROM sys.dba_free_space fs, sys.dba_data_files dd
WHERE dd.tablespace_name = fs.tablespace_name
AND dd.file_id = fs.file_id
GROUP BY dd.tablespace_name, dd.file_name, dd.bytes/1024
ORDER BY dd.tablespace_name, dd.file_name;

-- get tablespaces
select * from V$SYSAUX_OCCUPANTS

-- get tablespaces
SELECT TABLESPACE_NAME "TABLESPACE",
   INITIAL_EXTENT "INITIAL_EXT",
   NEXT_EXTENT "NEXT_EXT",
   MIN_EXTENTS "MIN_EXT",
   MAX_EXTENTS "MAX_EXT",
   PCT_INCREASE
   FROM DBA_TABLESPACES;

SELECT  FILE_NAME, BLOCKS, TABLESPACE_NAME
   FROM DBA_DATA_FILES;
   
SELECT TABLESPACE_NAME "TABLESPACE", FILE_ID,
   COUNT(*)    "PIECES",
   MAX(blocks) "MAXIMUM",
   MIN(blocks) "MINIMUM",
   AVG(blocks) "AVERAGE",
   SUM(blocks) "TOTAL"
   FROM DBA_FREE_SPACE
GROUP BY TABLESPACE_NAME, FILE_ID;

-- ***** good select
  SELECT * FROM DBA_PDBS p
  


-- *** create tablespace, move table into that tablespace

/* by user with dba role (NTG) */
create tablespace airline datafile '/home/oracle/app/oracle/oradata/orcl/my_test/ORCL/0A57CA28ACDC7FB9E055000000000002/datafile/airline01.dbf' SIZE 25M;
ALTER USER ntg quota unlimited on airline;
alter tablespace airline ONLINE;
alter table airline move tablespace airline;
ALTER INDEX al_id_idx REBUILD 
TABLESPACE airline;

select * from all_tables
where owner = 'NTG'


------- ***** create database backup

alter pluggable database my_test1 open read write;


alter pluggable database my_test1 close immediate;
ALTER PLUGGABLE DATABASE my_test1 UNPLUG INTO '/home/oracle/app/oracle/oradata/orcl/my_test1/my_test1.xml';

DECLARE
  l_result BOOLEAN;
BEGIN
  l_result := DBMS_PDB.check_plug_compatibility(
                pdb_descr_file => '/home/oracle/app/oracle/oradata/orcl/my_test1/my_test1.xml',
                pdb_name       => 'my_test2');

  IF l_result THEN
    DBMS_OUTPUT.PUT_LINE('compatible');
  ELSE
    DBMS_OUTPUT.PUT_LINE('incompatible');
  END IF;
END;
/
alter system set db_create_file_dest='/home/oracle/app/oracle/oradata/orcl/my_test2'
create pluggable database my_test2 
AS CLONE using '/home/oracle/app/oracle/oradata/orcl/my_test1/my_test1.xml' 
;
alter pluggable database my_test2 open read write; 

drop pluggable database my_test1 keep datafiles;
alter system set db_create_file_dest='/home/oracle/app/oracle/oradata/orcl/my_test1'
create pluggable database my_test1
using '/home/oracle/app/oracle/oradata/orcl/my_test1/my_test1.xml' 
NOCOPY
  TEMPFILE REUSE;
alter pluggable database my_test1 open read write; 

SELECT name, open_mode
FROM   v$pdbs
ORDER BY name;


CREATE TABLESPACE TMPDICT DATAFILE '/home/oracle/app/oracle/oradata/orcl/ORCL/032A6356A8B256D7E055000000000002/datafile/TMPDICT01.dbf' SIZE 250M EXTENT MANAGEMENT LOCAL AUTOALLOCATE;


--change pluggable database MAXSIZE
ALTER PLUGGABLE DATABASE NTG STORAGE (MAXSIZE UNLIMITED);


 /* create new user shcheme inside pdb */
create user hdbk identified by cccCCC111;
/     
/* inside pdb */ 
alter user hdbk
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users
/*ACCOUNT UNLOCK*/ ;

grant execute on hdbk.dtype to ntg_usr1
grant execute on hdbk.dtype to po_fwdr
grant execute on hdbk.fwdr to po_fwdr


alter user hdbk account lock;



 /* create new user shcheme inside pdb */
create user erp identified by ***;
/     
/* inside pdb */ 
alter user erp
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users
ACCOUNT LOCK ;


alter user erp account lock;

create user erp_gate identified by ***;
/     
/* inside pdb */ 
alter user erp_gate
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users
ACCOUNT UNLOCK ;


/*grant execute on hdbk.dtype to ntg_usr1
grant execute on hdbk.dtype to po_fwdr
grant execute on hdbk.fwdr to po_fwdr
*/

alter user erp_gate account UNLOCK;


