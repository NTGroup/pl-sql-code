/* system connect */
CREATE PLUGGABLE DATABASE rpepdb4 ADMIN USER rpeadm4 IDENTIFIED BY RPEpdb4  ROLES=(DBA)
  STORAGE (MAXSIZE 2G MAX_SHARED_TEMP_SIZE 100M)
  DEFAULT TABLESPACE USERS 
    DATAFILE '/home/oracle/app/oracle/oradata/ORCL/datafile/pdb/rpepdb04.dbf' SIZE 250M AUTOEXTEND ON;

/* sys as sysdba */
alter pluggable database rpepdb4 open read write; 
     
/* inside pdb */ 
alter user rpeadm4 
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
CREATE PUBLIC DATABASE LINK DBLTAGAN 
CONNECT TO c##tagan IDENTIFIED BY tagan 
USING 'orcl';
select * from geo@dblntg;
select * from t_version@dbltagan;