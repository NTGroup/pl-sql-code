
select * from dba_objects
where /*object_name like '%DOCUMENT%'
and*/ owner = 'BLNG'



 
SELECT sysdate FROM DUAL;


ALTER session SET NLS_DATE_FORMAT='DD.MM.YYYY HH24:MI:SS' SCOPE=SPFILE;

commit
select * from v$parameter where name = 'nls_date_format';
select * from nls_database_parameters
select * from nls_session_parameters
select * from nls_instance_parameters

create table temp_d (
id number,
d date
);
insert into temp_d

select 1, sysdate from dual

;
commit;


select * from temp_d
select * from dual

select * from nls_session_parameters
where parameter in ('NLS_DATE_FORMAT','NLS_DATE_LANGUAGE'); 


select * from blng.event




select 
d.parameter, d.value "database",i.value "instance", s.value "session"
from nls_database_parameters d,
nls_session_parameters s,
nls_instance_parameters i
where s.parameter(+)=d.parameter
and i.parameter(+)=d.parameter


update markup set client = 'default', gds = 'Sabre', pos = 'CJ8H';
commit;


select * from DBA_TAB_STATS_HISTORY
where owner = 'NTG'


SELECT * FROM markup
    AS OF TIMESTAMP 
    
    (SYSTIMESTAMP - INTERVAL '1' MINUTE);
    
    
    SELECT * 
    --NAME, VALUE/60 MINUTES_RETAINED
FROM   V$PARAMETER WHERE  NAME = 'undo_retention';
SELECT NAME, SCN, TIME FROM V$RESTORE_POINT;


SELECT CURRENT_SCN FROM V$DATABASE;


SELECT * FROM RECYCLEBIN;


SELECT * -- xid, operation, start_scn, commit_scn, logon_user, undo_sql
FROM flashback_transaction_query




select a.ID, a.validating_carrier new_sal, b.validating_carrier old_sal
      from markup a, markup as of SCN &SCN b
    where a.ID = b.ID
    AND A.ID = 5


select b.*,
versions_xid XID, versions_startscn START_SCN,
  versions_endscn END_SCN, versions_operation OPERATION
from  markup 
VERSIONS BETWEEN SCN  minvalue and maxvalue b
where ID = 5


select a.ID, a.validating_carrier new_sal, b.validating_carrier old_sal
      from (
      select 
      ) a, markup as of SCN &SCN b
    where a.ID = b.ID
    AND A.ID = 5
    
    
    

select thread, scn_bas, to_char(time_dp, 'yyyy-mm-dd hh24:mi:ss') from sys.smon_scn_time order 
by time_dp DESC;

select *
      from markup  VERSIONS BETWEEN SCN minvalue AND maxvalue
     where ID = 5
   
   

     


SELECT * FROM markup AS OF TIMESTAMP 
   TO_TIMESTAMP('2014-10-01 01:00:00', 'YYYY-MM-DD HH:MI:SS')
   WHERE id = 5;
   
SELECT * FROM markup AS OF TIMESTAMP 
   to_date()
   WHERE id = 5;
   
   
   
   
   
   
   SELECT * FROM t 
   VERSIONS BETWEEN TIMESTAMP  TO_TIMESTAMP('2014-10-01 16:00:00', 'YYYY-MM-DD HH24:MI:SS') 
   and TO_TIMESTAMP('2014-10-02 18:00:00', 'YYYY-MM-DD HH24:MI:SS') 
   WHERE id = 5;
   
   
   SELECT xid, start_scn, commit_scn, operation, table_name, table_owner
FROM flashback_transaction_query
where table_owner = 'NTG'


select thread, scn_bas, to_char(time_dp, 'yyyy-mm-dd hh24:mi:ss') from sys.smon_scn_time order 
by time_dp;


 select * from markup as of timestamp(sysdate - interval '380' minute);
 create view v_scn as select * from markup as of scn &SCN
 



  select *
    from markup versions between timestamp
     systimestamp - interval '30' minute and systimestamp
     where id = 5
     
     
     SELECT CURRENT_SCN FROM V$DATABASE;
     
     SELECT NAME, SCN, TIME FROM V$RESTORE_POINT;

     
     SELECT * --NAME, VALUE/60 MINUTES_RETAINED
FROM   V$PARAMETER
WHERE  NAME = 'undo_retention';

SELECT other.owner, other.table_name
FROM   sys.all_constraints this, sys.all_constraints other
WHERE  this.owner = 'NTG'
--AND    this.table_name = 'T'
AND    this.r_owner = other.owner
AND    this.r_constraint_name = other.constraint_name
--AND    this.constraint_type='R';


ALTER PLUGGABLE DATABASE ALL OPEN;


SELECT * 
FROM   V$FLASHBACK_DATABASE_LOG;

select * from 
FLASHBACK_TRANSACTION_TABLE 



select b.*,
versions_xid XID, versions_startscn START_SCN,
  versions_endscn END_SCN, versions_operation OPERATION
from  t 
VERSIONS BETWEEN SCN  minvalue and maxvalue b


