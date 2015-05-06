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


/*
$obj_type: function
$obj_name: pdf_printer_add
$obj_desc: add new task for pdf printer
$obj_param: p_payload: json with booking data
$obj_param: p_filename: name of generated file
$obj_return: row id
*/

  function pdf_printer_add(p_payload in hdbk.dtype.t_clob default null, p_filename in hdbk.dtype.t_msg default null)
  return hdbk.dtype.t_id;


/*
$obj_type: procedure
$obj_name: pdf_printer_edit
$obj_desc: edit task for pdf printer
$obj_param: p_id: task id
$obj_param: p_payload: json with booking data
$obj_param: p_status: wich status you want to set: [N]ew,[E]rror,[D]one
$obj_param: p_filename: name of generated file
*/

  procedure pdf_printer_edit(  p_id in hdbk.dtype.t_id  default null, 
                              p_payload in hdbk.dtype.t_clob default null, 
                              p_status in hdbk.dtype.t_status default null, 
                              p_filename in hdbk.dtype.t_msg default null
                            );

/*
$obj_type: procedure
$obj_name: pdf_printer_get
$obj_desc: return data for task
$obj_param: p_id: task id
$obj_param: o_payload: out parameter for return json with booking data
$obj_param: o_filename: out parameter for return file name
*/

  procedure pdf_printer_get(  p_id in hdbk.dtype.t_id  default null, 
                              o_payload out hdbk.dtype.t_clob, 
                              o_filename out hdbk.dtype.t_msg
                            );

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



  function pdf_printer_add(p_payload in hdbk.dtype.t_clob default null, p_filename in hdbk.dtype.t_msg default null)
  return hdbk.dtype.t_id
  is
    v_pdf_printer hdbk.dtype.t_id;
    v_count hdbk.dtype.t_id;
  begin
    select count(*) into v_count from pdf_printer where amnd_date >= trunc(sysdate,'mi');
    if v_count >= 60 then raise STORAGE_ERROR; 
    elsif v_count=59 then 
      hdbk.log_api.LOG_ADD(p_proc_name=>'pdf_printer_add', p_msg_type=>'DDoS',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM || ' '|| chr(13)||chr(10) || ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=item_avia_status,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);    
    end if;
    v_pdf_printer:=erp.erp_api.pdf_printer_add(p_payload=>p_payload, p_filename=>p_filename, p_status=>'N');
    commit;    
    return v_pdf_printer;
  exception 
    when NO_DATA_FOUND then rollback; return null;  
    when STORAGE_ERROR then raise; --RAISE_APPLICATION_ERROR(6500,'DDoS!'||SQLERRM);  
    when others then
      rollback; 
      hdbk.log_api.LOG_ADD(p_proc_name=>'pdf_printer_add', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM || ' '|| chr(13)||chr(10) || ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=item_avia_status,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'pdf_printer_add error. '||SQLERRM);
  end;

  procedure pdf_printer_edit(  p_id in hdbk.dtype.t_id  default null, 
                              p_payload in hdbk.dtype.t_clob default null, 
                              p_status in hdbk.dtype.t_status default null, 
                              p_filename in hdbk.dtype.t_msg default null
                            )
  is
    v_pdf_printer hdbk.dtype.t_id;
    v_count hdbk.dtype.t_id;
  begin
    select count(*) into v_count from pdf_printer where amnd_date >= trunc(sysdate,'mi');
    if v_count >= 60 then raise STORAGE_ERROR; 
    elsif v_count=59 then 
      hdbk.log_api.LOG_ADD(p_proc_name=>'pdf_printer_edit', p_msg_type=>'DDoS',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM || ' '|| chr(13)||chr(10) || ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=item_avia_status,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);    
    end if;
    erp.erp_api.pdf_printer_edit(p_id=>p_id, p_payload=>p_payload, p_filename=>p_filename, p_status=>p_status);
    commit;    
  exception 
    when NO_DATA_FOUND then rollback;  
    when STORAGE_ERROR then raise; --RAISE_APPLICATION_ERROR(6500,'DDoS!'||SQLERRM);  
    when others then
      rollback; 
      hdbk.log_api.LOG_ADD(p_proc_name=>'pdf_printer_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM || ' '|| chr(13)||chr(10) || ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=item_avia_status,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'pdf_printer_edit error. '||SQLERRM);
  end;

  procedure pdf_printer_get(  p_id in hdbk.dtype.t_id  default null, 
                              o_payload out hdbk.dtype.t_clob, 
                             -- p_status in hdbk.dtype.t_status default null, 
                              o_filename out hdbk.dtype.t_msg
                            )
  is
    v_pdf_printer hdbk.dtype.t_id;
    v_count hdbk.dtype.t_id;
  begin
    select payload, filename into o_payload, o_filename from pdf_printer where id = p_id;
  exception 
    when NO_DATA_FOUND then rollback;  
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'pdf_printer_get', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM || ' '|| chr(13)||chr(10) || ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=item_avia_status,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'pdf_printer_get error. '||SQLERRM);
  end;


end gate;

/
