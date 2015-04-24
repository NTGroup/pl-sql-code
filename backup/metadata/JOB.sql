BEGIN
DBMS_SCHEDULER.CREATE_SCHEDULE (    	   
  repeat_interval   => 'FREQ=SECONDLY;INTERVAL=2',     
  start_date        => SYSTIMESTAMP,
  comments          => 'Every 2 second',
  schedule_name     => 'BILL_PAY_SCHEDULE');    
END;

BEGIN
DBMS_SCHEDULER.CREATE_SCHEDULE ( 
  repeat_interval   => 'FREQ=SECONDLY;INTERVAL=2',     
  start_date        => SYSTIMESTAMP,
  comments          => 'Every 2 hours',
  schedule_name     => 'CREDIT_ONLINE_SCHEDULE');
END;
BEGIN
DBMS_SCHEDULER.CREATE_SCHEDULE (
  repeat_interval   => 'FREQ=SECONDLY;INTERVAL=2',     
  start_date        => SYSTIMESTAMP,
  comments          => 'Every 2 hours',
  schedule_name     => 'DEBIT_ONLINE_SCHEDULE');        
END;
BEGIN
DBMS_SCHEDULER.CREATE_SCHEDULE (
  repeat_interval   => 'FREQ=DAILY;INTERVAL=1',     
  start_date        => SYSTIMESTAMP,
  comments          => 'Every 24 hours',
  schedule_name     => 'DELAY_EXPIRE_SCHEDULE');        
END;
/
BEGIN
DBMS_SCHEDULER.CREATE_SCHEDULE ( 
  repeat_interval   => 'FREQ=SECONDLY;INTERVAL=2',     
  start_date        => SYSTIMESTAMP,
  comments          => 'Every 10 seconds',
  schedule_name     => 'DOCUMENT_SCHEDULE');
END;


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
   job_name           =>  'APPROVEDOCUMENTS',
   schedule_name      =>  'DOCUMENT_SCHEDULE',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'blng.core.approve_documents',
   --job_style        =>  'LIGHTWEIGHT',
   enabled            =>  TRUE,
   COMMENTS           =>  'approve documents' );
END;
/

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'BILLPAY',
   schedule_name      =>  'BILL_PAY_SCHEDULE',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'ord.core.bill_pay',
   --job_style        =>  'LIGHTWEIGHT',
   enabled            =>  TRUE,
   COMMENTS           =>  'pay bill' );
END;
/

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'CREDITONLINE',
   schedule_name      =>  'CREDIT_ONLINE_SCHEDULE',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'blng.core.credit_online',
   --job_style        =>  'LIGHTWEIGHT',
   enabled            =>  TRUE,
   COMMENTS           =>  'credit online' );
END;
/

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'DEBITONLINE',
   schedule_name      =>  'DEBIT_ONLINE_SCHEDULE',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'blng.core.debit_online',
   --job_style        =>  'LIGHTWEIGHT',
   enabled            =>  TRUE,
   COMMENTS           =>  'debit online' );
END;
/

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'DelayExpire',
   schedule_name      =>  'document_schedule',
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