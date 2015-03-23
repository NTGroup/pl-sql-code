
/
CREATE OR REPLACE PACKAGE "ORD"."FWDR" AS 


/*

pkg: ord.fwdr

*/


/*

$obj_type: function
$obj_name: order_create
$obj_desc: fake function. used in avia_register for creating emty order
$obj_param: p_date: date for wich we need create order
$obj_param: p_order_number: number could set or generate inside
$obj_param: p_status: status like 'W' waiting or smth else 
$obj_return: id of created order

*/
  function order_create(p_date  in ntg.dtype.t_date default null, 
                    p_order_number  in ntg.dtype.t_long_code default null, 
                    p_client in ntg.dtype.t_id default null,
                    p_status in ntg.dtype.t_status default null
                    )
  return ntg.dtype.t_id;

/*

$obj_type: function
$obj_name: item_add
$obj_desc: fake function.
$obj_return: id of created item

*/

  function item_add(p_order_oid in ntg.dtype.t_id default null,
                          p_pnr_locator in ntg.dtype.t_long_code default null,
                          p_time_limit  in ntg.dtype.t_date default null,
                          p_total_amount in ntg.dtype.t_amount default null,
                          p_total_markup in ntg.dtype.t_amount default null,
                          p_pnr_object in ntg.dtype.t_clob default null,
                          p_pnr_id in ntg.dtype.t_long_code default null
                          )
  return ntg.dtype.t_id;

/*

$obj_type: procedure
$obj_name: avia_update
$obj_desc: procedure update item_avia row searched by pnr_id.
$obj_param: p_pnr_id: id from NQT. search perform by this id
$obj_param: p_pnr_locator: record locator just for info
$obj_param: p_time_limit: time limit just for info
$obj_param: p_total_amount: total amount including markup
$obj_param: p_total_markup: just total markup
$obj_param: p_pnr_object: json for backup
$obj_param: p_nqt_status: current NQT process
$obj_param: p_tenant_id: id of contract in text format, for authorization

*/

  procedure avia_update(  p_pnr_id in ntg.dtype.t_long_code default null,
                          p_pnr_locator in ntg.dtype.t_long_code default null,
                          p_time_limit  in ntg.dtype.t_date default null,
                          p_total_amount in ntg.dtype.t_amount default null,
                          p_total_markup in ntg.dtype.t_amount default null,
                          p_pnr_object in ntg.dtype.t_clob default null,
                          p_nqt_status in  ntg.dtype.t_long_code default null,
                          p_tenant_id  in  ntg.dtype.t_long_code default null
                          );

/*

$obj_type: procedure
$obj_name: avia_reg_ticket
$obj_desc: procedure get ticket info by pnr_id.
$obj_desc: its create row for ticket. later this info will send to managers
$obj_param: p_pnr_id: id from NQT. search perform by this id
$obj_param: p_tenant_id: id of contract in text format, for authorization
$obj_param: p_ticket: json[p_number,p_name,p_fare_amount,p_tax_amount,p_markup_amount,p_type]

*/
  procedure avia_reg_ticket(  p_pnr_id in ntg.dtype.t_long_code default null,
                            p_tenant_id  in  ntg.dtype.t_long_code default null,
                            p_ticket in ntg.dtype.t_clob default null
                          );

/*

$obj_type: procedure
$obj_name: avia_pay
$obj_desc: procedure send all bills in status [M]arked to [W]aiting in billing for pay.
$obj_param: p_user_id: user identifire. at this moment email
$obj_param: p_pnr_id: id from NQT. search perform by this id

*/
  procedure avia_pay( p_user_id in ntg.dtype.t_long_code default null,
                      p_pnr_id in ntg.dtype.t_long_code default null);

/*

$obj_type: function
$obj_name: order_get
$obj_desc: fake

*/
  function order_get(p_id in ntg.dtype.t_id)
  return SYS_REFCURSOR;

/*

$obj_type: function
$obj_name: item_list
$obj_desc: fake

*/
  function item_get(p_id in ntg.dtype.t_id)
  return SYS_REFCURSOR;

/*

$obj_type: function
$obj_name: item_list
$obj_desc: fake

*/
  function item_list(p_order in ntg.dtype.t_id)
  return SYS_REFCURSOR;
  


/*

$obj_type: function
$obj_name: pnr_list
$obj_desc: get pnr list whith statuses listed in p_nqt_status_list and with paging by p_rownum count.
$obj_param: p_nqt_status_list: json[status]
$obj_param: p_rownum: filter for rows count
$obj_return: sys_refcursor[pnr_id, nqt_status, po_status, nqt_status_cur, null po_msg, 'avia' item_type, pnr_locator, tenant_id]

*/
  function pnr_list(p_nqt_status_list in ntg.dtype.t_clob, p_rownum in ntg.dtype.t_id default null)
  return SYS_REFCURSOR;

/*

$obj_type: function
$obj_name: pnr_list
$obj_desc: get pnr list whith id listed in p_pnr_list.
$obj_param: p_pnr_list: json[p_pnr_id,p_tenant_id], where
$obj_param: p_pnr_id: id from NQT. search perform by this id
$obj_param: p_tenant_id: id of contract in text format, for authorization
$obj_return: sys_refcursor[pnr_id, nqt_status, po_status, nqt_status_cur, null po_msg, 'avia' item_type, pnr_locator,tenant_id]

*/
 
  function pnr_list(p_pnr_list in ntg.dtype.t_clob)
  return SYS_REFCURSOR;

/*

$obj_type: procedure
$obj_name: commission_get
$obj_desc: calculate commission for pnr_id
$obj_param: p_pnr_id: id from NQT. search perform by this id
$obj_param: p_tenant_id: id of contract in text format, for authorization
$obj_param: o_fix: in this paraveter returned fix commission value
$obj_param: o_percent: in this paraveter returned percent commission value

*/
  procedure commission_get( p_pnr_id in ntg.dtype.t_long_code,
                            p_tenant_id in ntg.dtype.t_long_code, 
                            o_fix out  ntg.dtype.t_amount, 
                            o_percent out  ntg.dtype.t_amount
                          );

/*

$obj_type: function
$obj_name: order_number_generate
$obj_desc: generate order number as last number + 1 by client id
$obj_param: p_client: client id.
$obj_return: string like 0012410032, where 1241 - client id and 32 is a counter of order

*/

  function order_number_generate (p_client in ntg.dtype.t_id)
  return ntg.dtype.t_long_code;

/*

$obj_type: procedure
$obj_name: avia_manual
$obj_desc: update order status to p_result[ERROR/SUCCESS] or to INPROGRESS, if ERROR then return all money.
$obj_param: p_pnr_id: id from NQT. search perform by this id
$obj_param: p_tenant_id: id of contract in text format, for authorization
$obj_param: p_result: [ERROR/SUCCESS/ if null then INPROGRESS] 

*/
  procedure avia_manual( p_pnr_id in ntg.dtype.t_long_code default null, 
                          p_tenant_id in ntg.dtype.t_long_code default null, 
                          p_result in ntg.dtype.t_long_code default null);
  

/*
$obj_type: procedure
$obj_name: cash_back
$obj_desc: perform reverse for order scheme. return bill to Waiting status
$obj_desc: and call revoke_document from billing
$obj_param: p_pnr_id: id from NQT. search perform by this id
*/
  procedure cash_back(p_pnr_id in ntg.dtype.t_long_code);

