select * from blng.client

DECLARE
 v_ReturnValue  NUMBER;
BEGIN
  v_ReturnValue := BLNG.BLNG_API.client_add();
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
END;


DECLARE
  P_ID NUMBER;
  P_NAME VARCHAR2(255);
 v_ReturnValue  blng.blng_api.t_message;
BEGIN
  P_ID := 3;
  P_NAME := 'Pavel Ryzhikov1';

  v_ReturnValue := BLNG.BLNG_API.client_set_name(P_ID => P_ID,
P_NAME => P_NAME);
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
END;
--3	10.10.2014 10:40:59	NTG	A	3	P.Ryzhikov	
select * from log
select * from blng.client order by amnd_date desc
commit
DECLARE
  P_CLIENT_OID NUMBER;
 v_ReturnValue  NUMBER;
BEGIN
  P_CLIENT_OID := 3;

  v_ReturnValue := BLNG.BLNG_API.contract_add(P_CLIENT_OID => P_CLIENT_OID);
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
END;

select * from blng.contract order by amnd_date desc

DECLARE
  P_ID NUMBER;
  P_NUMBER VARCHAR2(50);
  v_ReturnValue  blng.blng_api.t_message;
BEGIN
  P_ID := 11;
  P_NUMBER := 'num2';

  v_ReturnValue := BLNG.BLNG_API.contract_set_number(P_ID => P_ID,
P_NUMBER => P_NUMBER);
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
END;

DECLARE
  P_CONTRACT_OID NUMBER;
 v_ReturnValue   blng.blng_api.t_message;
BEGIN
  P_CONTRACT_OID := 11;

  v_ReturnValue := BLNG.BLNG_API.account_init(P_CONTRACT_OID => P_CONTRACT_OID);
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
END;

select * from blng.account


SELECT * FROM dba_CONSTRAINTS WHERE 
SEARCH_CONDITION_vc not like '%IS NOT NULL%'



DECLARE
  P_NAME VARCHAR2(50);
  P_CODE VARCHAR2(10);
  P_DETAILS VARCHAR2(255);
 v_ReturnValue  NUMBER;
BEGIN
  P_NAME := 'decline';
  P_CODE := 'D';
  P_DETAILS := '';

  v_ReturnValue := BLNG.BLNG_API.status_type_add(P_NAME => P_NAME,
P_CODE => P_CODE,
P_DETAILS => P_DETAILS);
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
END;


select * from blng.event_type


select * from DBA_SCHEDULER_JOBS


select * from DBA_CREDENTIALS



SELECT event, total_waits waits, total_timeouts timeouts,
time_waited total_time, average_wait avg
FROM V$SYSTEM_EVENT
where event like 'db file s%'
order by 4 desc;


select * from blng.event

begin



declare
  P_CONTRACT NUMBER;
  P_AMOUNT NUMBER;
  P_TRANSACTION NUMBER;
  P_DATE_TO DATE;
  P_EVENT_TYPE NUMBER;
  P_STATUS VARCHAR2(1);
  P_PRIORITY NUMBER;
 v_ReturnValue  number;
BEGIN
  P_CONTRACT := 10;
  P_AMOUNT := 10;
  P_TRANSACTION := 1;
  P_DATE_TO := sysdate;
  P_EVENT_TYPE := 1;
  P_STATUS := 'A';
  P_PRIORITY := 1;

  v_ReturnValue := BLNG.BLNG_API.event_add(P_CONTRACT => P_CONTRACT,
P_AMOUNT => P_AMOUNT,
P_TRANSACTION => P_TRANSACTION,
P_DATE_TO => P_DATE_TO,
P_EVENT_TYPE => P_EVENT_TYPE,
P_STATUS => P_STATUS,
P_PRIORITY => P_PRIORITY);
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
END;


begin
blng.core.event_ins_test;
end;

DTYPE


select * from log

show error

select * from blng.event

