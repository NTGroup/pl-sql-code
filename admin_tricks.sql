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
