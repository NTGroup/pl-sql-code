/* system connect */
CREATE PLUGGABLE DATABASE ntg ADMIN USER ntg IDENTIFIED BY NTGdba1  ROLES=(DBA)
  STORAGE (MAXSIZE 2G MAX_SHARED_TEMP_SIZE 100M)
  DEFAULT TABLESPACE USERS 
    DATAFILE '/home/oracle/app/oracle/oradata/ORCL/datafile/pdb/ntg.dbf' SIZE 250M AUTOEXTEND ON;

/* sys as sysdba */
alter pluggable database ntg open read write; 


/* inside pdb */ 
alter user ntg 
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users
ACCOUNT UNLOCK;

/* lets work...*/
/* test ability create/insert data */
create table blahblah(id number,beta varchar2(100));
commit;
insert into blahblah
select 1,'a' from dual
union all
select 2,'b' from dual
union all
select 2,'с' from dual
union all
select 2,'д' from dual;
commit;
select * from blahblah where id = 1;
/* test abilyty get data from others db */
CREATE PUBLIC DATABASE LINK dblcntg 
CONNECT TO c##ntg IDENTIFIED BY NTGasdf1234 
USING 'rpe';
select * from geo@dblcntg;
select * from t_version@dbltagan;


/* create new user shcheme inside pdb */
create user blng identified by BLNGasdf1234;
     
/* inside pdb */ 
alter user blng 
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users
/*ACCOUNT UNLOCK*/ ;

/* create new user shcheme inside pdb */
create user ord identified by ORDasdf1234;
     
/* inside pdb */ 
alter user ord 
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users
/*ACCOUNT UNLOCK*/ ;

/* create new user shcheme inside pdb */
create user exp identified by EXPasdf1234;
/     
/* inside pdb */ 
alter user exp 
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users
/*ACCOUNT UNLOCK*/ ;

/* create new user shcheme inside pdb */
create user dict identified by DICTasdf1234;
     
/* inside pdb */ 
alter user dict 
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users
ACCOUNT LOCK ;
GRANT create session TO dict;

CREATE PLUGGABLE DATABASE ntg1 FROM ntg 
--  PATH_PREFIX = '/home/oracle/app/oracle/oradata/ORCL/datafile/pdb/ntg1/'
--  FILE_NAME_CONVERT = ('/home/oracle/app/oracle/oradata/ORCL/datafile/pdb/', '/home/oracle/app/oracle/oradata/ORCL/datafile/pdb')
  NOLOGGING;

/* sys as sysdba */
alter pluggable database ntg1 open read write; 


CREATE PLUGGABLE DATABASE ntg2 FROM ntg 
--PATH_PREFIX = '/home/oracle/app/oracle/oradata/ORCL/datafile/pdb/ntg2/'
--FILE_NAME_CONVERT = ('/home/oracle/app/oracle/oradata/ORCL/datafile/pdb/', '/home/oracle/app/oracle/oradata/ORCL/datafile/pdb/ntg2')
no data
NOLOGGING;


/* sys as sysdba */
alter pluggable database ntg2 open read write; 




DROP PLUGGABLE DATABASE salespdb
  INCLUDING DATAFILES;

alter pluggable database ntg close immediate;  
alter pluggable database ntg open read write; 

alter pluggable database ntg close immediate;  
alter pluggable database ntg open read only; 

-- create with data base in specified dir but temp datafiles names +++++++
/* sys as sysdba */
alter pluggable database ntg close immediate;  
alter pluggable database ntg open read only; 
--alter system set db_create_file_dest='/home/oracle/app/oracle/oradata/ORCL/datafile/pdb/ntg4';
CREATE PLUGGABLE DATABASE ntg4 FROM ntg 
NOLOGGING;
alter pluggable database ntg4 open read write; 


alter pluggable database test close immediate;
drop pluggable database test including datafiles;

 

-- create with no data base in specified dir but temp datafiles names +++++++
/* sys as sysdba */
alter pluggable database dev close immediate;  
alter pluggable database dev open read only; 
alter pluggable database dev close immediate;  
alter pluggable database dev open read write; 
--alter system set db_create_file_dest='/home/oracle/app/oracle/oradata/ORCL/datafile/pdb/test';

CREATE PLUGGABLE DATABASE test FROM dev 
no data
NOLOGGING;
alter pluggable database test open read write; 



--TODO implement tablespase
alter pluggable database test close immediate;
alter pluggable database test open read write; 

--drop pluggable database test including datafiles;



truncate table ntg.log;
truncate table blng.delay;
truncate table blng.event;

delete from blng.transaction; commit;
delete from blng.document; commit;
delete from blng.account; commit;
delete from blng.client2contract; commit;
delete from blng.contract; commit;
delete from blng.client; commit;
delete from blng.company; commit;

