--------------------------------------------------------
--  DDL for Package ORD_API
--------------------------------------------------------

  CREATE OR REPLACE  PACKAGE "ORD"."ORD_API" AS 

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
  function ord_add( p_date  in ntg.dtype.t_date default null, 
                    p_order_number  in ntg.dtype.t_long_code default null, 
                    p_client in ntg.dtype.t_id default null,
                    p_status in ntg.dtype.t_status default null
                    )
  return ntg.dtype.t_id;

  function item_avia_add(p_ORDER_OID in ntg.dtype.t_id default null,
                          p_PNR_ID in ntg.dtype.t_long_code default null,
                          p_TIME_LIMIT  in ntg.dtype.t_date default null,
                          p_TOTAL_AMOUNT in ntg.dtype.t_amount default null,
                          p_TOTAL_MARKUP in ntg.dtype.t_amount default null,
                          p_PNR_OBJECT in ntg.dtype.t_clob default null,
                          p_nqt_id in  ntg.dtype.t_long_code default null,
                          p_nqt_status in ntg.dtype.t_status default null, 
                          p_po_status in ntg.dtype.t_status default null,
                          p_nqt_status_cur in ntg.dtype.t_status default null 
                          )
  return ntg.dtype.t_id;



  function ord_get_info(p_id in ntg.dtype.t_id)
  return SYS_REFCURSOR;

  function ord_get_info_r (p_id in ntg.dtype.t_id
                          )
  return ord%rowtype;

  function item_avia_get_info(p_id in ntg.dtype.t_id default null,
                              p_nqt_id in ntg.dtype.t_long_code default null,
                              p_order in ntg.dtype.t_id default null
                              )
  return SYS_REFCURSOR;

  function item_avia_get_info_r ( p_id in ntg.dtype.t_id default null,
                              p_nqt_id in ntg.dtype.t_long_code default null,
                              p_order in ntg.dtype.t_id default null
                              )
  return item_avia%rowtype;
  
  procedure item_avia_edit( P_ID  in ntg.dtype.t_id default null,
                            p_ORDER_OID in ntg.dtype.t_id default null,
                          p_PNR_ID in ntg.dtype.t_long_code default null,
                          p_TIME_LIMIT  in ntg.dtype.t_date default null,
                          p_TOTAL_AMOUNT in ntg.dtype.t_amount default null,
                          p_TOTAL_MARKUP in ntg.dtype.t_amount default null,
                          p_PNR_OBJECT in ntg.dtype.t_clob default null,
                          p_nqt_id in ntg.dtype.t_long_code default null,
                          p_nqt_status in ntg.dtype.t_status default null, 
                          p_po_status in ntg.dtype.t_status default null,
                          p_nqt_status_cur in ntg.dtype.t_status default null);
                          
  function commission_add(p_airline in ntg.dtype.t_id default null,
                          p_details in ntg.dtype.t_name default null,
                          p_fix  in ntg.dtype.t_amount default null,
                          p_percent in ntg.dtype.t_amount default null,
                          P_DATE_FROM IN ntg.dtype.T_DATE DEFAULT NULL,
                          P_DATE_TO IN ntg.dtype.T_DATE DEFAULT NULL
                          )
  return ntg.dtype.t_id;
  
    procedure commission_edit( P_ID  in ntg.dtype.t_id default null,
                            p_airline in ntg.dtype.t_id default null,
                          p_details in ntg.dtype.t_name default null,
                          p_fix  in ntg.dtype.t_amount default null,
                          p_percent in ntg.dtype.t_amount default null,
                          P_DATE_FROM IN ntg.dtype.T_DATE DEFAULT NULL,
                          P_DATE_TO IN ntg.dtype.T_DATE DEFAULT NULL);

  function commission_get_info(p_id in ntg.dtype.t_id default null,
                              p_airline in ntg.dtype.t_id default null
  )
  return SYS_REFCURSOR;


  function commission_get_info_r ( p_id in ntg.dtype.t_id default null,
                              p_airline in ntg.dtype.t_id default null
                            )
  return commission%rowtype;

  function commission_template_add( p_template_type in ntg.dtype.t_long_code default null,
                                    p_CLASS in ntg.dtype.t_code default null,
                                    p_FLIGHT_AC in ntg.dtype.t_code default null,
                                    p_FLIGHT_NOT_AC in ntg.dtype.t_code default null,
                                    p_FLIGHT_MC in ntg.dtype.t_code default null,
                                    p_FLIGHT_OC in ntg.dtype.t_code default null,
                                    p_FLIGHT_SEGMENT in ntg.dtype.t_code default null,
                                    p_COUNTRY_FROM in ntg.dtype.t_code default null,
                                    p_COUNTRY_TO in ntg.dtype.t_code default null,
                                    p_COUNTRY_INSIDE in ntg.dtype.t_code default null,
                                    p_COUNTRY_OUTSIDE in ntg.dtype.t_code default null,
                                    p_TARIFF in ntg.dtype.t_code default null,
                                    p_priority in ntg.dtype.t_id default null
                                  )
  return ntg.dtype.t_id;
  
  procedure commission_template_edit( P_ID  in ntg.dtype.t_id default null,
                                    p_template_type in ntg.dtype.t_long_code default null,
                                    p_CLASS in ntg.dtype.t_code default null,
                                    p_FLIGHT_AC in ntg.dtype.t_code default null,
                                    p_FLIGHT_NOT_AC in ntg.dtype.t_code default null,
                                    p_FLIGHT_MC in ntg.dtype.t_code default null,
                                    p_FLIGHT_OC in ntg.dtype.t_code default null,
                                    p_FLIGHT_SEGMENT in ntg.dtype.t_code default null,
                                    p_COUNTRY_FROM in ntg.dtype.t_code default null,
                                    p_COUNTRY_TO in ntg.dtype.t_code default null,
                                    p_COUNTRY_INSIDE in ntg.dtype.t_code default null,
                                    p_COUNTRY_OUTSIDE in ntg.dtype.t_code default null,
                                    p_TARIFF in ntg.dtype.t_code default null,
                                    p_priority in ntg.dtype.t_id default null);
                                    
  function commission_template_get_info(p_id in ntg.dtype.t_id default null)
  return SYS_REFCURSOR;


  function commission_template_get_info_r ( p_id in ntg.dtype.t_id default null)
  return commission_template%rowtype;



  function commission_details_add( p_commission in ntg.dtype.t_id default null,
                                    p_commission_template in ntg.dtype.t_id default null,
                                    p_value in  ntg.dtype.t_name default null
                                  )
  return ntg.dtype.t_id;


  procedure commission_details_edit( P_ID  in ntg.dtype.t_id default null,
                                    p_commission in ntg.dtype.t_id default null,
                                    p_commission_template in ntg.dtype.t_id default null,
                                    p_value in  ntg.dtype.t_name default null);
                                

  function commission_details_get_info( p_id in ntg.dtype.t_id default null, p_commission in ntg.dtype.t_id default null )
  return SYS_REFCURSOR;

  function commission_details_get_info_r ( p_id in ntg.dtype.t_id default null, p_commission in ntg.dtype.t_id default null)
  return commission_details%rowtype;

  function commission_template_get_id( p_type in ntg.dtype.t_name default null)
  return  ntg.dtype.t_id;

