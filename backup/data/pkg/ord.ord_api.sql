
  CREATE OR REPLACE  PACKAGE ORD.ORD_API AS 

    
/*
$pkg: ORD.ORD_API
*/

/*
$obj_desc: ***_add insert row into table ***. could return id of new row.
$obj_desc: ***_edit update row into table ***. object have always one id. first, old data with amnd_state = [I]nactive
$obj_desc: inserted as row with link to new row(amnd_prev). new data just update object row, 
$obj_desc: amnd_date updates to sysdate and amnd_user to current user who called api.
$obj_desc: ***_get_info return data from table *** with format SYS_REFCURSOR.
$obj_desc: ***_get_info_r return one row from table *** with format ***%rowtype.
*/

  function ord_add( p_date  in hdbk.dtype.t_date default null, 
                    p_order_number  in hdbk.dtype.t_long_code default null, 
                    p_client in hdbk.dtype.t_id default null,
                    p_status in hdbk.dtype.t_status default null
                    )
  return hdbk.dtype.t_id;

  function item_avia_add(p_ORDER_OID in hdbk.dtype.t_id default null,
                          p_PNR_locator in hdbk.dtype.t_long_code default null,
                          p_TIME_LIMIT  in hdbk.dtype.t_date default null,
                          p_TOTAL_AMOUNT in hdbk.dtype.t_amount default null,
                          p_TOTAL_MARKUP in hdbk.dtype.t_amount default null,
                          p_PNR_OBJECT in hdbk.dtype.t_clob default null,
                          p_pnr_id in  hdbk.dtype.t_long_code default null,
                          p_nqt_status in hdbk.dtype.t_status default null, 
                          p_po_status in hdbk.dtype.t_status default null,
                          p_nqt_status_cur in hdbk.dtype.t_status default null 
                          )
  return hdbk.dtype.t_id;



  function ord_get_info(p_id in hdbk.dtype.t_id)
  return SYS_REFCURSOR;

  function ord_get_info_r (p_id in hdbk.dtype.t_id
                          )
  return ord%rowtype;

  function item_avia_get_info(p_id in hdbk.dtype.t_id default null,
                              p_pnr_id in hdbk.dtype.t_long_code default null,
                              p_order in hdbk.dtype.t_id default null
                              )
  return SYS_REFCURSOR;

  function item_avia_get_info_r ( p_id in hdbk.dtype.t_id default null,
                              p_pnr_id in hdbk.dtype.t_long_code default null,
                              p_order in hdbk.dtype.t_id default null
                              )
  return item_avia%rowtype;
  
  procedure item_avia_edit( P_ID  in hdbk.dtype.t_id default null,
                            p_ORDER_OID in hdbk.dtype.t_id default null,
                          p_PNR_locator in hdbk.dtype.t_long_code default null,
                          p_TIME_LIMIT  in hdbk.dtype.t_date default null,
                          p_TOTAL_AMOUNT in hdbk.dtype.t_amount default null,
                          p_TOTAL_MARKUP in hdbk.dtype.t_amount default null,
                          p_PNR_OBJECT in hdbk.dtype.t_clob default null,
                          p_pnr_id in hdbk.dtype.t_long_code default null,
                          p_nqt_status in hdbk.dtype.t_status default null, 
                          p_po_status in hdbk.dtype.t_status default null,
                          p_nqt_status_cur in hdbk.dtype.t_status default null);
                          
  function commission_add(p_airline in hdbk.dtype.t_id default null,
                          p_details in hdbk.dtype.t_name default null,
                          p_fix  in hdbk.dtype.t_amount default null,
                          p_percent in hdbk.dtype.t_amount default null,
                          P_DATE_FROM IN hdbk.dtype.T_DATE DEFAULT NULL,
                          P_DATE_TO IN hdbk.dtype.T_DATE DEFAULT NULL,
                          P_PRIORITY IN hdbk.dtype.t_id DEFAULT NULL,
                          P_contract_type IN hdbk.dtype.t_id DEFAULT NULL,
                          P_contract IN hdbk.dtype.t_id DEFAULT NULL,
                          P_min_absolut IN hdbk.dtype.t_amount DEFAULT NULL,
                          P_rule_type IN hdbk.dtype.t_id DEFAULT NULL,
                          P_markup_type IN hdbk.dtype.t_id DEFAULT NULL,
                          P_per_segment IN hdbk.dtype.t_status DEFAULT NULL,
                          p_currency in hdbk.dtype.t_id DEFAULT NULL,
                          P_per_fare IN hdbk.dtype.t_status DEFAULT NULL
                          )
  return hdbk.dtype.t_id;
  
    procedure commission_edit( P_ID  in hdbk.dtype.t_id default null,
                            p_airline in hdbk.dtype.t_id default null,
                          p_details in hdbk.dtype.t_name default null,
                          p_fix  in hdbk.dtype.t_amount default null,
                          p_percent in hdbk.dtype.t_amount default null,
                          P_DATE_FROM IN hdbk.dtype.T_DATE DEFAULT NULL,
                          P_DATE_TO IN hdbk.dtype.T_DATE DEFAULT NULL,
                          P_PRIORITY IN hdbk.dtype.t_id DEFAULT NULL,
                          P_contract_type IN hdbk.dtype.t_id DEFAULT NULL,
                          p_status in hdbk.dtype.t_status DEFAULT NULL,
                          P_contract IN hdbk.dtype.t_id DEFAULT NULL,
                          P_min_absolut IN hdbk.dtype.t_amount DEFAULT NULL,
                          P_rule_type IN hdbk.dtype.t_id DEFAULT NULL,
                          P_markup_type IN hdbk.dtype.t_id DEFAULT NULL,
                          P_per_segment IN hdbk.dtype.t_status DEFAULT NULL,
                          p_currency in hdbk.dtype.t_id DEFAULT NULL,
                          P_per_fare IN hdbk.dtype.t_status DEFAULT NULL);

  function commission_get_info(p_id in hdbk.dtype.t_id default null,
                              p_airline in hdbk.dtype.t_id default null
  )
  return SYS_REFCURSOR;


  function commission_get_info_r ( p_id in hdbk.dtype.t_id default null,
                              p_airline in hdbk.dtype.t_id default null
                            )
  return commission%rowtype;

  function commission_template_add( p_template_type in hdbk.dtype.t_long_code default null,
                                    p_CLASS in hdbk.dtype.t_code default null,
                                    p_FLIGHT_AC in hdbk.dtype.t_code default null,
                                    p_FLIGHT_NOT_AC in hdbk.dtype.t_code default null,
                                    p_FLIGHT_MC in hdbk.dtype.t_code default null,
                                    p_FLIGHT_OC in hdbk.dtype.t_code default null,
                                    p_FLIGHT_SEGMENT in hdbk.dtype.t_code default null,
                                    p_COUNTRY_FROM in hdbk.dtype.t_code default null,
                                    p_COUNTRY_TO in hdbk.dtype.t_code default null,
                                    p_COUNTRY_INSIDE in hdbk.dtype.t_code default null,
                                    p_COUNTRY_OUTSIDE in hdbk.dtype.t_code default null,
                                    p_TARIFF in hdbk.dtype.t_code default null,
                                    p_priority in hdbk.dtype.t_id default null
                                  )
  return hdbk.dtype.t_id;
  
  procedure commission_template_edit( P_ID  in hdbk.dtype.t_id default null,
                                    p_template_type in hdbk.dtype.t_long_code default null,
                                    p_CLASS in hdbk.dtype.t_code default null,
                                    p_FLIGHT_AC in hdbk.dtype.t_code default null,
                                    p_FLIGHT_NOT_AC in hdbk.dtype.t_code default null,
                                    p_FLIGHT_MC in hdbk.dtype.t_code default null,
                                    p_FLIGHT_OC in hdbk.dtype.t_code default null,
                                    p_FLIGHT_SEGMENT in hdbk.dtype.t_code default null,
                                    p_COUNTRY_FROM in hdbk.dtype.t_code default null,
                                    p_COUNTRY_TO in hdbk.dtype.t_code default null,
                                    p_COUNTRY_INSIDE in hdbk.dtype.t_code default null,
                                    p_COUNTRY_OUTSIDE in hdbk.dtype.t_code default null,
                                    p_TARIFF in hdbk.dtype.t_code default null,
                                    p_priority in hdbk.dtype.t_id default null);
                                    
  function commission_template_get_info(p_id in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR;


  function commission_template_get_info_r ( p_id in hdbk.dtype.t_id default null)
  return commission_template%rowtype;



  function commission_details_add( p_commission in hdbk.dtype.t_id default null,
                                    p_commission_template in hdbk.dtype.t_id default null,
                                    p_value in  hdbk.dtype.t_name default null
                                  )
  return hdbk.dtype.t_id;


  procedure commission_details_edit( P_ID  in hdbk.dtype.t_id default null,
                                    p_commission in hdbk.dtype.t_id default null,
                                    p_commission_template in hdbk.dtype.t_id default null,
                                    p_value in  hdbk.dtype.t_name default null,
                                    p_status in  hdbk.dtype.t_status default null);
                                

  function commission_details_get_info( p_id in hdbk.dtype.t_id default null, p_commission in hdbk.dtype.t_id default null )
  return SYS_REFCURSOR;

  function commission_details_get_info_r ( p_id in hdbk.dtype.t_id default null, p_commission in hdbk.dtype.t_id default null)
  return commission_details%rowtype;

  function commission_template_get_id( p_type in hdbk.dtype.t_long_code default null)
  return  hdbk.dtype.t_id;

/*  function v_json_r ( p_item_avia in hdbk.dtype.t_id default null)
  return v_json%rowtype;
*/

  function bill_add( p_order in hdbk.dtype.t_id default null,
                    p_amount in hdbk.dtype.t_amount default null,
                    p_date in  hdbk.dtype.t_date default null,
                    p_status in  hdbk.dtype.t_status default null,
                    p_contract in  hdbk.dtype.t_id default null
                    
                  )
  return hdbk.dtype.t_id;

  procedure bill_edit(  P_ID  in hdbk.dtype.t_id default null,
                        p_order in hdbk.dtype.t_id default null,
                        p_amount in hdbk.dtype.t_amount default null,
                        p_date in  hdbk.dtype.t_date default null,
                        p_status in  hdbk.dtype.t_status default null,
                        p_contract in  hdbk.dtype.t_id default null
                      );

  function bill_get_info( p_id in hdbk.dtype.t_id default null, 
                          p_order in hdbk.dtype.t_id default null,
                          p_date in  hdbk.dtype.t_date default null,
                          p_status in  hdbk.dtype.t_status default null,
                          p_contract in  hdbk.dtype.t_id default null
                          )
  return SYS_REFCURSOR;

  function bill_get_info_r (p_id in hdbk.dtype.t_id default null, 
                          p_order in hdbk.dtype.t_id default null,
                          p_date in  hdbk.dtype.t_date default null,
                          p_status in  hdbk.dtype.t_status default null,
                          p_contract in  hdbk.dtype.t_id default null
                          )
  return bill%rowtype;

  function item_avia_status_add( 
                    p_item_avia in hdbk.dtype.t_id default null,
                    p_po_status in hdbk.dtype.t_status default null,
                    p_nqt_status_cur in  hdbk.dtype.t_status default null
                  )
  return hdbk.dtype.t_id;

  procedure item_avia_status_edit(  P_ID  in hdbk.dtype.t_id default null,
                                    p_item_avia in hdbk.dtype.t_id default null,
                                    p_po_status in hdbk.dtype.t_status default null,
                                    p_nqt_status_cur in  hdbk.dtype.t_status default null
                      );

  function item_avia_status_get_info(   P_ID  in hdbk.dtype.t_id default null,
                                    p_item_avia in hdbk.dtype.t_id default null
                          )
  return SYS_REFCURSOR ;
  
  function item_avia_status_get_info_r (  P_ID  in hdbk.dtype.t_id default null,
                                    p_item_avia in hdbk.dtype.t_id default null
                          )
  return item_avia_status%rowtype;


  function ticket_add( 
                    p_item_avia in hdbk.dtype.t_id default null,
                    p_pnr_locator in hdbk.dtype.t_code default null,
                    p_ticket_number in  hdbk.dtype.t_long_code default null,
                    p_passenger_name in  hdbk.dtype.t_name default null,
                    p_passenger_type in  hdbk.dtype.t_code default null,
                    p_fare_amount in  hdbk.dtype.t_amount default null,
                    p_taxes_amount in  hdbk.dtype.t_amount default null,
                    p_service_fee_amount in  hdbk.dtype.t_amount default null,
                    p_partner_fee_amount in  hdbk.dtype.t_amount default null
                  )
  return hdbk.dtype.t_id;

  procedure ticket_edit(  P_ID  in hdbk.dtype.t_id default null,
                          p_item_avia in hdbk.dtype.t_id default null,
                          p_pnr_locator in hdbk.dtype.t_code default null,
                          p_ticket_number in  hdbk.dtype.t_long_code default null,
                          p_passenger_name in  hdbk.dtype.t_name default null,
                          p_passenger_type in  hdbk.dtype.t_code default null,
                          p_fare_amount in  hdbk.dtype.t_amount default null,
                          p_taxes_amount in  hdbk.dtype.t_amount default null,
                          p_service_fee_amount in  hdbk.dtype.t_amount default null,
                          p_partner_fee_amount in  hdbk.dtype.t_amount default null
                      );
                    
  function ticket_get_info(   P_ID  in hdbk.dtype.t_id default null,
                          p_item_avia in hdbk.dtype.t_id default null,
                          p_pnr_locator in hdbk.dtype.t_code default null,
                          p_ticket_number in  hdbk.dtype.t_long_code default null
                          )
  return SYS_REFCURSOR;

  function ticket_get_info_r (    P_ID  in hdbk.dtype.t_id default null,
                          p_ticket_number in  hdbk.dtype.t_long_code default null
                          )
  return ticket%rowtype;

  function pos_rule_add( 
                    p_contract in hdbk.dtype.t_id default null,
                    p_airline in hdbk.dtype.t_id default null,
                    p_booking_pos in hdbk.dtype.t_code default null,
                    p_ticketing_pos in hdbk.dtype.t_code default null,
                    p_stock in hdbk.dtype.t_code default null,
                    p_printer in hdbk.dtype.t_code default null
                  )
  return hdbk.dtype.t_id;

  procedure pos_rule_edit(  P_ID  in hdbk.dtype.t_id default null,
                              p_contract in hdbk.dtype.t_id default null,
                              p_airline in hdbk.dtype.t_id default null,
                              p_booking_pos in hdbk.dtype.t_code default null,
                              p_ticketing_pos in hdbk.dtype.t_code default null,
                              p_stock in hdbk.dtype.t_code default null,
                              p_printer in hdbk.dtype.t_code default null,
                              p_status in  hdbk.dtype.t_status default null
                      );

  function pos_rule_get_info(   P_ID  in hdbk.dtype.t_id default null,
                                  p_contract in hdbk.dtype.t_id default null,
                                  p_airline in hdbk.dtype.t_id default null
                          )
  return SYS_REFCURSOR;

  function pos_rule_get_info_r (    P_ID  in hdbk.dtype.t_id default null,
                                      p_contract in hdbk.dtype.t_id default null,
                                      p_airline in hdbk.dtype.t_id default null
                          )
  return pos_rule%rowtype;


  
END ORD_API;

/

  CREATE OR REPLACE  PACKAGE BODY ORD.ORD_API AS


  function ord_add( p_date  in hdbk.dtype.t_date, 
                    p_order_number  in hdbk.dtype.t_long_code, 
                    p_client in hdbk.dtype.t_id,
                    p_status in hdbk.dtype.t_status
                    )
  return hdbk.dtype.t_id
  is
    v_ord_row ord%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_ord_row.order_date:=p_date;
    v_ord_row.order_number:=p_order_number;
    v_ord_row.client_oid:=p_client;
    v_ord_row.status:=p_status;
    insert into ord.ord values v_ord_row returning id into v_id;
    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'ord_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=insert,p_table=ord,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into ord error. '||SQLERRM);
    return null;
  end;


  function item_avia_add(p_ORDER_OID in hdbk.dtype.t_id default null,
                          p_PNR_locator in hdbk.dtype.t_long_code default null,
                          p_TIME_LIMIT  in hdbk.dtype.t_date default null,
                          p_TOTAL_AMOUNT in hdbk.dtype.t_amount default null,
                          p_TOTAL_MARKUP in hdbk.dtype.t_amount default null,
                          p_PNR_OBJECT in hdbk.dtype.t_clob  default null,
                          p_pnr_id in hdbk.dtype.t_long_code default null,
                          p_nqt_status in hdbk.dtype.t_status default null, 
                          p_po_status in hdbk.dtype.t_status default null,
                          p_nqt_status_cur in hdbk.dtype.t_status default null
                          )
  return hdbk.dtype.t_id
  is
    v_item_avia_row item_avia%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_item_avia_row.ORDER_OID:=  p_ORDER_OID;
    v_item_avia_row.PNR_locator:=  p_PNR_locator;
    v_item_avia_row.TIME_LIMIT:=  p_TIME_LIMIT;
    v_item_avia_row.TOTAL_AMOUNT:=  p_TOTAL_AMOUNT;
    v_item_avia_row.TOTAL_MARKUP:=  p_TOTAL_MARKUP;
    v_item_avia_row.PNR_OBJECT:=  p_PNR_OBJECT;
    v_item_avia_row.pnr_id:=  p_pnr_id;
    v_item_avia_row.nqt_status:=  p_nqt_status;
    v_item_avia_row.po_status:=  p_po_status;
    v_item_avia_row.nqt_status_cur:=  p_nqt_status_cur;
    insert into ord.item_avia values v_item_avia_row returning id into v_id;
    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'item_avia_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=insert,p_table=item_avia,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into item_avia error. '||SQLERRM);
    return null;
  end;

  function ord_get_info(p_id in hdbk.dtype.t_id)
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'ord_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=ord,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into ord error. '||SQLERRM);
  end;


  function ord_get_info_r (p_id in hdbk.dtype.t_id
                          )
  return ord%rowtype
  is
    c_obj  SYS_REFCURSOR;
    r_obj ord%rowtype;
  begin
    if p_id is null then raise NO_DATA_FOUND; end if;
    SELECT
    * into r_obj
    from ord.ord where id = p_id
    order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then raise;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'ord_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=ord,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into ord error. '||SQLERRM);
  end;





  function item_avia_get_info(p_id in hdbk.dtype.t_id default null,
                              p_pnr_id in hdbk.dtype.t_long_code default null,
                              p_order in hdbk.dtype.t_id default null
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
        and pnr_id = nvl(p_pnr_id,pnr_id)
        and order_oid = nvl(p_order,order_oid)
        and amnd_state = 'A'
        order by id;
    return v_results;
  exception 
    when NO_DATA_FOUND then raise;
    when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'item_avia_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=select,p_table=item_avia,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into item_avia error. '||SQLERRM);
  end;

  function item_avia_get_info_r ( p_id in hdbk.dtype.t_id default null,
                              p_pnr_id in hdbk.dtype.t_long_code default null,
                              p_order in hdbk.dtype.t_id default null
                              
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
    and pnr_id = nvl(p_pnr_id,pnr_id)
    and order_oid = nvl(p_order,order_oid)
    and amnd_state != 'I'
    order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'item_avia_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=select,p_table=item_avia,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into item_avia error. '||SQLERRM);
  end item_avia_get_info_r;

  procedure item_avia_edit( P_ID  in hdbk.dtype.t_id default null,
                            p_ORDER_OID in hdbk.dtype.t_id default null,
                          p_PNR_locator in hdbk.dtype.t_long_code default null,
                          p_TIME_LIMIT  in hdbk.dtype.t_date default null,
                          p_TOTAL_AMOUNT in hdbk.dtype.t_amount default null,
                          p_TOTAL_MARKUP in hdbk.dtype.t_amount default null,
                          p_PNR_OBJECT in hdbk.dtype.t_clob default null,
                          p_pnr_id in hdbk.dtype.t_long_code default null,
                          p_nqt_status in hdbk.dtype.t_status default null, 
                          p_po_status in hdbk.dtype.t_status default null,
                          p_nqt_status_cur in hdbk.dtype.t_status default null
                          )
  is
    v_obj_row_new item_avia%rowtype;
    v_obj_row_old item_avia%rowtype;
  begin

    if p_id is null and p_pnr_id is null then raise NO_DATA_FOUND; end if;
    
    select * into v_obj_row_old from item_avia 
        where id = nvl(p_id,id)
        and pnr_id = nvl(p_pnr_id,pnr_id)
        and amnd_state = 'A'
    ;
    v_obj_row_new := v_obj_row_old;

    v_obj_row_old.amnd_state:='I';
    v_obj_row_old.id:=null;
    insert into item_avia values v_obj_row_old;


    v_obj_row_new.amnd_date:=sysdate;
    v_obj_row_new.amnd_user:=user;
    v_obj_row_new.PNR_locator := nvl(p_PNR_locator,v_obj_row_new.PNR_locator);
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
    when NO_DATA_FOUND then raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then raise NO_DATA_FOUND;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'item_avia_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=update,p_table=item_avia,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into item_avia error. '||SQLERRM);
  end item_avia_edit;


  function commission_add(p_airline in hdbk.dtype.t_id default null,
                          p_details in hdbk.dtype.t_name default null,
                          p_fix  in hdbk.dtype.t_amount default null,
                          p_percent in hdbk.dtype.t_amount default null,
                          P_DATE_FROM IN hdbk.dtype.T_DATE DEFAULT NULL,
                          P_DATE_TO IN hdbk.dtype.T_DATE DEFAULT NULL,
                          P_PRIORITY IN hdbk.dtype.t_id DEFAULT NULL,
                          P_contract_type IN hdbk.dtype.t_id DEFAULT NULL,
                          P_contract IN hdbk.dtype.t_id DEFAULT NULL,
                          P_min_absolut IN hdbk.dtype.t_amount DEFAULT NULL,
                          P_rule_type IN hdbk.dtype.t_id DEFAULT NULL,
                          P_markup_type IN hdbk.dtype.t_id DEFAULT NULL,
                          P_per_segment IN hdbk.dtype.t_status DEFAULT NULL,
                          p_currency in hdbk.dtype.t_id DEFAULT NULL,
                          P_per_fare IN hdbk.dtype.t_status DEFAULT NULL
                          )
  return hdbk.dtype.t_id
  is
    v_obj_row commission%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_obj_row.airline:=  p_airline;
    v_obj_row.details:=  p_details;
    v_obj_row.fix:=  p_fix;
    v_obj_row.percent:=  p_percent;
    v_obj_row.DATE_FROM:=  P_DATE_FROM;
    v_obj_row.DATE_TO:=  P_DATE_TO;
    v_obj_row.PRIORITY:=  P_PRIORITY;
    v_obj_row.contract_type:=  P_contract_type;
    v_obj_row.contract_oid:=  P_contract;
    v_obj_row.min_absolut:=  P_min_absolut;
    v_obj_row.rule_type:=  P_rule_type;
    v_obj_row.markup_type:=  P_markup_type;
    v_obj_row.per_segment:=  P_per_segment;
    v_obj_row.currency:=  p_currency;
    v_obj_row.per_fare:=  P_per_fare;

    insert into ord.commission values v_obj_row returning id into v_id;
    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'commission_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=commission,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into commission error. '||SQLERRM);
  end;



  procedure commission_edit( P_ID  in hdbk.dtype.t_id default null,
                            p_airline in hdbk.dtype.t_id default null,
                            p_details in hdbk.dtype.t_name default null,
                            p_fix  in hdbk.dtype.t_amount default null,
                            p_percent in hdbk.dtype.t_amount default null,
                            P_DATE_FROM IN hdbk.dtype.T_DATE DEFAULT NULL,
                            P_DATE_TO IN hdbk.dtype.T_DATE DEFAULT NULL,
                            P_PRIORITY IN hdbk.dtype.t_id DEFAULT NULL,
                            P_contract_type IN hdbk.dtype.t_id DEFAULT NULL,
                            p_status in hdbk.dtype.t_status DEFAULT NULL,
                            P_contract IN hdbk.dtype.t_id DEFAULT NULL,
                            P_min_absolut IN hdbk.dtype.t_amount DEFAULT NULL,
                            P_rule_type IN hdbk.dtype.t_id DEFAULT NULL,
                            P_markup_type IN hdbk.dtype.t_id DEFAULT NULL,
                            P_per_segment IN hdbk.dtype.t_status DEFAULT NULL,
                            p_currency in hdbk.dtype.t_id DEFAULT NULL,
                            P_per_fare IN hdbk.dtype.t_status DEFAULT NULL
                          )
  is
    v_obj_row_new commission%rowtype;
    v_obj_row_old commission%rowtype;
  begin

    if p_id is null then raise NO_DATA_FOUND; end if; 
    select * into v_obj_row_old from commission 
        where id = p_id
        and amnd_state = 'A';
        
    v_obj_row_new := v_obj_row_old;



    v_obj_row_new.amnd_date:=sysdate;
    v_obj_row_new.amnd_user:=user;
