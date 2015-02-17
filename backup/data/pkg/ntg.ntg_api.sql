create or replace package ntg.ntg_api as
  
  function gds_nationality_get_info (p_code in ntg.dtype.t_code)
  return SYS_REFCURSOR;

  function gds_nationality_get_info_r (p_code in ntg.dtype.t_code)
  return ntg.gds_nationality%rowtype;

  function gds_nationality_get_info_name (p_code in ntg.dtype.t_code)
  return ntg.dtype.t_name;

end;
/
create or replace package body ntg.ntg_api as
  
  function gds_nationality_get_info (p_code in ntg.dtype.t_code)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin
  
    OPEN v_results FOR
      select 
      *
      from 
      ntg.gds_nationality
      where code = p_code;
    return v_results;
  exception 
    when NO_DATA_FOUND then
      --CLOSE c_obj;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'gds_nationality_get_info', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=gds_nationality&\p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE;
--      return null;
    when TOO_MANY_ROWS then
      --CLOSE c_obj;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'gds_nationality_get_info', p_msg_type=>'TOO_MANY_ROWS',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=gds_nationality&\p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE;
--      return null;
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'gds_nationality_get_info', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=gds_nationality&\p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into gds_nationality error. '||SQLERRM);
      return null;
  end;


  function gds_nationality_get_info_r (p_code in ntg.dtype.t_code)
  return ntg.gds_nationality%rowtype
  is
    v_results ntg.gds_nationality%rowtype; 
  begin
  
    --OPEN v_results FOR
      select 
      * into v_results
      from 
      ntg.gds_nationality
      where code = p_code;
    return v_results;
  exception 
    when NO_DATA_FOUND then
      --CLOSE c_obj;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'gds_nationality_get_info_r', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=gds_nationality&\p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE;
--      return null;
    when TOO_MANY_ROWS then
      --CLOSE c_obj;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'gds_nationality_get_info_r', p_msg_type=>'TOO_MANY_ROWS',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=gds_nationality&\p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE;
--      return null;
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'gds_nationality_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=gds_nationality&\p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into gds_nationality error. '||SQLERRM);
      return null;
  end;

  function gds_nationality_get_info_name (p_code in ntg.dtype.t_code)
  return ntg.dtype.t_name
  is
    v_results ntg.dtype.t_name; 
  begin
  
      select 
       nls_name into v_results
      from 
      ntg.gds_nationality
      where code = p_code;
    return v_results;
  exception 
    when NO_DATA_FOUND then
      --CLOSE c_obj;
/*      NTG.LOG_API.LOG_ADD(p_proc_name=>'gds_nationality_get_info_name', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=gds_nationality&\p_code='||p_code||'&\p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE;*/
     return null;
    when TOO_MANY_ROWS then
      --CLOSE c_obj;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'gds_nationality_get_info_name', p_msg_type=>'TOO_MANY_ROWS',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=gds_nationality&\p_code='||p_code||'&\p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE;
--      return null;
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'gds_nationality_get_info_name', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=gds_nationality&\p_code='||p_code||'&\p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into gds_nationality error. '||SQLERRM);
      return null;
  end;



end;
/

grant execute on ntg.ntg_api to blng;
grant execute on ntg.ntg_api to ord;
grant execute on ntg.ntg_api to po_fwdr;
