--------------------------------------------------------
--  DDL for Package INFO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "BLNG"."INFO" as 

  function available
  return ntg.dtype.t_amount;
  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
  
  function contract_info_r ( p_contract in ntg.dtype.t_id default null
                            )
  return blng.v_account%rowtype;

  function contract_info ( p_contract in ntg.dtype.t_id default null
                            )
  return SYS_REFCURSOR;

  function statemant( p_contract in ntg.dtype.t_id,
                            p_trans_type_oid in ntg.dtype.t_id default null,
                            p_trans_type in ntg.dtype.t_name default null,
                            p_date_from in ntg.dtype.t_date default null,
                            p_date_to in ntg.dtype.t_date default null
                          )
  return SYS_REFCURSOR;


end info;

/

--------------------------------------------------------
--  DDL for Package Body INFO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "BLNG"."INFO" as

  function available
  return ntg.dtype.t_amount
  is
    v_amount ntg.dtype.t_amount;
  begin
    raise ntg.dtype.value_error; 
    return 1;
  exception when  ntg.dtype.value_error then
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(SQLERRM(-20000)));
      return null;
  end;

  function contract_info_r ( p_contract in ntg.dtype.t_id default null
                            )
  return blng.v_account%rowtype
  is
    r_account blng.v_account%rowtype;
    v_contract ntg.dtype.t_id;
  begin
    v_contract:=nvl(p_contract, blng.core.pay_contract_by_client(ntg.dtype.p_client) );
    select * into r_account from blng.v_account where contract_oid = v_contract;
    return r_account;
  exception when others then 
    NTG.LOG_API.LOG_ADD(p_proc_name=>'contract_info', p_msg_type=>'UNHANDLED_ERROR', 
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert&p_table=client&p_date=' 
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
    RAISE_APPLICATION_ERROR(-20002,'insert row into client error. '||SQLERRM);
    return null;
  end contract_info_r;

  function contract_info( p_contract in ntg.dtype.t_id  default null
                          )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_contract ntg.dtype.t_id;
  begin
    v_contract:=nvl(p_contract, blng.core.pay_contract_by_client(ntg.dtype.p_client) );
      OPEN v_results FOR
    select * from blng.v_account where contract_oid = v_contract;
    return v_results;
  exception when others then 
    NTG.LOG_API.LOG_ADD(p_proc_name=>'contract_info', p_msg_type=>'UNHANDLED_ERROR', 
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&p_table=v_account&p_date=' 
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
    RAISE_APPLICATION_ERROR(-20002,'select row into v_account error. '||SQLERRM);
    return null;
  end;

 
  function statemant( p_contract in ntg.dtype.t_id,
                            p_trans_type_oid in ntg.dtype.t_id default null,
                            p_trans_type in ntg.dtype.t_name default null,
                            p_date_from in ntg.dtype.t_date default null,
                            p_date_to in ntg.dtype.t_date default null
                          )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin
      OPEN v_results FOR
        SELECT 
        * 
        --id, name 
        from BLNG.V_STATEMENT 
        where contract_oid = nvl(p_contract,contract_oid)
        --and decode(p_date_from,null,1,doc_date) >= decode(p_date_from,null,1,p_date_from)
        and ((p_date_from is not null and doc_date >= p_date_from) or p_date_from is null)
        and ((p_date_to is not null and doc_date <= p_date_from) or p_date_from is null)
        and trans_type_oid = nvl(p_trans_type_oid,trans_type_oid)
        and trans_type = nvl(p_trans_type,trans_type);
    return v_results;
  exception when others then 
    NTG.LOG_API.LOG_ADD(p_proc_name=>'statemant', p_msg_type=>'UNHANDLED_ERROR', 
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert&p_table=client&p_date=' 
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
    RAISE_APPLICATION_ERROR(-20002,'insert row into client error. '||SQLERRM);
    return null;
  end;

end info;

/