/*
$obj_type: function
$obj_name: get_sales_list
$obj_desc: fake
*/    
  function get_sales_list(p_datetime_from in ntg.dtype.t_long_code default null,p_datetime_to in ntg.dtype.t_long_code default null)
  return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: commission_view
$obj_desc: return all rules by iata code of airline
$obj_param: p_iata: iata 2 char code
$obj_return: SYS_REFCURSOR[fields from v_rule view]
*/
  function commission_view(p_iata in ntg.dtype.t_code default null)
  return SYS_REFCURSOR;



/*

$obj_type: procedure
$obj_name: avia_create
$obj_desc: procedure create item_avia row only. it cant update item 
$obj_param: p_pnr_id: id from NQT. search perform by this id
$obj_param: p_user_id: user identifire. at this moment email

*/

  procedure avia_create(  p_pnr_id in ntg.dtype.t_long_code default null,
                          p_user_id  in  ntg.dtype.t_long_code default null
                          );


/*

$obj_type: procedure
$obj_name: avia_booked
$obj_desc: procedure send item/order/bill to billing for pay.
$obj_param: p_pnr_id: id from NQT. search perform by this id
$obj_param: p_user_id: user identifire. at this moment email

*/
  procedure avia_booked(
                      p_pnr_id in ntg.dtype.t_long_code default null,
                       p_user_id in ntg.dtype.t_long_code default null);



/*
$obj_type: function
$obj_name: pos_rule_get
$obj_desc: when p_version is null then return all active rows. if not null then  
$obj_desc: get all active and deleted rows that changed after p_version id
$obj_param: p_version: id
$obj_return: SYS_REFCURSOR[ID, TENANT_ID, VALIDATING_CARRIER,booking_pos,ticketing_pos,stock,printer,VERSION, IS_ACTIVE]
$obj_return: default tenant_id = 0, default validating_carrier = 'YY'
*/  
  function pos_rule_get(p_version in ntg.dtype.t_id default null)
  return SYS_REFCURSOR;


/*
$obj_type: function
$obj_name: pos_rule_edit
$obj_desc: update pos_rules or create new pos_rules. if success return true else false.
$obj_desc: if status equals [C]lose or [D]elete then delete pos_rule.
$obj_param: p_data: data for update. format json[id, tenant_id, validating_carrier, 
$obj_param: p_data: booking_pos, ticketing_pos, stock, printer, status]
$obj_return: SYS_REFCURSOR[res:true/false]
*/
  function pos_rule_edit(p_data in ntg.dtype.t_clob)
  return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: commission_edit
$obj_desc: update commission rules or create new commission rules. if success return true else false.
$obj_desc: if status equals [C]lose or [D]elete then delete commission rule.
$obj_param: p_data: data for update. format json[AIRLINE_ID, CONTRACT_ID, RULE_ID, 
$obj_param: p_data: RULE_DESCRIPTION, RULE_LIFE_FROM, RULE_LIFE_TO, RULE_AMOUNT, 
$obj_param: p_data: RULE_AMOUNT_MEASURE, RULE_PRIORITY, CONDITION_ID,condition_status, TEMPLATE_TYPE_ID, 
$obj_param: p_data: TEMPLATE_NAME_NLS, TEMPLATE_VALUE]
$obj_return: SYS_REFCURSOR[res:true/false]
*/

  function commission_edit(p_data in ntg.dtype.t_clob)
  return SYS_REFCURSOR;
  

/*
$obj_type: function
$obj_name: commission_template_list
$obj_desc: p_is_contract_type: if 'Y' then return all contract_types else all template_types
$obj_param: p_data: data for update. format json[AIRLINE_ID, CONTRACT_ID, RULE_ID, 
$obj_return: SYS_REFCURSOR[ID, TEMPLATE_TYPE, PRIORITY, DETAILS, IS_CONTRACT_TYPE, NAME, NLS_NAME, IS_VALUE]
*/  
  function commission_template_list(p_is_contract_type in ntg.dtype.t_status default null)
  return SYS_REFCURSOR;



END FWDR;

/

  CREATE OR REPLACE PACKAGE BODY "ORD"."FWDR" AS

  function order_create(p_date  in ntg.dtype.t_date default null, 
                        p_order_number  in ntg.dtype.t_long_code default null, 
                        p_client in ntg.dtype.t_id default null,
                        p_status in ntg.dtype.t_status default null
  )
  return ntg.dtype.t_id
  is
    v_ord_row ord%rowtype;
    v_id ntg.dtype.t_id;
  begin
    
    v_id:=ord_api.ord_add(p_date => sysdate,
                          p_order_number => fwdr.order_number_generate(p_client),
                          p_client => p_client,
                          p_status => 'A'
    );
    return v_id;
  exception when others then
    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'order_create', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=ord,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into ord error. '||SQLERRM);
    return null;
  end;

  function item_add(p_order_oid in ntg.dtype.t_id default null,
                          p_pnr_locator in ntg.dtype.t_long_code default null,
                          p_time_limit  in ntg.dtype.t_date default null,
                          p_total_amount in ntg.dtype.t_amount default null,
                          p_total_markup in ntg.dtype.t_amount default null,
                          p_pnr_object in ntg.dtype.t_clob default null,
                          p_pnr_id in ntg.dtype.t_long_code default null
                          )
  return ntg.dtype.t_id
  is
    v_ord_row ord%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_id:=ord_api.item_avia_add(  p_order_oid,
                                  p_pnr_locator,
                                  p_time_limit,
                                  p_total_amount,
                                  p_total_markup,
                                  p_pnr_object,
                                  p_pnr_id);
    return v_id;
  exception when others then
    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'item_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=item_avia,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into item_avia error. '||SQLERRM);
    return null;
  end;

  procedure avia_register( p_pnr_id in ntg.dtype.t_long_code default null,
                          p_pnr_locator in ntg.dtype.t_long_code default null,
                          p_time_limit  in ntg.dtype.t_date default null,
                          p_total_amount in ntg.dtype.t_amount default null,
                          p_total_markup in ntg.dtype.t_amount default null,
                          p_pnr_object in ntg.dtype.t_clob default null,
                          p_nqt_status in  ntg.dtype.t_long_code default null,
                          p_client in ntg.dtype.t_id default null,
                          p_tenant_id  in  ntg.dtype.t_long_code default null
                          )
  is
    v_id ntg.dtype.t_id;
    v_order ntg.dtype.t_id;
    v_avia ntg.dtype.t_id;
    v_bill ntg.dtype.t_id;
    v_client ntg.dtype.t_id;
    v_contract ntg.dtype.t_id;
    r_item_avia item_avia%rowtype;
  begin
    
    if p_tenant_id is null then
      raise VALUE_ERROR;
    end if;
    
    v_client := blng.fwdr.company_insteadof_client(to_number(p_tenant_id));
    if v_client is null then
      raise VALUE_ERROR;
    end if;
    
    r_item_avia := ord_api.item_avia_get_info_r(p_pnr_id => p_pnr_id);
        
    if r_item_avia.id is not null then
    -- po_status not nulled when register calls
      ORD_API.item_avia_edit ( 
        P_PNR_locator => P_PNR_locator,
        P_TIME_LIMIT => P_TIME_LIMIT,
        P_TOTAL_AMOUNT => P_TOTAL_AMOUNT,
        P_TOTAL_MARKUP => P_TOTAL_MARKUP,
        P_PNR_OBJECT => P_PNR_OBJECT,
        P_pnr_id => P_pnr_id,
        p_nqt_status => p_nqt_status,
        p_po_status => null
        ) ;  
    else
        v_order := fwdr.order_create(p_client=> v_client);
        
        v_avia := ORD_API.item_avia_add(P_ORDER_OID => v_ORDER,
          P_PNR_locator => P_PNR_locator,
          P_TIME_LIMIT => P_TIME_LIMIT,
          P_TOTAL_AMOUNT => P_TOTAL_AMOUNT,
          P_TOTAL_MARKUP => P_TOTAL_MARKUP,
          P_PNR_OBJECT => P_PNR_OBJECT,
          P_pnr_id => P_pnr_id,
          p_nqt_status => p_nqt_status,
          p_po_status => null
          );        


        v_contract := blng.core.pay_contract_by_client(v_client);
        v_bill := ORD_API.bill_add( P_ORDER => v_order,
                                    P_AMOUNT => P_TOTAL_AMOUNT,
                                    P_DATE => sysdate,
                                    P_STATUS => 'M', --managing
                                    P_CONTRACT => v_contract);

    end if;
    
      commit;          
  exception 
    when VALUE_ERROR then
      rollback;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_register', p_msg_type=>'VALUE_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=item_avia,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'avia_register error. put wrong value. '||SQLERRM);
    when others then    
      rollback;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_register', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=item_avia,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'avia_register error. '||SQLERRM);
  end;

  procedure avia_reg_ticket(  p_pnr_id in ntg.dtype.t_long_code default null,
                            p_tenant_id  in  ntg.dtype.t_long_code default null,
                            p_ticket in ntg.dtype.t_clob default null
                          )
  is
    v_id ntg.dtype.t_id;
    v_order ntg.dtype.t_id;
    v_avia ntg.dtype.t_id;
    v_bill ntg.dtype.t_id;
    v_client ntg.dtype.t_id;
    v_contract ntg.dtype.t_id;
    r_item_avia item_avia%rowtype;
    r_order ord%rowtype;
    r_ticket ticket%rowtype;
    r_client blng.client%rowtype;
    r_item_avia_status item_avia_status%rowtype;
    v_tenant_id ntg.dtype.t_id;
    v_ticket ntg.dtype.t_id;
  begin
    
    v_tenant_id := to_number(p_tenant_id);
  
    begin 
      if p_pnr_id is null then raise NO_DATA_FOUND; end if;