alter session set plsql_warnings = 'enable:all'

    
      SELECT   *
   FROM     dba_scheduler_window_log
   ORDER BY log_date DESC
    
    
    SELECT * FROM USER_SCHEDULER_JOBS;
    SELECT * FROM USER_SCHEDULER_JOB_LOG;
    SELECT * FROM USER_SCHEDULER_RUNNING_JOBS
    SELECT * FROM USER_SCHEDULER_JOB_RUN_DETAILS
    SELECT * FROM USER_SCHEDULER_JOB_DESTS
    SELECT * FROM USER_SCHEDULER_RUNNING_JOBS
    SELECT * FROM USER_SCHEDULER_RUNNING_JOBS
    
    BEGIN
DBMS_SCHEDULER.CREATE_JOB
( job_name   => 'simple_job'
, job_type   => 'STORED_PROCEDURE'
, job_action => 'updatesal'
, enabled   => TRUE
) ;
END;
/

    
    BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE (
( name   => 'simple_job'
, job_type   => 'STORED_PROCEDURE'
, job_action => 'updatesal'
, enabled   => TRUE
) ;
END;
/



BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'update_sales',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'ntg.log_api.LOG_ADD',
   enabled            =>  TRUE);
END;
/


begin
--    NTG.LOG_API.LOG_ADD(p_proc_name=>'delay_set_name', p_msg_type=>'Error');
    NTG.LOG_API.LOG_ADD;
 end;

select * from log order by id desc

select * from log order by id desc
desc blng.document


DECLARE
 v_ReturnValue  NUMBER;
BEGIN

  v_ReturnValue := blng.BLNG_API.document_add(P_CONTRACT => 11,
P_AMOUNT => 10010,
P_TRANS_TYPE => 2);
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
END;

select * from blng.document

    
BEGIN
  BLNG.CORE.approve_documents  ;  
END;

select * from blng.trans_type


DECLARE

 v_ReturnValue  NUMBER;
BEGIN

  v_ReturnValue := BLNG.BLNG_API.trans_type_add(P_NAME => 'max loan trans amount',
P_CODE => 'ult',
P_DETAILS => 'изменение максимальной суммы единоразового списания с кредитного лимита');
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
END;

select * from blng.account_type

select * from blng.trans_type

DECLARE
 v_ReturnValue  NUMBER;
BEGIN


  v_ReturnValue := BLNG.BLNG_API.account_type_add(P_NAME => 'credit online',
P_CODE => 'co',
P_PRIORITY => 0,
P_DETAILS => 'счет зачисления');
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
END;

create type 

COLUMN NTG.LOG



grant execute on dtype to blng;


    
BEGIN
  BLNG.CORE.et_test  ;  
END;

select * from blng.document


select * from blng.account


  select sum(amount) from blng.account where amnd_state = 'A' and contract_oid = 11 and code in ('d','l','cl','clb');

  select sum(amount) from blng.account where amnd_state = 'A' and contract_oid = 11 and account_type_oid in (select id from blng.account_type where amnd_state = 'A' and  code in ('d','l','cl','clb'));
  
  (select id from blng.account_type where amnd_state = 'A' and  code in ('d','l','cl','clb'))
  
select * from blng.trans_type



declare
PROCEDURE account_status (
  due_date DATE,
  today    DATE
) 
IS
  past_due  EXCEPTION;  -- declare exception
  v_today date;
BEGIN
v_today:=today;
for i in 1..5
loop
  IF due_date< v_today THEN
    RAISE past_due;  -- explicitly raise exception
  else 
    DBMS_OUTPUT.PUT_LINE ('ok');
  END IF;
  v_today:=v_today-7;
end loop;  
EXCEPTION
  WHEN past_due THEN  -- handle exception
    DBMS_OUTPUT.PUT_LINE ('Account past due.');
END account_status;

 
BEGIN
  account_status (TO_DATE('01-07-2010', 'DD-MM-YYYY'),
                  TO_DATE('09-07-2010', 'DD-MM-YYYY'));
              
END;


compile all

EXEC DBMS_UTILITY.compile_schema(schema => 'BLNG');

declare 
a number;
begin
select blng.info.available(111) into a
from dual;
end;


