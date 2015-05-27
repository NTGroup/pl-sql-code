  CREATE OR REPLACE PACKAGE erp.erp_api as 

 /*
 
 pkg: erp.erp_api
 
 */
  
/*
$obj_desc: ***_add: insert row into table ***. could return id of new row.
$obj_desc: ***_edit: update row into table ***. object have always one id. first, old data with amnd_state = [I]nactive
$obj_desc: ***_edit: inserted as row with link to new row(amnd_prev). new data just update object row, 
$obj_desc: ***_edit: amnd_date updates to sysdate and amnd_user to current user who called api.
$obj_desc: ***_get_info: return data from table *** with format SYS_REFCURSOR.
$obj_desc: ***_get_info_r: return one row from table *** with format ***%rowtype.
*/
  

/*
  function pdf_printer_add( 
                    p_payload in hdbk.dtype.t_long default null,
                    p_status in hdbk.dtype.t_status default null,
                    p_filename in hdbk.dtype.t_msg default null
                  )
  return hdbk.dtype.t_id;


  procedure pdf_printer_edit(  P_ID  in hdbk.dtype.t_id default null,
                                p_payload in hdbk.dtype.t_long default null,
                                p_status in hdbk.dtype.t_status default null,
                                p_filename in hdbk.dtype.t_msg default null
                      );


  function pdf_printer_get_info( P_ID  in hdbk.dtype.t_id default null
                          )
  return SYS_REFCURSOR;


  function pdf_printer_get_info_r (     P_ID  in hdbk.dtype.t_id default null
                                )
  return pdf_printer%rowtype;
*/

end erp_api;


/

  CREATE OR REPLACE PACKAGE BODY erp.erp_api as


/*
  function pdf_printer_add( 
                    p_payload in hdbk.dtype.t_long default null,
                    p_status in hdbk.dtype.t_status default null,
                    p_filename in hdbk.dtype.t_msg default null
                  )
  return hdbk.dtype.t_id
  is
    v_obj_row pdf_printer%rowtype;
    v_id hdbk.dtype.t_id;
  begin
--    if p_date_to is null or p_day_type is null then raise NO_DATA_FOUND; end if;   
    v_obj_row.payload:=  p_payload;
    v_obj_row.status:=  p_status;
    v_obj_row.filename:=  p_filename;

    insert into pdf_printer values v_obj_row returning id into v_id;
    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'pdf_printer_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=pdf_printer,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into pdf_printer error. '||SQLERRM);
  end;


  procedure pdf_printer_edit(  P_ID  in hdbk.dtype.t_id default null,
                                p_payload in hdbk.dtype.t_long default null,
                                p_status in hdbk.dtype.t_status default null,
                                p_filename in hdbk.dtype.t_msg default null
                      )
  is
    v_obj_row_new pdf_printer%rowtype;
    v_obj_row_old pdf_printer%rowtype;
  begin
    if p_id is null then raise NO_DATA_FOUND; end if;   
--    if p_date_to is null and p_day_type is null and p_contract is null then raise NO_DATA_FOUND; end if;   
  
    select * into v_obj_row_old from pdf_printer 
        where id = nvl(p_id,id)
        and amnd_state = 'A'
    ;
    v_obj_row_new := v_obj_row_old;

    v_obj_row_new.amnd_date:=sysdate;
    v_obj_row_new.amnd_user:=user;
    v_obj_row_new.payload := nvl(p_payload,v_obj_row_new.payload);
    v_obj_row_new.status := nvl(p_status,v_obj_row_new.status);
    v_obj_row_new.filename := nvl(p_filename,v_obj_row_new.filename);

    v_obj_row_old.amnd_state:='I';
    v_obj_row_old.id:=null;
    insert into pdf_printer values v_obj_row_old;

    update pdf_printer set row = v_obj_row_new where id = v_obj_row_new.id;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'pdf_printer_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=pdf_printer,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into pdf_printer error. '||SQLERRM);
  end;


  function pdf_printer_get_info( P_ID  in hdbk.dtype.t_id default null
                          )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from pdf_printer 
        where id = nvl(p_id,id)
        and amnd_state = 'A'
        order by id;
    return v_results;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'pdf_printer_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=pdf_printer,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into pdf_printer error. '||SQLERRM);
  end;


  function pdf_printer_get_info_r (     P_ID  in hdbk.dtype.t_id default null
                                )
  return pdf_printer%rowtype
  is
    r_obj pdf_printer%rowtype;
  begin
    if p_id is null then raise NO_DATA_FOUND; end if;   
    
    SELECT
    * into r_obj
    from pdf_printer 
    where id = nvl(p_id,id)
   -- and date_to = nvl(p_date_to,date_to)
    and amnd_state = 'A'
    order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;  
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'pdf_printer_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=pdf_printer,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into pdf_printer error. '||SQLERRM);
  end;
*/


end erp_api;

/