/*  function v_json_r ( p_item_avia in ntg.dtype.t_id default null)
  return v_json%rowtype;
*/

  function bill_add( p_order in ntg.dtype.t_id default null,
                    p_amount in ntg.dtype.t_amount default null,
                    p_date in  ntg.dtype.t_date default null,
                    p_status in  ntg.dtype.t_status default null,
                    p_contract in  ntg.dtype.t_id default null
                    
                  )
  return ntg.dtype.t_id;

  procedure bill_edit(  P_ID  in ntg.dtype.t_id default null,
                        p_order in ntg.dtype.t_id default null,
                        p_amount in ntg.dtype.t_amount default null,
                        p_date in  ntg.dtype.t_date default null,
                        p_status in  ntg.dtype.t_status default null,
                        p_contract in  ntg.dtype.t_id default null
                      );

  function bill_get_info( p_id in ntg.dtype.t_id default null, 
                          p_order in ntg.dtype.t_id default null,
                          p_date in  ntg.dtype.t_date default null,
                          p_status in  ntg.dtype.t_status default null,
                          p_contract in  ntg.dtype.t_id default null
                          )
  return SYS_REFCURSOR;

  function bill_get_info_r (p_id in ntg.dtype.t_id default null, 
                          p_order in ntg.dtype.t_id default null,
                          p_date in  ntg.dtype.t_date default null,
                          p_status in  ntg.dtype.t_status default null,
                          p_contract in  ntg.dtype.t_id default null
                          )
  return bill%rowtype;

  function item_avia_status_add( 
                    p_item_avia in ntg.dtype.t_id default null,
                    p_po_status in ntg.dtype.t_status default null,
                    p_nqt_status_cur in  ntg.dtype.t_status default null
                  )
  return ntg.dtype.t_id;

  procedure item_avia_status_edit(  P_ID  in ntg.dtype.t_id default null,
                                    p_item_avia in ntg.dtype.t_id default null,
                                    p_po_status in ntg.dtype.t_status default null,
                                    p_nqt_status_cur in  ntg.dtype.t_status default null
                      );

  function item_avia_status_get_info(   P_ID  in ntg.dtype.t_id default null,
                                    p_item_avia in ntg.dtype.t_id default null
                          )
  return SYS_REFCURSOR ;
  
  function item_avia_status_get_info_r (  P_ID  in ntg.dtype.t_id default null,
                                    p_item_avia in ntg.dtype.t_id default null
                          )
  return item_avia_status%rowtype;



  

  
END ORD_API;

/

--------------------------------------------------------
--  DDL for Package Body ORD_API
--------------------------------------------------------

  CREATE OR REPLACE  PACKAGE BODY "ORD"."ORD_API" AS


  function ord_add( p_date  in ntg.dtype.t_date, 
                    p_order_number  in ntg.dtype.t_long_code, 
                    p_client in ntg.dtype.t_id,
                    p_status in ntg.dtype.t_status
                    )
  return ntg.dtype.t_id
  is
    v_ord_row ord%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_ord_row.order_date:=p_date;
    v_ord_row.order_number:=p_order_number;
    v_ord_row.client_oid:=p_client;
    v_ord_row.status:=p_status;
    insert into ord.ord values v_ord_row returning id into v_id;