select decode(null,1,1) from dual

select * from blng.event_type

select * from blng.trans_type

  procedure account_edit(       p_id in dtype.t_id default null,
                                p_contract in dtype.t_id default null,
                                p_account_type in dtype.t_id default null,
                                p_code in dtype.t_code default null,
                                p_amount in dtype.t_amount default null,
                                p_last_document in dtype.t_id default null,
                                p_set_amount in dtype.t_status default 'Y'



select * from blng.account


[external block] 
declare
  doc_waiting EXCEPTION;                     
  PRAGMA EXCEPTION_INIT (doc_waiting, -20000);  

  insufficient_funds  EXCEPTION;                      
  PRAGMA EXCEPTION_INIT (insufficient_funds, -20001);  
is
  [internal block]
  begin
    raise_application_error(-20001,'insufficient funds');
  exception 
    when dtype.insufficient_funds then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'buy', p_msg_type=>'Warning', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20001)),p_info => 'p_doc=' || p_doc.id || '&p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>2);
      raise;
    when dtype.doc_waiting then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'buy', p_msg_type=>'Error', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20000)),p_info => 'p_doc=' || p_doc.id || '&p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
      raise;      
    when others then
      rollback;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'buy', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_doc=' || p_doc.id || '&p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
      raise;
  end [internal block];

exception 
  when dtype.insufficient_funds then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'approve_documents', p_msg_type=>'Warning', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20001)),p_info => '&p_process=set&p_status=D&p_doc=' || r_doc.id || '&p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>2);
    mess := blng.blng_api.document_set_status(r_doc.id, 'D'); --commited inside. its wrong.
    commit;
  when dtype.doc_waiting then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'approve_documents', p_msg_type=>'Error', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20000)),p_info => 'p_doc=' || r_doc.id || '&p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
    commit;
  when others then
    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'approve_documents.c_doc', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_doc=' || r_doc.id || '&p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
    mess := blng.blng_api.document_set_status(r_doc.id, 'E'); --commited inside. its wrong.
    commit;
end;



select * from blng.trans_type
select * from blng.account



C:\Users\Pavel\Downloads

BEGIN
 DBMS_SCHEDULER.CREATE_SCHEDULE (
  schedule_name     => 'document_schedule',
  start_date        => SYSTIMESTAMP,
  --end_date          => SYSTIMESTAMP + INTERVAL '30' day,
  repeat_interval   => 'FREQ=SECONDLY;INTERVAL=10',
  comments          => 'Every 10 seconds');
END;
/


select 
*
from
   dba_scheduler_schedules

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'DelayExpire',
   schedule_name => 'document_schedule',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'blng.core.delay_expire',
   --job_style        => 'LIGHTWEIGHT',
   enabled            =>  TRUE,
   COMMENTS            => 'check delays' );
END;
/

      SELECT   *
   FROM     dba_scheduler_window_log
   ORDER BY log_date DESC
    
    
    SELECT * FROM USER_SCHEDULER_JOBS;
    SELECT * FROM USER_SCHEDULER_JOB_LOG where owner = 'NTG' order by log_id desc
    SELECT COUNT(*) FROM USER_SCHEDULER_JOB_LOG where owner = 'NTG'
    SELECT * FROM USER_SCHEDULER_RUNNING_JOBS
    SELECT * FROM USER_SCHEDULER_JOB_RUN_DETAILS
    SELECT * FROM USER_SCHEDULER_JOB_DESTS
    SELECT * FROM USER_SCHEDULER_RUNNING_JOBS
    SELECT * FROM USER_SCHEDULER_RUNNING_JOBS
    
 select * from log
 order by id desc
 
select * from blng.account



 select * from blng.document order by id desc
 
    BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE ( name   => 'document_schedule', attribute         =>  'repeat_interval', value => 'FREQ=MINUTELY;INTERVAL=2') ;
END;
/

    
    BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE ( name   => 'document_schedule', attribute         =>  'repeat_interval', value => 'FREQ=SECONDLY;INTERVAL=10') ;