-- check that item with this pnr_id exists
      r_item_avia := ord_api.item_avia_get_info_r(p_pnr_id=>p_pnr_id);
    exception 
      when NO_DATA_FOUND then 
        NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_reg_ticket', p_msg_type=>'NO_DATA_FOUND',
          P_MSG => 'p_pnr_id does not exists',p_info => 'p_pnr_id='||p_pnr_id||',p_date='
          || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>1);
        RAISE_APPLICATION_ERROR(-20002,'avia_reg_ticket error. p_pnr_id does not found.');
    end;
    --    dbms_output.put_line(' p_id='||p_pnr_id);          

    begin 
-- check that cliemt with this user_id exist
      if v_tenant_id is null then raise NO_DATA_FOUND; end if;
      r_order := ord_api.ord_get_info_r(p_id=>r_item_avia.order_oid);
/* 
$TODO: there must be check for users with ISSUES permission
*/
      r_client := blng.blng_api.client_get_info_r(p_id=>r_order.client_oid);
        --dbms_output.put_line(' p_id='||r_client.id);   
--      r_company := blng.blng_api.company_get_info_r(p_id=>r_order.client_oid);
      if blng.core.pay_contract_by_client(r_client.id)!=v_tenant_id then raise NO_DATA_FOUND; end if;

    exception when NO_DATA_FOUND then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_reg_ticket', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => 'tenant_id not found',p_info => 'p_tenant_id='||v_tenant_id||',p_pnr_id='||p_pnr_id||',p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>1);
      RAISE_APPLICATION_ERROR(-20002,'avia_manual error. user_id not found. ');
    end;

      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_reg_ticket', p_msg_type=>'OK',
        P_MSG => p_ticket,
        p_info => 'p_pnr_id='||p_pnr_id||',p_tenant_id='||p_tenant_id||',p_table=ticket,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);

  

  for i in (
    select * from 
    json_table  
      ( p_ticket,'$[*]' 
      columns (p_number VARCHAR2(250) path '$.p_number',
              p_name VARCHAR2(250) path '$.p_name',
              p_type VARCHAR2(250) path '$.p_type',
              p_fare_amount number(20,2) path '$.p_fare_amount',
              p_tax_amount number(20,2) path '$.p_tax_amount',
              p_markup_amount number(20,2) path '$.p_markup_amount'
              )
      ) as j
  )
  loop
    begin
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_reg_ticket', p_msg_type=>'1',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,
        p_info => 'p_tenant_id='||v_tenant_id||',p_pnr_id='||p_pnr_id||',p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);


    
      r_ticket:= ord_api.ticket_get_info_r(
                            p_ticket_number       => i.p_number
                          );
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_reg_ticket', p_msg_type=>'2',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,
        p_info => 'p_tenant_id='||v_tenant_id||',p_pnr_id='||p_pnr_id||',p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);

      ord_api.ticket_edit( p_id => r_ticket.id,
                              --p_item_avia           => r_item_avia.id,
                              p_pnr_locator         => r_item_avia.pnr_locator,
                              p_ticket_number       => i.p_number,
                              p_passenger_name      => i.p_name,
                              p_passenger_type      => i.p_type,
                              p_fare_amount         => i.p_fare_amount,
                              p_taxes_amount        => i.p_tax_amount,
                              p_service_fee_amount  => i.p_markup_amount
                            );    
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_reg_ticket', p_msg_type=>'3',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,
        p_info => 'p_tenant_id='||v_tenant_id||',p_pnr_id='||p_pnr_id||',p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    exception when NO_DATA_FOUND then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_reg_ticket', p_msg_type=>'4',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,
        p_info => 'p_tenant_id='||v_tenant_id||',p_pnr_id='||p_pnr_id||',p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      v_ticket:=ord_api.ticket_add( p_item_avia           => r_item_avia.id,
                              p_pnr_locator         => r_item_avia.pnr_locator,
                              p_ticket_number       => i.p_number,
                              p_passenger_name      => i.p_name,
                              p_passenger_type      => i.p_type,
                              p_fare_amount         => i.p_fare_amount,
                              p_taxes_amount        => i.p_tax_amount,
                              p_service_fee_amount  => i.p_markup_amount
                            );
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_reg_ticket', p_msg_type=>'5',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,
        p_info => 'p_tenant_id='||v_tenant_id||',p_pnr_id='||p_pnr_id||',p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    end;
    
  end loop;
  
  commit;    
  
  exception 
    when others then    
      rollback;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_reg_ticket', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,
        p_info => 'p_tenant_id='||v_tenant_id||',p_pnr_id='||p_pnr_id||',p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'avia_reg_ticket error. '||SQLERRM);
  end;





  function item_list(p_order in ntg.dtype.t_id)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        id, 'avia' item_type
        from ord.item_avia where order_oid = p_order
        order by id;
    return v_results;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'item_list', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=item_avia,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into item_avia error. '||SQLERRM);
    return null;
  end;


  function pnr_list(p_nqt_status_list in ntg.dtype.t_clob, p_rownum in ntg.dtype.t_id default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        ia.pnr_id, ia.nqt_status, ias.po_status, ias.nqt_status_cur, null po_msg, 'avia' item_type, ia.pnr_locator,
        (select contract_oid from ord.bill where order_oid = ia.order_oid and amnd_state = 'A') tenant_id
        from ord.item_avia ia, ord.item_avia_status ias,
        json_table  
          ( p_nqt_status_list,'$[*]' 
          columns (status VARCHAR2(250) path '$.status')
          ) as j
        where ia.nqt_status = upper(j.status) 
        and ia.amnd_state = 'A'
        and ias.amnd_state = 'A'
        and ia.id = ias.item_avia_oid
        and ROWNUM <= nvl(p_rownum,rownum)
        order by ia.time_limit asc; --, ia.id;
    return v_results;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'pnr_list', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=item_avia,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into item_avia error. '||SQLERRM);
    return null;    
  end;
  

  function pnr_list(p_pnr_list in ntg.dtype.t_clob)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        ia.pnr_id, ia.nqt_status, ias.po_status, ias.nqt_status_cur, 
        null po_msg, 'avia' item_type, ia.pnr_locator, j.p_tenant_id tenant_id
        from ord.item_avia ia, ord.item_avia_status ias, blng.client cl, ord.ord ord, blng.client2contract c2c,
        json_table  
          ( p_pnr_list,'$[*]' 
          columns (p_pnr_id VARCHAR2(250) path '$.p_pnr_id',
          p_tenant_id VARCHAR2(250) path '$.p_tenant_id')
          ) as j
        where ia.pnr_id = j.p_pnr_id
        and j.p_pnr_id is not null
        and j.p_tenant_id is not null
        and ia.amnd_state = 'A'
        and ias.amnd_state = 'A'
        and ia.id = ias.item_avia_oid
        and ord.amnd_state = 'A'
        and ord.id = ia.order_oid
        and cl.amnd_state = 'A'
        and cl.id = ord.client_oid
        and c2c.contract_oid = j.p_tenant_id
        and cl.id = c2c.client_oid
        and c2c.permission = 'B'
        order by ia.time_limit asc; 
    return v_results;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'pnr_list', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=item_avia,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into item_avia error. '||SQLERRM);
    return null;
  end;
    
  function item_get(p_id in ntg.dtype.t_id)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from ord.item_avia where id = p_id
        order by id;
    return v_results;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'item_list', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=item_avia,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into item_avia error. '||SQLERRM);
    return null;    
  end;

  function order_get(p_id in ntg.dtype.t_id)
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
    NTG.LOG_API.LOG_ADD(p_proc_name=>'order_get', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=ord,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into ord error. '||SQLERRM);
    return null;
  end;

  procedure commission_get(p_pnr_id in ntg.dtype.t_long_code, 
                            p_tenant_id in ntg.dtype.t_long_code, 
                            o_fix out  ntg.dtype.t_amount, 
                            o_percent out  ntg.dtype.t_amount)
  is
    v_iata varchar2(255); 
  --  v_out number := null;
    r_json v_json%rowtype;
    r_item_avia item_avia%rowtype;
    r_client blng.client%rowtype;
    r_order ord%rowtype;
--    f_chs_VCeqMC number;  
--    f_chs_MCneOC number;  
    f_VCeqMC ntg.dtype.t_id;  
    f_MCeqOC ntg.dtype.t_id;  
    f_rule ntg.dtype.t_id;  
    f_template_type ntg.dtype.t_id;  
    f_list ntg.dtype.t_id;  
    v_contract_type ntg.dtype.t_id;
    v_template_type varchar2(255);
    v_tenant_id ntg.dtype.t_id;
    v_airline ntg.dtype.t_id;
    v_id ntg.dtype.t_id;
    
  begin
--o_percent:=0.6;
--o_fix:= 2.3;
    v_tenant_id := to_number(p_tenant_id);

    begin 
      if p_pnr_id is null then raise NO_DATA_FOUND; end if;
      -- check that item with this pnr_id exists
      r_item_avia := ord_api.item_avia_get_info_r(p_pnr_id=>p_pnr_id);
    exception 
      when NO_DATA_FOUND then 
        NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_get', p_msg_type=>'NO_DATA_FOUND',
          P_MSG => 'p_pnr_id does not exists',p_info => 'p_pnr_id='||p_pnr_id||',p_date='
          || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>1);
        RAISE_APPLICATION_ERROR(-20002,'commission_get error. p_pnr_id does not found.');
    end;
--    dbms_output.put_line(' p_id='||p_pnr_id);          

    begin 
-- check that cliemt with this user_id exist
      if v_tenant_id is null then raise NO_DATA_FOUND; end if;
      r_order := ord_api.ord_get_info_r(p_id=>r_item_avia.order_oid);
/* 
$TODO: there must be check for users with ISSUES permission
*/
      r_client := blng.blng_api.client_get_info_r(p_id=>r_order.client_oid);
      
--      r_company := blng.blng_api.company_get_info_r(p_id=>r_order.client_oid);
      if blng.core.pay_contract_by_client(r_client.id)!=v_tenant_id then raise NO_DATA_FOUND; end if;

    exception when NO_DATA_FOUND then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_get', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => 'user_id not found',p_info => 'p_user_id='||v_tenant_id||',p_pnr_id='||p_pnr_id||',p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>1);
      RAISE_APPLICATION_ERROR(-20002,'commission_get error. user_id not found. ');
    end;


    NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_get', p_msg_type=>'STARTED',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=commission,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
        
    r_item_avia := ord_api.item_avia_get_info_r(p_pnr_id => p_pnr_id);
    if r_item_avia.id is null then
