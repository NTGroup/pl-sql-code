  CREATE OR REPLACE PACKAGE hdbk.core as 

 /*
 
 pkg: hdbk.core
 
 */
  

  
/*
$obj_type: function
$obj_name: delay_payday
$obj_desc: find nearest date for get money from client
$obj_param: P_DELAY: count of days to delay bill paying.
$obj_param: P_CONTRACT: id of contract. maybe at custom calendar we will find special PAYDAY
$obj_return: day of pay
*/
  function delay_payday(
    P_DELAY   in hdbk.dtype.t_id default null,
    P_CONTRACT   in hdbk.dtype.t_id default null )
  return hdbk.dtype.t_date;


procedure buy_run;


procedure DOC_TASK_LIST_run;


end core;

/

  CREATE OR REPLACE PACKAGE BODY hdbk.core as

  function delay_payday(
    P_DELAY   in hdbk.dtype.t_id default null,
    P_CONTRACT   in hdbk.dtype.t_id default null )
  return hdbk.dtype.t_date
  is
    v_out hdbk.dtype.t_date;
    v_calendar_day hdbk.dtype.t_date;
    v_custom_day hdbk.dtype.t_date;
    v_custom_status hdbk.dtype.t_id;
  begin
--return sysdate + 123;
-- 1. get calendar date Xcal   
--   1. check if current_date is a last_date 
dbms_output.put_line('1');

    if trunc(sysdate) = trunc(last_day(sysdate)) then
      v_calendar_day := trunc(sysdate);
    else
dbms_output.put_line('2');

--   2. in loop search day for pay
      
      v_calendar_day := trunc(sysdate,'MM')+P_DELAY-1;
      loop
        if v_calendar_day >= trunc(sysdate) then 
          exit;
        end if;
dbms_output.put_line('3');
        if trunc(last_day(sysdate)) - trunc(sysdate) < P_DELAY then 
          v_calendar_day := trunc(last_day(sysdate));
          exit;
        end if;
        if trunc(last_day(sysdate)) <= v_calendar_day then 
dbms_output.put_line('4');
          v_calendar_day := trunc(last_day(sysdate));
          exit;
        end if;
        v_calendar_day := v_calendar_day+P_DELAY;
dbms_output.put_line('5');
      end loop;    
    end if;
dbms_output.put_line('v_calendar_day='||v_calendar_day);

--   3. now lets find when it will be payed. it will be payed at the NEXT day after BUY period 
--      ending. If day is holiday get monday

dbms_output.put_line('6');
    v_calendar_day := v_calendar_day+1;

    loop
      v_custom_status :=0;

dbms_output.put_line('7');
--   4. check if calendar_date is holyday
      BEGIN
        --if P_CONTRACT is NOT null then  
          select day_type into v_custom_status from hdbk.calendar where amnd_state = 'A' AND contract_oid = P_CONTRACT
          and date_to = v_calendar_day;      
/*        else
          select day_type into v_custom_status from hdbk.calendar where amnd_state = 'A' and contract_oid IS NULL
          and date_to = v_calendar_day;              
        end if;*/
      EXCEPTION WHEN OTHERS THEN 
        begin
          select day_type into v_custom_status from hdbk.calendar where amnd_state = 'A' and contract_oid IS NULL
          and date_to = v_calendar_day;              
        exception when others then null;
        end;
      END;

--dbms_output.put_line('v_custom_status='||v_custom_status);

--dbms_output.put_line('9');
      if to_char(v_calendar_day,'D') in ('6','7') then -- WEEKEND
        v_calendar_day := v_calendar_day + 1;
      ELSIF v_custom_status = hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'CALENDAR',p_code=>'HOLYDAY') THEN 
        v_calendar_day := v_calendar_day + 1;
      else exit;
--dbms_output.put_line('10');
      end if;
--dbms_output.put_line('v_calendar_day='||v_calendar_day);
    end loop;

-- 2. find custom day
    begin
      select min(date_to) into v_custom_day from hdbk.calendar where day_type in (
        hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'CALENDAR',p_code=>'PAYDAY'),
        hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'CALENDAR',p_code=>'WORKDAY')      
      )
      and amnd_state = 'A' and (contract_oid is null or contract_oid = P_CONTRACT)
      and date_to > trunc(sysdate);
    exception when others then null;
    end;
