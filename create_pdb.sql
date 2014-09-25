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