--    commit;
    return v_id;
  exception when others then
--    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'ord_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=insert,p_table=ord,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into ord error. '||SQLERRM);
    return null;
  end;


  function item_avia_add(p_ORDER_OID in ntg.dtype.t_id default null,
                          p_PNR_ID in ntg.dtype.t_long_code default null,
                          p_TIME_LIMIT  in ntg.dtype.t_date default null,
                          p_TOTAL_AMOUNT in ntg.dtype.t_amount default null,
                          p_TOTAL_MARKUP in ntg.dtype.t_amount default null,
                          p_PNR_OBJECT in ntg.dtype.t_clob  default null,
                          p_nqt_id in ntg.dtype.t_long_code default null,
                          p_nqt_status in ntg.dtype.t_status default null, 
                          p_po_status in ntg.dtype.t_status default null,
                          p_nqt_status_cur in ntg.dtype.t_status default null
                          )
  return ntg.dtype.t_id
  is
    v_item_avia_row item_avia%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_item_avia_row.ORDER_OID:=  p_ORDER_OID;
    v_item_avia_row.PNR_ID:=  p_PNR_ID;
    v_item_avia_row.TIME_LIMIT:=  p_TIME_LIMIT;
    v_item_avia_row.TOTAL_AMOUNT:=  p_TOTAL_AMOUNT;
    v_item_avia_row.TOTAL_MARKUP:=  p_TOTAL_MARKUP;
    v_item_avia_row.PNR_OBJECT:=  p_PNR_OBJECT;
    v_item_avia_row.nqt_id:=  p_nqt_id;
    v_item_avia_row.nqt_status:=  p_nqt_status;
    v_item_avia_row.po_status:=  p_po_status;
    v_item_avia_row.nqt_status_cur:=  p_nqt_status_cur;
--    v_item_avia_row.client_oid:=  p_client;
    insert into ord.item_avia values v_item_avia_row returning id into v_id;
--    commit;
    return v_id;
  exception when others then
--    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'item_avia_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=insert,p_table=item_avia,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into item_avia error. '||SQLERRM);
    return null;
  end;

  function ord_get_info(p_id in ntg.dtype.t_id)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from ord.ord where id = p_id
        order by id;
    return v_results;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'ord_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=ord,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into ord error. '||SQLERRM);
    return null;
  end;


  function ord_get_info_r (p_id in ntg.dtype.t_id
                          )
  return ord%rowtype
  is
    c_obj  SYS_REFCURSOR;
    r_obj ord%rowtype;
  begin
    c_obj := ord_api.ord_get_info(p_id);
    --DBMS_OUTPUT.put_line (1);
    LOOP
      FETCH c_obj INTO r_obj;
      EXIT WHEN c_obj%NOTFOUND;
      --DBMS_OUTPUT.put_line (r_account.name);
    END LOOP;
    CLOSE c_obj;
    return r_obj;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'ord_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=ord,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into ord error. '||SQLERRM);
    return null;
  end;





  function item_avia_get_info(p_id in ntg.dtype.t_id default null,
                              p_nqt_id in ntg.dtype.t_long_code default null,
                              p_order in ntg.dtype.t_id default null
  )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from ord.item_avia 
        where id = nvl(p_id,id)
        and nqt_id = nvl(p_nqt_id,nqt_id)
        and order_oid = nvl(p_order,order_oid)
        and amnd_state = 'A'
        order by id;
    return v_results;
  exception 
    when NO_DATA_FOUND then raise;
    when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'item_avia_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=select,p_table=item_avia,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into item_avia error. '||SQLERRM);
--    return null;
  end;

  function item_avia_get_info_r ( p_id in ntg.dtype.t_id default null,
                              p_nqt_id in ntg.dtype.t_long_code default null,
                              p_order in ntg.dtype.t_id default null
                              
                            )
  return item_avia%rowtype
  is
    c_obj  SYS_REFCURSOR;
    r_obj item_avia%rowtype;
  begin
  
    SELECT
    * into r_obj
    from ord.item_avia 
    where id = nvl(p_id,id)
    and nqt_id = nvl(p_nqt_id,nqt_id)
    and order_oid = nvl(p_order,order_oid)
    and amnd_state = 'A'
    order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'item_avia_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=select,p_table=item_avia,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into item_avia error. '||SQLERRM);
  --    return null;
  end item_avia_get_info_r;

  procedure item_avia_edit( P_ID  in ntg.dtype.t_id default null,
                            p_ORDER_OID in ntg.dtype.t_id default null,
                          p_PNR_ID in ntg.dtype.t_long_code default null,
                          p_TIME_LIMIT  in ntg.dtype.t_date default null,
                          p_TOTAL_AMOUNT in ntg.dtype.t_amount default null,
                          p_TOTAL_MARKUP in ntg.dtype.t_amount default null,
                          p_PNR_OBJECT in ntg.dtype.t_clob default null,
                          p_nqt_id in ntg.dtype.t_long_code default null,
                          p_nqt_status in ntg.dtype.t_status default null, 
                          p_po_status in ntg.dtype.t_status default null,
                          p_nqt_status_cur in ntg.dtype.t_status default null
                          )
  is
  --  v_mess ntg.dtype.t_msg;
    v_obj_row_new item_avia%rowtype;
    v_obj_row_old item_avia%rowtype;
