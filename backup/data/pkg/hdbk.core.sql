  CREATE OR REPLACE PACKAGE hdbk.core as 

/*
$pkg: HDBK.CORE 
*/
  

  
/*
$obj_type: function
$obj_name: delay_payday
$obj_desc: find nearest date for get money from client. after that day contr5act will be blocked
$obj_param: P_DELAY(t_id): is not null. count of days to delay bill paying.
$obj_param: P_CONTRACT(t_id): is not null. id of contract. maybe at custom calendar we will find special PAYDAY
$obj_return: day of pay (t_date)
*/
  function delay_payday(
    P_DELAY   in hdbk.dtype.t_id default null,
    P_CONTRACT   in hdbk.dtype.t_id default null )
  return hdbk.dtype.t_date;


  
/*
$obj_type: procedure
$obj_name: buy_run
$obj_desc: handler for buy bills
*/
  procedure buy_run;
  
  
/*
$obj_type: procedure
$obj_name: DOC_TASK_LIST_run
$obj_desc: handler for cash_in bills and contract limit documents(credit limit, delay days, etc.)
*/
  procedure DOC_TASK_LIST_run;


/*
$obj_type: function
$obj_name: dictionary_get_id
$obj_desc: find id of dictionary row. dictionary is a list of names and codes 
$obj_desc: associated with dictionary types. for example dictionary of letters: 
$obj_desc: dictionary_type = LETTERS, name and/or code = A, B, C, etc. 
$obj_desc: each letter is a new row. dictionary_get_* fn-s is a useful api for dictionary 
$obj_param: p_dictionary_type(t_name): is not null. code of dictionary type
$obj_param: p_code(t_code): is null. code value
$obj_param: p_name(t_name): is null. name value
$obj_return: id of dictionary row (t_id)
*/
  function dictionary_get_id (    p_dictionary_type  in hdbk.dtype.t_name default null,
                                p_code in hdbk.dtype.t_code default null,
                                p_name in hdbk.dtype.t_name default null
                          )
  return hdbk.dtype.t_id;


/*
$obj_type: function
$obj_name: dictionary_get_name_by_code
$obj_desc: find name in dictionary by code. 
$obj_param: p_dictionary_type(t_name): is not null. code of dictionary type
$obj_param: p_code(t_code): is not null. code value
$obj_return: name (t_name)
*/
  function dictionary_get_name_by_code (    p_dictionary_type  in hdbk.dtype.t_name default null,
                                p_code in hdbk.dtype.t_code default null
                          )
  return hdbk.dtype.t_name;

/*
$obj_type: function
$obj_name: dictionary_get_code
$obj_desc: find code in dictionary by id. 
$obj_param: p_id(t_id): is not null. dictionary id
$obj_return: code (t_name)
*/
  function dictionary_get_code (    p_id  in hdbk.dtype.t_id default null
                          )
  return hdbk.dtype.t_name;
  
/*
$obj_type: function
$obj_name: dictionary_get_name
$obj_desc: find name in dictionary by id. 
$obj_param: p_id(t_id): is not null. dictionary id
$obj_return: name (t_name)
*/
  function dictionary_get_name (    p_id  in hdbk.dtype.t_id default null
                          )
  return hdbk.dtype.t_name;

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
      ELSIF v_custom_status = hdbk.core.dictionary_get_id(p_dictionary_type=>'CALENDAR',p_code=>'HOLYDAY') THEN 
        v_calendar_day := v_calendar_day + 1;
      else exit;
--dbms_output.put_line('10');
      end if;
--dbms_output.put_line('v_calendar_day='||v_calendar_day);
    end loop;

-- 2. find custom day
    begin
      select min(date_to) into v_custom_day from hdbk.calendar where day_type in (
        hdbk.core.dictionary_get_id(p_dictionary_type=>'CALENDAR',p_code=>'PAYDAY'),
        hdbk.core.dictionary_get_id(p_dictionary_type=>'CALENDAR',p_code=>'WORKDAY')      
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
                      and trans_type_oid = hdbk.core.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>'BUY')
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
                      and trans_type_oid = hdbk.core.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>'BUY')
                      order by id desc;
  
  if job_count = 0 and BILL_count =0 
  then
    BEGIN
/*         hdbk.log_api.LOG_ADD(p_proc_name=>'DOC_TASK_LIST_RUN', p_msg_type=>'OK',
      P_MSG => 'RUN',p_info => 'p_process=update,p_table=bill,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);*/
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


  function dictionary_get_id (    p_dictionary_type  in hdbk.dtype.t_name default null,
                                p_code in hdbk.dtype.t_code default null,
                                p_name in hdbk.dtype.t_name default null
                          )
  return hdbk.dtype.t_id
  is
    r_obj hdbk.dtype.t_id;
  begin
    if p_dictionary_type is not null and p_code is not null then 
      SELECT
      id into r_obj
      from dictionary 
      where dictionary_type = p_dictionary_type
      and code = p_code
      and amnd_state = 'A';
    elsif p_dictionary_type is not null and p_name is not null then 
      SELECT
      id into r_obj
      from dictionary 
      where dictionary_type = p_dictionary_type
      and name = p_name
      and amnd_state = 'A';
    else raise NO_DATA_FOUND; 
    end if;   
    
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;  
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'dictionary_get_id', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=dictionary,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into dictionary error. '||SQLERRM);
  end;


  function dictionary_get_name_by_code (    p_dictionary_type  in hdbk.dtype.t_name default null,
                                p_code in hdbk.dtype.t_code default null
                          )
  return hdbk.dtype.t_name
  is
    v_result hdbk.dtype.t_name;
  begin
    if p_dictionary_type is null and p_code is null then raise NO_DATA_FOUND; end if;

    SELECT
    name into v_result
    from dictionary 
    where dictionary_type = p_dictionary_type
    and code = p_code
    and amnd_state = 'A';
    
    return v_result;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;  
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'dictionary_get_name_by_code', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into dictionary error. '||SQLERRM);
  end;


  function dictionary_get_code (    p_id  in hdbk.dtype.t_id default null
                          )
  return hdbk.dtype.t_name
  is
    v_result hdbk.dtype.t_name;
  begin
--    if p_dictionary_type is null and p_code is null then raise NO_DATA_FOUND; end if;

    SELECT
    code into v_result
    from dictionary 
    where id = p_id;
    
    return v_result;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;  
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'dictionary_get_code', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into dictionary error. '||SQLERRM);
  end;


  function dictionary_get_name (    p_id  in hdbk.dtype.t_id default null
                          )
  return hdbk.dtype.t_name
  is
    v_result hdbk.dtype.t_name;
  begin
--    if p_dictionary_type is null and p_code is null then raise NO_DATA_FOUND; end if;

    SELECT
    name into v_result
    from dictionary 
    where id = p_id;
    
    return v_result;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;  
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'dictionary_get_name', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into dictionary error. '||SQLERRM);
  end;





end core;

/
