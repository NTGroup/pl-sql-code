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

end core;

/

  CREATE OR REPLACE PACKAGE BODY hdbk.core as

  function delay_payday(
    P_DELAY   in hdbk.dtype.t_id default null,
    P_CONTRACT   in hdbk.dtype.t_id default null )
  return hdbk.dtype.t_date
  is
--    v_log_row hdbk.log%rowtype;
--    v_id hdbk.dtype.t_id;
    v_cur_month_day hdbk.dtype.t_id;
    v_cur_week_day hdbk.dtype.t_id;
    
  begin

-- 1. get calendar date Xcal   
--   1. check if current_date is a last_date 

    if current_date = last_day(sysdate) then
    
      loop
        null;    
      
      end loop;
    end if;
    
    commit;
    RETURN sysdate;
  exception 
    when NO_DATA_FOUND then return null;  
    when others then
    rollback;
    hdbk.log_api.LOG_ADD(p_proc_name=>'avia_pay', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM || ' '|| chr(13)||chr(10) || ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=item_avia_status,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'avia_pay error. '||SQLERRM);
  end;



end core;

/