--      dbms_output.put_line(' p_id='||p_pnr_id);          
      --raise NO_DATA_FOUND;
      return;
    end if;
--    dbms_output.put_line('NN p_id='||r_item_avia.id);          
    v_id:= r_item_avia.id;
  
    select distinct al.id, al.iata  into v_airline, v_iata from ord.v_json j, ntg.airline al where j.id = v_id
    and al.AMND_STATE = 'A'
    and j.validatingcarrier = al.iata
    ;
--    dbms_output.put_line('1');          

-- 1. get contract_type (code-share/interline/self)
    f_VCeqMC := 1;
    f_MCeqOC := 1;
    begin
      for i_json in (select m_airline,o_airline from ord.v_json where id = v_id)
      loop
        if v_iata != i_json.m_airline then f_VCeqMC := 0; end if;
        if i_json.o_airline != i_json.m_airline then f_MCeqOC := 0; end if;
      end loop; --json
    exception when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_get', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=commission,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'commission_get error. json not found. '||SQLERRM);
      --      o_fix := null; o_percent:=5;
    end;
    if f_VCeqMC = 0 then
      v_contract_type := ord_api.commission_template_get_id('interline');
    elsif f_MCeqOC = 0 then
      v_contract_type := ord_api.commission_template_get_id('code-share');
    else 
      v_contract_type := ord_api.commission_template_get_id('self');
    end if;