--    v_id 
  begin

    select * into v_obj_row_old from item_avia 
        where id = nvl(p_id,id)
        and nqt_id = nvl(p_nqt_id,nqt_id)
        and amnd_state = 'A'
    ;
    v_obj_row_new := v_obj_row_old;

    v_obj_row_old.amnd_state:='I';
    v_obj_row_old.id:=null;
    insert into item_avia values v_obj_row_old;


    v_obj_row_new.amnd_date:=sysdate;
    v_obj_row_new.amnd_user:=user;
    v_obj_row_new.PNR_ID := nvl(p_PNR_ID,v_obj_row_new.PNR_ID);
    v_obj_row_new.TIME_LIMIT := nvl(p_TIME_LIMIT,v_obj_row_new.TIME_LIMIT);
    v_obj_row_new.TOTAL_AMOUNT := nvl(p_TOTAL_AMOUNT,v_obj_row_new.TOTAL_AMOUNT);
    v_obj_row_new.TOTAL_MARKUP := nvl(p_TOTAL_MARKUP,v_obj_row_new.TOTAL_MARKUP);
    v_obj_row_new.PNR_OBJECT := nvl(p_PNR_OBJECT, v_obj_row_new.PNR_OBJECT);
    v_obj_row_new.nqt_status := nvl(p_nqt_status,v_obj_row_new.nqt_status);
    v_obj_row_new.po_status := nvl(p_po_status,v_obj_row_new.po_status);
    v_obj_row_new.nqt_status_cur := nvl(p_nqt_status_cur,v_obj_row_new.nqt_status_cur);
--    v_obj_row_new.status := p_status;

    update item_avia set row = v_obj_row_new where id = v_obj_row_new.id;
  exception 
    when NO_DATA_FOUND then
/*      NTG.LOG_API.LOG_ADD(p_proc_name=>'item_avia_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=update,p_table=item_avia,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into item_avia error. '||SQLERRM);*/
      raise;
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'item_avia_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=update,p_table=item_avia,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into item_avia error. '||SQLERRM);
  end item_avia_edit;


  function commission_add(p_airline in ntg.dtype.t_id default null,
                          p_details in ntg.dtype.t_name default null,
                          p_fix  in ntg.dtype.t_amount default null,
                          p_percent in ntg.dtype.t_amount default null,
                          P_DATE_FROM IN ntg.dtype.T_DATE DEFAULT NULL,
                          P_DATE_TO IN ntg.dtype.T_DATE DEFAULT NULL
                          )
  return ntg.dtype.t_id
  is
    v_obj_row commission%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_obj_row.airline:=  p_airline;
    v_obj_row.details:=  p_details;
    v_obj_row.fix:=  p_fix;
    v_obj_row.percent:=  p_percent;
    v_obj_row.DATE_FROM:=  P_DATE_FROM;
    v_obj_row.DATE_TO:=  P_DATE_TO;

    insert into ord.commission values v_obj_row returning id into v_id;
--    commit;
    return v_id;
  exception when others then
--    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=commission,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into commission error. '||SQLERRM);
    return null;
  end;



  procedure commission_edit( P_ID  in ntg.dtype.t_id default null,
                            p_airline in ntg.dtype.t_id default null,
                          p_details in ntg.dtype.t_name default null,
                          p_fix  in ntg.dtype.t_amount default null,
                          p_percent in ntg.dtype.t_amount default null,
                          P_DATE_FROM IN ntg.dtype.T_DATE DEFAULT NULL,
                          P_DATE_TO IN ntg.dtype.T_DATE DEFAULT NULL)
  is
  --  v_mess ntg.dtype.t_msg;
    v_obj_row_new commission%rowtype;
    v_obj_row_old commission%rowtype;
--    v_id 
  begin

    select * into v_obj_row_old from commission 
        where id = nvl(p_id,id)
        and amnd_state = 'A'
    ;
    v_obj_row_new := v_obj_row_old;

    v_obj_row_old.amnd_state:='I';
    v_obj_row_old.id:=null;
    insert into commission values v_obj_row_old;


    v_obj_row_new.amnd_date:=sysdate;
    v_obj_row_new.amnd_user:=user;
    v_obj_row_new.airline := nvl(p_airline,v_obj_row_new.airline);
    v_obj_row_new.details := nvl(p_details,v_obj_row_new.details);
    v_obj_row_new.fix := nvl(p_fix,v_obj_row_new.fix);
    v_obj_row_new.percent := nvl(p_percent,v_obj_row_new.percent);
    v_obj_row_new.date_from := nvl(p_date_from,v_obj_row_new.date_from);
    v_obj_row_new.date_to := nvl(p_date_to,v_obj_row_new.date_to);

    update commission set row = v_obj_row_new where id = v_obj_row_new.id;
  exception 
    when NO_DATA_FOUND then
