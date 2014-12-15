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
alter system set db_create_file_dest='/home/oracle/app/oracle/oradata/ORCL/datafile/pdb/ntg4';
CREATE PLUGGABLE DATABASE ntg4 FROM ntg 
NOLOGGING;
alter pluggable database ntg4 open read write; 


alter pluggable database ntg4 close immediate;
drop pluggable database ntg4 including datafiles;

 

-- create with no data base in specified dir but temp datafiles names +++++++
/* sys as sysdba */
alter pluggable database ntg close immediate;  
alter pluggable database ntg open read only; 
alter system set db_create_file_dest='/home/oracle/app/oracle/oradata/ORCL/datafile/pdb/test';
CREATE PLUGGABLE DATABASE test FROM ntg 
no data
NOLOGGING;
alter pluggable database test open read write; 


--TODO implement tablespase
--alter pluggable database test close immediate;
--drop pluggable database test including datafiles;