--    dbms_output.put_line('2');

-- get list of rulles for airline
    for i_rule in ( 
      select distinct rule_oid id, fix, percent, priority,rule_description 
      from ord.v_rule 
      where contract_type_oid = v_contract_type and iata = v_iata
      and nvl(to_date(rule_life_from,'yyyy-mm-dd'),trunc(sysdate)) <= trunc(sysdate)
      and nvl(to_date(rule_life_to,'yyyy-mm-dd'),trunc(sysdate)) >= trunc(sysdate)
      order by priority desc
    )
    loop
-- several rules can be true. each of them we need to check and get minimum commission value.
-- its mean we have to check all rules.
      f_rule := 1; 
      for i_condition in (
        select template_type_code,template_value, template_type_oid from ord.v_rule where contract_type_oid = v_contract_type and iata = v_iata and rule_oid = i_rule.id
      )
      loop
        f_template_type := 0; 
        
-- template_type distribute rule by conditions. for examples geo type and class type.
-- each of conditions must be true inside rule.
-- thats why order of conditions is dosnt matter

-- for each conditions we make different logic. 
-- json is just iteration for each segment. some conditions must be true for each segment,
-- others only for one of them
        
        if i_condition.template_type_oid is null then
          f_template_type:=1;
          continue;
          --exit;
        end if;
        
        
        if i_condition.template_type_code = 'class' then
          for i_json in (select bookingcode from ord.v_json where id = v_id)
          loop
            if i_condition.template_value like '%'||i_json.bookingcode||'%' then
              f_template_type:=1;
              exit;
            end if;
          end loop; --json
        end if;

        if i_condition.template_type_code = 'airport_from_to' then
          for i_json in (select bookingcode from ord.v_json where id = v_id)
          loop
            null;  --example
            f_template_type := 1;
          end loop; 
        end if;        

        if f_template_type = 0 then 
          f_rule := 0;
          exit;
        end if;
        
      end loop; --i_condition
      
      if f_rule = 1 then
        if o_fix is null or o_fix > i_rule.fix then 
          o_fix := i_rule.fix; 
        end if;
        if o_percent is null or o_percent > i_rule.percent then 
          o_percent := i_rule.percent; 
        end if;
      end if;
    dbms_output.put_line(' p_id='||i_rule.rule_description||' v_iata='||v_iata||' o_fix='||o_fix||' o_percent='||o_percent);          
    end loop; --i_rule
--    dbms_output.put_line('3');          
 
    if o_fix is not null then o_percent := null; end if;
    --c_fix := to_char(o);
    dbms_output.put_line(' p_id='||v_id||' v_iata='||v_iata||' o_fix='||o_fix||' o_percent='||o_percent);        
  exception 
    WHEN NO_DATA_FOUND then 
      dbms_output.put_line(' p_id='||v_id||' v_iata='||v_iata||' o_fix='||o_fix||' o_percent='||o_percent);        
      NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_get', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM || ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=commission,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      return;
    when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_get', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM || ' '|| chr(13)||chr(10)|| ' '||sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=commission,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'commission_get error. '||SQLERRM);
    ---o_fix := null; o_percent:=5;
  end;

  function order_number_generate (p_client in ntg.dtype.t_id)
  return ntg.dtype.t_long_code
  is
    v_client_oid number;
    v_order_count number;
  begin
    select count(*) into v_order_count from ord.ord where client_oid = p_client and amnd_state <> 'I';
    return lpad(p_client,6,'0')||lpad(v_order_count+1,4,'0');
  end;

  procedure avia_manual( p_pnr_id in ntg.dtype.t_long_code default null, 
                          p_tenant_id in ntg.dtype.t_long_code default null, 
                          p_result in ntg.dtype.t_long_code default null
                          )
  is
--    v_ord_row ord%rowtype;
    v_id ntg.dtype.t_id;
    v_order ntg.dtype.t_id;
    v_item_avia_status ntg.dtype.t_id;
    r_item_avia item_avia%rowtype;
    r_order ord%rowtype;
--    r_client item_avia%rowtype;
    r_client blng.client%rowtype;
    r_item_avia_status item_avia_status%rowtype;
    v_order_r ord%rowtype;
    v_bill ntg.dtype.t_id;
    v_contract ntg.dtype.t_id;
    v_tenant_id ntg.dtype.t_id;
    
    c_bill  SYS_REFCURSOR;
    r_bill bill%rowtype;
  begin

    v_tenant_id := to_number(p_tenant_id);
  
    begin 
      if p_pnr_id is null then raise NO_DATA_FOUND; end if;
-- check that item with this pnr_id exists
      r_item_avia := ord_api.item_avia_get_info_r(p_pnr_id=>p_pnr_id);
    exception 
      when NO_DATA_FOUND then 
        NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_manual', p_msg_type=>'NO_DATA_FOUND',
          P_MSG => 'p_pnr_id does not exists',p_info => 'p_pnr_id='||p_pnr_id||',p_date='
          || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>1);
        RAISE_APPLICATION_ERROR(-20002,'avia_manual error. p_pnr_id does not found.');
    end;
    --    dbms_output.put_line(' p_id='||p_pnr_id);          

    begin 
-- check that cliemt with this user_id exist
      if v_tenant_id is null then raise NO_DATA_FOUND; end if;
      r_order := ord_api.ord_get_info_r(p_id=>r_item_avia.order_oid);
/* 
$TODO: there must be check for users with ISSUES permission
*/
      r_client := blng.blng_api.client_get_info_r(p_id=>r_order.client_oid);
        --dbms_output.put_line(' p_id='||r_client.id);   