/*      NTG.LOG_API.LOG_ADD(p_proc_name=>'item_avia_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=update,p_table=item_avia,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into item_avia error. '||SQLERRM);*/
      raise;
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=commission,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into commission error. '||SQLERRM);
  end commission_edit;



  function commission_get_info(p_id in ntg.dtype.t_id default null,
                              p_airline in ntg.dtype.t_id default null
  )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from ord.commission 
        where id = nvl(p_id,id)
        and airline = nvl(p_airline,airline)
        and amnd_state = 'A'
        order by id;
    return v_results;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=commission,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into commission error. '||SQLERRM);
    return null;
  end;


  function commission_get_info_r ( p_id in ntg.dtype.t_id default null,
                              p_airline in ntg.dtype.t_id default null
                            )
  return commission%rowtype
  is
    c_obj  SYS_REFCURSOR;
    r_obj commission%rowtype;
  begin
    c_obj := ord_api.commission_get_info(p_id, p_airline);
    --DBMS_OUTPUT.put_line (1);
    LOOP
      FETCH c_obj INTO r_obj;
      EXIT WHEN c_obj%NOTFOUND;
      --DBMS_OUTPUT.put_line (r_account.name);
    END LOOP;
    CLOSE c_obj;
    return r_obj;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=commission,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into commission error. '||SQLERRM);
    return null;
  end commission_get_info_r;



  function commission_template_add( p_template_type in ntg.dtype.t_long_code default null,
                                    p_CLASS in ntg.dtype.t_code default null,
                                    p_FLIGHT_AC in ntg.dtype.t_code default null,
                                    p_FLIGHT_NOT_AC in ntg.dtype.t_code default null,
                                    p_FLIGHT_MC in ntg.dtype.t_code default null,
                                    p_FLIGHT_OC in ntg.dtype.t_code default null,
                                    p_FLIGHT_SEGMENT in ntg.dtype.t_code default null,
                                    p_COUNTRY_FROM in ntg.dtype.t_code default null,
                                    p_COUNTRY_TO in ntg.dtype.t_code default null,
                                    p_COUNTRY_INSIDE in ntg.dtype.t_code default null,
                                    p_COUNTRY_OUTSIDE in ntg.dtype.t_code default null,
                                    p_TARIFF in ntg.dtype.t_code default null,
                                    p_priority in ntg.dtype.t_id default null
                                  )
  return ntg.dtype.t_id
  is
    v_obj_row commission_template%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_obj_row.template_type:=  p_template_type;
    v_obj_row.CLASS:=  p_CLASS;
    v_obj_row.FLIGHT_AC:=  p_FLIGHT_AC;
    v_obj_row.FLIGHT_NOT_AC:=  p_FLIGHT_NOT_AC;
    v_obj_row.FLIGHT_MC:=  p_FLIGHT_MC;
    v_obj_row.FLIGHT_OC:=  p_FLIGHT_OC;
    v_obj_row.FLIGHT_SEGMENT:=  p_FLIGHT_SEGMENT;
    v_obj_row.COUNTRY_FROM:=  p_COUNTRY_FROM;
    v_obj_row.COUNTRY_TO:=  p_COUNTRY_TO;
    v_obj_row.COUNTRY_INSIDE:=  p_COUNTRY_INSIDE;
    v_obj_row.COUNTRY_OUTSIDE:=  p_COUNTRY_OUTSIDE;
    v_obj_row.TARIFF:=  p_TARIFF;
    v_obj_row.priority:=  p_priority;

    insert into ord.commission_template values v_obj_row returning id into v_id;
--    commit;
    return v_id;
  exception when others then
--    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_template_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=commission_template,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into commission_template error. '||SQLERRM);
    return null;
  end;



  procedure commission_template_edit( P_ID  in ntg.dtype.t_id default null,
                                    p_template_type in ntg.dtype.t_long_code default null,
                                    p_CLASS in ntg.dtype.t_code default null,
                                    p_FLIGHT_AC in ntg.dtype.t_code default null,
                                    p_FLIGHT_NOT_AC in ntg.dtype.t_code default null,
                                    p_FLIGHT_MC in ntg.dtype.t_code default null,
                                    p_FLIGHT_OC in ntg.dtype.t_code default null,
                                    p_FLIGHT_SEGMENT in ntg.dtype.t_code default null,
                                    p_COUNTRY_FROM in ntg.dtype.t_code default null,
                                    p_COUNTRY_TO in ntg.dtype.t_code default null,
                                    p_COUNTRY_INSIDE in ntg.dtype.t_code default null,
                                    p_COUNTRY_OUTSIDE in ntg.dtype.t_code default null,
                                    p_TARIFF in ntg.dtype.t_code default null,
                                    p_priority in ntg.dtype.t_id default null)
  is
  --  v_mess ntg.dtype.t_msg;
    v_obj_row_new commission_template%rowtype;
    v_obj_row_old commission_template%rowtype;