/*
truncate table blng.client;
truncate table blng.document;
truncate table blng.contract;
truncate table blng.account;
truncate table blng.transaction;
truncate table blng.client2contract;
truncate table blng.company;
*/

delete from ord.item_avia; commit;
delete from ord.ord; commit;
delete from ord.item_hotel; commit;
delete from ord.bill; commit;
delete from ord.ticket; commit;




-- create with no data base in specified dir but temp datafiles names +++++++
/* sys as sysdba */
alter pluggable database ntg close immediate;  
alter pluggable database ntg open read only; 
--alter system set db_create_file_dest='/home/oracle/app/oracle/oradata/orcl/my_test';
--ALTER SESSION SET PDB_FILE_NAME_CONVERT='/home/oracle/app/oracle/oradata/orcl/ORCL/032A6356A8B256D7E055000000000002/datafile/', '/home/oracle/app/oracle/oradata/orcl/my_test/',
'/home/oracle/app/oracle/oradata/ORCL/datafile/pdb/', '/home/oracle/app/oracle/oradata/orcl/my_test/'
CREATE PLUGGABLE DATABASE my_test FROM ntg 
NOLOGGING;
alter pluggable database my_test open read write; 





alter pluggable database my_test close immediate;  
alter pluggable database my_test open read only; 
--alter system set db_create_file_dest='/home/oracle/app/oracle/oradata/orcl/my_test1';
CREATE PLUGGABLE DATABASE my_test1 FROM my_test 
--USER_TABLESPACES=ALL EXCEPT('users')
NOLOGGING;
alter pluggable database my_test1 open read write; 


-- ***** create user with specific grants
-- user for application with execute grants



create user po_fwdr
    IDENTIFIED BY xxx
    DEFAULT TABLESPACE users
    QUOTA 0 ON users;
GRANT create session TO po_fwdr;

ALTER USER po_fwdr
    QUOTA 0 ON users


--create pdb from seed
--alter system set db_create_file_dest='/home/oracle/app/oracle/oradata/orcl/ntg1';


create pluggable database ntg1 
admin user ntg identified by cccCCC111 --default tablespace USERS
roles = (DBA)
--FILE_NAME_CONVERT=('/home/oracle/app/oracle/oradata/ORCL/datafile','/home/oracle/app/oracle/oradata/orcl/ntg1');
  DEFAULT TABLESPACE USERS 
    DATAFILE SIZE 25M AUTOEXTEND ON



alter pluggable database ntg1 open read write; 

--alter user ntg default tablespace USERS;

create user BLNG IDENTIFIED BY ccc DEFAULT TABLESPACE users ;
create user ORD IDENTIFIED BY ccc DEFAULT TABLESPACE users ;
create user po_fwdr IDENTIFIED BY ccc DEFAULT TABLESPACE users ;

GRANT RESTRICTED SESSION to ord
GRANT RESTRICTED SESSION to blng
GRANT RESTRICTED SESSION to po_fwdr

GRANT RESTRICTED SESSION to dict

ORA-01950: нет привилегий на раздел 'USERS'


SELECT PRIVILEGE
  FROM sys.dba_sys_privs
 WHERE grantee = 'DICT'
UNION
SELECT PRIVILEGE 
  FROM dba_role_privs rp JOIN role_sys_privs rsp ON (rp.granted_role = rsp.role)
 WHERE rp.grantee = 'DICT'
 ORDER BY 1;

grant
CREATE MATERIALIZED VIEW,
CREATE SEQUENCE,
CREATE SESSION,
CREATE TABLE,
CREATE TRIGGER,
SELECT ANY SEQUENCE,
SET CONTAINER
to dict

GRANT CREATE PACKAGE BODY to DICT;

SELECT owner, table_name, select_priv, insert_priv, delete_priv, update_priv, references_priv, alter_priv, index_priv
  FROM table_privileges
 WHERE grantee = 'ORD'
 ORDER BY owner, table_name;
Indirect grants to tables/views:

SELECT DISTINCT owner, table_name, PRIVILEGE 
  FROM dba_role_privs rp JOIN role_tab_privs rtp ON (rp.granted_role = rtp.role)
 WHERE rp.grantee = 'ORD'
 ORDER BY owner, table_name;
 
 
 
 /* create new user shcheme inside pdb */
create user ntg_usr1 identified by cccCCC111;
/     
/* inside pdb */ 
alter user ntg_usr1 
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users
/*ACCOUNT UNLOCK*/ ;


 /* create new user shcheme inside pdb */
create user ntg_usr2 identified by cccCCC111;
/     
/* inside pdb */ 
alter user ntg_usr2
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users
/*ACCOUNT UNLOCK*/ ;




 /* create new user shcheme inside pdb */
create user hui identified by cccCCC111;
/     
/* inside pdb */ 
alter user hui
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users
/*ACCOUNT UNLOCK*/ ;

GRANT create SESSION to erp_gate;