--      r_company := blng.blng_api.company_get_info_r(p_id=>r_order.client_oid);
      if blng.core.pay_contract_by_client(r_client.id)!=v_tenant_id then raise NO_DATA_FOUND; end if;

    exception when NO_DATA_FOUND then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_manual', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => 'tenant_id not found',p_info => 'p_tenant_id='||v_tenant_id||',p_pnr_id='||p_pnr_id||',p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>1);
      RAISE_APPLICATION_ERROR(-20002,'avia_manual error. user_id not found. ');
    end;
    
    ord_api.item_avia_status_edit (  p_item_avia => r_item_avia.id, p_po_status => nvl(p_result,'INPROGRESS'),
                              p_nqt_status_cur => r_item_avia.nqt_status) ;  
    
    if p_result = 'ERROR' then 
      fwdr.cash_back(p_pnr_id);
    end if;

    commit;             
  exception 
    when others then
    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_manual', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM || ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=item_avia_status,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'avia_manual error. '||SQLERRM);
  end;

  procedure cash_back(p_pnr_id in ntg.dtype.t_long_code)
  is
    r_item_avia item_avia%rowtype;
    r_bill bill%rowtype;
    r_document blng.document%rowtype;
    c_bill SYS_REFCURSOR;
  begin
    r_item_avia:=ord_api.item_avia_get_info_r(p_pnr_id=>p_pnr_id);
    c_bill := ord_api.bill_get_info(p_order=>r_item_avia.order_oid,p_status=>'P');
    LOOP
      FETCH c_bill INTO r_bill;
      EXIT WHEN c_bill%NOTFOUND;
        begin        
          ORD_API.bill_edit( P_id => r_bill.id, P_STATUS => 'M');
          r_document:=blng.blng_api.document_get_info_r(p_bill=>r_bill.id);
          blng.core.revoke_document(p_document =>r_document.id );
        exception when others then
          rollback;
          NTG.LOG_API.LOG_ADD(p_proc_name=>'cash_back', p_msg_type=>'UNHANDLED_ERROR', 
            P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=bill,p_date=' 
            || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
          CLOSE c_bill;
          raise;
        end;
    END LOOP;
    CLOSE c_bill;

  exception when others then 
    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'cash_back', p_msg_type=>'UNHANDLED_ERROR', 
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=bill,p_date=' 
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
    RAISE_APPLICATION_ERROR(-20002,'cash_back error. '||SQLERRM);
  end;


  function get_sales_list(p_datetime_from in ntg.dtype.t_long_code default null,p_datetime_to in ntg.dtype.t_long_code default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin
    OPEN v_results FOR  
      SELECT
      to_char(AMND_DATE,'yyyy-mm-dd hh24') issue_date, PNR_LOCATOR, TICKET_NUMBER, PASSENGER_NAME, PASSENGER_TYPE, FARE_AMOUNT, TAXES_AMOUNT, SERVICE_FEE_AMOUNT
      FROM
      ord.ticket
      where AMND_DATE >= to_date(p_datetime_from,'YYYY-MM-DD HH24') 
      and AMND_DATE < to_date(p_datetime_to ,'YYYY-MM-DD HH24');
    return v_results;
  end;



  function commission_view(p_iata in ntg.dtype.t_code default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin
    OPEN v_results FOR  
      select * from ord.v_rule where IATA = p_iata;         
    return v_results;
  end;


  procedure avia_create(  p_pnr_id in ntg.dtype.t_long_code default null,
                          p_user_id in ntg.dtype.t_long_code default null
                          )
  is
    v_order ntg.dtype.t_id;
    v_item_avia ntg.dtype.t_id;
    v_item_avia_status ntg.dtype.t_id;
    r_item_avia item_avia%rowtype;
    r_client blng.client%rowtype;
  begin

    begin 
-- check that cliemt with this user_id exist
      if p_user_id is null then raise NO_DATA_FOUND; end if;
      
      r_client := blng.blng_api.client_get_info_r(p_email=>p_user_id);
    exception when NO_DATA_FOUND then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_create', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => 'email not found',p_info => 'p_user_id='||p_user_id||',p_pnr_id='||p_pnr_id||',p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>1);
      RAISE_APPLICATION_ERROR(-20002,'avia_create error. user_id not found. ');
    end;

    begin 
      -- check that item with this pnr_id does not exist
      if p_pnr_id is null then raise VALUE_ERROR; end if;

      r_item_avia := ord_api.item_avia_get_info_r(p_pnr_id=>p_pnr_id);
      if r_item_avia.id is not null then 
        RAISE_APPLICATION_ERROR(-20002,'avia_create error. this item already exists.');       
      end if;
    exception 
      when NO_DATA_FOUND then 
      -- its ok. else is not ok      
        null;
      when VALUE_ERROR then 
      -- its not ok      
        NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_create', p_msg_type=>'VALUE_ERROR',
          P_MSG => 'p_pnr_id is null',p_info => 'p_user_id='||p_user_id||',p_pnr_id='||p_pnr_id||',p_date='
          || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>1);
        RAISE_APPLICATION_ERROR(-20002,'avia_create error. p_pnr_id is null');
    end;
    dbms_output.put_line(' p_id='||p_pnr_id);          
    
    v_order := fwdr.order_create(p_client => r_client.id);
    
    v_item_avia := ORD_API.item_avia_add(P_ORDER_OID => v_order,
      P_pnr_id => P_PNR_ID
      ); 
    v_item_avia_status := ord_api.item_avia_status_add (  p_item_avia => v_item_avia) ;  

    commit;          
  exception 
    when others then    
      rollback;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_create', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM || ' '|| chr(13)||chr(10)
        || ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=item_avia,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'avia_create error. '||SQLERRM);
  end;


  procedure avia_update( p_pnr_id in ntg.dtype.t_long_code default null,
                          p_pnr_locator in ntg.dtype.t_long_code default null,
                          p_time_limit  in ntg.dtype.t_date default null,
                          p_total_amount in ntg.dtype.t_amount default null,
                          p_total_markup in ntg.dtype.t_amount default null,
                          p_pnr_object in ntg.dtype.t_clob default null,
                          p_nqt_status in  ntg.dtype.t_long_code default null,
                          p_tenant_id  in  ntg.dtype.t_long_code default null
                          )
  is
    v_id ntg.dtype.t_id;
    v_order ntg.dtype.t_id;
    v_avia ntg.dtype.t_id;
    v_bill ntg.dtype.t_id;
    v_client ntg.dtype.t_id;
    v_contract ntg.dtype.t_id;
    r_item_avia item_avia%rowtype;
    r_order ord%rowtype;
    r_client blng.client%rowtype;
    v_tenant_id ntg.dtype.t_id;
  begin

  v_tenant_id := to_number(p_tenant_id);
  
  dbms_output.put_line(' v_tenant_id='||v_tenant_id); 
    begin 
      if p_pnr_id is null then raise NO_DATA_FOUND; end if;
-- check that item with this pnr_id exists
      r_item_avia := ord_api.item_avia_get_info_r(p_pnr_id=>p_pnr_id);
    exception 
      when NO_DATA_FOUND then 
        NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_update', p_msg_type=>'NO_DATA_FOUND',
          P_MSG => 'p_pnr_id does not exists',p_info => 'p_pnr_id='||p_pnr_id||',p_date='
          || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>1);
        RAISE_APPLICATION_ERROR(-20002,'avia_update error. p_pnr_id does not found.');
    end;
--    dbms_output.put_line(' p_id='||p_pnr_id);          

    begin 
      -- check that client with this user_id exist
      if v_tenant_id is null then raise NO_DATA_FOUND; end if;
      r_order := ord_api.ord_get_info_r(p_id=>r_item_avia.order_oid);
/* 
$TODO: there must be check for users with ISSUES permission
*/
      r_client := blng.blng_api.client_get_info_r(p_id=>r_order.client_oid);

--      r_company := blng.blng_api.company_get_info_r(p_id=>r_order.client_oid);
      if blng.core.pay_contract_by_client(r_client.id)!=v_tenant_id then raise NO_DATA_FOUND; end if;

    exception when NO_DATA_FOUND then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_update', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => 'user_id not found',p_info => 'p_user_id='||v_tenant_id||',p_pnr_id='||p_pnr_id||',p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>1);
      RAISE_APPLICATION_ERROR(-20002,'avia_update error. user_id not found. ');
    end;
    