--    v_id 
  begin

    select * into v_obj_row_old from commission_template 
        where id = nvl(p_id,id)
        and amnd_state = 'A'
    ;
    v_obj_row_new := v_obj_row_old;

    v_obj_row_old.amnd_state:='I';
    v_obj_row_old.id:=null;
    insert into commission_template values v_obj_row_old;


    v_obj_row_new.amnd_date:=sysdate;
    v_obj_row_new.amnd_user:=user;
    v_obj_row_new.template_type := nvl(p_template_type,v_obj_row_new.template_type);
    v_obj_row_new.CLASS := nvl(p_CLASS,v_obj_row_new.CLASS);
    v_obj_row_new.FLIGHT_AC := nvl(p_FLIGHT_AC,v_obj_row_new.FLIGHT_AC);
    v_obj_row_new.FLIGHT_NOT_AC := nvl(p_FLIGHT_NOT_AC,v_obj_row_new.FLIGHT_NOT_AC);
    v_obj_row_new.FLIGHT_MC := nvl(p_FLIGHT_MC,v_obj_row_new.FLIGHT_MC);
    v_obj_row_new.FLIGHT_OC := nvl(p_FLIGHT_OC,v_obj_row_new.FLIGHT_OC);
    v_obj_row_new.FLIGHT_SEGMENT := nvl(p_FLIGHT_SEGMENT,v_obj_row_new.FLIGHT_SEGMENT);
    v_obj_row_new.COUNTRY_FROM := nvl(p_COUNTRY_FROM,v_obj_row_new.COUNTRY_FROM);
    v_obj_row_new.COUNTRY_TO := nvl(p_COUNTRY_TO,v_obj_row_new.COUNTRY_TO);
    v_obj_row_new.COUNTRY_INSIDE := nvl(p_COUNTRY_INSIDE,v_obj_row_new.COUNTRY_INSIDE);
    v_obj_row_new.COUNTRY_OUTSIDE := nvl(p_COUNTRY_OUTSIDE,v_obj_row_new.COUNTRY_OUTSIDE);
    v_obj_row_new.TARIFF := nvl(p_TARIFF,v_obj_row_new.TARIFF);
    v_obj_row_new.priority := nvl(p_priority,v_obj_row_new.priority);


    update commission_template set row = v_obj_row_new where id = v_obj_row_new.id;
  exception 
    when NO_DATA_FOUND then
/*      NTG.LOG_API.LOG_ADD(p_proc_name=>'item_avia_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=update,p_table=item_avia,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into item_avia error. '||SQLERRM);*/
      raise;
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_template_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=commission_template,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into commission_template error. '||SQLERRM);
  end commission_template_edit;



  function commission_template_get_info(p_id in ntg.dtype.t_id default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from ord.commission_template 
        where id = nvl(p_id,id)
        and amnd_state = 'A'
        order by id;
    return v_results;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_template_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=commission_template,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into commission_template error. '||SQLERRM);
    return null;
  end;


  function commission_template_get_info_r ( p_id in ntg.dtype.t_id default null)
  return commission_template%rowtype
  is
    c_obj  SYS_REFCURSOR;
    r_obj commission_template%rowtype;
  begin
    c_obj := ord_api.commission_template_get_info(p_id);
    --DBMS_OUTPUT.put_line (1);
    LOOP
      FETCH c_obj INTO r_obj;
      EXIT WHEN c_obj%NOTFOUND;
      --DBMS_OUTPUT.put_line (r_account.name);
    END LOOP;
    CLOSE c_obj;
    return r_obj;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_template_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=commission_template,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into commission_template error. '||SQLERRM);
    return null;
  end commission_template_get_info_r;



  function commission_details_add( p_commission in ntg.dtype.t_id default null,
                                    p_commission_template in ntg.dtype.t_id default null,
                                    p_value in  ntg.dtype.t_name default null
                                  )
  return ntg.dtype.t_id
  is
    v_obj_row commission_details%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_obj_row.commission_oid:=  p_commission;
    v_obj_row.commission_template_oid:=  p_commission_template;
    v_obj_row.value:=  p_value;


    insert into ord.commission_details values v_obj_row returning id into v_id;
--    commit;
    return v_id;
  exception when others then
--    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_details_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=commission_details,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into commission_details error. '||SQLERRM);
    return null;
  end;



  procedure commission_details_edit( P_ID  in ntg.dtype.t_id default null,
                                    p_commission in ntg.dtype.t_id default null,
                                    p_commission_template in ntg.dtype.t_id default null,
                                    p_value in  ntg.dtype.t_name default null)
  is
  --  v_mess ntg.dtype.t_msg;
    v_obj_row_new commission_details%rowtype;
    v_obj_row_old commission_details%rowtype;
--    v_id 
  begin

    select * into v_obj_row_old from commission_details 
        where id = nvl(p_id,id)
        and amnd_state = 'A'
    ;
    v_obj_row_new := v_obj_row_old;

    v_obj_row_old.amnd_state:='I';
    v_obj_row_old.id:=null;
    insert into commission_details values v_obj_row_old;


    v_obj_row_new.amnd_date:=sysdate;
    v_obj_row_new.amnd_user:=user;
    v_obj_row_new.commission_oid := nvl(p_commission,v_obj_row_new.commission_oid);
    v_obj_row_new.commission_template_oid := nvl(p_commission_template,v_obj_row_new.commission_template_oid);
    v_obj_row_new.value := nvl(p_value,v_obj_row_new.value);

    update commission_details set row = v_obj_row_new where id = v_obj_row_new.id;
  exception 
    when NO_DATA_FOUND then
/*      NTG.LOG_API.LOG_ADD(p_proc_name=>'item_avia_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=update,p_table=item_avia,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into item_avia error. '||SQLERRM);*/
      raise;
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_details_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=commission_details,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into commission_details error. '||SQLERRM);
  end commission_details_edit;



  function commission_details_get_info( p_id in ntg.dtype.t_id default null, p_commission in ntg.dtype.t_id default null )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from ord.commission_details 
        where id = nvl(p_id,id)
        and commission_oid = nvl(p_commission,commission_oid)
        and amnd_state = 'A'
        order by id;
    return v_results;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_details_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=commission_details,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into commission_details error. '||SQLERRM);
    return null;
  end;


  function commission_details_get_info_r ( p_id in ntg.dtype.t_id default null, p_commission in ntg.dtype.t_id default null)
  return commission_details%rowtype
  is
    c_obj  SYS_REFCURSOR;
    r_obj commission_details%rowtype;
  begin
    c_obj := ord_api.commission_details_get_info(p_id,p_commission);
    --DBMS_OUTPUT.put_line (1);
    LOOP
      FETCH c_obj INTO r_obj;
      EXIT WHEN c_obj%NOTFOUND;
      --DBMS_OUTPUT.put_line (r_account.name);
    END LOOP;
    CLOSE c_obj;
    return r_obj;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_details_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=commission_details,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into commission_details error. '||SQLERRM);
    return null;
  end commission_details_get_info_r;


  function commission_template_get_id( p_type in ntg.dtype.t_name default null)
  return  ntg.dtype.t_id
  is
    v_result  ntg.dtype.t_id;
  begin
--      OPEN v_results FOR
        SELECT id into v_result        
        from ord.commission_template 
        where template_type = nvl(p_type,template_type)
        and amnd_state = 'A'
        order by id;
    return v_result;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_template_get_id', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=commission_template,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into commission_template error. '||SQLERRM);
    return null;
  end;


  function v_json_r ( p_item_avia in ntg.dtype.t_id default null)
  return v_json%rowtype
  is
