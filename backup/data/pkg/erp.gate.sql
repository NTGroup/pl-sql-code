  CREATE OR REPLACE PACKAGE erp.gate as 

 /*
 
 pkg: erp.gate
 
 */
  

  
/*
$obj_type: function
$obj_name: get_cursor
$obj_desc: test function. return cursor with rowcount <= p_rowcount
$obj_param: p_rowcount: count rows in response
$obj_return: SYS_REFCURSOR[n,date_to,str,int,double]. table with this columns.
*/
  function get_cursor(p_rowcount in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR;

/*
$obj_type: procedure
$obj_name: run_proc
$obj_desc: test procedure. do nothing, but return string "input: p_rowcount" in out parameter o_result.
$obj_param: p_rowcount: its just parameter for input
$obj_param: o_result: string out parameter for return "input: p_rowcount"
$obj_return: SYS_REFCURSOR[n,date_to,str,int,double]. table with this columns.
*/
  procedure run_proc(p_rowcount in hdbk.dtype.t_id default null, o_result out hdbk.dtype.t_name);

end gate;

/

  CREATE OR REPLACE PACKAGE BODY erp.gate as

  function get_cursor(p_rowcount in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR
  is
--    v_result hdbk.dtype.t_date;
    v_result SYS_REFCURSOR;
  begin
    hdbk.log_api.LOG_ADD(p_proc_name=>'get_cursor', p_msg_type=>'OK',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM || ' '|| chr(13)||chr(10) || ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=item_avia_status,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    open v_result for
      select rownum n, sysdate date_to, 'hello' str, rownum int, rownum/3+0.5 double
      from dual
      connect by level <= p_rowcount;
      
    RETURN v_result;
  exception 
    when NO_DATA_FOUND then return null;  
    when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'avia_pay', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM || ' '|| chr(13)||chr(10) || ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=item_avia_status,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'avia_pay error. '||SQLERRM);
  end;

  procedure run_proc(p_rowcount in hdbk.dtype.t_id default null, o_result out hdbk.dtype.t_name)
  is
  begin
    hdbk.log_api.LOG_ADD(p_proc_name=>'run_proc', p_msg_type=>'OK',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM || ' '|| chr(13)||chr(10) || ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=item_avia_status,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    o_result :='input: '||p_rowcount;
  exception 
--    when NO_DATA_FOUND then return null;  
    when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'run_proc', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM || ' '|| chr(13)||chr(10) || ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=item_avia_status,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'run_proc error. '||SQLERRM);
  end;



end gate;

/