/*
        NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_update', p_msg_type=>'RUN item_avia_edit',
        P_MSG => 'p_nqt_status='||p_nqt_status||',P_PNR_ID='||P_PNR_ID,
        p_info => 'p_date='|| to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>0);
*/

    -- po_status not nulled when register calls
      ORD_API.item_avia_edit ( 
        P_PNR_locator => P_PNR_locator,
        P_TIME_LIMIT => P_TIME_LIMIT,
        P_TOTAL_AMOUNT => P_TOTAL_AMOUNT,
        P_TOTAL_MARKUP => P_TOTAL_MARKUP,
        P_PNR_OBJECT => P_PNR_OBJECT,
        P_pnr_id => P_PNR_ID,
        p_nqt_status => p_nqt_status
        ) ;  
    
      commit;          
  exception 
    when others then    
      rollback;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_update', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=item_avia,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'avia_update error. '||SQLERRM);
  end;


  procedure avia_pay( p_user_id in ntg.dtype.t_long_code default null,
                      p_pnr_id in ntg.dtype.t_long_code default null
                            )
  is
    r_item_avia item_avia%rowtype;
    r_item_avia_status item_avia_status%rowtype;
    v_order_r ord%rowtype;
    v_bill ntg.dtype.t_id;
    r_client blng.client%rowtype;    
    c_bill  SYS_REFCURSOR;
    r_bill bill%rowtype;
  begin

    begin 
-- check that cliemt with this user_id exists
      if p_user_id is null then raise NO_DATA_FOUND; end if;
      
      r_client := blng.blng_api.client_get_info_r(p_email=>p_user_id);
    exception when NO_DATA_FOUND then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_pay', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => 'user_id not found',p_info => 'p_user_id='||p_user_id||',p_pnr_id='||p_pnr_id||',p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>1);
      RAISE_APPLICATION_ERROR(-20002,'avia_pay error. user_id not found. ');
    end;

    begin 
-- check that cliemt with this user_id exists
      if p_pnr_id is null then raise NO_DATA_FOUND; end if;
      
      r_item_avia := ord_api.item_avia_get_info_r(p_pnr_id=>p_pnr_id);
    exception when NO_DATA_FOUND then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_pay', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => 'pnr_id not found',p_info => 'p_user_id='||p_user_id||',p_pnr_id='||p_pnr_id||',p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>1);
      RAISE_APPLICATION_ERROR(-20002,'avia_pay error. pnr_id not found. ');
    end;

    ord_api.item_avia_status_edit (  p_item_avia => r_item_avia.id, p_po_status => 'INPROGRESS',
                            p_nqt_status_cur => r_item_avia.nqt_status) ;  
                                    
    c_bill := ord_api.bill_get_info(p_order => r_item_avia.order_oid, p_status=>'M');
-- push all Managed bills to Waiting for pay process
    LOOP
      FETCH c_bill INTO r_bill;
      EXIT WHEN c_bill%NOTFOUND;
        ORD_API.bill_edit( P_id => r_bill.id, P_STATUS => 'W');
    END LOOP;
    CLOSE c_bill;  
    commit;             
  exception 
    when NO_DATA_FOUND then return;  
    when others then
    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_pay', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM || ' '|| chr(13)||chr(10) || ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=item_avia_status,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'avia_pay error. '||SQLERRM);
  end;

  procedure avia_booked( 
                          p_pnr_id in ntg.dtype.t_long_code default null,
                          p_user_id in ntg.dtype.t_long_code default null
                            )
  is
    r_item_avia item_avia%rowtype;
    r_client blng.client%rowtype;
    v_bill ntg.dtype.t_id;
    v_contract ntg.dtype.t_id;
  begin
  
    begin 
-- check that cliemt with this user_id exists
      if p_user_id is null then raise NO_DATA_FOUND; end if;
      
      r_client := blng.blng_api.client_get_info_r(p_email=>p_user_id);
    exception when NO_DATA_FOUND then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_booked', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => 'user_id not found',p_info => 'p_user_id='||p_user_id||',p_pnr_id='||p_pnr_id||',p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>1);
      RAISE_APPLICATION_ERROR(-20002,'avia_booked error. user_id not found. ');
    end;

    begin 
-- check that cliemt with this user_id exists
      if p_pnr_id is null then raise NO_DATA_FOUND; end if;
      
      r_item_avia := ord_api.item_avia_get_info_r(p_pnr_id=>p_pnr_id);