--    c_obj  SYS_REFCURSOR;
    r_obj v_json%rowtype;
  begin
    select * into r_obj from ord.v_json where id = p_item_avia;

    return r_obj;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'v_json_r', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=v_json,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into v_json error. '||SQLERRM);
    return null;
  end v_json_r;

  function bill_add( p_order in ntg.dtype.t_id default null,
                    p_amount in ntg.dtype.t_amount default null,
                    p_date in  ntg.dtype.t_date default null,
                    p_status in  ntg.dtype.t_status default null,
                    p_contract in  ntg.dtype.t_id default null
                    
                  )
  return ntg.dtype.t_id
  is
    v_obj_row bill%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_obj_row.order_oid:=  p_order;
    v_obj_row.amount:=  p_amount;
    v_obj_row.bill_date:=  p_date;
    v_obj_row.status:=  p_status;
    v_obj_row.contract_oid:=  p_contract;

    insert into ord.bill values v_obj_row returning id into v_id;
--    commit;
    return v_id;
  exception when others then
--    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'bill_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=bill,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into bill error. '||SQLERRM);
    return null;
  end;


  procedure bill_edit(  P_ID  in ntg.dtype.t_id default null,
                        p_order in ntg.dtype.t_id default null,
                        p_amount in ntg.dtype.t_amount default null,
                        p_date in  ntg.dtype.t_date default null,
                        p_status in  ntg.dtype.t_status default null,
                        p_contract in  ntg.dtype.t_id default null
                      )
  is
  --  v_mess ntg.dtype.t_msg;
    v_obj_row_new bill%rowtype;
    v_obj_row_old bill%rowtype;
--    v_id 
  begin

    select * into v_obj_row_old from bill 
        where id = nvl(p_id,id)
        and amnd_state = 'A'
    ;
    v_obj_row_new := v_obj_row_old;

    v_obj_row_old.amnd_state:='I';
    v_obj_row_old.id:=null;
    insert into bill values v_obj_row_old;


    v_obj_row_new.amnd_date:=sysdate;
    v_obj_row_new.amnd_user:=user;
    v_obj_row_new.status := nvl(p_status,v_obj_row_new.status);

    update bill set row = v_obj_row_new where id = v_obj_row_new.id;
  exception 
    when NO_DATA_FOUND then
