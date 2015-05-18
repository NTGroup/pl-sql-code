BEGIN
DBMS_SCHEDULER.CREATE_SCHEDULE ( 
  repeat_interval   => 'FREQ=SECONDLY;INTERVAL=2',     
  start_date        => SYSTIMESTAMP,
  comments          => 'Every 2 seconds',
  schedule_name     => 'HDBK.BUY_SCHEDULE'
  );
END;
/
BEGIN
DBMS_SCHEDULER.CREATE_SCHEDULE (    	   
  repeat_interval   => 'FREQ=SECONDLY;INTERVAL=10',     
  start_date        => SYSTIMESTAMP,
  comments          => 'Every 10 second',
  schedule_name     => 'HDBK.DOC_TASK_LIST_SCHEDULE');    
END;
/
/*
BEGIN
DBMS_SCHEDULER.CREATE_SCHEDULE (
  repeat_interval   => 'FREQ=SECONDLY;INTERVAL=2',     
  start_date        => SYSTIMESTAMP,
  comments          => 'Every 5 seconds',
  schedule_name     => 'HDBK.ONLINE_SCHEDULE');        
END;
/*/

ALTER SESSION SET TIME_ZONE = '0:0';
/
BEGIN
DBMS_SCHEDULER.CREATE_SCHEDULE (
  repeat_interval   => 'FREQ=DAILY;INTERVAL=1',     
  start_date        => trunc(SYSTIMESTAMP),
  comments          => 'Every 24 hours',
  schedule_name     => 'HDBK.DELAY_EXPIRE_SCHEDULE');        
END;
/


/*
BEGIN
 DBMS_SCHEDULER.CREATE_SCHEDULE (
  schedule_name     => 'document_schedule',
  start_date        => SYSTIMESTAMP,
  --end_date          => SYSTIMESTAMP + INTERVAL '30' day,
  repeat_interval   => 'FREQ=SECONDLY;INTERVAL=10',
  comments          => 'Every 10 seconds');
END;
*/

/


BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'HDBK.BUY_RUN',
 --  job_owner          =>  'HDBK',
   schedule_name      =>  'HDBK.BUY_SCHEDULE',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'ORD.CORE.BUY_JOB',
   enabled            =>  TRUE,
   COMMENTS           =>  'approve buy ticket tasks' );
END;
/
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'HDBK.DOC_TASK_LIST_RUN',
   schedule_name      =>  'HDBK.DOC_TASK_LIST_SCHEDULE',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'ORD.CORE.DOC_TASK_LIST_JOB',
   enabled            =>  TRUE,
   COMMENTS           =>  'approve tasks with contract like set parameters or cash in' );
END;
/



/*
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'HDBK.BUY_JOB',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'ORD.CORE.BUY',
--  repeat_interval   => 'FREQ=SECONDLY;INTERVAL=2',     
  start_date        => SYSTIMESTAMP,
   enabled            =>  TRUE,
   COMMENTS           =>  'approve buy ticket tasks' );
END;
/
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'HDBK.DOC_TASK_LIST_JOB',
--   schedule_name      =>  'HDBK.DOC_TASK_LIST_SCHEDULE',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'ORD.CORE.DOC_TASK_LIST',
--   repeat_interval   => 'FREQ=SECONDLY;INTERVAL=10',     
  start_date        => SYSTIMESTAMP,
   --job_style        =>  'LIGHTWEIGHT',
   enabled            =>  TRUE,
   COMMENTS           =>  'approve tasks with contract like set parameters or cash in' );
END;
/
*/
/*
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'HDBK.ONLINE_JOB',
   schedule_name      =>  'HDBK.ONLINE_SCHEDULE',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'blng.core.online_accounts',
   --job_style        =>  'LIGHTWEIGHT',
   enabled            =>  TRUE,
   COMMENTS           =>  'get money from online accounts' );
END;
/ */

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'HDBK.DELAY_EXPIRE_JOB',
   schedule_name      =>  'HDBK.DELAY_EXPIRE_SCHEDULE',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'blng.core.delay_expire',
   --job_style        =>  'LIGHTWEIGHT',
   enabled            =>  TRUE,
   COMMENTS           =>  'check delays' );
END;
/

/*
    BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE ( name   => 'document_schedule', attribute         =>  'repeat_interval', value => 'FREQ=MINUTELY;INTERVAL=2') ;
END;
/
*/


BEGIN


    DBMS_SCHEDULER.DROP_JOB(job_name => 'NTG.APPROVEDOCUMENTS',
                                defer => false,
                                force => false);

    DBMS_SCHEDULER.DROP_SCHEDULE(schedule_name => 'NTG.DOCUMENT_SCHEDULE',
                                    force => false);

    DBMS_SCHEDULER.DROP_JOB(job_name => 'NTG.BILLPAY',
                                defer => false,
                                force => false);
    DBMS_SCHEDULER.DROP_SCHEDULE(schedule_name => 'NTG.BILL_PAY_SCHEDULE',
                                force => false);
                                
    DBMS_SCHEDULER.DROP_JOB(job_name => 'NTG.CREDITONLINE',
                                defer => false,
                                force => false);
                                
    DBMS_SCHEDULER.DROP_SCHEDULE(schedule_name => 'NTG.CREDIT_ONLINE_SCHEDULE',
                                force => false);
                                
    DBMS_SCHEDULER.DROP_JOB(job_name => 'NTG.DEBITONLINE',
                                defer => false,
                                force => false);
                                
    DBMS_SCHEDULER.DROP_SCHEDULE(schedule_name => 'NTG.DEBIT_ONLINE_SCHEDULE',
                                force => false);
                                
    DBMS_SCHEDULER.DROP_JOB(job_name => 'NTG.DELAYEXPIRE',
                                defer => false,
                                force => false);
                                
    DBMS_SCHEDULER.DROP_SCHEDULE(schedule_name => 'NTG.DELAY_EXPIRE_SCHEDULE',
                                force => false);

/*    DBMS_SCHEDULER.DROP_JOB(job_name => 'HDBK.DELAY_EXPIRE_JOB',
                                defer => false,
                                force => false);
                                
    DBMS_SCHEDULER.DROP_SCHEDULE(schedule_name => 'HDBK.DELAY_EXPIRE_SCHEDULE',
                                force => false);*/
END;



/*
BEGIN


    DBMS_SCHEDULER.DROP_JOB(job_name => 'HDBK.BUY_JOB',
                                defer => false,
                                force => false);
                                
END;
*/


