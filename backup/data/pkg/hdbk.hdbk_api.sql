
/

create or replace package hdbk.hdbk_api as

  
/*
$pkg: hdbk.hdbk_api
*/

/*
$obj_desc: ***_add insert row into table ***. could return id of new row.
$obj_desc: ***_edit update row into table ***. object have always one id. first, old data with amnd_state = [I]nactive
$obj_desc: inserted as row with link to new row(amnd_prev). new data just update object row, 
$obj_desc: amnd_date updates to sysdate and amnd_user to current user who called api.
$obj_desc: ***_get_info return data from table *** with format SYS_REFCURSOR.
$obj_desc: ***_get_info_r return one row from table *** with format ***%rowtype.
*/
  
  function gds_nationality_get_info (p_code in hdbk.dtype.t_code)
  return SYS_REFCURSOR;

  function gds_nationality_get_info_r (p_code in hdbk.dtype.t_code)
  return hdbk.gds_nationality%rowtype;

  function gds_nationality_get_info_name (p_code in hdbk.dtype.t_code)
  return hdbk.dtype.t_name;
  
  function note_add( 
                    p_name in hdbk.dtype.t_name default null,
                    p_client in hdbk.dtype.t_id default null
                  )
  return hdbk.dtype.t_id;


  procedure note_edit(  P_ID  in hdbk.dtype.t_id default null,
                              p_name in hdbk.dtype.t_name default null,
                    p_client in hdbk.dtype.t_id default null,
                    p_status in hdbk.dtype.t_status default null
                      );

  function note_get_info_r ( P_ID  in hdbk.dtype.t_id default null)
  return note%rowtype;



  function note_ticket_add( 
                    p_note in hdbk.dtype.t_id default null,
                    p_tickets in hdbk.dtype.t_clob default null
                  )
  return hdbk.dtype.t_id;


  procedure note_ticket_edit(  P_ID  in hdbk.dtype.t_id default null,
                                p_note in hdbk.dtype.t_id default null,
                                p_tickets in hdbk.dtype.t_clob default null,
                                p_status in hdbk.dtype.t_status default null                                
                      );


  function note_ticket_get_info_r (    P_ID  in hdbk.dtype.t_id default null  )
  return note_ticket%rowtype;

  