/*      NTG.LOG_API.LOG_ADD(p_proc_name=>'item_avia_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=update,p_table=item_avia,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into item_avia error. '||SQLERRM);*/
      raise;
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'bill_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=bill,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into bill error. '||SQLERRM);
  end;


  function bill_get_info( p_id in ntg.dtype.t_id default null, 
                          p_order in ntg.dtype.t_id default null,
                          p_date in  ntg.dtype.t_date default null,
                          p_status in  ntg.dtype.t_status default null,
                          p_contract in  ntg.dtype.t_id default null
                          )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from ord.bill 
        where id = nvl(p_id,id)
        and order_oid = nvl(p_order,order_oid)
        and status = nvl(p_status,status)
        and contract_oid = nvl(p_contract,contract_oid)
        and amnd_state = 'A'
        order by id;
    return v_results;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'bill_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=bill,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into bill error. '||SQLERRM);
    return null;
  end;


  function bill_get_info_r (p_id in ntg.dtype.t_id default null, 
                          p_order in ntg.dtype.t_id default null,
                          p_date in  ntg.dtype.t_date default null,
                          p_status in  ntg.dtype.t_status default null,
                          p_contract in  ntg.dtype.t_id default null
                          )
  return bill%rowtype
  is
    c_obj  SYS_REFCURSOR;
    r_obj bill%rowtype;
  begin
    c_obj := ord_api.bill_get_info(p_id,p_order,p_date,p_status,p_contract);
    --DBMS_OUTPUT.put_line (1);
    LOOP
      FETCH c_obj INTO r_obj;
      EXIT WHEN c_obj%NOTFOUND;
      --DBMS_OUTPUT.put_line (r_account.name);
    END LOOP;
    CLOSE c_obj;
    return r_obj;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'bill_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=bill,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into bill error. '||SQLERRM);
    return null;
  end;

  function item_avia_status_add( 
                    p_item_avia in ntg.dtype.t_id default null,
                    p_po_status in ntg.dtype.t_status default null,
                    p_nqt_status_cur in  ntg.dtype.t_status default null
                  )
  return ntg.dtype.t_id
  is
    v_obj_row item_avia_status%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_obj_row.item_avia_oid:=  p_item_avia;
    v_obj_row.po_status:=  p_po_status;
    v_obj_row.nqt_status_cur:=  p_nqt_status_cur;

    insert into ord.item_avia_status values v_obj_row returning id into v_id;
--    commit;
    return v_id;
  exception when others then
--    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'item_avia_status_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=item_avia_status,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into item_avia_status error. '||SQLERRM);
    return null;
  end;


  procedure item_avia_status_edit(  P_ID  in ntg.dtype.t_id default null,
                                    p_item_avia in ntg.dtype.t_id default null,
                                    p_po_status in ntg.dtype.t_status default null,
                                    p_nqt_status_cur in  ntg.dtype.t_status default null
                      )
  is
  --  v_mess ntg.dtype.t_msg;
    v_obj_row_new item_avia_status%rowtype;
    v_obj_row_old item_avia_status%rowtype;
--    v_id 
  begin

    select * into v_obj_row_old from item_avia_status 
        where id = nvl(p_id,id)
        and item_avia_oid = nvl(p_item_avia,item_avia_oid)
        and amnd_state = 'A'
    ;
    v_obj_row_new := v_obj_row_old;

    v_obj_row_old.amnd_state:='I';
    v_obj_row_old.id:=null;
    insert into item_avia_status values v_obj_row_old;


    v_obj_row_new.amnd_date:=sysdate;
    v_obj_row_new.amnd_user:=user;
    v_obj_row_new.po_status := nvl(p_po_status,v_obj_row_new.po_status);
    v_obj_row_new.nqt_status_cur := nvl(p_nqt_status_cur,v_obj_row_new.nqt_status_cur);

    update item_avia_status set row = v_obj_row_new where id = v_obj_row_new.id;
  exception 
    when NO_DATA_FOUND then
/*      NTG.LOG_API.LOG_ADD(p_proc_name=>'item_avia_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=update,p_table=item_avia,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into item_avia error. '||SQLERRM);*/
      raise;
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'item_avia_status_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=item_avia_status,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into item_avia_status error. '||SQLERRM);
  end;


  function item_avia_status_get_info(   P_ID  in ntg.dtype.t_id default null,
                                    p_item_avia in ntg.dtype.t_id default null
                          )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from ord.item_avia_status 
        where id = nvl(p_id,id)
        and item_avia_oid = nvl(p_item_avia,item_avia_oid)
        and amnd_state = 'A'
        order by id;
    return v_results;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'item_avia_status_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=item_avia_status,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into item_avia_status error. '||SQLERRM);
    return null;
  end;


  function item_avia_status_get_info_r (  P_ID  in ntg.dtype.t_id default null,
                                    p_item_avia in ntg.dtype.t_id default null
                          )
  return item_avia_status%rowtype
  is
    c_obj  SYS_REFCURSOR;
    r_obj item_avia_status%rowtype;
  begin
    c_obj := ord_api.item_avia_status_get_info(p_id,p_item_avia);
    --DBMS_OUTPUT.put_line (1);
    LOOP
      FETCH c_obj INTO r_obj;
      EXIT WHEN c_obj%NOTFOUND;
      --DBMS_OUTPUT.put_line (r_account.name);
    END LOOP;
    CLOSE c_obj;
    return r_obj;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'item_avia_status_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=item_avia_status,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into item_avia_status error. '||SQLERRM);
    return null;
  end;


END ORD_API;

/