--     if r_item_avia.order_oid is null then raise NO_DATA_FOUND; end if;
      
    exception when NO_DATA_FOUND then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_booked', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => 'pnr_id not found',p_info => 'p_user_id='||p_user_id||',p_pnr_id='||p_pnr_id||',p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>1);
      RAISE_APPLICATION_ERROR(-20002,'avia_booked error. pnr_id not found. ');
    end;

    v_contract := blng.core.pay_contract_by_client(r_client.id);
    v_bill := ORD_API.bill_add( P_ORDER => r_item_avia.order_oid,
                                P_AMOUNT => r_item_avia.TOTAL_AMOUNT,
                                P_DATE => sysdate,
                                P_STATUS => 'M', --[M]anaging
                                P_CONTRACT => v_contract);
                                
    NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_booked', p_msg_type=>'OK',
      P_MSG => 'pnr_id not found',p_info => 'p_user_id='||p_user_id||',p_pnr_id='||p_pnr_id||',p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>1);                                
                                    
    commit;             
  exception 
    when others then
    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_booked', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM || ' '|| chr(13)||chr(10) || ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=item_avia_status,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'avia_booked error. '||SQLERRM);
  end;



  function pos_rule_get(p_version in ntg.dtype.t_id default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin

    OPEN v_results FOR
      select
      isr.id,
      nvl(isr.contract_oid,0) tenant_id,
      air.iata validating_carrier,
      isr.booking_pos,
      isr.ticketing_pos,
      isr.stock,
      isr.printer,
      (select max(id) from pos_rule)  version,
      decode(isr.amnd_state, 'A','Y','C','N','E') is_active
      from pos_rule isr, ntg.airline air
      where air.amnd_state = 'A'
      and air.id = isr.airline_oid
      and ((isr.amnd_state in ('C','A') 
            and isr.id in (select amnd_prev from pos_rule where id > p_version)
            and p_version is not null)
        or
          (isr.amnd_state = 'A'
          and p_version is null)
          );
    return v_results;
  exception when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'get_full', p_msg_type=>'UNHANDLED_ERROR', 
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=select,p_table=markup,p_date=' 
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
      RAISE_APPLICATION_ERROR(-20002,'select row into markup error. '||SQLERRM);
    return null;  
  end;

  function pos_rule_edit(p_data in ntg.dtype.t_clob)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_id ntg.dtype.t_id; 
    v_pos_rule ntg.dtype.t_id; 
    r_client pos_rule%rowtype;
  begin
-- first update client info. then if doc_number is not null then update client_data 
    for i in (
      select 
      dd.*
      from
      json_table(p_data, '$'
        COLUMNS 
          (
           id number(20,2) PATH '$.id',
           tenant_id number(20,2) PATH '$.tenant_id',
           validating_carrier number(20,2) PATH '$.validating_carrier',
           booking_pos VARCHAR2(10 CHAR) PATH '$.booking_pos',
           ticketing_pos VARCHAR2(10 CHAR) PATH '$.ticketing_pos',
           stock VARCHAR2(10 CHAR) PATH '$.stock',
           printer VARCHAR2(10 CHAR) PATH '$.printer',      
           status VARCHAR2(10 CHAR) PATH '$.status'       
          )
        ) dd
    )
    loop
      if i.id is null then 
        v_pos_rule:=ord_api.pos_rule_add( 
                                    p_contract => i.tenant_id,
                                    p_airline => i.validating_carrier,
                                    p_booking_pos => i.booking_pos,
                                    p_ticketing_pos => i.ticketing_pos,
                                    p_stock => i.stock,
                                    p_printer => i.printer
                                  );
      else
        ord_api.pos_rule_edit(  P_ID => i.id,
                                    p_contract => i.tenant_id,
                                    p_airline => i.validating_carrier,
                                    p_booking_pos => i.booking_pos,
                                    p_ticketing_pos => i.ticketing_pos,
                                    p_stock => i.stock,
                                    p_printer => i.printer,
                                    p_status => i.status
                                  ); 
      end if;
    end loop;
    
    commit;
      open v_results for
        select 'true' res from dual;
      return v_results;
  exception 
    when NO_DATA_FOUND then
      ROLLBACK;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'client_data_edit', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '||  sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=client,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
--      RAISE_APPLICATION_ERROR(-20002,'select row into client error. '||SQLERRM);
      open v_results for
        select 'false' res from dual;
      return v_results;
    when others then
      ROLLBACK;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'client_data_edit', p_msg_type=>'UNHANDLED_ERROR', 
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=client,p_date=' 
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
--      RAISE_APPLICATION_ERROR(-20002,'select row into client error. '||SQLERRM);
      open v_results for
        select 'false' res from dual;
      return v_results;
  end;


  function commission_edit(p_data in ntg.dtype.t_clob)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_id ntg.dtype.t_id; 
    v_pos_rule ntg.dtype.t_id; 
    r_client pos_rule%rowtype;
    v_commission ntg.dtype.t_id:=null;
    v_commission_details ntg.dtype.t_id:=null;
  begin
-- first update client info. then if doc_number is not null then update client_data 
    for i in (
        select *
        from 
        json_table (p_data,'$' columns(
          airline_id number(20,2) path '$.airline_id',
    --      airline_name VARCHAR2(250) path '$.airline_name',
    --      airline_iata VARCHAR2(250) path '$.airline_iata',
          NESTED PATH '$.contracts[*]' COLUMNS (
            contract_id number(20,2) path '$.contract_id',
    --        contract_type VARCHAR2(250) path '$.contract_type',
            NESTED PATH '$.rules[*]' COLUMNS (
              rule_id number(20,2) path '$.rule_id',
              rule_description VARCHAR2(250) path '$.rule_description',
              rule_life_from VARCHAR2(250) path '$.rule_life_from',
              rule_life_to VARCHAR2(250) path '$.rule_life_to',
              rule_amount number(20,2) path '$.rule_amount',
              rule_amount_measure VARCHAR2(250) path '$.rule_amount_measure',
              rule_priority number(20,2) path '$.rule_priority',
              NESTED PATH '$.conditions[*]' COLUMNS (
                condition_id number(20,2) path '$.condition_id',
                condition_status VARCHAR2(10) path '$.condition_status',
                template_type_id number(20,2) path '$.template_type_id',
                template_name_nls VARCHAR2(250) path '$.template_name_nls',
                template_value VARCHAR2(250) path '$.template_value'
              )          
            )
          )
        ))
    )
    loop
      if i.rule_id is not null then v_commission:= i.rule_id; end if;

      if v_commission is null then
        v_commission:=ord_api.commission_add( 
                          p_airline => i.airline_id,
                          p_details => i.rule_description,
                          p_fix => case when i.rule_amount_measure = 'PERCENT' then null else  i.rule_amount end,
                          p_percent => case when i.rule_amount_measure = 'PERCENT' then i.rule_amount else  null end,
                          P_DATE_FROM => to_date(i.rule_life_from,'yyyy-mm-dd')-ntg.fwdr.utc_offset_mow/24,
                          P_DATE_TO => to_date(i.rule_life_to,'yyyy-mm-dd')-ntg.fwdr.utc_offset_mow/24,
                          p_priority => i.rule_priority,
                          p_contract_type => i.contract_id --its contract_type of commission (self/interline/code-share)                          
                          );

                                  
      else
        ord_api.commission_edit( 
                          p_id => v_commission,
                          p_airline => i.airline_id,
                          p_details => i.rule_description,
                          p_fix => case when i.rule_amount_measure = 'PERCENT' then null else  i.rule_amount end,
                          p_percent => case when i.rule_amount_measure = 'PERCENT' then i.rule_amount else  null end,
                          P_DATE_FROM => to_date(i.rule_life_from,'yyyy-mm-dd')-ntg.fwdr.utc_offset_mow/24,
                          P_DATE_TO => to_date(i.rule_life_to,'yyyy-mm-dd')-ntg.fwdr.utc_offset_mow/24,
                          p_priority => i.rule_priority,
                          p_contract_type => i.contract_id /*, --its contract_type of commission (self/interline/code-share)                          
                          p_status =>*/
                          );
      end if;

      if i.condition_id is null and i.template_name_nls <> 'default' then
        v_commission_details:=ord_api.commission_details_add( 
                                    p_commission => v_commission,
                                    p_commission_template => i.template_type_id,
                                    p_value => i.template_value               
                          );

                                  
      elsif i.condition_id is not null and i.template_name_nls <> 'default' then
        ord_api.commission_details_edit( p_id => i.condition_id,
                                    p_commission => v_commission,
                                    p_commission_template => i.template_type_id,
                                    p_value => i.template_value,
                                    p_status => i.condition_status
                          );
      end if;
      
    end loop;
    
    commit;
      open v_results for
        select 'true' res from dual;
      return v_results;
  exception 
    when NO_DATA_FOUND then
      ROLLBACK;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'client_data_edit', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '||  sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=client,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
--      RAISE_APPLICATION_ERROR(-20002,'select row into client error. '||SQLERRM);
      open v_results for
        select 'false' res from dual;
      return v_results;
    when others then
      ROLLBACK;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'client_data_edit', p_msg_type=>'UNHANDLED_ERROR', 
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=client,p_date=' 
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
--      RAISE_APPLICATION_ERROR(-20002,'select row into client error. '||SQLERRM);
      open v_results for
        select 'false' res from dual;
      return v_results;
  end;


  function commission_template_list(p_is_contract_type in ntg.dtype.t_status default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin
    if p_is_contract_type = 'Y' then  
      OPEN v_results FOR
          SELECT
          decode(ID,1,null,id) id, TEMPLATE_TYPE, PRIORITY, DETAILS, IS_CONTRACT_TYPE, NAME, NLS_NAME, IS_VALUE
          from ord.commission_template 
          where /*id = nvl(p_id,id)
          and*/ amnd_state = 'A'
          and is_contract_type = 'Y'
          order by id;
    else
      OPEN v_results FOR
          SELECT
          decode(ID,1,null,id) id, TEMPLATE_TYPE, PRIORITY, DETAILS, IS_CONTRACT_TYPE, NAME, NLS_NAME, IS_VALUE
          from ord.commission_template 
          where /*id = nvl(p_id,id)
          and*/ amnd_state = 'A'
          and is_contract_type = 'N'
          order by id;
    end if;    

    return v_results;
  exception when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_template_get', p_msg_type=>'UNHANDLED_ERROR', 
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=select,p_table=commission_template,p_date=' 
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
      RAISE_APPLICATION_ERROR(-20002,'select row into commission_template_get error. '||SQLERRM);
    return null;  
  end;


END FWDR;
/
