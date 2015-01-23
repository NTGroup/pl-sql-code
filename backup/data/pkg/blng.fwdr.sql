create or replace package blng.fwdr as

  function get_tenant (p_email in ntg.dtype.t_name default null)
  return ntg.dtype.t_id;  
end;
/
create  or replace package BODY blng.fwdr as

  function get_tenant (p_email in ntg.dtype.t_name default null)
  return ntg.dtype.t_id
  is
    r_client blng.client%rowtype;
  begin
    r_client:=blng.blng_api.client_get_info_r(p_email=>p_email);
    return r_client.company_oid;
  exception 
    when NO_DATA_FOUND then
     -- CLOSE c_delay;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'get_tenant', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '||  sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=delay&\p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
--      RAISE_APPLICATION_ERROR(-20002,'select row into client error. '||SQLERRM);
      return null;
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'get_tenant', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=delay&\p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into client error. '||SQLERRM);
      return null;
  end;


end;
/