END;
/

    
    BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE ( name   => 'document_schedule', attribute         =>  'repeat_interval', value => 'FREQ=DAILY;INTERVAL=2') ;
END;
/

    BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE ( name   => 'APPROVEDOCUMENTS', attribute         =>  'job_action', value => 'blng.core.approve_documents') ;
END;
/



<<<<<<< HEAD




DECLARE

 v_ReturnValue  NUMBER;
BEGIN

  v_ReturnValue := blng.BLNG_API.document_add(P_CONTRACT => 11,
P_AMOUNT => 666,
P_TRANS_TYPE =>1);
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
  commit;
END;



select * from blng.trans_type

select * from blng.document
where amnd_state = 'A'
--and status = 'W'
order by id desc

select * from blng.account where amnd_state = 'A' order by id desc

select * from blng.account where amnd_prev=28
ORDER BY AMND_DATE DESC

select * from blng.DELAY where amnd_state = 'A' order by id desc  
select * from blng.DELAY where  amnd_prev = 40  order by id desc  
/*update blng.DELAY 
set date_to = trunc(sysdate)
where amnd_state = 'A' ;
commit;*/
select * from blng.DELAY order by id desc 

select * from blng.v_account

select * from blng.transaction order by AMND_DATE desc

  P_CONTRACT NUMBER;

DECLARE
  P_AMOUNT NUMBER;    
BEGIN
  P_CONTRACT := 10;
  P_AMOUNT := 1500;

  BLNG.CORE.delay_remove (  P_CONTRACT => P_CONTRACT,
P_AMOUNT => P_AMOUNT) ;  
END;


select * from 


DECLARE
  P_CONTRACT NUMBER;
  P_DAYS NUMBER;    
BEGIN
  P_CONTRACT := 11;
  P_DAYS := 1;

  BLNG.CORE.contract_unblock (  P_CONTRACT => P_CONTRACT,
P_DAYS => P_DAYS) ;  
exception when others
then
DBMS_OUTPUT.PUT_LINE ('catch it');
END;

DECLARE
V_TR NUMBER;
BEGIN
 V_TR := BLNG.BLNG_API.transaction_add(P_AMOUNT => -(-5000),
        P_TRANS_TYPE => 10, P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => 28);        
        COMMIT;
                DBMS_OUTPUT.PUT_LINE (V_TR);
        END;
        
        update blng.delay set date_to = trunc(sysdate) where id = 44;
        commit;
        
 DECLARE

 v_ReturnValue  NUMBER;
BEGIN

  v_ReturnValue := blng.BLNG_API.document_add(P_CONTRACT => 11,
P_AMOUNT => 35,
P_TRANS_TYPE =>11);
  DBMS_OUTPUT.PUT_LINE('v_ReturnValue = ' || v_ReturnValue);
  commit;
END;


select acc.id,
acc.contract_oid
from 
BLNG.account ACC
where 
acc.amnd_state = 'A'
code in 



select *
from 
BLNG.transaction trn
where 
trn.amnd_state = 'A'

create or replace view blng.v_statement as
select
doc.contract_oid contract_oid,
tt.id trans_type_oid,
doc.id doc_oid,
cntr.contract_number,
tt.name trans_type,
tt.details trans_detals,
doc.doc_date,
doc.amount

from BLNG.document doc,
blng.trans_type tt,
blng.contract cntr
where doc.amnd_state = 'A'
and tt.amnd_state = 'A'
and doc.status = 'A'
and tt.id = doc.trans_type_oid
--and trans_type_oid = 2
and doc.contract_oid = cntr.id
order by doc.contract_oid, doc.doc_date


DECLARE
  P_CONTRACT NUMBER;    
BEGIN
  P_CONTRACT := 11;

  blng.BLNG_API.account_init (  P_CONTRACT => P_CONTRACT) ;  
END;



select * from blng.delay order by id desc

select * from blng.transaction_type

=======
SELECT * FROM BLNG.TRANS_TYPE
>>>>>>> origin/master