dbms_output.put_line('11');
dbms_output.put_line('v_custom_day='||v_custom_day);
dbms_output.put_line('v_calendar_day='||v_calendar_day);
    
    case
    when v_custom_day is null and v_calendar_day is null then raise NO_DATA_FOUND;
    when v_custom_day is null then v_out :=  v_calendar_day;
    when v_calendar_day is null then v_out :=  v_custom_day;
    else v_out := least(v_custom_day,v_calendar_day);
    end case;

dbms_output.put_line('12');
-- add 1 day for pay it --NO,  not here 
    --v_out := v_out +1;
    RETURN v_out;
  exception 
    when NO_DATA_FOUND then return null;  
    when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'avia_pay', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM || ' '|| chr(13)||chr(10) || ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=item_avia_status,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'avia_pay error. '||SQLERRM);
  end;




procedure buy_run
is
  job_count number;
  BILL_count number;
begin
  
---  SELECT count(*) FROM DBA_SCHEDULER_JOB_DESTS where job_name in ('DOC_TASK_LIST_JOB','BUY_JOB','DOC_TASK_LIST_RUN','BUY_RUN')
  SELECT count(*) into job_count FROM ALL_SCHEDULER_JOB_DESTS where job_name in (/*'DOC_TASK_LIST_JOB',*/'BUY_JOB');
  select count(*) into BILL_count from ord.bill where amnd_state = 'A' and status = 'W'
                      and trans_type_oid = hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>'BUY')
                      order by id desc;
  if job_count = 0 and BILL_count <>0 then
    BEGIN
      sys.DBMS_SCHEDULER.CREATE_JOB (
       job_name           =>  'HDBK.BUY_JOB',
       job_type           =>  'STORED_PROCEDURE',
       job_action         =>  'ORD.CORE.BUY',
    --  repeat_interval   => 'FREQ=SECONDLY;INTERVAL=2',     
      start_date        => SYSTIMESTAMP,
       enabled            =>  TRUE,
       COMMENTS           =>  'approve buy ticket tasks' );
    END;
  end if;  
exception when others then 
    hdbk.log_api.LOG_ADD(p_proc_name=>'buy_run', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=bill,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
--    RAISE_APPLICATION_ERROR(-20002,'buy_run error. '||SQLERRM);
end;


procedure DOC_TASK_LIST_RUN
is
  job_count number;
  BILL_count number;
begin
  
---  SELECT count(*) FROM DBA_SCHEDULER_JOB_DESTS where job_name in ('DOC_TASK_LIST_JOB','BUY_JOB','DOC_TASK_LIST_RUN','BUY_RUN')
  SELECT count(*) into job_count FROM ALL_SCHEDULER_JOB_DESTS where job_name in ('DOC_TASK_LIST_JOB','BUY_JOB');
  select count(*) into BILL_count from ord.bill where amnd_state = 'A' and status = 'W'
                      and trans_type_oid = hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>'BUY')
                      order by id desc;
  
  if job_count = 0 --and BILL_count =0 
  then
    BEGIN
         hdbk.log_api.LOG_ADD(p_proc_name=>'DOC_TASK_LIST_RUN', p_msg_type=>'OK',
      P_MSG => 'RUN',p_info => 'p_process=update,p_table=bill,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      sys.DBMS_SCHEDULER.CREATE_JOB (
       job_name           =>  'HDBK.DOC_TASK_LIST_JOB',
       job_type           =>  'STORED_PROCEDURE',
       job_action         =>  'ORD.CORE.DOC_TASK_LIST',
    --  repeat_interval   => 'FREQ=SECONDLY;INTERVAL=2',     
      start_date        => SYSTIMESTAMP,
       enabled            =>  TRUE,
       COMMENTS           =>  'approve buy ticket tasks' );
    END;
  else
     hdbk.log_api.LOG_ADD(p_proc_name=>'DOC_TASK_LIST_RUN', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => 'JOB ALREADY RUNNING',p_info => 'p_process=update,p_table=bill,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
  end if;  
exception when others then 
    hdbk.log_api.LOG_ADD(p_proc_name=>'DOC_TASK_LIST_RUN', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=bill,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
--    RAISE_APPLICATION_ERROR(-20002,'DOC_TASK_LIST_RUN error. '||SQLERRM);
end;


end core;

/