select --b.*,
versions_xid XID, versions_startscn START_SCN,
  versions_endscn END_SCN, versions_operation OPERATION
from  markup
VERSIONS BETWEEN SCN  minvalue and maxvalue b


select maxvalue from scn

2	goe	07000300A9100000	5417446		U
2	go	0A000200BC160000	5417205	5417446	I
1	hello	05001300D5130000	5417197		I

2	god	02001800CB100000	5418826		U
1	hell	02001800CB100000	5418826		U
2	goe	07000300A9100000	5417446	5418826	U
1	hello			5418826	
2	go			5417446	

select * from USER_TAB_STATS_HISTORY 

select * from "BIN$BFfHyZ4PUB/gVQAAAAAAAg==$0"


select '    audit_pkg.check_val( ''&1'', ''' || column_name ||
          ''', ' || ':new.' || column_name || ', :old.' || 
             column_name || ');'
from user_tab_columns where table_name = upper('&1')






CREATE USER wsmgmt IDENTIFIED BY wsmgmt;
GRANT dba to wsmgmt;
grant execute on dbms_lock to wsmgmt;


begin
            DBMS_WM.GrantSystemPriv
        ('ACCESS_ANY_WORKSPACE, MERGE_ANY_WORKSPACE, ' ||
         'CREATE_ANY_WORKSPACE, REMOVE_ANY_WORKSPACE, ' ||
   'ROLLBACK_ANY_WORKSPACE', 'WSMGMT', 'YES');
    end;
    
    
    
    create table t as  select * from ntg.t
     alter table t add constraint t_pk primary key(id);
     alter table t add constraint t_fk_t foreign key(mgr) references 
t(id);


begin
           DBMS_WM.EnableVersioning ('t',  'VIEW_WO_OVERWRITE');
    end;
    
    
    
    update wsmgmt.t set name = name ||'q';
    commit;
    
    select E.* from T_hist e
    
    select -- ename, sal, comm, workspace, type_of_change,
           to_char(wm_createtime,'dd-mon hh24:mi:ss') created,
           to_char(wm_retiretime,'dd-mon hh24:mi:ss') retired
      from t_hist

    
    select * from wsmgmt.t_
    
    select * --rpad('*',level*2,'*') || ename
      from t

    select * from wsmgmt.t


    exec dbms_wm.gotoDate( sysdate - 1/24);
    
    
    exec dbms_wm.gotoDate( to_date( '02-окт-2014 08:31:44', 'dd-mon-yyyy hh24:mi:ss'));
    exec dbms_wm.gotoDate( sysdate);
    dbms_wm.
    
    insert into wsmgmt.t select 3 , 'nono' from dual;
    
    
    create table   addresses
   ( empno       number,
     addr_data   varchar2(30),
     start_date  date,
     end_date    date,
     period for valid(start_date,end_date)
   )
   
   
   
   select * from addresses
   
   insert into addresses (empno, addr_data, start_date, end_date )
   values ( 1234, '123 Main Street', trunc(sysdate-5), trunc(sysdate-2) );
   insert into addresses (empno, addr_data, start_date, end_date )
  values ( 1234, '456 Fleet Street', trunc(sysdate-1), trunc(sysdate+1) );
insert into addresses (empno, addr_data, start_date, end_date )
   values ( 1234, '789 1st Ave', trunc(sysdate+2), null );
   
   select /* for update */ * from addresses;
   
   select * from addresses as of period for valid sysdate;
commit;


desc addresses



create or replace function addRow(markup%rowtype) return number
is 
id number;
begin
--insert into table1 (description) values (desc) returning table1ID
--into id;
--return(id);
return 0;
--exception
--when others then return(-1)
end;




declare
type GEO_tapi_rec
IS
  record
  (
    ID GEO.ID%type ,
    PARENT_ID GEO.PARENT_ID%type ,
    NAME GEO.NAME%type ,
    NLS_NAME GEO.NLS_NAME%type ,
    IATA GEO.IATA%type ,
    CODE GEO.CODE%type ,
    OBJECT_TYPE GEO.OBJECT_TYPE%type ,
    COUNTRY_ID GEO.COUNTRY_ID%type ,
    CITY_ID GEO.CITY_ID%type ,
    IS_ACTIVE GEO.IS_ACTIVE%type ,
    NEW_PARENT_ID GEO.NEW_PARENT_ID%type ,
    UTC_OFFSET GEO.UTC_OFFSET%type); 

begin

select * into GEO_tapi_rec  from geo where id=5;
dbms_output.put_line(GEO_tapi_rec.name);
  
end;


 ALTER USER ord ACCOUNT LOCK;

select * from gba_users


           select * from blng.delay d
           where transaction_oid = 272
           order by contract_oid asc, date_to asc, id asc
           
        
        begin
        blng.core.credit_online;
        end;
        
                  select * from blng.delay d
           where amnd_prev = (
             select amnd_prev from blng.delay d
             where transaction_oid = 310)
           order by contract_oid asc, date_to asc, id asc