--    v_obj_row_new.airline := nvl(p_airline,v_obj_row_new.airline);
    v_obj_row_new.details := nvl(p_details,v_obj_row_new.details);
    v_obj_row_new.fix := nvl(p_fix,v_obj_row_new.fix);
    v_obj_row_new.percent := nvl(p_percent,v_obj_row_new.percent);
    v_obj_row_new.date_from := nvl(p_date_from,v_obj_row_new.date_from);
    v_obj_row_new.date_to := nvl(p_date_to,v_obj_row_new.date_to);
    v_obj_row_new.PRIORITY := nvl(P_PRIORITY,v_obj_row_new.PRIORITY);
    v_obj_row_new.contract_type := nvl(P_contract_type,v_obj_row_new.contract_type);
    if p_status in ('C','D') then  v_obj_row_new.amnd_state := 'C'; end if;
    v_obj_row_new.contract_oid := nvl(P_contract,v_obj_row_new.contract_oid);
    v_obj_row_new.min_absolut := nvl(P_min_absolut,v_obj_row_new.min_absolut);
    v_obj_row_new.rule_type := nvl(P_rule_type,v_obj_row_new.rule_type);
    v_obj_row_new.markup_type := nvl(P_markup_type,v_obj_row_new.markup_type);
    v_obj_row_new.per_segment := nvl(P_per_segment,v_obj_row_new.per_segment);
    v_obj_row_new.currency := nvl(p_currency,v_obj_row_new.currency);
    v_obj_row_new.per_fare := nvl(P_per_fare,v_obj_row_new.per_fare);


    if nvl(v_obj_row_new.details,'X') = nvl(v_obj_row_old.details,'X')
      and nvl(v_obj_row_new.fix,-1) = nvl(v_obj_row_old.fix,-1)
      and nvl(v_obj_row_new.percent,-1) = nvl(v_obj_row_old.percent,-1)
      and nvl(to_char(v_obj_row_new.date_from,'ddmmyyyy'),'X')  = nvl(to_char(v_obj_row_old.date_from,'ddmmyyyy'),'X')     
      and nvl(to_char(v_obj_row_new.date_to,'ddmmyyyy'),'X')  = nvl(to_char(v_obj_row_old.date_to,'ddmmyyyy'),'X') 
      and nvl(v_obj_row_new.PRIORITY,-1) = nvl(v_obj_row_old.PRIORITY,-1)
      and nvl(v_obj_row_new.contract_type,-1) = nvl(v_obj_row_old.contract_type,-1)
      and nvl(v_obj_row_new.contract_oid,-1) = nvl(v_obj_row_old.contract_oid,-1)
      and nvl(v_obj_row_new.min_absolut,-1) = nvl(v_obj_row_old.min_absolut,-1)
      and nvl(v_obj_row_new.rule_type,-1) = nvl(v_obj_row_old.rule_type,-1)
      and nvl(v_obj_row_new.markup_type,-1) = nvl(v_obj_row_old.markup_type,-1)
      and nvl(v_obj_row_new.per_segment,'X') = nvl(v_obj_row_old.per_segment,'X')
      and nvl(v_obj_row_new.currency,-1) = nvl(v_obj_row_old.currency,-1)
      and nvl(v_obj_row_new.per_fare,'X') = nvl(v_obj_row_old.per_fare,'X')
      and v_obj_row_new.amnd_state <> 'C'
      then return;
    end if;

    v_obj_row_old.amnd_state:='I';
    v_obj_row_old.id:=null;
    insert into commission values v_obj_row_old;

    update commission set row = v_obj_row_new where id = v_obj_row_new.id;
  exception 
    when NO_DATA_FOUND then
      raise;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'commission_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=commission,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into commission error. '||SQLERRM);
  end commission_edit;



  function commission_get_info(p_id in hdbk.dtype.t_id default null,
                              p_airline in hdbk.dtype.t_id default null
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'commission_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=commission,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into commission error. '||SQLERRM);
  end;


  function commission_get_info_r ( p_id in hdbk.dtype.t_id default null,
                              p_airline in hdbk.dtype.t_id default null
                            )
  return commission%rowtype
  is
    c_obj  SYS_REFCURSOR;
    r_obj commission%rowtype;
  begin
    if p_id is null and p_airline is null then raise NO_DATA_FOUND; end if;
    SELECT
    * into r_obj
    from ord.commission 
    where id = nvl(p_id,id)
    and airline = nvl(p_airline,airline)
    and amnd_state != 'I'
    order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;
    when others then
        hdbk.log_api.LOG_ADD(p_proc_name=>'commission_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
          P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=commission,p_date='
          || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
        RAISE_APPLICATION_ERROR(-20002,'select row into commission error. '||SQLERRM);
  end commission_get_info_r;



  function commission_template_add( p_template_type in hdbk.dtype.t_long_code default null,
                                    p_CLASS in hdbk.dtype.t_code default null,
                                    p_FLIGHT_AC in hdbk.dtype.t_code default null,
                                    p_FLIGHT_NOT_AC in hdbk.dtype.t_code default null,
                                    p_FLIGHT_MC in hdbk.dtype.t_code default null,
                                    p_FLIGHT_OC in hdbk.dtype.t_code default null,
                                    p_FLIGHT_SEGMENT in hdbk.dtype.t_code default null,
                                    p_COUNTRY_FROM in hdbk.dtype.t_code default null,
                                    p_COUNTRY_TO in hdbk.dtype.t_code default null,
                                    p_COUNTRY_INSIDE in hdbk.dtype.t_code default null,
                                    p_COUNTRY_OUTSIDE in hdbk.dtype.t_code default null,
                                    p_TARIFF in hdbk.dtype.t_code default null,
                                    p_priority in hdbk.dtype.t_id default null
                                  )
  return hdbk.dtype.t_id
  is
    v_obj_row commission_template%rowtype;
    v_id hdbk.dtype.t_id;
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
    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'commission_template_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=commission_template,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into commission_template error. '||SQLERRM);
  end;



  procedure commission_template_edit( P_ID  in hdbk.dtype.t_id default null,
                                    p_template_type in hdbk.dtype.t_long_code default null,
                                    p_CLASS in hdbk.dtype.t_code default null,
                                    p_FLIGHT_AC in hdbk.dtype.t_code default null,
                                    p_FLIGHT_NOT_AC in hdbk.dtype.t_code default null,
                                    p_FLIGHT_MC in hdbk.dtype.t_code default null,
                                    p_FLIGHT_OC in hdbk.dtype.t_code default null,
                                    p_FLIGHT_SEGMENT in hdbk.dtype.t_code default null,
                                    p_COUNTRY_FROM in hdbk.dtype.t_code default null,
                                    p_COUNTRY_TO in hdbk.dtype.t_code default null,
                                    p_COUNTRY_INSIDE in hdbk.dtype.t_code default null,
                                    p_COUNTRY_OUTSIDE in hdbk.dtype.t_code default null,
                                    p_TARIFF in hdbk.dtype.t_code default null,
                                    p_priority in hdbk.dtype.t_id default null)
  is
    v_obj_row_new commission_template%rowtype;
    v_obj_row_old commission_template%rowtype;
  begin
    if p_id is null then raise NO_DATA_FOUND; end if;

    select * into v_obj_row_old from commission_template 
        where id = p_id
        and amnd_state = 'A';
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
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'commission_template_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=commission_template,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into commission_template error. '||SQLERRM);
  end commission_template_edit;



  function commission_template_get_info(p_id in hdbk.dtype.t_id default null)
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'commission_template_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=commission_template,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into commission_template error. '||SQLERRM);
  end;


  function commission_template_get_info_r ( p_id in hdbk.dtype.t_id default null)
  return commission_template%rowtype
  is
    c_obj  SYS_REFCURSOR;
    r_obj commission_template%rowtype;
  begin
    if p_id is null then raise NO_DATA_FOUND; end if; 
    
    SELECT
    * into r_obj
    from ord.commission_template 
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
      hdbk.log_api.LOG_ADD(p_proc_name=>'commission_template_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=commission_template,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into commission_template error. '||SQLERRM);
  end commission_template_get_info_r;



  function commission_details_add( p_commission in hdbk.dtype.t_id default null,
                                    p_commission_template in hdbk.dtype.t_id default null,
                                    p_value in  hdbk.dtype.t_name default null
                                  )
  return hdbk.dtype.t_id
  is
    v_obj_row commission_details%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_obj_row.commission_oid:=  p_commission;
    v_obj_row.commission_template_oid:=  p_commission_template;
    v_obj_row.value:=  p_value;

    insert into ord.commission_details values v_obj_row returning id into v_id;
    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'commission_details_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=commission_details,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into commission_details error. '||SQLERRM);
  end;



  procedure commission_details_edit( P_ID  in hdbk.dtype.t_id default null,
                                    p_commission in hdbk.dtype.t_id default null,
                                    p_commission_template in hdbk.dtype.t_id default null,
                                    p_value in  hdbk.dtype.t_name default null,
                                    p_status in  hdbk.dtype.t_status default null)
  is
    v_obj_row_new commission_details%rowtype;
    v_obj_row_old commission_details%rowtype;
  begin
    if p_id is null then raise NO_DATA_FOUND; end if; 
  
    select * into v_obj_row_old from commission_details 
        where id = nvl(p_id,id)
        and amnd_state = 'A'
    ;
    v_obj_row_new := v_obj_row_old;


    v_obj_row_new.amnd_date:=sysdate;
    v_obj_row_new.amnd_user:=user;
    v_obj_row_new.commission_oid := nvl(p_commission,v_obj_row_new.commission_oid);
    v_obj_row_new.commission_template_oid := nvl(p_commission_template,v_obj_row_new.commission_template_oid);
    v_obj_row_new.value := nvl(p_value,v_obj_row_new.value);
    if p_status in ('C','D') then  v_obj_row_new.amnd_state:='C'; end if;

    if nvl(v_obj_row_new.value,'_X_') = nvl(v_obj_row_old.value,'_X_')  --there could be value X
      and nvl(v_obj_row_new.commission_oid,-1) = nvl(v_obj_row_old.commission_oid,-1)
      and nvl(v_obj_row_new.commission_template_oid,-1) = nvl(v_obj_row_old.commission_template_oid,-1)
      and v_obj_row_new.amnd_state <> 'C'
      then return;
    end if;

    v_obj_row_old.amnd_state:='I';
    v_obj_row_old.id:=null;
    insert into commission_details values v_obj_row_old;

    update commission_details set row = v_obj_row_new where id = v_obj_row_new.id;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;  
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'commission_details_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=commission_details,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into commission_details error. '||SQLERRM);
  end commission_details_edit;



  function commission_details_get_info( p_id in hdbk.dtype.t_id default null, p_commission in hdbk.dtype.t_id default null )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
    if p_id is null and p_commission is null then raise NO_DATA_FOUND; end if; 
    
    OPEN v_results FOR
      SELECT
      *
      from ord.commission_details 
      where id = nvl(p_id,id)
      and commission_oid = nvl(p_commission,commission_oid)
      and amnd_state = 'A'
      order by id;
    return v_results;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;    
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'commission_details_get_info', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=commission_details,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into commission_details error. '||SQLERRM);
  end;


  function commission_details_get_info_r ( p_id in hdbk.dtype.t_id default null, p_commission in hdbk.dtype.t_id default null)
  return commission_details%rowtype
  is
    c_obj  SYS_REFCURSOR;
    r_obj commission_details%rowtype;
  begin
    if p_id is null and p_commission is null then raise NO_DATA_FOUND; end if; 
    
    SELECT
    * into r_obj
    from ord.commission_details 
    where id = nvl(p_id,id)
    and commission_oid = nvl(p_commission,commission_oid)
    and amnd_state != 'I'
    order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;    
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'commission_details_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=commission_details,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into commission_details error. '||SQLERRM);
  end commission_details_get_info_r;


  function commission_template_get_id( p_type in hdbk.dtype.t_long_code default null)
  return  hdbk.dtype.t_id
  is
    v_result  hdbk.dtype.t_id;
  begin
    if p_type is null then raise NO_DATA_FOUND; end if;   

    SELECT id into v_result        
    from ord.commission_template 
    where template_type = nvl(p_type,template_type)
    and amnd_state != 'I'
    order by id;
    return v_result;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'commission_template_get_id', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=commission_template,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into commission_template error. '||SQLERRM);
  end;


  function v_json_r ( p_item_avia in hdbk.dtype.t_id default null)
  return v_json%rowtype
  is
    r_obj v_json%rowtype;
  begin
    if p_item_avia is null then raise NO_DATA_FOUND; end if; 
    select * into r_obj from ord.v_json where id = p_item_avia;

    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;       
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'v_json_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=v_json,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into v_json error. '||SQLERRM);
  end v_json_r;

  function bill_add( p_order in hdbk.dtype.t_id default null,
                    p_amount in hdbk.dtype.t_amount default null,
                    p_date in  hdbk.dtype.t_date default null,
                    p_status in  hdbk.dtype.t_status default null,
                    p_contract in  hdbk.dtype.t_id default null
                    
                  )
  return hdbk.dtype.t_id
  is
    v_obj_row bill%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_obj_row.order_oid:=  p_order;
    v_obj_row.amount:=  p_amount;
    v_obj_row.bill_date:=  nvl(p_date,sysdate);
    v_obj_row.status:=  nvl(p_status,'A');
    v_obj_row.contract_oid:=  p_contract;

    insert into ord.bill values v_obj_row returning id into v_id;
    return v_id;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;     
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'bill_add', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=bill,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'insert row into bill error. '||SQLERRM);
  end;


  procedure bill_edit(  P_ID  in hdbk.dtype.t_id default null,
                        p_order in hdbk.dtype.t_id default null,
                        p_amount in hdbk.dtype.t_amount default null,
                        p_date in  hdbk.dtype.t_date default null,
                        p_status in  hdbk.dtype.t_status default null,
                        p_contract in  hdbk.dtype.t_id default null
                      )
  is
    v_obj_row_new bill%rowtype;
    v_obj_row_old bill%rowtype;
  begin
    if p_id is null then raise NO_DATA_FOUND; end if; 
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
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'bill_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=bill,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into bill error. '||SQLERRM);
  end;


  function bill_get_info( p_id in hdbk.dtype.t_id default null, 
                          p_order in hdbk.dtype.t_id default null,
                          p_date in  hdbk.dtype.t_date default null,
                          p_status in  hdbk.dtype.t_status default null,
                          p_contract in  hdbk.dtype.t_id default null
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'bill_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=bill,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into bill error. '||SQLERRM);
  end;


  function bill_get_info_r (p_id in hdbk.dtype.t_id default null, 
                          p_order in hdbk.dtype.t_id default null,
                          p_date in  hdbk.dtype.t_date default null,
                          p_status in  hdbk.dtype.t_status default null,
                          p_contract in  hdbk.dtype.t_id default null
                          )
  return bill%rowtype
  is
    c_obj  SYS_REFCURSOR;
    r_obj bill%rowtype;
  begin
    SELECT
    * into r_obj
    from ord.bill 
    where id = nvl(p_id,id)
    and status = nvl(p_status,status)
    and amnd_state != 'I'
    order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'bill_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=bill,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into bill error. '||SQLERRM);
  end;

  function item_avia_status_add( 
                    p_item_avia in hdbk.dtype.t_id default null,
                    p_po_status in hdbk.dtype.t_status default null,
                    p_nqt_status_cur in  hdbk.dtype.t_status default null
                  )
  return hdbk.dtype.t_id
  is
    v_obj_row item_avia_status%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_obj_row.item_avia_oid:=  p_item_avia;
    v_obj_row.po_status:=  p_po_status;
    v_obj_row.nqt_status_cur:=  p_nqt_status_cur;

    insert into ord.item_avia_status values v_obj_row returning id into v_id;
    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'item_avia_status_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=item_avia_status,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into item_avia_status error. '||SQLERRM);
  end;


  procedure item_avia_status_edit(  P_ID  in hdbk.dtype.t_id default null,
                                    p_item_avia in hdbk.dtype.t_id default null,
                                    p_po_status in hdbk.dtype.t_status default null,
                                    p_nqt_status_cur in  hdbk.dtype.t_status default null
                      )
  is
    v_obj_row_new item_avia_status%rowtype;
    v_obj_row_old item_avia_status%rowtype;
  begin
    if p_id is null and p_item_avia is null then raise NO_DATA_FOUND; end if;   
  
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
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'item_avia_status_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=item_avia_status,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into item_avia_status error. '||SQLERRM);
  end;


  function item_avia_status_get_info(   P_ID  in hdbk.dtype.t_id default null,
                                    p_item_avia in hdbk.dtype.t_id default null
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'item_avia_status_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=item_avia_status,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into item_avia_status error. '||SQLERRM);
  end;


  function item_avia_status_get_info_r (  P_ID  in hdbk.dtype.t_id default null,
                                    p_item_avia in hdbk.dtype.t_id default null
                          )
  return item_avia_status%rowtype
  is
    r_obj item_avia_status%rowtype;
  begin
    if p_id is null and p_item_avia is null then raise NO_DATA_FOUND; end if;   
    
    SELECT
    * into r_obj
    from ord.item_avia_status 
    where id = nvl(p_id,id)
    and item_avia_oid = nvl(p_item_avia,item_avia_oid)
    and amnd_state != 'I'
    order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;  
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'item_avia_status_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=item_avia_status,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into item_avia_status error. '||SQLERRM);
  end;


  function ticket_add( 
                    p_item_avia in hdbk.dtype.t_id default null,
                    p_pnr_locator in hdbk.dtype.t_code default null,
                    p_ticket_number in  hdbk.dtype.t_long_code default null,
                    p_passenger_name in  hdbk.dtype.t_name default null,
                    p_passenger_type in  hdbk.dtype.t_code default null,
                    p_fare_amount in  hdbk.dtype.t_amount default null,
                    p_taxes_amount in  hdbk.dtype.t_amount default null,
                    p_service_fee_amount in  hdbk.dtype.t_amount default null,
                    p_partner_fee_amount in  hdbk.dtype.t_amount default null
                    
                  )
  return hdbk.dtype.t_id
  is
    v_obj_row ticket%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_obj_row.item_avia_oid:=  p_item_avia;
    v_obj_row.pnr_locator:=  p_pnr_locator;
    v_obj_row.ticket_number:=  p_ticket_number;
    v_obj_row.passenger_name:=  p_passenger_name;
    v_obj_row.passenger_type:=  p_passenger_type;
    v_obj_row.fare_amount:=  p_fare_amount;
    v_obj_row.taxes_amount:=  p_taxes_amount;
    v_obj_row.service_fee_amount:=  p_service_fee_amount;
    v_obj_row.partner_fee_amount:=  p_partner_fee_amount;

    insert into ord.ticket values v_obj_row returning id into v_id;
    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'ticket_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=ticket,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into ticket error. '||SQLERRM);
  end;


  procedure ticket_edit(  P_ID  in hdbk.dtype.t_id default null,
                          p_item_avia in hdbk.dtype.t_id default null,
                          p_pnr_locator in hdbk.dtype.t_code default null,
                          p_ticket_number in  hdbk.dtype.t_long_code default null,
                          p_passenger_name in  hdbk.dtype.t_name default null,
                          p_passenger_type in  hdbk.dtype.t_code default null,
                          p_fare_amount in  hdbk.dtype.t_amount default null,
                          p_taxes_amount in  hdbk.dtype.t_amount default null,
                          p_service_fee_amount in  hdbk.dtype.t_amount default null,
                          p_partner_fee_amount in  hdbk.dtype.t_amount default null
                      )
  is
    v_obj_row_new ticket%rowtype;
    v_obj_row_old ticket%rowtype;
  begin
    if p_id is null and p_ticket_number is null then raise NO_DATA_FOUND; end if;   
  
    select * into v_obj_row_old from ticket 
        where id = nvl(p_id,id)
        and ticket_number = nvl(p_ticket_number,ticket_number)
        and amnd_state = 'A'
    ;
    v_obj_row_new := v_obj_row_old;

    v_obj_row_old.amnd_state:='I';
    v_obj_row_old.id:=null;


    v_obj_row_new.amnd_date:=sysdate;
    v_obj_row_new.amnd_user:=user;
    v_obj_row_new.pnr_locator := nvl(p_pnr_locator,v_obj_row_new.pnr_locator);
    v_obj_row_new.passenger_name := nvl(p_passenger_name,v_obj_row_new.passenger_name);
    v_obj_row_new.passenger_type := nvl(p_passenger_type,v_obj_row_new.passenger_type);
    v_obj_row_new.fare_amount := nvl(p_fare_amount,v_obj_row_new.fare_amount);
    v_obj_row_new.taxes_amount := nvl(p_taxes_amount,v_obj_row_new.taxes_amount);
    v_obj_row_new.service_fee_amount := nvl(p_service_fee_amount,v_obj_row_new.service_fee_amount);
    v_obj_row_new.partner_fee_amount := nvl(p_partner_fee_amount,v_obj_row_new.partner_fee_amount);

    if nvl(v_obj_row_new.pnr_locator,'X') = nvl(v_obj_row_old.pnr_locator,'X')
      and nvl(v_obj_row_new.passenger_name,'X') = nvl(v_obj_row_old.passenger_name,'X')
      and nvl(v_obj_row_new.passenger_type,'X') = nvl(v_obj_row_old.passenger_type,'X')
      and nvl(v_obj_row_new.fare_amount,-1) = nvl(v_obj_row_old.fare_amount,-1)
      and nvl(v_obj_row_new.taxes_amount,-1) = nvl(v_obj_row_old.taxes_amount,-1)
      and nvl(v_obj_row_new.service_fee_amount,-1) = nvl(v_obj_row_old.service_fee_amount,-1)
      and nvl(v_obj_row_new.partner_fee_amount,-1) = nvl(v_obj_row_old.partner_fee_amount,-1)
      then return;
    end if;

    insert into ticket values v_obj_row_old;
    update ticket set row = v_obj_row_new where id = v_obj_row_new.id;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'ticket_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=ticket,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into ticket error. '||SQLERRM);
  end;


  function ticket_get_info(   P_ID  in hdbk.dtype.t_id default null,
                          p_item_avia in hdbk.dtype.t_id default null,
                          p_pnr_locator in hdbk.dtype.t_code default null,
                          p_ticket_number in  hdbk.dtype.t_long_code default null
                          )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from ord.ticket 
        where id = nvl(p_id,id)
        and item_avia_oid = nvl(p_item_avia,item_avia_oid)
        and pnr_locator = nvl(p_pnr_locator,pnr_locator)
        and ticket_number = nvl(p_ticket_number,ticket_number)
        and amnd_state = 'A'
        order by id;
    return v_results;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'ticket_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=ticket,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into ticket error. '||SQLERRM);
  end;


  function ticket_get_info_r (    P_ID  in hdbk.dtype.t_id default null,
                          p_ticket_number in  hdbk.dtype.t_long_code default null
                          )
  return ticket%rowtype
  is
    r_obj ticket%rowtype;
  begin
    if p_id is null and p_ticket_number is null then raise NO_DATA_FOUND; end if;   
    
    SELECT
    * into r_obj
    from ord.ticket 
    where id = nvl(p_id,id)
    and ticket_number = nvl(p_ticket_number,ticket_number)
    and amnd_state != 'I'
    order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;  
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'ticket_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=ticket,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into ticket error. '||SQLERRM);
  end;



  function pos_rule_add( 
                    p_contract in hdbk.dtype.t_id default null,
                    p_airline in hdbk.dtype.t_id default null,
                    p_booking_pos in hdbk.dtype.t_code default null,
                    p_ticketing_pos in hdbk.dtype.t_code default null,
                    p_stock in hdbk.dtype.t_code default null,
                    p_printer in hdbk.dtype.t_code default null
                  )
  return hdbk.dtype.t_id
  is
    v_obj_row pos_rule%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_obj_row.contract_oid:=  p_contract;
    v_obj_row.airline_oid:=  p_airline;
    v_obj_row.booking_pos:=  p_booking_pos;
    v_obj_row.ticketing_pos:=  p_ticketing_pos;
    v_obj_row.stock:=  p_stock;
    v_obj_row.printer:=  p_printer;

    insert into ord.pos_rule values v_obj_row returning id into v_id;
    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'pos_rule_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=pos_rule,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into pos_rule error. '||SQLERRM);
  end;


  procedure pos_rule_edit(  P_ID  in hdbk.dtype.t_id default null,
                              p_contract in hdbk.dtype.t_id default null,
                              p_airline in hdbk.dtype.t_id default null,
                              p_booking_pos in hdbk.dtype.t_code default null,
                              p_ticketing_pos in hdbk.dtype.t_code default null,
                              p_stock in hdbk.dtype.t_code default null,
                              p_printer in hdbk.dtype.t_code default null,
                              p_status in  hdbk.dtype.t_status default null
                      )
  is
    v_obj_row_new pos_rule%rowtype;
    v_obj_row_old pos_rule%rowtype;
  begin
    if p_id is null and p_contract is null and p_airline is null then raise NO_DATA_FOUND; end if;   
  
    select * into v_obj_row_old from pos_rule 
        where id = nvl(p_id,id)
        and contract_oid = nvl(p_contract,contract_oid)
        and airline_oid = nvl(p_airline,airline_oid)
        and amnd_state = 'A'
    ;
    v_obj_row_new := v_obj_row_old;



    v_obj_row_new.amnd_date:=sysdate;
    v_obj_row_new.amnd_user:=user;
    v_obj_row_new.contract_oid := nvl(p_contract,v_obj_row_new.contract_oid);
    v_obj_row_new.airline_oid := nvl(p_airline,v_obj_row_new.airline_oid);
    v_obj_row_new.booking_pos := nvl(p_booking_pos,v_obj_row_new.booking_pos);
    v_obj_row_new.ticketing_pos := nvl(p_ticketing_pos,v_obj_row_new.ticketing_pos);
    v_obj_row_new.stock := nvl(p_stock,v_obj_row_new.stock);
    v_obj_row_new.printer := nvl(p_printer,v_obj_row_new.printer);
    if p_status in ('C','D') then  v_obj_row_new.amnd_state := 'C'; end if;

    if nvl(v_obj_row_new.contract_oid,-1) = nvl(v_obj_row_old.contract_oid,-1)
      and nvl(v_obj_row_new.airline_oid,-1) = nvl(v_obj_row_old.airline_oid,-1)
      and nvl(v_obj_row_new.booking_pos,'X') = nvl(v_obj_row_old.booking_pos,'X')
      and nvl(v_obj_row_new.ticketing_pos,'X') = nvl(v_obj_row_old.ticketing_pos,'X')
      and nvl(v_obj_row_new.stock,'X') = nvl(v_obj_row_old.stock,'X')
      and nvl(v_obj_row_new.printer,'X') = nvl(v_obj_row_old.printer,'X')
      and v_obj_row_new.amnd_state <> 'C'
      then return;
    end if;

    v_obj_row_old.amnd_state:='I';
    v_obj_row_old.id:=null;
    insert into pos_rule values v_obj_row_old;

    update pos_rule set row = v_obj_row_new where id = v_obj_row_new.id;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'pos_rule_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=pos_rule,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into pos_rule error. '||SQLERRM);
  end;


  function pos_rule_get_info(   P_ID  in hdbk.dtype.t_id default null,
                                  p_contract in hdbk.dtype.t_id default null,
                                  p_airline in hdbk.dtype.t_id default null
                          )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from ord.pos_rule 
        where id = nvl(p_id,id)
        and contract_oid = nvl(p_contract,contract_oid)
        and airline_oid = nvl(p_airline,airline_oid)
        and amnd_state = 'A'
        order by id;
    return v_results;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'pos_rule_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=pos_rule,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into pos_rule error. '||SQLERRM);
  end;


  function pos_rule_get_info_r (    P_ID  in hdbk.dtype.t_id default null,
                                      p_contract in hdbk.dtype.t_id default null,
                                      p_airline in hdbk.dtype.t_id default null
                          )
  return pos_rule%rowtype
  is
    r_obj pos_rule%rowtype;
  begin
    if p_id is null and p_contract is null and p_airline is null then raise NO_DATA_FOUND; end if;   
    
    SELECT
    * into r_obj
    from ord.pos_rule 
    where id = nvl(p_id,id)
    and contract_oid = nvl(p_contract,contract_oid)
    and airline_oid = nvl(p_airline,airline_oid)
    and amnd_state != 'I'
    order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;  
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'pos_rule_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=pos_rule,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into pos_rule error. '||SQLERRM);
  end;


END ORD_API;

/