end;
/
create or replace package body hdbk.hdbk_api as
  
  function gds_nationality_get_info (p_code in hdbk.dtype.t_code)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin
  
    OPEN v_results FOR
      select 
      *
      from 
      hdbk.gds_nationality
      where code = p_code;
    return v_results;
  exception 
    when NO_DATA_FOUND then
      hdbk.log_api.LOG_ADD(p_proc_name=>'gds_nationality_get_info', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=gds_nationality,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE;
    when TOO_MANY_ROWS then
      hdbk.log_api.LOG_ADD(p_proc_name=>'gds_nationality_get_info', p_msg_type=>'TOO_MANY_ROWS',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=gds_nationality,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'gds_nationality_get_info', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=gds_nationality,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into gds_nationality error. '||SQLERRM);
      return null;
  end;


  function gds_nationality_get_info_r (p_code in hdbk.dtype.t_code)
  return hdbk.gds_nationality%rowtype
  is
    v_results hdbk.gds_nationality%rowtype; 
  begin
      select 
      * into v_results
      from 
      hdbk.gds_nationality
      where code = p_code;
    return v_results;
  exception 
    when NO_DATA_FOUND then
      hdbk.log_api.LOG_ADD(p_proc_name=>'gds_nationality_get_info_r', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=gds_nationality,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE NO_DATA_FOUND;
    when TOO_MANY_ROWS then
      hdbk.log_api.LOG_ADD(p_proc_name=>'gds_nationality_get_info_r', p_msg_type=>'TOO_MANY_ROWS',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=gds_nationality,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE TOO_MANY_ROWS;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'gds_nationality_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=gds_nationality,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into gds_nationality error. '||SQLERRM);
  end;

  function gds_nationality_get_info_name (p_code in hdbk.dtype.t_code)
  return hdbk.dtype.t_name
  is
    v_results hdbk.dtype.t_name; 
  begin
    if p_code is null then return null; end if; 
    select 
    nls_name into v_results
    from 
    hdbk.gds_nationality
    where code = p_code;
    return v_results;
  exception 
    when NO_DATA_FOUND then
      hdbk.log_api.LOG_ADD(p_proc_name=>'gds_nationality_get_info_name', p_msg_type=>'TOO_MANY_ROWS',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=gds_nationality,p_code='||p_code||',p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then
      hdbk.log_api.LOG_ADD(p_proc_name=>'gds_nationality_get_info_name', p_msg_type=>'TOO_MANY_ROWS',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=gds_nationality,p_code='||p_code||',p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE TOO_MANY_ROWS;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'gds_nationality_get_info_name', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=gds_nationality,p_code='||p_code||',p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into gds_nationality error. '||SQLERRM);
  end;




  function note_add( 
                    p_name in hdbk.dtype.t_name default null,
                    p_client in hdbk.dtype.t_id default null
                  )
  return hdbk.dtype.t_id
  is
    v_obj_row note%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_obj_row.name:=  p_name;
    v_obj_row.client_oid:=  p_client;

    insert into note values v_obj_row returning id into v_id;
    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'note_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=note,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into note error. '||SQLERRM);
  end;


  procedure note_edit(  P_ID  in hdbk.dtype.t_id default null,
                              p_name in hdbk.dtype.t_name default null,
                    p_client in hdbk.dtype.t_id default null,
                    p_status in hdbk.dtype.t_status default null
                      )
  is
    v_obj_row_new note%rowtype;
    v_obj_row_old note%rowtype;
  begin
    if p_id is null then raise NO_DATA_FOUND; end if;   
  
    select * into v_obj_row_old from note 
        where id = nvl(p_id,id)
        and amnd_state  != 'I'
    ;
    v_obj_row_new := v_obj_row_old;

    v_obj_row_new.amnd_date:=sysdate;
    v_obj_row_new.amnd_user:=user;
    v_obj_row_new.name := nvl(p_name,v_obj_row_new.name);
    if p_status in ('C','D') then  v_obj_row_new.amnd_state := 'C'; end if;
    if p_status in ('A') then  v_obj_row_new.amnd_state := 'A'; end if;

    v_obj_row_old.amnd_state:='I';
    v_obj_row_old.id:=null;
    insert into note values v_obj_row_old;

    update note set row = v_obj_row_new where id = v_obj_row_new.id;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'note_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=note,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into note error. '||SQLERRM);
  end;

  function note_get_info_r ( P_ID  in hdbk.dtype.t_id default null)
  return note%rowtype
  is
    r_obj note%rowtype;
  begin
    if p_id is null  then raise NO_DATA_FOUND; end if;   
    
    SELECT
    * into r_obj
    from note 
    where id = nvl(p_id,id)
    and amnd_state != 'I'
    order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;  
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'note_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=note,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into note error. '||SQLERRM);
  end;



  function note_ticket_add( 
                    p_note in hdbk.dtype.t_id default null,
                    p_tickets in hdbk.dtype.t_clob default null
                  )
  return hdbk.dtype.t_id
  is
    v_obj_row note_ticket%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_obj_row.note_oid:=  p_note;
    v_obj_row.tickets:=  p_tickets;

    insert into hdbk.note_ticket values v_obj_row returning id into v_id;
    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'note_ticket_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=note_ticket,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into note_ticket error. '||SQLERRM);
  end;


  procedure note_ticket_edit(  P_ID  in hdbk.dtype.t_id default null,
                                p_note in hdbk.dtype.t_id default null,
                                p_tickets in hdbk.dtype.t_clob default null,
                                p_status in hdbk.dtype.t_status default null                                
                      )
  is
    v_obj_row_new note_ticket%rowtype;
    v_obj_row_old note_ticket%rowtype;
  begin
    if p_id is null then raise NO_DATA_FOUND; end if;   
  
    select * into v_obj_row_old from note_ticket 
        where id = nvl(p_id,id)
        and amnd_state != 'I'
    ;
    v_obj_row_new := v_obj_row_old;

    v_obj_row_new.amnd_date:=sysdate;
    v_obj_row_new.amnd_user:=user;
    v_obj_row_new.note_oid := nvl(p_note,v_obj_row_new.note_oid);
    v_obj_row_new.tickets := nvl(p_tickets,v_obj_row_new.tickets);
    if p_status in ('C','D') then  v_obj_row_new.amnd_state := 'C'; end if;
    if p_status in ('A') then  v_obj_row_new.amnd_state := 'A'; end if;


    v_obj_row_old.amnd_state:='I';
    v_obj_row_old.id:=null;
    insert into note_ticket values v_obj_row_old;

    update note_ticket set row = v_obj_row_new where id = v_obj_row_new.id;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'note_ticket_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=note_ticket,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into note_ticket error. '||SQLERRM);
  end;


  function note_ticket_get_info_r (    P_ID  in hdbk.dtype.t_id default null  )
  return note_ticket%rowtype
  is
    r_obj note_ticket%rowtype;
  begin
    if p_id is null then raise NO_DATA_FOUND; end if;   
    
    SELECT
    * into r_obj
    from note_ticket 
    where id = nvl(p_id,id)
    and amnd_state != 'I'
    order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;  
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'note_ticket_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=note_ticket,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into note_ticket error. '||SQLERRM);
  end;



end;
/

--------------------------------------------------------
--  DDL for Grants
--------------------------------------------------------

--grant execute on hdbk.hdbk_api to blng;
--grant execute on hdbk.hdbk_api to ord;
--grant execute on hdbk.hdbk_api to po_fwdr;

/