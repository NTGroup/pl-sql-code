create or replace package blng.fwdr as

  function get_tenant (p_email in ntg.dtype.t_name default null)
  return ntg.dtype.t_id;  

  function company_insteadof_client(p_company in ntg.dtype.t_id)
  return ntg.dtype.t_id;
  
  function balance( P_TENANT_ID in ntg.dtype.t_id  default null
                          )
  return SYS_REFCURSOR;  
  
end;
/
create  or replace package BODY blng.fwdr as

  function get_tenant (p_email in ntg.dtype.t_name default null)
  return ntg.dtype.t_id
  is
    r_client blng.client%rowtype;
    r_company blng.company%rowtype;
    v_client ntg.dtype.t_id;
    v_company ntg.dtype.t_id;
    r_contract blng.contract%rowtype;
    v_client_count ntg.dtype.t_id;
  begin
  --all emails must be in lower case
    begin
      r_client:=blng.blng_api.client_get_info_r(p_email=>lower(p_email));
      
      if r_client.id is null then raise no_data_found; end if;
      v_company := r_client.company_oid;
    exception 
      when NO_DATA_FOUND then
        begin
          r_company:=blng.blng_api.COMPANY_get_info_r(p_domain=>SUBSTR(lower(p_email),INSTR(lower(p_email),'@')+1));
          r_contract:=blng.blng_api.contract_get_info_r(p_company=>r_company.id);
          select count(*) into v_client_count from blng.client where amnd_state = 'A' and company_oid = r_company.id and amnd_date > sysdate-1/24/60;
          -- auto user registration stoper 10 user per minute
          if v_client_count>=10 then return null; end if;
          v_client := blng.BLNG_API.client_add(P_NAME => '', p_company => r_company.id,p_email=>p_email);
          blng.BLNG_API.client2contract_add(P_client => v_client, p_permission=> 'B', p_contract => r_contract.id);
          commit;
          v_company:=r_company.id;
        exception when others then
          rollback;
          raise;
        end;
    end;
    return v_company;
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

  function company_insteadof_client(p_company in ntg.dtype.t_id)
  return ntg.dtype.t_id
  is
    v_result ntg.dtype.t_id;
  begin
    select max(id) into v_result from blng.client where company_oid = p_company and amnd_state = 'A';
    return v_result;
  exception when others then 
    NTG.LOG_API.LOG_ADD(p_proc_name=>'company_insteadof_client', p_msg_type=>'UNHANDLED_ERROR', 
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update&\p_table=bill&\p_date=' 
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
    --RAISE_APPLICATION_ERROR(-20002,'cash_back error. '||SQLERRM);  
    return null;
  end;



  function balance( P_TENANT_ID in ntg.dtype.t_id  default null
                          )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_contract ntg.dtype.t_id;
  begin
    v_contract:= blng.core.pay_contract_by_client(blng.fwdr.company_insteadof_client(P_TENANT_ID)) ;
      OPEN v_results FOR
    select * from blng.v_account where contract_oid = v_contract;
    return v_results;
  exception when others then 
    NTG.LOG_API.LOG_ADD(p_proc_name=>'contract_info', p_msg_type=>'UNHANDLED_ERROR', 
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\\p_table=v_account&\\p_date=' 
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
    RAISE_APPLICATION_ERROR(-20002,'select row into v_account error. '||SQLERRM);
    return null;
  end;

end;
/