  CREATE OR REPLACE PACKAGE hdbk.fwdr AS 


/*

pkg: hdbk.fwdr

*/

/*

$obj_type: procedure
$obj_name: bill_pay
$obj_desc: procedure perform transit bills with status [W]aiting to billing system. 
$obj_desc: that means bill requested for pay. after that bill marked as [T]ransported
$obj_desc: this procedure executed from job scheduler
$obj_param: p_pnr_id: id from NQT. search perform by this id
$obj_return: SYS_REFCURSOR[code,rate,version,is_active(Y,N)]
*/

  function rate_list( p_version in ntg.dtype.t_id default null)
  return SYS_REFCURSOR;

END fwdr;

/

--------------------------------------------------------
--  DDL for Package Body CORE
--------------------------------------------------------

  CREATE OR REPLACE  PACKAGE BODY hdbk.fwdr AS

  function rate_list(p_version in ntg.dtype.t_id default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
--    v_ord_row ord%rowtype;
--    v_id ntg.dtype.t_id; 
  begin
    OPEN v_results FOR
      SELECT 'EUR' code,60.12 rate,1 version,'Y' is_active  from dual
      union all
      SELECT 'USD' code,53.32 rate,1 version,'Y' is_active  from dual;      
    return v_results;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'rate_list', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=rate_list,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into rate error. '||SQLERRM);
    return null;    
  end;


END fwdr;

/
