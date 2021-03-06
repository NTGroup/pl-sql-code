CREATE OR REPLACE PACKAGE ORD.FWDR AS 


/*

$pkg: ORD.FWDR

*/


/*

$obj_type: function
$obj_name: order_create
$obj_desc: for creating empty order
$obj_param: p_date(t_date): is null. date for which we need to create order. now equals sysdate 
$obj_param: p_order_number(t_long_code): is null. number could set or generate inside. now generates by p_user
$obj_param: p_user(t_id): is not null. number could set or generate inside
$obj_param: p_status(t_status): is null. status like 'W' waiting or smth else. now equals 'A' 
$obj_return: id(t_id) of created order

*/
  function order_create(p_date  in hdbk.dtype.t_date default null, 
                    p_order_number  in hdbk.dtype.t_long_code default null, 
                    p_user in hdbk.dtype.t_id default null,
                    p_status in hdbk.dtype.t_status default null
                    )
  return hdbk.dtype.t_id;

/*

$obj_type: function
$obj_name: item_add
$obj_desc: fake function.
$obj_return: id of created item

*/

  function item_add(p_order_oid in hdbk.dtype.t_id default null,
                          p_pnr_locator in hdbk.dtype.t_long_code default null,
                          p_time_limit  in hdbk.dtype.t_date default null,
                          p_total_amount in hdbk.dtype.t_amount default null,
                          p_total_markup in hdbk.dtype.t_amount default null,
                          p_pnr_object in hdbk.dtype.t_clob default null,
                          p_pnr_id in hdbk.dtype.t_long_code default null
                          )
  return hdbk.dtype.t_id;

/*

$obj_type: procedure
$obj_name: avia_update
$obj_desc: procedure update item_avia row searched by pnr_id.
$obj_param: p_pnr_id(t_long_code): id from NQT. search perform by this id
$obj_param: p_pnr_locator(t_long_code): record locator just for info
$obj_param: p_time_limit(t_date): time limit just for info
$obj_param: p_total_amount(t_amount): total amount including markup
$obj_param: p_total_markup(t_amount): just total markup
$obj_param: p_pnr_object(t_clob): json for backup from nqt db
$obj_param: p_nqt_status(t_long_code): current NQT process
$obj_param: p_tenant_id(t_long_code): id of contract in text format, for authorization

*/

  procedure avia_update(  p_pnr_id in hdbk.dtype.t_long_code default null,
                          p_pnr_locator in hdbk.dtype.t_long_code default null,
                          p_time_limit  in hdbk.dtype.t_date default null,
                          p_total_amount in hdbk.dtype.t_amount default null,
                          p_total_markup in hdbk.dtype.t_amount default null,
                          p_pnr_object in hdbk.dtype.t_clob default null,
                          p_nqt_status in  hdbk.dtype.t_long_code default null,
                          p_tenant_id  in  hdbk.dtype.t_long_code default null
                          );

/*

$obj_type: procedure
$obj_name: avia_reg_ticket
$obj_desc: procedure get ticket info by pnr_id.
$obj_desc: its create row for ticket. later this info will send to managers
$obj_param: p_pnr_id(t_long_code): is not null. id from NQT. search perform by this id
$obj_param: p_tenant_id(t_long_code): is not null. id of contract in text format, for authorization
$obj_param: p_ticket: json {
$obj_param: p_ticket:   p_number(t_long_code) is null - ticket number
$obj_param: p_ticket:   p_name(t_name) is null - passenger FIRST_NAME + LAST_NAME
$obj_param: p_ticket:   p_fare_amount(t_amount) is null - fare amount
$obj_param: p_ticket:   p_tax_amount(t_amount) is null - taxes amount
$obj_param: p_ticket:   p_markup_amount(t_amount) is null - markup amount
$obj_param: p_ticket:   p_type(t_code) is null - passenger age type ADT, CNN, INF, etc.
$obj_param: p_ticket: }

*/
  procedure avia_reg_ticket(  p_pnr_id in hdbk.dtype.t_long_code default null,
                            p_tenant_id  in  hdbk.dtype.t_long_code default null,
                            p_ticket in hdbk.dtype.t_clob default null
                          );

/*

$obj_type: procedure
$obj_name: avia_pay
$obj_desc: procedure send all bills in status [M]arked to [W]aiting in billing for pay.
$obj_param: p_user_id(t_long_code): is not null. user identifire. at this moment email
$obj_param: p_pnr_id(t_long_code): is not null. id from NQT. search perform by this id

*/
  procedure avia_pay( p_user_id in hdbk.dtype.t_long_code default null,
                      p_pnr_id in hdbk.dtype.t_long_code default null);

/*

$obj_type: function
$obj_name: order_get
$obj_desc: fake

*/
  function order_get(p_id in hdbk.dtype.t_id)
  return SYS_REFCURSOR;

/*

$obj_type: function
$obj_name: item_list
$obj_desc: fake

*/
  function item_get(p_id in hdbk.dtype.t_id)
  return SYS_REFCURSOR;

/*

$obj_type: function
$obj_name: item_list
$obj_desc: fake

*/
  function item_list(p_order in hdbk.dtype.t_id)
  return SYS_REFCURSOR;
  


/*

$obj_type: function
$obj_name: pnr_list
$obj_desc: get pnr list whith statuses listed in p_nqt_status_list and with paging by p_rownum count.
$obj_desc: written for yaNQT.
$obj_param: p_nqt_status_list(t_clob): is null. list of statuses. json {
$obj_param: p_nqt_status_list(t_clob):   status(t_long_code) - status name
$obj_param: p_nqt_status_list(t_clob): }
$obj_param: p_rownum(t_id): is null. filter for rows count. if null then fetch all rows
$obj_return: sys_refcursor {
$obj_return:   pnr_id(t_long_code) - id from nqt
$obj_return:   nqt_status(t_long_code) - name of task that scheduled by NQT and processed by PO
$obj_return:   po_status(t_long_code) - progress status of task that scheduled by nqt
$obj_return:   nqt_status_cur(t_long_code) - name of current task that scheduled by nqt
$obj_return:   po_msg(t_msg) is null - equal NULL
$obj_return:   item_type(t_long_code) is not null  - equal 'avia' 
$obj_return:   pnr_locator(t_long_code) - pnr locator code
$obj_return:   tenant_id(t_long_code) - id of contract
$obj_return: }

*/
  function pnr_list(p_nqt_status_list in hdbk.dtype.t_clob, 
                    p_rownum in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR;

/*

$obj_type: function
$obj_name: pnr_list
$obj_desc: get pnr list whith id listed in p_pnr_list. written for NQT.
$obj_param: p_pnr_list(t_clob): is not null. json {
$obj_param: p_pnr_list(t_clob):   p_pnr_id(t_long_code) is not null - id from NQT. search perform by this id
$obj_param: p_pnr_list(t_clob):   p_tenant_id(t_long_code) is not null - id of contract in text format, for authorization
$obj_param: p_pnr_list(t_clob): }
$obj_param: p_rownum(t_id): is null. filter for rows count. if null then fetch all rows
$obj_return: sys_refcursor {
$obj_return:   pnr_id(t_long_code) - id from nqt
$obj_return:   nqt_status(t_long_code) - name of task that scheduled by NQT and processed by PO
$obj_return:   po_status(t_long_code) - progress status of task that scheduled by nqt
$obj_return:   nqt_status_cur(t_long_code) - name of current task that scheduled by nqt
$obj_return:   po_msg(t_msg) is null - equal NULL
$obj_return:   item_type(t_long_code) is not null  - equal 'avia' 
$obj_return:   pnr_locator(t_long_code) - pnr locator code
$obj_return:   tenant_id(t_long_code) - id of contract
$obj_return: }

*/
 
  function pnr_list(p_pnr_list in hdbk.dtype.t_clob)
  return SYS_REFCURSOR;

/*

$obj_type: procedure
$obj_name: commission_get
$obj_desc: calculates commission for pnr_id
$obj_param: p_pnr_id(t_long_code): is not null. id from NQT. search perform by this id
$obj_param: p_tenant_id(t_long_code): is not null. id of contract in text format, for authorization
$obj_param: o_fix(t_amount): is null. in this parameter returned fix commission value
$obj_param: o_percent(t_amount): is null. in this parameter returned percent commission value

*/
  procedure commission_get( p_pnr_id in hdbk.dtype.t_long_code,
                            p_tenant_id in hdbk.dtype.t_long_code, 
                            o_fix out  hdbk.dtype.t_amount, 
                            o_percent out  hdbk.dtype.t_amount
                          );

/*

$obj_type: function
$obj_name: order_number_generate
$obj_desc: generates order number as last number + 1 by user id
$obj_param: p_user(t_id): is not null. user id.
$obj_return: string(t_long_code) like 0012410032, where 1241 - user id and 32 is a counter of order

*/

  function order_number_generate (p_user in hdbk.dtype.t_id)
  return hdbk.dtype.t_long_code;

/*

$obj_type: procedure
$obj_name: avia_manual
$obj_desc: update order status to p_result, if p_result = ERROR then return all money.
$obj_param: p_pnr_id(t_long_code): is not null. id from NQT. search perform by this id
$obj_param: p_tenant_id(t_long_code): is not null. id of contract in text format, for authorization
$obj_param: p_result(t_long_code): is null. ERROR, SUCCESS, INPROGRESS. if null then INPROGRESS 

*/
  procedure avia_manual( p_pnr_id in hdbk.dtype.t_long_code default null, 
                          p_tenant_id in hdbk.dtype.t_long_code default null, 
                          p_result in hdbk.dtype.t_long_code default null);
  

/*
$obj_type: procedure
$obj_name: cash_back
$obj_desc: perform reverse for order scheme. return bill to Waiting status
$obj_desc: and call revoke_document from billing
$obj_param: p_pnr_id(t_long_code): is not null. id from NQT. search perform by this id
*/
  procedure cash_back(p_pnr_id in hdbk.dtype.t_long_code);

/*
$obj_type: function
$obj_name: get_sales_list
$obj_desc: fake
*/    
  function get_sales_list(p_datetime_from in hdbk.dtype.t_long_code default null,p_datetime_to in hdbk.dtype.t_long_code default null)
  return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: rule_view
$obj_desc: return all rules by iata code of airline
$obj_param: p_iata(t_code): is not null. iata 2 char code
$obj_return: SYS_REFCURSOR {
$obj_return:   AIRLINE_ID(t_id) is not null - id of airline
$obj_return:   IATA(t_code) is null - airline iata code
$obj_return:   NLS_AIRLINE(t_name) is not null - name of airline
$obj_return:   CONTRACT_TYPE_ID(t_id) is not null - id of contract type with airline. self, code-share, interline
$obj_return:   TENANT_ID(t_id) is not null - id of the contract
$obj_return:   CONTRACT_TYPE_NAME(t_long_code) is not null - name of contract type with airline. self, code-share, interline
$obj_return:   RULE_ID(t_id) is not null - id of the rule. rules is a statements describes how to calculate commission.
$obj_return:   RULE_DESCRIPTION(t_msg) is null - some additional info. this copied from document.
$obj_return:   RULE_AMOUNT(t_amount) is null - amount of rule
$obj_return:   RULE_MIN_ABSOLUTE(t_amount) is null - minimal absolute amount for rules with percents
$obj_return:   RULE_AMOUNT_MEASURE(t_long_code) is null - measure of rule. percent, fix
$obj_return:   PRIORITY(t_id) is null - number for ordering
$obj_return:   RULE_LIFE_FROM(t_long_code) is null - rule is active due to this dates. date from  
$obj_return:   RULE_LIFE_TO(t_long_code) is null - rule is active due to this dates. date to
$obj_return:   CONDITION_ID(t_id) is null - id of condition. condition its additional parameters into rule.
$obj_return:   TEMPLATE_TYPE_ID(t_id) is not null - template id. template is a statement for description conditions.
$obj_return:   TEMPLATE_TYPE(t_long_code) is not null - name of template
$obj_return:   TEMPLATE_TYPE_CODE(t_long_code) is null - code of template
$obj_return:   TEMPLATE_VALUE(t_msg) is null - value for this template
$obj_return:   IS_VALUE(t_status) is null - flag. is this template nead a value?
$obj_return:   CURRENCY(t_code) is null - currency of rule amount
$obj_return:   PER_SEGMENT(t_status) is not null - flag. is this rule calculated for each segment? else for ticket.
$obj_return:   PER_FARE(t_status) is not null - flag. is this rule calculated only for fare? else for full amount.
$obj_return:   RULE_TYPE(t_long_code) is null - type of rule. commission, markup
$obj_return:   MARKUP_TYPE(t_long_code) is null - base, partner, etc.
$obj_return: }
$obj_return: if NO_DATA_FOUND then SYS_REFCURSOR {
$obj_return:   IATA(t_code) is null - airline iata code
$obj_return:   NLS_AIRLINE(t_name) is not null - name of airline
$obj_return:   TENANT_ID(t_id) is not null - id of the contract
$obj_return: }
*/
  function rule_view( 
                      p_rule_id in hdbk.dtype.t_id default null,
                      p_iata in hdbk.dtype.t_code default null, 
                      p_rule_type in hdbk.dtype.t_code default null,
                      p_tenant_id in hdbk.dtype.t_id default null
                      
  )
  return SYS_REFCURSOR;



/*

$obj_type: procedure
$obj_name: avia_create
$obj_desc: procedure create item_avia row only. it cant update item. add PNR info like who, where, when
$obj_param: p_pnr_id(t_long_code): is not null. id from NQT. search perform by this id
$obj_param: p_user_id(t_long_code): is not null. user identifire. at this moment email
$obj_param: p_itinerary(t_clob): is null. PNR info like who, where, when

*/

  procedure avia_create(  p_pnr_id in hdbk.dtype.t_long_code default null,
                          p_user_id  in  hdbk.dtype.t_long_code default null,
                          p_itinerary  in  hdbk.dtype.t_clob default null
                          );


/*

$obj_type: procedure
$obj_name: avia_booked
$obj_desc: procedure send item/order/bill to billing for pay.
$obj_param: p_pnr_id(t_long_code): is not null. id from NQT. search perform by this id
$obj_param: p_user_id(t_long_code): is not null. user identifire. at this moment email

*/
  procedure avia_booked(
                      p_pnr_id in hdbk.dtype.t_long_code default null,
                       p_user_id in hdbk.dtype.t_long_code default null);



/*
$obj_type: function
$obj_name: pos_rule_get
$obj_desc: when p_version is null then return all active rows. if not null then  
$obj_desc: get all active and deleted rows that changed after p_version id
$obj_param: p_version(t_id): is null. id
$obj_return: SYS_REFCURSOR {
$obj_return:   ID(t_id) is not null - rule id
$obj_return:   TENANT_ID(t_id) is not null - id of contract. default value 0
$obj_return:   VALIDATING_CARRIER(t_code) is not null - airline code. default value 'YY'
$obj_return:   booking_pos(t_code) is not null - pos code. in that pos ticket must be booked
$obj_return:   ticketing_pos(t_code) is not null - pos code. in that pos ticket must be issued?
$obj_return:   stock(t_code) is not null - code of country where stock is situated 
$obj_return:   printer(t_code) is not null - code of printer
$obj_return:   VERSION(t_id) is not null - current last id from table 
$obj_return:   IS_ACTIVE(t_status) is not null - flag. is it pos_rule active?
$obj_return: }

*/  
  function pos_rule_get(p_version in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR;


/*
$obj_type: function
$obj_name: pos_rule_edit
$obj_desc: update pos_rules or create new pos_rules. if success return true else false.
$obj_desc: if status equals [C]lose or [D]elete then delete pos_rule.
$obj_param: p_data(t_clob): data for update. format json {
$obj_param: p_data(t_clob):   ID(t_id) is not null - rule id
$obj_param: p_data(t_clob):   TENANT_ID(t_id) is not null - id of contract. default value 0
$obj_param: p_data(t_clob):   VALIDATING_CARRIER(t_code) is not null - airline code. default value 'YY'
$obj_param: p_data(t_clob):   booking_pos(t_code) is not null - pos code. in that pos ticket must be booked
$obj_param: p_data(t_clob):   ticketing_pos(t_code) is not null - pos code. in that pos ticket must be issued?
$obj_param: p_data(t_clob):   stock(t_code) is not null - code of country where stock is situated 
$obj_param: p_data(t_clob):   printer(t_code) is not null - code of printer
$obj_param: p_data(t_clob):   status(t_status) is null - status of pos_rule. if 'C' or 'D' then delete this pos_rule
$obj_param: p_data(t_clob): }
$obj_return: SYS_REFCURSOR {
$obj_return:   res(t_code) is not null - 'true' is SUCCESS, else 'false'
$obj_return: }
*/
  function pos_rule_edit(p_data in hdbk.dtype.t_clob)
  return SYS_REFCURSOR;


/*
$obj_type: function
$obj_name: rule_add
$obj_desc: add new rule
$obj_param: p_data: data for add new rule. format json {
$obj_param: p_data:   AIRLINE_IATA(t_code) is null - airline iata code
$obj_param: p_data:   TENANT_ID(t_id) is not null - id of the contract
$obj_param: p_data:   CONTRACT_TYPE_ID(t_id) is not null - id of contract type with airline. self, code-share, interline
$obj_param: p_data:   RULE_ID(t_id) is not null - id of the rule. rules is a statements describes how to calculate commission.
$obj_param: p_data:   RULE_DESCRIPTION(t_msg) is null - some additional info. this copied from document.
$obj_param: p_data:   RULE_AMOUNT(t_amount) is null - amount of rule
$obj_param: p_data:   RULE_MIN_ABSOLUTE(t_amount) is null - minimal absolute amount for rules with percents
$obj_param: p_data:   RULE_AMOUNT_MEASURE(t_long_code) is null - measure of rule. percent, fix
$obj_param: p_data:   RULE_PRIORITY(t_id) is not null - number for ordering
$obj_param: p_data:   RULE_STATUS(t_status) is null - status of rule. if 'C' or 'D' then delete this pos_rulestatus of pos_rule. if 'C' or 'D' then delete this rule
$obj_param: p_data:   RULE_LIFE_FROM(t_long_code) is null - rule is active due to this dates. date from  
$obj_param: p_data:   RULE_LIFE_TO(t_long_code) is null - rule is active due to this dates. date to
$obj_param: p_data:   PER_SEGMENT(t_status) is not null - flag. is this rule calculated for each segment? else for ticket.
$obj_param: p_data:   PER_FARE(t_status) is not null - flag. is this rule calculated only for fare? else for full amount.
$obj_param: p_data:   RULE_TYPE(t_long_code) is null - type of rule. commission, markup
$obj_param: p_data:   MARKUP_TYPE(t_long_code) is null - type of commission. base, partner, etc.
$obj_param: p_data:   CURRENCY(t_code) is null - currency of rule amount
$obj_param: p_data:   CONDITION_ID(t_id) is null - id of condition. condition its additional parameters into rule.
$obj_param: p_data:   CONDITION_STATUS(t_status) is null - status of condition. if 'C' or 'D' then delete this pos_rulestatus of pos_rule. if 'C' or 'D' then delete this rulestatus of rule. if 'C' or 'D' then delete this pos_rulestatus of pos_rule. if 'C' or 'D' then delete this condition
$obj_param: p_data:   TEMPLATE_TYPE_ID(t_id) is not null - template id. template is a statement for description conditions.
$obj_param: p_data:   TEMPLATE_TYPE_NAME(t_long_code) is not null - name of template
$obj_param: p_data:   TEMPLATE_VALUE(t_msg) is null - value for this template
$obj_param: p_data: }
$obj_return: SYS_REFCURSOR {
$obj_return:   res(t_code) is not null - 'true' is SUCCESS, else 'false'
$obj_return: }
*/

  function rule_add(p_data in hdbk.dtype.t_clob)
  return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: rule_edit
$obj_desc: update rule info.
$obj_desc: add new condition or update info. 
$obj_desc: if condition status equals [D]elete then delete condition from rule. 
$obj_param: p_data: data for update rule. format json {
$obj_param: p_data:   RULE_ID(t_id) is not null - id of the rule. rules is a statements describes how to calculate commission.
$obj_param: p_data:   RULE_DESCRIPTION(t_msg) is null - some additional info. this copied from document.
$obj_param: p_data:   RULE_AMOUNT(t_amount) is null - amount of rule
$obj_param: p_data:   RULE_MIN_ABSOLUTE(t_amount) is null - minimal absolute amount for rules with percents
$obj_param: p_data:   RULE_AMOUNT_MEASURE(t_long_code) is null - measure of rule. percent, fix
$obj_param: p_data:   RULE_PRIORITY(t_id) is not null - number for ordering
$obj_param: p_data:   RULE_STATUS(t_status) is null - status of rule. if 'C' or 'D' then delete this pos_rulestatus of pos_rule. if 'C' or 'D' then delete this rule
$obj_param: p_data:   RULE_LIFE_FROM(t_long_code) is null - rule is active due to this dates. date from  
$obj_param: p_data:   RULE_LIFE_TO(t_long_code) is null - rule is active due to this dates. date to
$obj_param: p_data:   PER_SEGMENT(t_status) is not null - flag. is this rule calculated for each segment? else for ticket.
$obj_param: p_data:   PER_FARE(t_status) is not null - flag. is this rule calculated only for fare? else for full amount.
$obj_param: p_data:   RULE_TYPE(t_long_code) is null - type of rule. commission, markup
$obj_param: p_data:   MARKUP_TYPE(t_long_code) is null - type of commission. base, partner, etc.
$obj_param: p_data:   CURRENCY(t_code) is null - currency of rule amount
$obj_param: p_data:   CONDITION_ID(t_id) is null - id of condition. condition its additional parameters into rule.
$obj_param: p_data:   CONDITION_STATUS(t_status) is null - status of condition. if 'C' or 'D' then delete this pos_rulestatus of pos_rule. if 'C' or 'D' then delete this rulestatus of rule. if 'C' or 'D' then delete this pos_rulestatus of pos_rule. if 'C' or 'D' then delete this condition
$obj_param: p_data:   TEMPLATE_TYPE_ID(t_id) is not null - template id. template is a statement for description conditions.
$obj_param: p_data:   TEMPLATE_VALUE(t_msg) is null - value for this template
$obj_param: p_data: }
$obj_return: SYS_REFCURSOR {
$obj_return:   res(t_code) is not null - 'true' is SUCCESS, else 'false'
$obj_return: }

*/

  function rule_edit(p_data in hdbk.dtype.t_clob)
  return SYS_REFCURSOR;

  
/*
$obj_type: function
$obj_name: rule_delete
$obj_desc: delete commission rule.
$obj_param: p_rule_id(t_id): is not null. rule id
$obj_return: SYS_REFCURSOR {
$obj_return:   res(t_code) is not null - 'true' is SUCCESS, else 'false'
$obj_return: }
*/

  function rule_delete(p_rule_id in hdbk.dtype.t_id)
  return SYS_REFCURSOR;
 
 
/*
$obj_type: function
$obj_name: rule_template_list
$obj_desc: if p_is_contract_type='Y' then returns all contract_types. else 
$obj_desc: if p_is_markup_type = 'Y' then returns all markup_types. 
$obj_desc: else returns all commission templates
$obj_param: p_is_contract_type(t_status): is null. flag. is contract types requested?
$obj_param: p_is_markup_type(t_status):  is null. flag. is markup types requested?
$obj_return: SYS_REFCURSOR {
$obj_return:   ID(t_id) is not null - type id
$obj_return:   NAME(t_name) is not null - type name
$obj_return: }
*/  
  function rule_template_list(p_is_contract_type in hdbk.dtype.t_status default null,
                              p_is_markup_type in hdbk.dtype.t_status default null)
  return SYS_REFCURSOR;


/*  function bill_import_list
  return SYS_REFCURSOR;
*/

/*
$obj_type: function
$obj_name: markup_rule_get
$obj_desc: return all markup rules
$obj_param: p_version: version id. filter new changes
$obj_return: SYS_REFCURSOR {
$obj_return:   RULE_ID(t_id) is not null - id of the rule. rules is a statements describes how to calculate commission.
$obj_return:   IS_ACTIVE(t_status) is not null - flag. is it pos_rule active?
$obj_return:   VERSION(t_id) is not null - current last id from table 
$obj_return:   TENANT_ID(t_id) is not null - id of the contract
$obj_return:   IATA(t_code) is null - airline iata code
$obj_return:   MARKUP_TYPE(t_long_code) is null - base, partner, etc.
$obj_return:   RULE_AMOUNT(t_amount) is null - amount of rule
$obj_return:   RULE_AMOUNT_MEASURE(t_long_code) is null - measure of rule. percent, fix
$obj_return:   MIN_ABSOLUTE(t_amount) is null - minimal absolute amount for rules with percents
$obj_return:   PRIORITY(t_id) is not null - number for ordering
$obj_return:   PER_SEGMENT(t_status) is not null - flag. is this rule calculated for each segment? else for ticket.
$obj_return:   CONTRACT_TYPE(t_long_code) is not null - name of contract type with airline. self, code-share, interline
$obj_return:   CONDITION_COUNT(t_id) is not null - COUNT OF CONDITIONS FOR ir rule
$obj_return: }
*/
  function markup_rule_get(p_version in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: markup_templ_get
$obj_desc: return all markup templates for rule id
$obj_param: p_rule_id(t_id): is not null. id of rule
$obj_return: SYS_REFCURSOR {
$obj_return:   ID(t_id) is not null - id of template
$obj_return:   TEMPLATE_TYPE_CODE(t_id) is not null - code of template
$obj_return:   TEMPLATE_VALUE(t_id) is not null - value for it template
$obj_return: }
*/  
  function markup_templ_get(p_rule_id in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR;
  
/*
$obj_type: procedure
$obj_name: check_request
$obj_desc: authorize user or contract. check that pnr is correct
$obj_param: p_contract(t_id): is not null. id of contract
$obj_param: p_pnr_id(t_long_code): is not null. pnr id from nqt
*/   
  procedure check_request(  p_contract in hdbk.dtype.t_id default null,
                            p_pnr_id in hdbk.dtype.t_long_code default null
                            );
/*
$obj_type: procedure
$obj_name: check_request
$obj_desc: authorize user or contract. check that pnr is correct
$obj_param: p_email(t_long_code): is not null. email of user
$obj_param: p_pnr_id(t_long_code): is not null. pnr id from nqt
$obj_param: p_is_createp_is_create(t_statust_status): is null. if 'Y' then its creating procedure. default 'N'
*/   
  procedure check_request(  
                            p_email in hdbk.dtype.t_long_code default null,
                            p_pnr_id in hdbk.dtype.t_long_code default null,
                            p_is_create in hdbk.dtype.t_status default 'N'
                            );
/*
$obj_type: function
$obj_name: task_get
$obj_desc: fetch 1 nearest task. return task data. task is a feature to do some work. send email, transport bills, etc. apdate status of task as [W]aiting
$obj_return: BILL_ADD task. transit bill to 1c
$obj_return: SYS_REFCURSOR {
$obj_return:   email(t_long_code) is not null - email for sending letter to user
$obj_return:   task_id(t_id) is not null - id of task at PO
$obj_return:   task_type(t_long_code) is not null - task type equal 'BILL'
$obj_return:   contract_id(t_id) is not null - id of contract
$obj_return:   PRODUCT(t_long_code) is not null - info about bill for 1c to add correct bill item
$obj_return:   description(t_msg) is not null - description for adding to 1c bill
$obj_return:   quantity(t_id) is not null - quatity of 1c bill item
$obj_return:   price(t_amount) is not null - price of item
$obj_return:   vat(t_id) is not null - vat of item
$obj_return:   date_to(t_long_code) is not null - minimal date_to from all bills in string format yyyy-mm-dd
$obj_return: }
$obj_return: AVIA_ETICKET task. send avia eticket to client
$obj_return: SYS_REFCURSOR {
$obj_return:   email(t_long_code) is not null - email for sending letter to user
$obj_return:   task_id(t_id) is not null - id of task at PO
$obj_return:   task_type(t_long_code) is not null - task type equals 'ETICKET'
$obj_return:   pnr_id(t_long_code) is not null - id of pnr from NQT
$obj_return:   order_number(t_long_code) is not null - order number from ticket buy order
$obj_return:   city_from(t_name) is not null - departure city name
$obj_return:   city_to(t_name) is not null - arrival city name
$obj_return:   IS_ONE_LEG(t_status) is not null - flag. is itinerary has 1 leg? 
$obj_return: }
$obj_return: 1C_FIN_ACTS task. send fin acts to client from 1c
$obj_return: SYS_REFCURSOR {
$obj_return:   email(t_long_code) is not null - email for sending letter to user
$obj_return:   task_id(t_id) is not null - id of task at PO
$obj_return:   task_type(t_long_code) is not null - task type equals 'FIN_ACTS'
$obj_return:   bill_number(t_long_code) is not null - 1c bill number
$obj_return: }
$obj_return: BILL_DEPOSIT task. CREATES DEPOSIT bill to 1c
$obj_return: SYS_REFCURSOR {
$obj_return:   email(t_long_code) is not null - email for sending letter to user
$obj_return:   task_id(t_id) is not null - id of task at PO
$obj_return:   task_type(t_long_code) is not null - task type equal 'BILL_DEPOSIT'
$obj_return:   contract_id(t_id) is not null - id of contract
$obj_return:   PRODUCT(t_long_code) is not null - info about bill for 1c to add correct bill item
$obj_return:   description(t_msg) is not null - description for adding to 1c bill item
$obj_return:   quantity(t_id) is not null - quatity of 1c bill item
$obj_return:   price(t_amount) is not null - price of item
$obj_return:   vat(t_id) is not null - vat of item
$obj_return: }

*/  
  function task_get
  return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: task_close
$obj_desc: mark task as [C]losed
$obj_param: p_task(t_id): is not null. task id
$obj_param: p_number_1c(t_long_code): is not null. 1c bill number
$obj_param: p_data(t_clob): is null. task could be updated by this info-result
$obj_return: SYS_REFCURSOR {
$obj_return:   res(t_code) is not null - result of operation. equal SUCCESS or ERROR.
$obj_return: }
*/   
  function task_close(p_task in hdbk.dtype.t_id default null,
                      p_number_1c in hdbk.dtype.t_long_code default null,
                      p_data in hdbk.dtype.t_clob default null)
  return SYS_REFCURSOR;


/*
$obj_type: function
$obj_name: bill_1c_payed
$obj_desc: create task that sends fin docs.
$obj_param: p_number_1c(t_long_code): is not null. 1c bill number
$obj_return: SYS_REFCURSOR {
$obj_return:   res(t_code) is not null - result of operation. equal SUCCESS or ERROR.
$obj_return: }
*/  
  function bill_1c_payed(p_number_1c in hdbk.dtype.t_long_code default null)
  return SYS_REFCURSOR;
  

/*
$obj_type: function
$obj_name: vat_calc
$obj_desc: calculates vat. vat values saved at dictionary with 1C_PRODUCT_W_VAT code.
$obj_param: p_itinerary(t_id): is not null. itinerary id
$obj_return: ID(t_id) of dictionary 1C_PRODUCT_W_VAT code
*/  
  function vat_calc(p_itinerary in hdbk.dtype.t_id default null)
  return hdbk.dtype.t_id;
  
/*
$obj_type: function
$obj_name: bill_deposit
$obj_desc: create task thats add deposit bill to 1c.
$obj_param: p_user_id(t_long_code): is not null. user email who call this request
$obj_param: p_amount(t_amount): is not null. amount of deposit
$obj_return: SYS_REFCURSOR {
$obj_return:   res(t_code) is not null - result of operation. equal SUCCESS, ERROR, NOT_AUTHORIZED, VALUE_ERROR, NO_DATA_FOUND
$obj_return: }
*/  
  function bill_deposit(p_user_id in hdbk.dtype.t_long_code default null,
                        p_amount in hdbk.dtype.t_amount default null)
  return SYS_REFCURSOR;


/*
$obj_type: procedure
$obj_name: reg_task
$obj_desc: catch events from NQT. in terms of NQT event means task. task creates with result status 'INPROGRESS'
$obj_param: p_task(t_long_code): is not null. name of registered event
$obj_param: p_tenant_id(t_long_code): is null. contract id. needs for authorization
$obj_param: p_user_id(t_long_code): is null. user email who call this request. needs for authorization
$obj_param: p_pnr_id(t_long_code): is not null. pnr id from nqt 
$obj_param: p_data(t_clob): is null. data in json format contains event details

*/  
  procedure reg_task(
                    p_task in hdbk.dtype.t_long_code default null,
                    p_tenant_id in hdbk.dtype.t_long_code default null,
                    p_user_id in hdbk.dtype.t_long_code default null,
                    p_pnr_id in hdbk.dtype.t_long_code default null,
                    p_data in hdbk.dtype.t_clob default null)
                    ;


/*
$obj_type: function
$obj_name: reg_task_list
$obj_desc: return list of tasks for NQT (events at PO).
$obj_param: p_tenant_id(t_long_code): is null. contract id. if null do not use this filter
$obj_param: p_pnr_id(t_long_code): is null. pnr id from NQT. if null do not use this filter
$obj_param: p_task(t_long_code): is null. task code. if null do not use this filter
$obj_return: SYS_REFCURSOR {
$obj_return:   task(t_code) is not null - task code
$obj_return:   pnr_id(t_code) is not null - pnr id from NQT
$obj_return:   result(t_code) is not null - status of task(event). INPROGRESS,SUCCESS,ERROR
$obj_return:   error(t_code) is null - there could be codes of errors
$obj_return:   tenant_id(t_code) is not null - contract id
$obj_return: }
*/  

  function reg_task_list(
                    p_tenant_id in hdbk.dtype.t_long_code default null,
                    p_pnr_id in hdbk.dtype.t_long_code default null,
                    p_task in hdbk.dtype.t_long_code default null)
  return SYS_REFCURSOR;  
  
END FWDR;

/

  CREATE OR REPLACE PACKAGE BODY ORD.FWDR AS

  function order_create(p_date  in hdbk.dtype.t_date default null, 
                        p_order_number  in hdbk.dtype.t_long_code default null, 
                        p_user in hdbk.dtype.t_id default null,
                        p_status in hdbk.dtype.t_status default null
  )
  return hdbk.dtype.t_id
  is
    v_ord_row ord%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    
    v_id:=ord_api.ord_add(p_date => sysdate,
                          p_order_number => fwdr.order_number_generate(p_user),
                          p_user => p_user,
                          p_status => 'A'
    );
    return v_id;
  exception when others then
    rollback;
    hdbk.log_api.LOG_ADD(p_proc_name=>'order_create', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'insert row into ord error. '||SQLERRM);
    return null;
  end;

  function item_add(p_order_oid in hdbk.dtype.t_id default null,
                          p_pnr_locator in hdbk.dtype.t_long_code default null,
                          p_time_limit  in hdbk.dtype.t_date default null,
                          p_total_amount in hdbk.dtype.t_amount default null,
                          p_total_markup in hdbk.dtype.t_amount default null,
                          p_pnr_object in hdbk.dtype.t_clob default null,
                          p_pnr_id in hdbk.dtype.t_long_code default null
                          )
  return hdbk.dtype.t_id
  is
    v_ord_row ord%rowtype;
    v_id hdbk.dtype.t_id;
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'item_add', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'insert row into item_avia error. '||SQLERRM);
    return null;
  end;

  procedure avia_reg_ticket(  p_pnr_id in hdbk.dtype.t_long_code default null,
                            p_tenant_id  in  hdbk.dtype.t_long_code default null,
                            p_ticket in hdbk.dtype.t_clob default null
                          )
  is
    v_id hdbk.dtype.t_id;
    v_order hdbk.dtype.t_id;
    v_avia hdbk.dtype.t_id;
    v_bill hdbk.dtype.t_id;
    v_user hdbk.dtype.t_id;
    v_contract hdbk.dtype.t_id;
    v_task1c hdbk.dtype.t_id;
    v_bill2task hdbk.dtype.t_id;
    r_item_avia item_avia%rowtype;
    r_order ord%rowtype;
    r_ticket ticket%rowtype;
    r_usr blng.usr%rowtype;
    r_bill bill%rowtype;
    r_item_avia_status item_avia_status%rowtype;
    v_tenant_id hdbk.dtype.t_id;
    v_ticket hdbk.dtype.t_id;
    v_delay_count hdbk.dtype.t_id;
    v_is_ticket_received hdbk.dtype.t_status:='N';
    v_request hdbk.dtype.t_clob;
    
  begin
      hdbk.log_api.LOG_ADD(p_proc_name=>'avia_reg_ticket', p_msg_type=>'0',
        P_MSG => 'p_ticket='||p_ticket);
    
    v_tenant_id := to_number(p_tenant_id);
    check_request(p_contract=>v_tenant_id,p_pnr_id =>p_pnr_id);
  
      r_item_avia := ord_api.item_avia_get_info_r(p_pnr_id=>p_pnr_id);

  for i in (
    select * from 
    json_table  
      ( p_ticket,'$[*]' 
      columns (p_number VARCHAR2(250) path '$.p_number',
              p_name VARCHAR2(250) path '$.p_name',
              p_type VARCHAR2(250) path '$.p_type',
              p_fare_amount number(20,2) path '$.p_fare_amount',
              p_tax_amount number(20,2) path '$.p_tax_amount',
              p_markup_base number(20,2) path '$.p_markup_breakdown.base',
              p_markup_partner number(20,2) path '$.p_markup_breakdown.partner'
              )
      ) as j
  )
  loop
    begin
      r_ticket:= ord_api.ticket_get_info_r(
                            p_item_avia           => r_item_avia.id,
                            p_ticket_number       => i.p_number
                          );

      ord_api.ticket_edit( p_id => r_ticket.id,
                              --p_item_avia           => r_item_avia.id,
                              p_pnr_locator         => r_item_avia.pnr_locator,
                              p_ticket_number       => i.p_number,
                              p_passenger_name      => i.p_name,
                              p_passenger_type      => i.p_type,
                              p_fare_amount         => i.p_fare_amount,
                              p_taxes_amount        => i.p_tax_amount,
                              p_service_fee_amount  => i.p_markup_base,
                              p_partner_fee_amount  => i.p_markup_partner
                              
                            );    
        v_is_ticket_received := 'Y';
        
    exception when NO_DATA_FOUND then

      v_ticket:=ord_api.ticket_add( p_item_avia           => r_item_avia.id,
                              p_pnr_locator         => r_item_avia.pnr_locator,
                              p_ticket_number       => i.p_number,
                              p_passenger_name      => i.p_name,
                              p_passenger_type      => i.p_type,
                              p_fare_amount         => i.p_fare_amount,
                              p_taxes_amount        => i.p_tax_amount,
                              p_service_fee_amount  => i.p_markup_base,
                              p_partner_fee_amount  => i.p_markup_partner
                            );
      v_is_ticket_received := 'Y';
      
    end;
    
  end loop;
  if v_is_ticket_received = 'Y' then
        
    r_bill := ord_api.bill_get_info_r(p_order=>r_item_avia.order_oid);

    select count(*) into v_delay_count from blng.v_delay where bill_id = r_bill.id;
    if v_delay_count <> 0 then
-- This is prevent create task when whole bill payed from deposit
      v_task1c := ord_api.task1c_add(p_task_type=>hdbk.core.dictionary_get_id(p_dictionary_type=>'1C',p_code=>'BILL_ADD'));
      v_bill2task := ord_api.bill2task_add(p_bill=>r_bill.id,p_task=>v_task1c);
    end if;

    v_request := '{"item_avia": '||r_item_avia.id||'}';
    v_task1c := ord_api.task1c_add(p_task_type=>hdbk.core.dictionary_get_id(p_dictionary_type=>'TASK',p_code=>'AVIA_ETICKET'),
                  p_request => v_request);
    
  end if;  
  commit;    
  
  exception 
    when others then    
      rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'avia_reg_ticket', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'avia_reg_ticket error. '||SQLERRM);
  end;





  function item_list(p_order in hdbk.dtype.t_id)
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'item_list', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into item_avia error. '||SQLERRM);
    return null;
  end;


  function pnr_list(p_nqt_status_list in hdbk.dtype.t_clob, p_rownum in hdbk.dtype.t_id default null)
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
        where ias.po_status = upper(j.status) 
        and ia.amnd_state = 'A'
        and ias.amnd_state = 'A'
        and ia.id = ias.item_avia_oid
        and ROWNUM <= nvl(p_rownum,rownum)
        order by ia.time_limit asc; --, ia.id;
    return v_results;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'pnr_list', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into item_avia error. '||SQLERRM);
    return null;    
  end;
  

  function pnr_list(p_pnr_list in hdbk.dtype.t_clob)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        ia.pnr_id, ia.nqt_status, ias.po_status, ias.nqt_status_cur, 
        null po_msg, 'avia' item_type, ia.pnr_locator, j.p_tenant_id tenant_id
        from ord.item_avia ia, ord.item_avia_status ias, blng.usr, ord.ord, blng.usr2contract,
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
        and usr.amnd_state = 'A'
        and usr.id = ord.user_oid
        and usr2contract.contract_oid = j.p_tenant_id
        and usr.id = usr2contract.user_oid
        and usr2contract.permission = 'B'
        order by ia.time_limit asc; 
    return v_results;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'pnr_list', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into item_avia error. '||SQLERRM);
    return null;
  end;
    
  function item_get(p_id in hdbk.dtype.t_id)
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'item_list', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into item_avia error. '||SQLERRM);
    return null;    
  end;

  function order_get(p_id in hdbk.dtype.t_id)
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'order_get', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into ord error. '||SQLERRM);
    return null;
  end;

  procedure commission_get(p_pnr_id in hdbk.dtype.t_long_code, 
                            p_tenant_id in hdbk.dtype.t_long_code, 
                            o_fix out  hdbk.dtype.t_amount, 
                            o_percent out  hdbk.dtype.t_amount)
  is
    v_iata varchar2(255); 
  --  v_out number := null;
    r_json v_json%rowtype;
    r_item_avia item_avia%rowtype;
    r_usr blng.usr%rowtype;
    r_order ord%rowtype;
--    f_chs_VCeqMC number;  
--    f_chs_MCneOC number;  
    f_VCeqMC hdbk.dtype.t_id;  
    f_MCeqOC hdbk.dtype.t_id;  
    f_rule hdbk.dtype.t_id;  
    f_template_type hdbk.dtype.t_id;  
    f_list hdbk.dtype.t_id;  
    v_contract_type hdbk.dtype.t_id;
    v_template_type varchar2(255);
    v_tenant_id hdbk.dtype.t_id;
    v_airline hdbk.dtype.t_id;
    v_id hdbk.dtype.t_id;
    
  begin
--o_percent:=0.6;
--o_fix:= 2.3;
    v_tenant_id := to_number(p_tenant_id);
    check_request(p_contract=>v_tenant_id,p_pnr_id =>p_pnr_id);


    hdbk.log_api.LOG_ADD(p_proc_name=>'commission_get', p_msg_type=>'STARTED');
        
    r_item_avia := ord_api.item_avia_get_info_r(p_pnr_id => p_pnr_id);
    if r_item_avia.id is null then
--      dbms_output.put_line(' p_id='||p_pnr_id);          
      --raise NO_DATA_FOUND;
      return;
    end if;
--    dbms_output.put_line('NN p_id='||r_item_avia.id);          
    v_id:= r_item_avia.id;
  
    select distinct al.id, al.iata  into v_airline, v_iata from ord.v_json j, hdbk.airline al where j.id = v_id
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
      hdbk.log_api.LOG_ADD(p_proc_name=>'commission_get', p_msg_type=>'UNHANDLED_ERROR');
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
      select distinct rule_id id, /*fix, percent, */ priority,rule_description , rule_amount_measure,rule_amount
      from ord.v_rule 
      where contract_type_id = v_contract_type and iata = v_iata
      and nvl(to_date(rule_life_from,'yyyy-mm-dd'),trunc(sysdate)) <= trunc(sysdate)
      and nvl(to_date(rule_life_to,'yyyy-mm-dd'),trunc(sysdate)) >= trunc(sysdate)
      order by priority desc
    )
    loop
-- several rules can be true. each of them we need to check and get minimum commission value.
-- its mean we have to check all rules.
      f_rule := 1; 
      for i_condition in (
        select template_type_code,template_value, template_type_id from ord.v_rule where contract_type_id = v_contract_type and iata = v_iata and rule_id = i_rule.id
      )
      loop
        f_template_type := 0; 
        
-- template_type distribute rule by conditions. for examples geo type and class type.
-- each of conditions must be true inside rule.
-- thats why order of conditions is dosnt matter

-- for each conditions we make different logic. 
-- json is just iteration for each segment. some conditions must be true for each segment,
-- others only for one of them
        
        if i_condition.template_type_id=0 then
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
        if o_fix is null or o_fix > i_rule.rule_amount and i_rule.rule_amount_measure='FIX' then 
          o_fix := i_rule.rule_amount; 
        end if;
        if o_percent is null or o_percent > i_rule.rule_amount and i_rule.rule_amount_measure='PERCENT' then 
          o_percent := i_rule.rule_amount; 
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
      hdbk.log_api.LOG_ADD(p_proc_name=>'commission_get', p_msg_type=>'NO_DATA_FOUND');
      return;
    when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'commission_get', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'commission_get error. '||SQLERRM);
    ---o_fix := null; o_percent:=5;
  end;

  function order_number_generate (p_user in hdbk.dtype.t_id)
  return hdbk.dtype.t_long_code
  is
    v_user_oid number;
    v_order_count number;
  begin
    select count(*) into v_order_count from ord.ord where user_oid = p_user and amnd_state <> 'I';
    return lpad(p_user,6,'0')||lpad(v_order_count+1,4,'0');
  end;

  procedure avia_manual( p_pnr_id in hdbk.dtype.t_long_code default null, 
                          p_tenant_id in hdbk.dtype.t_long_code default null, 
                          p_result in hdbk.dtype.t_long_code default null
                          )
  is
--    v_ord_row ord%rowtype;
    v_id hdbk.dtype.t_id;
    v_order hdbk.dtype.t_id;
    v_item_avia_status hdbk.dtype.t_id;
    r_item_avia item_avia%rowtype;
    r_order ord%rowtype;
--    r_usr item_avia%rowtype;
    r_usr blng.usr%rowtype;
    r_item_avia_status item_avia_status%rowtype;
    v_order_r ord%rowtype;
    v_bill hdbk.dtype.t_id;
    v_contract hdbk.dtype.t_id;
    v_tenant_id hdbk.dtype.t_id;
    
    c_bill  SYS_REFCURSOR;
    r_bill bill%rowtype;
  begin

    v_tenant_id := to_number(p_tenant_id);
    check_request(p_contract=>v_tenant_id,p_pnr_id =>p_pnr_id);

    r_item_avia := ord_api.item_avia_get_info_r(p_pnr_id=>p_pnr_id);
    
    ord_api.item_avia_status_edit (  p_item_avia => r_item_avia.id, p_po_status => nvl(p_result,'INMANUAL'),
                              p_nqt_status_cur => r_item_avia.nqt_status) ;  
    
    if p_result = 'ERROR' then 
      fwdr.cash_back(p_pnr_id);
    end if;

    commit;             
  exception 
    when others then
    rollback;
    hdbk.log_api.LOG_ADD(p_proc_name=>'avia_manual', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'avia_manual error. '||SQLERRM);
  end;

  procedure cash_back(p_pnr_id in hdbk.dtype.t_long_code)
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
          hdbk.log_api.LOG_ADD(p_proc_name=>'cash_back', p_msg_type=>'UNHANDLED_ERROR');      
          CLOSE c_bill;
          raise;
        end;
    END LOOP;
    CLOSE c_bill;

  exception when others then 
    rollback;
    hdbk.log_api.LOG_ADD(p_proc_name=>'cash_back', p_msg_type=>'UNHANDLED_ERROR');      
    RAISE_APPLICATION_ERROR(-20002,'cash_back error. '||SQLERRM);
  end;


  function get_sales_list(p_datetime_from in hdbk.dtype.t_long_code default null,p_datetime_to in hdbk.dtype.t_long_code default null)
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



  function rule_view( 
                      p_rule_id in hdbk.dtype.t_id default null,
                      p_iata in hdbk.dtype.t_code default null, 
                      p_rule_type in hdbk.dtype.t_code default null,
                      p_tenant_id in hdbk.dtype.t_id default null
                      )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
    v_count hdbk.dtype.t_id:=0;
  begin
    if p_rule_id is null then    
      select count(*) into v_count from ord.v_rule where IATA = p_iata and rule_type = p_rule_type and tenant_id = p_tenant_id;    
      if v_count <> 0 then
        OPEN v_results FOR  
          select * from ord.v_rule where IATA = p_iata and rule_type = p_rule_type and tenant_id = p_tenant_id;         
      else
        OPEN v_results FOR  
          select iata, nls_name nls_airline, p_tenant_id tenant_id from hdbk.airline where iata = p_iata and amnd_state = 'A';               
      end if;
    else
      OPEN v_results FOR  
        select * from ord.v_rule where rule_id = p_rule_id;         
    end if;
    return v_results;
  end;


  procedure avia_create(  p_pnr_id in hdbk.dtype.t_long_code default null,
                          p_user_id in hdbk.dtype.t_long_code default null,
                          p_itinerary  in  hdbk.dtype.t_clob default null
                          )
  is
    v_order hdbk.dtype.t_id;
    v_item_avia hdbk.dtype.t_id;
    v_item_avia_status hdbk.dtype.t_id;
    r_item_avia item_avia%rowtype;
    r_usr blng.usr%rowtype;
    v_prev_leg hdbk.dtype.t_id :=0;
    v_itinerary hdbk.dtype.t_id;
    v_leg hdbk.dtype.t_id;
    v_segment hdbk.dtype.t_id;
  begin
      hdbk.log_api.LOG_ADD(p_proc_name=>'avia_create', p_msg_type=>'ok');

    check_request(p_email => p_user_id,p_pnr_id =>p_pnr_id, p_is_create=>'Y');

    dbms_output.put_line(' p_id='||p_pnr_id);          
    r_usr := blng.blng_api.usr_get_info_r(p_email=>p_user_id);
    
    v_order := fwdr.order_create(p_user => r_usr.id);
    
    v_item_avia := ORD_API.item_avia_add(P_ORDER_OID => v_order,
      P_pnr_id => P_PNR_ID
      ); 
    v_item_avia_status := ord_api.item_avia_status_add (  p_item_avia => v_item_avia) ;  

    for i in (
              select
              leg_num,
              hdbk.hdbk_api.airline_get_id(p_iata => validating_carrier) validating_carrier,
              leg_departure_iata,
              (select id from hdbk.geo where id = (select city_id from hdbk.geo where iata = leg_departure_iata and amnd_state = 'A' and is_active = 'Y' and object_type='airport real')) leg_departure_city,
              to_date(leg_departure_date,'yyyy-mm-dd"T"HH24:mi:ss') leg_departure_date,
              leg_arrival_iata,
              (select id from hdbk.geo where id = (select city_id from hdbk.geo where iata = leg_arrival_iata and amnd_state = 'A' and is_active = 'Y' and object_type='airport real')) leg_arrival_city,
              to_date(leg_arrival_date,'yyyy-mm-dd"T"HH24:mi:ss') leg_arrival_date,
              segment_num,
              hdbk.hdbk_api.airline_get_id(p_iata => segment_marketing_carrier) segment_marketing_carrier,
              hdbk.hdbk_api.airline_get_id(p_iata => segment_operating_carrier) segment_operating_carrier,
              segment_departure_iata,
              (select id from hdbk.geo where id = (select city_id from hdbk.geo where iata = segment_departure_iata and amnd_state = 'A' and is_active = 'Y' and object_type='airport real')) segment_departure_city,
              to_date(segment_departure_date,'yyyy-mm-dd"T"HH24:mi:ss') segment_departure_date,
              segment_arrival_iata,
              (select id from hdbk.geo where id = (select city_id from hdbk.geo where iata = segment_arrival_iata and amnd_state = 'A' and is_active = 'Y' and object_type='airport real')) segment_arrival_city,
              to_date(segment_arrival_date,'yyyy-mm-dd"T"HH24:mi:ss') segment_arrival_date
              from 
                  json_table  
                    ( p_itinerary,'$' 
                    columns (
                            validating_carrier VARCHAR2(250) path '$.validating_carrier',
                            NESTED PATH '$.legs[*]' COLUMNS (
                              leg_num number(18,0) path '$.leg_num',
                              leg_departure_iata VARCHAR2(250) path '$.departure_location',
                              leg_departure_date VARCHAR2(250) path '$.departure_datetime',
                              leg_arrival_iata VARCHAR2(250) path '$.arrival_location',
                              leg_arrival_date VARCHAR2(250) path '$.arrival_datetime',
                              NESTED PATH '$.segments[*]' COLUMNS (
                                segment_num number(20,2) path '$.segment_num',
                                segment_marketing_carrier VARCHAR2(250) path '$.marketing_carrier',
                                segment_operating_carrier VARCHAR2(250) path '$.operating_carrier',
                                segment_departure_iata VARCHAR2(250) path '$.departure_location',
                                segment_departure_date VARCHAR2(250) path '$.departure_datetime',
                                segment_arrival_iata VARCHAR2(250) path '$.arrival_location',
                                segment_arrival_date VARCHAR2(250) path '$.arrival_datetime'
                                )
                              )
                            )
                    ) as j
    )
    loop
      if v_prev_leg = 0 then
        v_itinerary := ord_api.itinerary_add(p_item_avia=>v_item_avia,
                                              p_validating_carrier=>i.validating_carrier);
      end if;
      
      if v_prev_leg <> i.leg_num then
        v_leg := ord_api.leg_add( p_itinerary => v_itinerary, 
                                  p_sequence_number  => i.leg_num,
                                  p_departure_iata  => i.leg_departure_iata,
                                  p_departure_city => i.leg_departure_city,
                                  p_departure_date => i.leg_departure_date,
                                  p_arrival_iata  => i.leg_arrival_iata,
                                  p_arrival_city  => i.leg_arrival_city,
                                  p_arrival_date  => i.leg_arrival_date
                        );
        v_prev_leg:= i.leg_num;
      
      end if;

        v_segment := ord_api.segment_add( p_leg => v_leg, 
                                  p_sequence_number  => i.segment_num,
                                  p_departure_iata  => i.segment_departure_iata,
                                  p_departure_city => i.segment_departure_city,
                                  p_departure_date => i.segment_departure_date,
                                  p_arrival_iata  => i.segment_arrival_iata,
                                  p_arrival_city  => i.segment_arrival_city,
                                  p_arrival_date  => i.segment_arrival_date,
                                  p_marketing_carrier  => i.segment_marketing_carrier,
                                  p_operating_carrier  => i.segment_operating_carrier
                        );
      
    end loop;

    commit;          
  exception 
    when others then    
      rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'avia_create', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'avia_create error. '||SQLERRM);
  end;


  procedure avia_update( p_pnr_id in hdbk.dtype.t_long_code default null,
                          p_pnr_locator in hdbk.dtype.t_long_code default null,
                          p_time_limit  in hdbk.dtype.t_date default null,
                          p_total_amount in hdbk.dtype.t_amount default null,
                          p_total_markup in hdbk.dtype.t_amount default null,
                          p_pnr_object in hdbk.dtype.t_clob default null,
                          p_nqt_status in  hdbk.dtype.t_long_code default null,
                          p_tenant_id  in  hdbk.dtype.t_long_code default null
                          )
  is
    v_id hdbk.dtype.t_id;
    v_order hdbk.dtype.t_id;
    v_avia hdbk.dtype.t_id;
    v_bill hdbk.dtype.t_id;
    v_user hdbk.dtype.t_id;
    v_contract hdbk.dtype.t_id;
    r_item_avia item_avia%rowtype;
    r_order ord%rowtype;
    r_usr blng.usr%rowtype;
    v_tenant_id hdbk.dtype.t_id;
  begin

  v_tenant_id := to_number(p_tenant_id);
    check_request(p_contract=>v_tenant_id,p_pnr_id =>p_pnr_id);


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
      hdbk.log_api.LOG_ADD(p_proc_name=>'avia_update', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'avia_update error. '||SQLERRM);
  end;


  procedure avia_pay( p_user_id in hdbk.dtype.t_long_code default null,
                      p_pnr_id in hdbk.dtype.t_long_code default null
                            )
  is
    r_item_avia item_avia%rowtype;
    r_item_avia_status item_avia_status%rowtype;
    v_order_r ord%rowtype;
    v_bill hdbk.dtype.t_id;
    r_usr blng.usr%rowtype;    
    c_bill  SYS_REFCURSOR;
    r_bill bill%rowtype;
  begin
      hdbk.log_api.LOG_ADD(p_proc_name=>'avia_pay', p_msg_type=>'ok');

    check_request(p_email => p_user_id,p_pnr_id =>p_pnr_id);

      r_item_avia := ord_api.item_avia_get_info_r(p_pnr_id=>p_pnr_id);

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
    hdbk.log_api.LOG_ADD(p_proc_name=>'avia_pay', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'avia_pay error. '||SQLERRM);
  end;

  procedure avia_booked( 
                          p_pnr_id in hdbk.dtype.t_long_code default null,
                          p_user_id in hdbk.dtype.t_long_code default null
                            )
  is
    r_item_avia item_avia%rowtype;
    r_itinerary itinerary%rowtype;
    r_usr blng.usr%rowtype;
    v_bill hdbk.dtype.t_id;
    v_contract hdbk.dtype.t_id;
  begin

    hdbk.log_api.LOG_ADD(p_proc_name=>'avia_booked', p_msg_type=>'OK');                                

    check_request(p_email => p_user_id,p_pnr_id =>p_pnr_id);
  
      r_usr := blng.blng_api.usr_get_info_r(p_email=>p_user_id);
      r_item_avia := ord_api.item_avia_get_info_r(p_pnr_id=>p_pnr_id);
      r_itinerary := ord_api.itinerary_get_info_r(p_item_avia=>r_item_avia.id);

    v_contract := blng.core.pay_contract_by_user(r_usr.id);
    v_bill := ORD_API.bill_add( P_ORDER => r_item_avia.order_oid,
                                P_AMOUNT => r_item_avia.TOTAL_AMOUNT,
                                P_DATE => sysdate,
                                P_STATUS => 'M', --[M]anaging
                                P_CONTRACT => v_contract,
                                p_trans_type=>hdbk.core.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>'BUY'),
                                p_vat_type=>vat_calc(r_itinerary.id)
                                );
                                
    hdbk.log_api.LOG_ADD(p_proc_name=>'avia_booked', p_msg_type=>'OK');                                
                                    
    commit;             
  exception 
    when others then
    rollback;
    hdbk.log_api.LOG_ADD(p_proc_name=>'avia_booked', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'avia_booked error. '||SQLERRM);
  end;



  function pos_rule_get(p_version in hdbk.dtype.t_id default null)
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
      (select max(id) from ord.pos_rule)  version,
      decode(isr.amnd_state, 'A','Y','C','N','E') is_active
      from ord.pos_rule isr, hdbk.airline air
      where air.amnd_state = 'A'
      and air.id = isr.airline_oid
      and ((isr.amnd_state in ('C','A') 
            and isr.id in (select amnd_prev from ord.pos_rule where id > p_version)
            and p_version is not null)
        or
          (isr.amnd_state = 'A'
          and p_version is null)
          );
    return v_results;
  exception when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'pos_rule_get', p_msg_type=>'UNHANDLED_ERROR');      
      RAISE_APPLICATION_ERROR(-20002,'select row into markup error. '||SQLERRM);
    return null;  
  end;

  function pos_rule_edit(p_data in hdbk.dtype.t_clob)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_id hdbk.dtype.t_id; 
    v_pos_rule hdbk.dtype.t_id; 

  begin

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
      hdbk.log_api.LOG_ADD(p_proc_name=>'pos_rule_edit', p_msg_type=>'NO_DATA_FOUND');

      open v_results for
        select 'false' res from dual;
      return v_results;
    when others then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'pos_rule_edit', p_msg_type=>'UNHANDLED_ERROR');      

      open v_results for
        select 'false' res from dual;
      return v_results;
  end;

  function rule_add(p_data in hdbk.dtype.t_clob)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_id hdbk.dtype.t_id; 
    v_airline hdbk.dtype.t_id; 
    v_pos_rule hdbk.dtype.t_id; 

--    r_airline hdbk.airline%rowtype;
    v_rule hdbk.dtype.t_id:=null;
    v_commission_details hdbk.dtype.t_id:=null;
  begin
    hdbk.log_api.LOG_ADD(p_proc_name=>'rule_add', p_msg_type=>'OK',P_MSG => p_data);

  
    for i in (
        select *
        from 
        json_table (p_data,'$' columns(
            tenant_id number(20,2) path '$.tenant_id',
            airline_iata VARCHAR2(10) path '$.airline_iata',
            contract_type_id number(20,2) path '$.contract_type_id',
    --        contract_type VARCHAR2(250) path '$.contract_type',
           -- NESTED PATH '$.rule[*]' COLUMNS (
              rule_id number(20,2) path '$.rule.rule_id',
              rule_type VARCHAR2(250) path '$.rule.rule_type',
              markup_type VARCHAR2(250) path '$.rule.markup_type',
              rule_description VARCHAR2(250) path '$.rule.rule_description',
              rule_life_from VARCHAR2(250) path '$.rule.rule_life_from',
              rule_life_to VARCHAR2(250) path '$.rule.rule_life_to',
              rule_amount number(20,2) path '$.rule.rule_amount',
              rule_amount_measure VARCHAR2(250) path '$.rule.rule_amount_measure',
              rule_min_absolute number(20,2) path '$.rule.rule_min_absolute',
              currency  varchar2(250) path '$.rule.currency',
              per_segment  VARCHAR2(250) path '$.rule.per_segment',
              per_fare  VARCHAR2(250) path '$.rule.per_fare',
              rule_priority number(20,2) path '$.rule.rule_priority',
              rule_status VARCHAR2(10) path '$.rule.rule_status',
              NESTED PATH '$.rule.conditions[*]' COLUMNS (
                condition_id number(20,2) path '$.condition_id',
                condition_status VARCHAR2(10) path '$.condition_status',
                template_type_id number(20,2) path '$.template_type_id',
                template_type_name VARCHAR2(250) path '$.template_type_name',
                template_value VARCHAR2(250) path '$.template_value'
              )          
            --)
        ))
    )
    loop
--    hdbk.log_api.LOG_ADD(p_proc_name=>'rule_add', p_msg_type=>'1',P_MSG => '1');
      if i.rule_id is not null then raise VALUE_ERROR; end if;
--    hdbk.log_api.LOG_ADD(p_proc_name=>'rule_add', p_msg_type=>'1',P_MSG => '2');
      if v_rule is null then
--    hdbk.log_api.LOG_ADD(p_proc_name=>'rule_add', p_msg_type=>'1',P_MSG => '22');
        v_airline:=hdbk.hdbk_api.airline_get_id(p_iata => i.airline_iata);    
--    hdbk.log_api.LOG_ADD(p_proc_name=>'rule_add', p_msg_type=>'1',P_MSG => i.rule_type||' '||i.markup_type||' '||i.currency);
        v_rule:=ord_api.commission_add( 
                          p_airline => v_airline,
                          p_details => i.rule_description,
                          p_fix => case when i.rule_amount_measure = 'PERCENT' then null else  i.rule_amount end,
                          p_percent => case when i.rule_amount_measure = 'PERCENT' then i.rule_amount else  null end,
                          P_DATE_FROM => to_date(i.rule_life_from,'yyyy-mm-dd')-hdbk.fwdr.utc_offset_mow/24,
                          P_DATE_TO => to_date(i.rule_life_to,'yyyy-mm-dd')-hdbk.fwdr.utc_offset_mow/24,
                          p_priority => i.rule_priority,
                          p_contract_type => i.contract_type_id, --its contract_type of commission (self/interline/code-share)                          
                          p_contract => i.tenant_id,
                          p_min_absolut => i.rule_min_absolute,
                          p_rule_type => hdbk.core.dictionary_get_id(p_dictionary_type=>'RULE_TYPE',p_code=> i.rule_type),
                          p_markup_type => hdbk.core.dictionary_get_id(p_dictionary_type=>'MARKUP_TYPE',p_code=> i.markup_type), 
                          p_per_segment => i.per_segment,
                          p_currency => hdbk.hdbk_api.currency_get_id(i.currency),
                          p_per_fare => i.per_fare
                          );
      end if;
--    hdbk.log_api.LOG_ADD(p_proc_name=>'rule_add', p_msg_type=>'1',P_MSG => '3');
      
      if i.template_type_id <> 0 and v_rule is not null then
--    hdbk.log_api.LOG_ADD(p_proc_name=>'rule_add', p_msg_type=>'1',P_MSG => '4');
        v_commission_details:=ord_api.commission_details_add( 
                                    p_commission => v_rule,
                                    p_commission_template => i.template_type_id,
                                    p_value => i.template_value               
                          );
      end if;
--    hdbk.log_api.LOG_ADD(p_proc_name=>'rule_add', p_msg_type=>'1',P_MSG => '5');
      
    end loop;
--    hdbk.log_api.LOG_ADD(p_proc_name=>'rule_add', p_msg_type=>'1',P_MSG => '6');
    
    commit;
      open v_results for
        select 'SUCCESS' res, v_rule id from dual;
      return v_results;
  exception 
    when NO_DATA_FOUND then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'rule_add', p_msg_type=>'VALUE_ERROR');

      open v_results for
        select 'VALUE_ERROR' res from dual;
      return v_results;
    when VALUE_ERROR then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'rule_add', p_msg_type=>'VALUE_ERROR');

      open v_results for
        select 'VALUE_ERROR' res from dual;
      return v_results;
    when others then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'rule_add', p_msg_type=>'UNHANDLED_ERROR');      

      open v_results for
        select 'ERROR' res from dual;
      return v_results;
  end;


  function rule_edit(p_data in hdbk.dtype.t_clob)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_id hdbk.dtype.t_id; 
    v_airline hdbk.dtype.t_id; 
    v_pos_rule hdbk.dtype.t_id; 

--    r_airline hdbk.airline%rowtype;
    v_commission hdbk.dtype.t_id:=null;
    v_commission_details hdbk.dtype.t_id:=null;
  begin
    hdbk.log_api.LOG_ADD(p_proc_name=>'rule_edit', p_msg_type=>'OK',P_MSG => p_data);

--    if p_tenant_id is null then raise VALUE_ERROR; end if;
         
  
    for i in (
        select *
        from 
        json_table (p_data,'$' columns(
              rule_id number(20,2) path '$.rule_id',
              --rule_type VARCHAR2(250) path '$.rule_type',
              --markup_type VARCHAR2(250) path '$.markup_type',
              rule_description VARCHAR2(250) path '$.rule_description',
              rule_life_from VARCHAR2(250) path '$.rule_life_from',
              rule_life_to VARCHAR2(250) path '$.rule_life_to',
              rule_amount number(20,2) path '$.rule_amount',
              rule_amount_measure VARCHAR2(250) path '$.rule_amount_measure',
              rule_min_absolute number(20,2) path '$.rule_min_absolute',
              currency  varchar2(250) path '$.currency',
              per_segment  VARCHAR2(250) path '$.per_segment',
              per_fare  VARCHAR2(250) path '$.per_fare',
              rule_priority number(20,2) path '$.rule_priority',
           --   rule_status VARCHAR2(10) path '$.rule_status',
              NESTED PATH '$.conditions[*]' COLUMNS (
                condition_id number(20,2) path '$.condition_id',
                condition_status VARCHAR2(10) path '$.condition_status',
                template_type_id number(20,2) path '$.template_type_id',
           --     template_type_name VARCHAR2(250) path '$.template_type_name',
                template_value VARCHAR2(250) path '$.template_value'
              )          
        ))
    )
    loop
      if i.rule_id is null then raise VALUE_ERROR; end if;

---      v_airline:=hdbk.hdbk_api.airline_get_id(p_iata => p_iata);    

      ord_api.commission_edit( 
                        p_id => i.rule_id,
                        --p_airline => v_airline,
                        p_details => i.rule_description,
                        p_fix => case when i.rule_amount_measure = 'PERCENT' then null else  i.rule_amount end,
                        p_percent => case when i.rule_amount_measure = 'PERCENT' then i.rule_amount else  null end,
                        P_DATE_FROM => to_date(i.rule_life_from,'yyyy-mm-dd')-hdbk.fwdr.utc_offset_mow/24,
                        P_DATE_TO => to_date(i.rule_life_to,'yyyy-mm-dd')-hdbk.fwdr.utc_offset_mow/24,
                        p_priority => i.rule_priority,
                        --p_contract_type => i.contract_type_id,  --its contract_type of commission (self/interline/code-share)                          
                        --p_status => i.rule_status,
                        --p_contract => p_tenant_id,
                        p_min_absolut => i.rule_min_absolute,
                        p_per_segment => i.per_segment,
                        p_currency => hdbk.hdbk_api.currency_get_id(i.currency),
                        p_per_fare => i.per_fare
                        
                        );

      if i.condition_id is null and i.template_type_id <> 0 then
        v_commission_details:=ord_api.commission_details_add( 
                                    p_commission => i.rule_id,
                                    p_commission_template => i.template_type_id,
                                    p_value => i.template_value               
                          );

                                  
      elsif i.condition_id is not null and i.template_type_id <> 0 then
        ord_api.commission_details_edit( p_id => i.condition_id,
                                    p_commission => i.rule_id,
                                    p_commission_template => i.template_type_id,
                                    p_value => i.template_value,
                                    p_status => i.condition_status
                          );
      end if;
      
    end loop;
    
    commit;
      open v_results for
        select 'SUCCESS' res from dual;
      return v_results;
  exception 
    when NO_DATA_FOUND then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'rule_edit', p_msg_type=>'NO_DATA_FOUND');

      open v_results for
        select 'NO_DATA_FOUND' res from dual;
      return v_results;
    when VALUE_ERROR then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'rule_edit', p_msg_type=>'VALUE_ERROR');

      open v_results for
        select 'VALUE_ERROR' res from dual;
      return v_results;
    when others then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'rule_edit', p_msg_type=>'UNHANDLED_ERROR');      

      open v_results for
        select 'ERROR' res from dual;
      return v_results;
  end;

  function rule_manage_back(p_iata in hdbk.dtype.t_code, p_tenant_id in hdbk.dtype.t_id, p_data in hdbk.dtype.t_clob)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_id hdbk.dtype.t_id; 
    v_airline hdbk.dtype.t_id; 
    v_pos_rule hdbk.dtype.t_id; 

--    r_airline hdbk.airline%rowtype;
    v_commission hdbk.dtype.t_id:=null;
    v_commission_details hdbk.dtype.t_id:=null;
  begin
    hdbk.log_api.LOG_ADD(p_proc_name=>'rule_manage', p_msg_type=>'OK',P_MSG => p_data);

    if p_tenant_id is null then raise VALUE_ERROR; end if;
         
    v_airline:=hdbk.hdbk_api.airline_get_id(p_iata => p_iata);    
  
    for i in (
        select *
        from 
        json_table (p_data,'$' columns(
            contract_type_id number(20,2) path '$.contract_type_id',
    --        contract_type VARCHAR2(250) path '$.contract_type',
            NESTED PATH '$.rules[*]' COLUMNS (
              rule_id number(20,2) path '$.rule_id',
              rule_type VARCHAR2(250) path '$.rule_type',
              markup_type VARCHAR2(250) path '$.markup_type',
              rule_description VARCHAR2(250) path '$.rule_description',
              rule_life_from VARCHAR2(250) path '$.rule_life_from',
              rule_life_to VARCHAR2(250) path '$.rule_life_to',
              rule_amount number(20,2) path '$.rule_amount',
              rule_amount_measure VARCHAR2(250) path '$.rule_amount_measure',
              rule_min_absolute number(20,2) path '$.rule_min_absolute',
              currency  varchar2(250) path '$.currency',
              per_segment  VARCHAR2(250) path '$.per_segment',
              per_fare  VARCHAR2(250) path '$.per_fare',
              rule_priority number(20,2) path '$.rule_priority',
              rule_status VARCHAR2(10) path '$.rule_status',
              NESTED PATH '$.conditions[*]' COLUMNS (
                condition_id number(20,2) path '$.condition_id',
                condition_status VARCHAR2(10) path '$.condition_status',
                template_type_id number(20,2) path '$.template_type_id',
                template_type_name VARCHAR2(250) path '$.template_type_name',
                template_value VARCHAR2(250) path '$.template_value'
              )          
            )
        ))
    )
    loop
      if i.rule_id is not null then v_commission:= i.rule_id; end if;

      if v_commission is null then
        v_commission:=ord_api.commission_add( 
                          p_airline => v_airline,
                          p_details => i.rule_description,
                          p_fix => case when i.rule_amount_measure = 'PERCENT' then null else  i.rule_amount end,
                          p_percent => case when i.rule_amount_measure = 'PERCENT' then i.rule_amount else  null end,
                          P_DATE_FROM => to_date(i.rule_life_from,'yyyy-mm-dd')-hdbk.fwdr.utc_offset_mow/24,
                          P_DATE_TO => to_date(i.rule_life_to,'yyyy-mm-dd')-hdbk.fwdr.utc_offset_mow/24,
                          p_priority => i.rule_priority,
                          p_contract_type => i.contract_type_id, --its contract_type of commission (self/interline/code-share)                          
                          p_contract => p_tenant_id,
                          p_min_absolut => i.rule_min_absolute,
                          p_rule_type => hdbk.core.dictionary_get_id(p_dictionary_type=>'RULE_TYPE',p_code=> i.rule_type), 
                          p_markup_type => hdbk.core.dictionary_get_id(p_dictionary_type=>'MARKUP_TYPE',p_code=> i.markup_type),
                          p_per_segment => i.per_segment,
                          p_currency => hdbk.hdbk_api.currency_get_id(i.currency),
                          p_per_fare => i.per_fare
                          );

                                  
      else
        ord_api.commission_edit( 
                          p_id => v_commission,
                          p_airline => v_airline,
                          p_details => i.rule_description,
                          p_fix => case when i.rule_amount_measure = 'PERCENT' then null else  i.rule_amount end,
                          p_percent => case when i.rule_amount_measure = 'PERCENT' then i.rule_amount else  null end,
                          P_DATE_FROM => to_date(i.rule_life_from,'yyyy-mm-dd')-hdbk.fwdr.utc_offset_mow/24,
                          P_DATE_TO => to_date(i.rule_life_to,'yyyy-mm-dd')-hdbk.fwdr.utc_offset_mow/24,
                          p_priority => i.rule_priority,
                          p_contract_type => i.contract_type_id,  --its contract_type of commission (self/interline/code-share)                          
                          p_status => i.rule_status,
                          p_contract => p_tenant_id,
                          p_min_absolut => i.rule_min_absolute,
                          p_rule_type => hdbk.core.dictionary_get_id(p_dictionary_type=>'RULE_TYPE',p_code=> i.rule_type), 
                          p_markup_type => hdbk.core.dictionary_get_id(p_dictionary_type=>'MARKUP_TYPE',p_code=> i.markup_type),
                          p_per_segment => i.per_segment,
                          p_currency => hdbk.hdbk_api.currency_get_id(i.currency),
                          p_per_fare => i.per_fare
                          
                          );
      end if;

      if i.condition_id is null and i.template_type_id <> 0 then
        v_commission_details:=ord_api.commission_details_add( 
                                    p_commission => v_commission,
                                    p_commission_template => i.template_type_id,
                                    p_value => i.template_value               
                          );

                                  
      elsif i.condition_id is not null and i.template_type_id <> 0 then
        ord_api.commission_details_edit( p_id => i.condition_id,
                                    p_commission => v_commission,
                                    p_commission_template => i.template_type_id,
                                    p_value => i.template_value,
                                    p_status => nvl(i.condition_status,i.rule_status)
                          );
      end if;
      
    end loop;
    
    commit;
      open v_results for
        select 'SUCCESS' res from dual;
      return v_results;
  exception 
    when NO_DATA_FOUND then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'rule_manage', p_msg_type=>'NO_DATA_FOUND');

      open v_results for
        select 'NO_DATA_FOUND' res from dual;
      return v_results;
    when VALUE_ERROR then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'rule_manage', p_msg_type=>'VALUE_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '||  sys.DBMS_UTILITY.format_call_stack);

      open v_results for
        select 'ERROR' res from dual;
      return v_results;
    when others then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'rule_manage', p_msg_type=>'UNHANDLED_ERROR');      

      open v_results for
        select 'ERROR' res from dual;
      return v_results;
  end;


  function rule_delete(p_rule_id in hdbk.dtype.t_id)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_id hdbk.dtype.t_id; 
    v_airline hdbk.dtype.t_id; 
    v_pos_rule hdbk.dtype.t_id; 
--    r_usr pos_rule%rowtype;
--    r_airline hdbk.airline%rowtype;
    v_commission hdbk.dtype.t_id:=null;
    v_commission_details hdbk.dtype.t_id:=null;
  begin
    
    ord_api.commission_edit( 
                      p_id => p_rule_id,
                      p_status => 'D'
                      );
    for i in (select id from ord.commission_details where amnd_state = 'A' and commission_oid = p_rule_id)
    loop    
      ord_api.commission_details_edit( 
                        p_id => i.id,
                        p_status => 'D'
                        );
    end loop;                  
    commit;
      open v_results for
        select 'SUCCESS' res from dual;
      return v_results;
  exception 
    when NO_DATA_FOUND then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'rule_delete', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '||  sys.DBMS_UTILITY.format_call_stack);

      open v_results for
        select 'NO_DATA_FOUND' res from dual;
      return v_results;
    when others then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'rule_delete', p_msg_type=>'UNHANDLED_ERROR');      

      open v_results for
        select 'ERROR' res from dual;
      return v_results;
  end;


  function rule_template_list(p_is_contract_type in hdbk.dtype.t_status default null,
                              p_is_markup_type in hdbk.dtype.t_status default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin
    if p_is_contract_type = 'Y' then  
      OPEN v_results FOR
          select id, name from 
          (SELECT
--          decode(ID,1,null,id) id, TEMPLATE_TYPE, PRIORITY, DETAILS, IS_CONTRACT_TYPE, NAME, NLS_NAME, IS_VALUE
          id, NLS_NAME name,priority
          from ord.commission_template 
          where /*id = nvl(p_id,id)
          and*/ amnd_state = 'A'
          and is_contract_type = 'Y'
          union all
          select 
          0 id, name, 0 priority from
          hdbk.dictionary where code = 'DEFAULT'   )
          order by priority;
    elsif p_is_markup_type = 'Y' then
      OPEN v_results FOR
          SELECT
          id, code name
          from hdbk.dictionary 
          where dictionary_type = 'MARKUP_TYPE'
          and amnd_state = 'A'
          order by id;
    else
      OPEN v_results FOR
          SELECT
--          decode(ID,1,null,id) id, TEMPLATE_TYPE, PRIORITY, DETAILS, IS_CONTRACT_TYPE, NAME, NLS_NAME, IS_VALUE
          id, NLS_NAME name
          from ord.commission_template 
          where /*id = nvl(p_id,id)
          and*/ amnd_state = 'A'
          and id in (24,25,26,27,28)
          and is_contract_type = 'N'
          --order by id
          union all
          select 
          0 id, name from
          hdbk.dictionary where code = 'DEFAULT'   
          order by id;
    end if;    

    return v_results;
  exception when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'commission_template_get', p_msg_type=>'UNHANDLED_ERROR');      
      RAISE_APPLICATION_ERROR(-20002,'select row into commission_template_get error. '||SQLERRM);
    return null;  
  end;

/*  function bill_import_list
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin
    OPEN v_results FOR
      select
      bill.id bill_oid,
      'fare' item,
      (select decode(code,'РФ','Y','N') from hdbk.geo where amnd_state = 'A' and id = (select country_id from hdbk.geo where iata = 'MOW' and amnd_state = 'A')) is_nds,
      'MOW' flight_from,
      'LON' flight_to,
      ticket.fare_amount,
      contract.contract_number,
      ticket.passenger_name
      from ord.ticket,
      ord.item_avia,
      ord.bill,
      blng.contract
      where bill.order_oid = item_avia.order_oid
      and ticket.item_avia_oid = item_avia.id
      and ticket.amnd_state = 'A'
      and item_avia.amnd_state = 'A'
      and bill.amnd_state = 'A'
      and contract.amnd_state = 'A'
      and bill.contract_oid = contract.id
      
      union all
      
      select
      bill.id bill_oid,
      'fee' item,
      (select decode(code,'РФ','Y','N') from hdbk.geo where amnd_state = 'A' and id = (select country_id from hdbk.geo where iata = 'MOW' and amnd_state = 'A')) is_nds,
      'MOW' flight_from,
      'LON' flight_to,
      ticket.service_fee_amount + nvl(ticket.partner_fee_amount,0),
      contract.contract_number,
      ticket.passenger_name
      from ord.ticket,
      ord.item_avia,
      ord.bill,
      blng.contract
      where bill.order_oid = item_avia.order_oid
      and ticket.item_avia_oid = item_avia.id
      and ticket.amnd_state = 'A'
      and item_avia.amnd_state = 'A'
      and bill.amnd_state = 'A'
      and contract.amnd_state = 'A'
      and bill.contract_oid = contract.id
      order by 1,2  desc;

    return v_results;
  exception when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'bill_import_list', p_msg_type=>'UNHANDLED_ERROR');      
      RAISE_APPLICATION_ERROR(-20002,'select row error. '||SQLERRM);
    return null;  
  end;
*/

  function markup_rule_get(p_version in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin
/*      hdbk.log_api.LOG_ADD(p_proc_name=>'markup_rule_get', p_msg_type=>'OK');*/      
    OPEN v_results FOR
      select 
      cmn.id,
      case 
      when cmn.amnd_state <> 'A' then 'N'
      when cmn.date_to is not null and cmn.date_to < sysdate then 'N'
      else 'Y'
      end is_active,
      /*max(case
      when cmn.date_from is null and cmn.date_to is null then to_char(cmn.amnd_date,'yyyymmddhh24')*1
      when cmn.amnd_state <> 'A' then to_char(cmn.amnd_date,'yyyymmddhh24')*1
      when cmn.date_from is not null and cmn.date_to is null then to_char(greatest(cmn.amnd_date,cmn.date_from),'yyyymmddhh24')*1
      when cmn.date_from is null and cmn.date_to is not null then to_char(least(cmn.amnd_date,cmn.date_to),'yyyymmddhh24')*1
      else to_char(greatest(cmn.amnd_date,cmn.date_from),'yyyymmddhh24')*1
      end) over () version,*/
      to_char(sysdate,'yymmddhh24mi')*1 version,
      nvl(cmn.contract_oid,0) tenant_id,
      nvl(al.IATA,'YY') iata,
      nvl(hdbk.core.dictionary_get_code(cmn.markup_type),'ERROR') markup_type,
      -------------------------------
      nvl(nvl(cmn.percent,cmn.fix),0) rule_amount,
      case 
      when cmn.percent is not null then 'PERCENT'
      when cmn.fix is not null then 'RUB'
      else 'ERROR'
      end rule_amount_measure,
      nvl(min_absolut,0) min_absolut,
      nvl(cmn.priority,0) priority,
      nvl(cmn.per_segment,'N') per_segment,
      nvl(cmn.per_fare,'N') per_fare,
      nvl(upper((select name from 
      ORD.commission_template 
      where id = cmn.contract_type)),'DEFAULT') contract_type,
      (select count(*) from ord.commission_details where commission_oid = cmn.id and amnd_state = 'A') condition_count
      from 
      ord.commission cmn ,
      hdbk.airline al
      where
      al.amnd_state = 'A'
      and al.IATA is not null
      and cmn.amnd_state in ( 'A','C')
      and cmn.airline = al.id
      and cmn.rule_type = 5
      and cmn.id in 
            (select
            amnd_prev
            from ord.commission 
            where (date_from is not null or date_to is not null )
            --and amnd_state = 'A'
            and nvl(date_to+5 /*$TODO*/ ,sysdate+1) >= sysdate -- filter very old rules
            and nvl(date_from,sysdate-1) <= trunc(sysdate,'hh24') -- filter not active new
            and rule_type = 5 --in (1,2,3)
            union all 
            select id from  ord.commission where date_from is null and date_to is null 
            and ((amnd_date >= to_date(p_version,'yymmddhh24mi') and amnd_state <>'I' and p_version <>0 and p_version is not null) 
              or (amnd_state ='A' and (p_version =0 or p_version is null)))  
            and rule_type = 5
            union all 
            select commission_details.commission_oid 
              from  ord.commission_details, ord.commission 
              where commission_details.amnd_date >= to_date(p_version,'yymmddhh24mi') and commission_details.amnd_state <>'I' and p_version <>0 and p_version is not null
              and commission_details.commission_oid = commission.id and  commission.date_from is null and commission.date_to is null 
              and rule_type = 5
            )
      ;      
    return v_results;
  exception when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'markup_rule_get', p_msg_type=>'UNHANDLED_ERROR');      
      RAISE_APPLICATION_ERROR(-20002,'select row error. '||SQLERRM);
--    return null;  
  end;


  function markup_templ_get(p_rule_id in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin
    OPEN v_results FOR

      select 
      cmn.id,
      nvl(dtl.template_type_code,'DEFAULT') template_type_code,
      dtl.template_value
      from 
      ord.commission cmn ,
      hdbk.airline al ,
      (
        select 
        cd.commission_oid ,
        ct.id template_type_oid, 
        ct.nls_name template_type,
        ct.name template_type_code,
        ct.is_value,
        cd.id condition_oid,
        cd.value template_value
        from 
        ord.commission_details  cd,
        ORD.commission_template ct
        where cd.amnd_state = 'A'
        and ct.amnd_state = 'A'
        and cd.commission_template_oid = ct.id        
      ) dtl        
      where
      al.amnd_state = 'A'
      and cmn.amnd_state = 'A'
      and cmn.airline = al.id
      and cmn.id = dtl.commission_oid
      and cmn.id = p_rule_id 
      ;


    return v_results;
  exception when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'markup_templ_get', p_msg_type=>'UNHANDLED_ERROR');      
      RAISE_APPLICATION_ERROR(-20002,'select row error. '||SQLERRM);
    return null;  
  end;

  procedure check_request(  p_contract in hdbk.dtype.t_id default null,
--                            p_email in hdbk.dtype.t_long_code default null,
                            p_pnr_id in hdbk.dtype.t_long_code default null
                            )
  is
    r_item_avia item_avia%rowtype;
    r_order ord%rowtype;
    r_item_avia_status item_avia_status%rowtype;
    v_order_r ord%rowtype;
    v_bill hdbk.dtype.t_id;
    r_usr blng.usr%rowtype;    
    c_bill  SYS_REFCURSOR;
    r_bill bill%rowtype;
  begin
    begin 
      if p_pnr_id is null then raise NO_DATA_FOUND; end if;
-- check that item with this pnr_id exists
      r_item_avia := ord_api.item_avia_get_info_r(p_pnr_id=>p_pnr_id);
    exception 
      when NO_DATA_FOUND then 
        hdbk.log_api.LOG_ADD(p_proc_name=>'check_request', p_msg_type=>'NO_DATA_FOUND');
        RAISE_APPLICATION_ERROR(-20002,'p_pnr_id does not found.');
    end;

    begin 
-- check that user with this user_id exist
      if p_contract is null then raise NO_DATA_FOUND; end if;
      r_order := ord_api.ord_get_info_r(p_id=>r_item_avia.order_oid);
/* 
$TODO: there must be check for users with ISSUES permission
*/
      r_usr := blng.blng_api.usr_get_info_r(p_id=>r_order.user_oid);
      if blng.core.pay_contract_by_user(r_usr.id)!=p_contract then raise NO_DATA_FOUND; end if;

    exception when NO_DATA_FOUND then
      hdbk.log_api.LOG_ADD(p_proc_name=>'check_request', p_msg_type=>'NO_DATA_FOUND');
      RAISE_APPLICATION_ERROR(-20002,'user_id not found. ');
    end;
    
  exception when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'check_request', p_msg_type=>'UNHANDLED_ERROR');      
      RAISE_APPLICATION_ERROR(-20002,'select row error. '||SQLERRM);
  end;


  procedure check_request(  p_email in hdbk.dtype.t_long_code default null,
                            p_pnr_id in hdbk.dtype.t_long_code default null,
                            p_is_create in hdbk.dtype.t_status default 'N'
                            )
  is
    r_item_avia item_avia%rowtype;
    r_item_avia_status item_avia_status%rowtype;
    r_order ord%rowtype;
    v_order_r ord%rowtype;
    v_bill hdbk.dtype.t_id;
    r_usr blng.usr%rowtype;    
    c_bill  SYS_REFCURSOR;
    r_bill bill%rowtype;
  begin
    begin 
-- check that cliemt with this user_id exist
      if p_email is null then raise NO_DATA_FOUND; end if;
      if p_email = hdbk.core.dictionary_get_name_by_code(p_dictionary_type=>'CONSTANT',p_code=>'GOD') then raise NOT_LOGGED_ON; end if;
      
      r_usr := blng.blng_api.usr_get_info_r(p_email=>p_email);
    exception 
      when NO_DATA_FOUND then
        hdbk.log_api.LOG_ADD(p_proc_name=>'check_request', p_msg_type=>'NO_DATA_FOUND');
        RAISE_APPLICATION_ERROR(-20002,'user_id not found. ');
      when NOT_LOGGED_ON then
        hdbk.log_api.LOG_ADD(p_proc_name=>'check_request', p_msg_type=>'NOT_LOGGED_ON');
        RAISE_APPLICATION_ERROR(-20002,'permission denied');
    end;

    if p_is_create = 'Y' then 
    -- this is call from avia_create
      begin 
        -- check that item with this pnr_id does not exist
        if p_pnr_id is null then raise VALUE_ERROR; end if;
  
        r_item_avia := ord_api.item_avia_get_info_r(p_pnr_id=>p_pnr_id);
        if r_item_avia.id is not null then 
          RAISE_APPLICATION_ERROR(-20002,'this item already exists.');       
        end if;
      exception 
        when NO_DATA_FOUND then 
        -- its ok. else is not ok      
          null;
        when VALUE_ERROR then 
        -- its not ok      
          hdbk.log_api.LOG_ADD(p_proc_name=>'check_request', p_msg_type=>'VALUE_ERROR');
          RAISE_APPLICATION_ERROR(-20002,'check_request error. p_pnr_id is null');
      end;
    else  
    -- this is call from other functions when pnr is exist
      begin 
  -- check that user with this user_id exists
        if p_pnr_id is null then raise NO_DATA_FOUND; end if;
        
        r_item_avia := ord_api.item_avia_get_info_r(p_pnr_id=>p_pnr_id);
  --     if r_item_avia.order_oid is null then raise NO_DATA_FOUND; end if;
        
      exception when NO_DATA_FOUND then
        hdbk.log_api.LOG_ADD(p_proc_name=>'avia_booked', p_msg_type=>'NO_DATA_FOUND');
        RAISE_APPLICATION_ERROR(-20002,'check_request error. pnr_id not found. ');
      end;
    end if;
      
  exception when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'check_request', p_msg_type=>'UNHANDLED_ERROR');      
      RAISE_APPLICATION_ERROR(-20002,'select row error. '||SQLERRM);
  end;



  function task_get
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_task hdbk.dtype.t_id;
    v_type_id hdbk.dtype.t_id;
    v_type hdbk.dtype.t_long_code;
    r_dictionary hdbk.dictionary%rowtype;
    r_task1c task1c%rowtype;
  begin

      select 
      id into v_task from
      ord.task1c
      where amnd_state = 'A' 
      and (status in ('A') 
      or (status in ('W') and amnd_date < sysdate - to_number(hdbk.core.dictionary_get_name_by_code(p_dictionary_type=>'1C',p_code=>'TASK_INTERVAL')/24/60/60))
      )
      --and task_type = hdbk.core.dictionary_get_id(p_dictionary_type=>'1C',p_code=>'BILL_ADD')
      order by id
      FETCH FIRST 1 ROWS ONLY;
      
      r_task1c := ord_api.task1c_get_info_r(p_id => v_task );

      v_type:= hdbk.core.dictionary_get_code(p_id=>r_task1c.task_type);
      
      if v_type = 'BILL_ADD' then 
  
        OPEN v_results FOR
          select 
          email,
          task_id,
          'BILL' task_type,
          contract_id,
          PRODUCT,
          description,
          quantity,
          price,
          vat,
          to_char((min(date_to) over()),'yyyy-mm-dd') date_to
          from
            (select 
            1 rn,
            bill.id bill_oid,
            ticket.id ticket_oid,
            (select email from blng.usr where id = (select user_oid from ord.ord where id = item_avia.order_oid)) email,
             bill2task.task_oid task_id,
             bill.contract_oid  contract_id,
            hdbk.core.dictionary_get_code(bill.vat_type_oid)  PRODUCT, 
      --      'Авиабилет (электронный билет), пассажир ' || ticket.passenger_name description, 
            'Авиабилет (электронный билет) по маршруту '||
            (SELECT LISTAGG(
            (select nls_name from hdbk.geo where geo.id = leg.departure_city )||' - '||(select nls_name from hdbk.geo where geo.id = leg.arrival_city )
            ||' ('||to_char(departure_date,'dd.mm.yyyy') ||')'
            , ', ') WITHIN GROUP (ORDER BY id) AS description
               FROM ord.leg
               where itinerary_oid = (select id from ord.itinerary where itinerary.amnd_state = 'A' and itinerary.item_avia_oid = item_avia.id)
               group by itinerary_oid)
            ||', перевозчик '|| (select nls_name||' ('||iata||')' from hdbk.airline where id = (select validating_carrier from ord.itinerary where amnd_state = 'A' and item_avia_oid = item_avia.id))
            ||', пассажир '|| ticket.passenger_name description, 
            1 quantity, 
            nvl(ticket.fare_amount,0) + nvl(ticket.taxes_amount,0) price, 
            to_number(hdbk.core.dictionary_get_name(bill.vat_type_oid)) vat,
            trunc(nvl((select date_to -1 from blng.v_delay where bill_id = bill.id),sysdate)) date_to
             from
            ord.bill2task, ord.bill, ord.item_avia, ord.ticket
            where bill2task.amnd_state = 'A' 
            and item_avia.amnd_state = 'A' 
            and ticket.amnd_state = 'A' 
            and bill.amnd_state = 'A' 
            and bill2task.bill_oid = bill.id
            and bill.order_oid = item_avia.order_oid
            and item_avia.id = ticket.item_avia_oid
            and bill2task.task_oid = v_task
            and (ticket.fare_amount is not null or ticket.taxes_amount is not null)
            and nvl(ticket.fare_amount,0) + nvl(ticket.taxes_amount,0) <> 0
      union all
            select 
            2 rn,
            bill.id bill_oid,
            ticket.id ticket_oid,
            (select email from blng.usr where id = (select user_oid from ord.ord where id = item_avia.order_oid)) email,
             bill2task.task_oid task_id,
             bill.contract_oid  contract_id,
            'SERVICE_FEE'  PRODUCT, 
            'Сервисный сбор'  description, 
            1 quantity, 
            nvl(ticket.service_fee_amount,0) price, 
            18 vat,
            trunc(nvl((select date_to -1 from blng.v_delay where bill_id = bill.id),sysdate)) date_to
             from
            ord.bill2task, ord.bill, ord.item_avia, ord.ticket
            where bill2task.amnd_state = 'A' 
            and item_avia.amnd_state = 'A' 
            and ticket.amnd_state = 'A' 
            and bill.amnd_state = 'A' 
            and bill2task.bill_oid = bill.id
            and bill.order_oid = item_avia.order_oid
            and item_avia.id = ticket.item_avia_oid
            and bill2task.task_oid = v_task
            and ticket.service_fee_amount is not null
            and ticket.service_fee_amount <> 0
            )       
            order by bill_oid, ticket_oid, rn
          ;    

      ord_api.task1c_edit(p_id=>v_task, p_status=>'W');

    elsif v_type = 'AVIA_ETICKET' then     

      OPEN v_results FOR
        select 
        v_task task_id,
        'ETICKET' task_type,  pnr_id, pnr_locator order_number,
        (select email from blng.usr where id = (select user_oid from ord.ord where id = item_avia.order_oid)) email,
        (select nls_name from hdbk.geo where id = (select departure_city from ord.leg where itinerary_oid = itinerary.id and sequence_number = 1 and amnd_state = 'A')) city_from,
        (select nls_name from hdbk.geo where id = (select arrival_city from ord.leg where itinerary_oid = itinerary.id and sequence_number = 1 and amnd_state = 'A')) city_to,
        (select case when count(*) = 1 then 'Y' else 'N' end from ord.leg where itinerary_oid = itinerary.id and amnd_state = 'A') IS_ONE_LEG

        
        
        from ord.item_avia, ord.itinerary where 
        item_avia.id = itinerary.item_avia_oid
        and item_avia.amnd_state = 'A'
        and itinerary.amnd_state = 'A'
        and item_avia.id =  
              (select item_avia from
                json_table  
                  ( r_task1c.request ,'$' 
                  columns (item_avia number(18,0) path '$.item_avia'
                          )
                  ) as j);
          
      ord_api.task1c_edit(p_id=>v_task, p_status=>'W');
      
    elsif v_type = '1C_FIN_ACTS' then     

      OPEN v_results FOR
        select 
        v_task task_id,
        'FIN_ACTS' task_type,
        (select email from blng.usr where id = (select user_oid from ord.ord where id = item_avia.order_oid)) email,
        task1c.number_1c bill_number
        from ord.task1c,
        ord.bill2task, ord.bill, ord.item_avia,
        json_table  
                        ( r_task1c.request ,'$' 
                        columns (bill_1c varchar2(255) path '$.bill_1c'
                                )
                        ) as j
        where task1c.amnd_state <> 'I'
        and bill2task.task_oid = task1c.id
        and bill.id = bill2task.bill_oid
        and bill.order_oid = item_avia.order_oid
        and item_avia.amnd_state = 'A'
        and task1c.number_1c = j.bill_1c
        ;
          
      ord_api.task1c_edit(p_id=>v_task, p_status=>'W');
          
    elsif v_type = 'BILL_DEPOSIT' then     

      OPEN v_results FOR
        select 
          j.email email,
          'BILL_DEPOSIT' task_type,
          r_task1c.id task_id,
          contract.id  contract_id,
          'DEPOSIT'  PRODUCT, 
          'Пополнение счета по договору №'||contract.contract_number description, 
          1 quantity, 
          nvl(j.amount,0) price, 
          '0' vat
        from blng.contract,
        json_table  
                        ( r_task1c.request ,'$' 
                        columns (contract number(18,0) path '$.contract',
                                  amount number(20,2) path '$.amount',
                                  email VARCHAR2(255) path '$.email'
                                )
                        ) as j
        where contract.id = j.contract
        --and contract.amnd_state = 'A'
        
        ;
          
      ord_api.task1c_edit(p_id=>v_task, p_status=>'W');
          
          
          
    end if;

    COMMIT;
 
  
    return v_results;
  exception 
    when VALUE_ERROR then 
      hdbk.log_api.LOG_ADD(p_proc_name=>'task_get', p_msg_type=>'VALUE_ERROR');      
        open v_results for
          select 'ERROR' res from dual;
        return v_results;
    when NO_DATA_FOUND then      
        open v_results for
          select 'NO_DATA_FOUND' res from dual;
        return v_results;
    when others then
      rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'task_get', p_msg_type=>'UNHANDLED_ERROR');      
        open v_results for
          select 'ERROR' res from dual;
        return v_results;
  end;


  function task_close(p_task in hdbk.dtype.t_id default null,
                      p_number_1c in hdbk.dtype.t_long_code default null,
                      p_data in hdbk.dtype.t_clob default null
                      )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_task hdbk.dtype.t_id;
    v_type hdbk.dtype.t_long_code;
    v_number_1c hdbk.dtype.t_long_code;
    r_dictionary hdbk.dictionary%rowtype;
    r_task1c task1c%rowtype;    
  begin

    r_task1c := ord_api.task1c_get_info_r(p_id => p_task );


      v_type:= hdbk.core.dictionary_get_code(p_id=>r_task1c.task_type);
      
      if v_type in ('BILL_ADD','BILL_DEPOSIT') then 
        if p_data is null then raise VALUE_ERROR; end if;
        select number_1c into v_number_1c from
                        json_table  
                          ( p_data ,'$' 
                          columns (number_1c varchar2(255) path '$.number_1c'
                                  )
                          ) ;
        if v_number_1c is null then raise VALUE_ERROR; end if;                    
      end if;

    ord_api.task1c_edit(p_id=>p_task,p_number_1c=>v_number_1c, p_status=>'C');
    COMMIT;
    
    open v_results for
      select 'SUCCESS' res from dual;
    return v_results;
  exception 
    when VALUE_ERROR then 
      hdbk.log_api.LOG_ADD(p_proc_name=>'task_close', p_msg_type=>'VALUE_ERROR');      
        open v_results for
          select 'ERROR' res from dual;
        return v_results;
    when NO_DATA_FOUND then 
      hdbk.log_api.LOG_ADD(p_proc_name=>'task_close', p_msg_type=>'NO_DATA_FOUND');      
        open v_results for
          select 'ERROR' res from dual;
        return v_results;
    when others then
      rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'task_close', p_msg_type=>'UNHANDLED_ERROR');      
        open v_results for
          select 'ERROR' res from dual;
        return v_results;
  end;




  function bill_1c_payed(p_number_1c in hdbk.dtype.t_long_code default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_task1c hdbk.dtype.t_id;
    v_request hdbk.dtype.t_clob;
  begin
      if p_number_1c is null then raise VALUE_ERROR; end if;
      v_request := '{"bill_1c": "'||p_number_1c||'"}';
      v_task1c := ord_api.task1c_add(p_task_type=>hdbk.core.dictionary_get_id(p_dictionary_type=>'TASK',p_code=>'1C_FIN_ACTS'),
                  p_request => v_request );

    COMMIT;
    
    open v_results for
      select 'SUCCESS' res from dual;
    return v_results;
  exception 
    when VALUE_ERROR then 
      hdbk.log_api.LOG_ADD(p_proc_name=>'bill_1c_payed', p_msg_type=>'VALUE_ERROR');      
        open v_results for
          select 'ERROR' res from dual;
        return v_results;
    when NO_DATA_FOUND then 
      hdbk.log_api.LOG_ADD(p_proc_name=>'bill_1c_payed', p_msg_type=>'NO_DATA_FOUND');      
        open v_results for
          select 'ERROR' res from dual;
        return v_results;
    when others then
      rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'bill_1c_payed', p_msg_type=>'UNHANDLED_ERROR');      
        open v_results for
          select 'ERROR' res from dual;
        return v_results;
  end;


  function vat_calc(p_itinerary in hdbk.dtype.t_id default null)
  return hdbk.dtype.t_id
  is
    v_task1c hdbk.dtype.t_id;
    v_request hdbk.dtype.t_clob;
  begin
      if p_itinerary is null then raise VALUE_ERROR; end if;
      
      --- NOT RUSSIA 
      for i in (
        select * from hdbk.geo where id in 
          ( 
          select departure_city from ord.leg where itinerary_oid = p_itinerary
          union
          select arrival_city from ord.leg where itinerary_oid = p_itinerary
          )
        )
      loop
        if i.country_id <> 390 then null; -- NOT RUSSIA VAT = 0
          return hdbk.core.dictionary_get_id(p_dictionary_type=>'1C_PRODUCT_W_VAT',p_code=>'AVIATICKET_VAT_0');
        end if;
      end loop;

      -- RUSSIA - KRYM
      for i in (
        select * from hdbk.geo where id in 
          ( 
          select departure_city from ord.leg where itinerary_oid = p_itinerary
          union
          select arrival_city from ord.leg where itinerary_oid = p_itinerary
          )
        )
      loop
        if i.id in ( 1130,11021,10762,5911,22521,20262) then null; --KRYM  VAT = 0
          return hdbk.core.dictionary_get_id(p_dictionary_type=>'1C_PRODUCT_W_VAT',p_code=>'AVIATICKET_VAT_0');        
        end if;
      end loop;

      -- RUSSIA
      
      if sysdate < to_date('31122017','ddmmyyyy') then null; -- RUSSIA VAT = 10
        return hdbk.core.dictionary_get_id(p_dictionary_type=>'1C_PRODUCT_W_VAT',p_code=>'AVIATICKET_VAT_10');
      else
        return hdbk.core.dictionary_get_id(p_dictionary_type=>'1C_PRODUCT_W_VAT',p_code=>'AVIATICKET_VAT_18');       
      end if;
    
  exception 
    when VALUE_ERROR then 
      hdbk.log_api.LOG_ADD(p_proc_name=>'bill_1c_payed', p_msg_type=>'VALUE_ERROR');      
      raise;
    when NO_DATA_FOUND then 
      hdbk.log_api.LOG_ADD(p_proc_name=>'bill_1c_payed', p_msg_type=>'NO_DATA_FOUND');      
      raise;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'bill_1c_payed', p_msg_type=>'UNHANDLED_ERROR');      
      raise;
  end;
  


  function bill_deposit(p_user_id in hdbk.dtype.t_long_code default null,
                        p_amount in hdbk.dtype.t_amount default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_contract hdbk.dtype.t_id;
    v_task1c hdbk.dtype.t_id;
    v_request hdbk.dtype.t_clob;
    r_user blng.usr%rowtype;
  begin

      if p_user_id is null or p_amount <= 0 then raise VALUE_ERROR; end if;
      
      begin
        r_user := blng.blng_api.usr_get_info_r(p_email=>p_user_id);
        v_contract := blng.core.pay_contract_by_user(r_user.id);
      exception when others then RAISE hdbk.dtype.not_authorized;
      end;
      
      v_request := '{"contract": '||v_contract||', "amount": '||p_amount||', "email": "'||p_user_id||'"}';
      v_task1c := ord_api.task1c_add(p_task_type=>hdbk.core.dictionary_get_id(p_dictionary_type=>'TASK',p_code=>'BILL_DEPOSIT'),
                    p_request => v_request);
    
    COMMIT;
    
    open v_results for
      select 'SUCCESS' res from dual;
    return v_results;
  exception 
    when VALUE_ERROR then 
      hdbk.log_api.LOG_ADD(p_proc_name=>'bill_deposit', p_msg_type=>'VALUE_ERROR');      
        open v_results for
          select 'VALUE_ERROR' res from dual;
        return v_results;
    when hdbk.dtype.not_authorized then 
      hdbk.log_api.LOG_ADD(p_proc_name=>'bill_deposit', p_msg_type=>'NOT_AUTHORIZED');      
        open v_results for
          select 'NOT_AUTHORIZED' res from dual;
        return v_results;
    when NO_DATA_FOUND then 
      hdbk.log_api.LOG_ADD(p_proc_name=>'bill_deposit', p_msg_type=>'NO_DATA_FOUND');      
        open v_results for
          select 'NO_DATA_FOUND' res from dual;
        return v_results;
    when others then
      rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'bill_deposit', p_msg_type=>'UNHANDLED_ERROR');      
        open v_results for
          select 'ERROR' res from dual;
        return v_results;
  end;



  procedure reg_task(
                    p_task in hdbk.dtype.t_long_code default null,
                    p_tenant_id in hdbk.dtype.t_long_code default null,
                    p_user_id in hdbk.dtype.t_long_code default null,
                    p_pnr_id in hdbk.dtype.t_long_code default null,
                    p_data in hdbk.dtype.t_clob default null)
  is
    v_event hdbk.dtype.t_id;
    r_user blng.usr%rowtype;
    r_contract blng.contract%rowtype;
    v_results SYS_REFCURSOR; 
    v_contract hdbk.dtype.t_id;
    v_request hdbk.dtype.t_clob;
  begin

  v_contract:=to_number(p_tenant_id);

      hdbk.log_api.LOG_ADD(p_proc_name=>'reg_task', p_msg_type=>'ok',
      p_msg=>'p_task='||p_task||',p_tenant_id='||p_tenant_id||',p_user_id='||p_user_id||',p_pnr_id='||p_pnr_id||',p_data='||p_data);      
--      if p_user_id is null or p_amount <= 0 then raise VALUE_ERROR; end if;

      r_contract := blng.blng_api.contract_get_info_r(p_id=>v_contract);
      r_user := blng.blng_api.usr_get_info_r(p_email=>p_user_id);

            
      v_event:= ord_api.event_add( 
                    p_task =>p_task,
                    p_contract =>r_contract.id,
                    p_user =>r_user.id,
                    p_pnr_id =>p_pnr_id,
                    p_request =>P_DATA,
                    --p_status =>,
                    p_result => 'INPROGRESS',
                    p_error => null
                    )   ;      

    COMMIT;
    
  exception 
    when VALUE_ERROR then 
      rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'reg_task', p_msg_type=>'VALUE_ERROR');      

    when hdbk.dtype.not_authorized then 
      rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'reg_task', p_msg_type=>'NOT_AUTHORIZED');      

    when NO_DATA_FOUND then 
      rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'reg_task', p_msg_type=>'NO_DATA_FOUND');      

    when others then
      rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'reg_task', p_msg_type=>'UNHANDLED_ERROR');      

  end;



  function reg_task_list(
                    p_tenant_id in hdbk.dtype.t_long_code default null,
                    p_pnr_id in hdbk.dtype.t_long_code default null,
                    p_task in hdbk.dtype.t_long_code default null)
  return SYS_REFCURSOR                    
  is
    v_results SYS_REFCURSOR; 
    v_contract hdbk.dtype.t_id;
    v_task1c hdbk.dtype.t_id;
    v_request hdbk.dtype.t_clob;
    r_user blng.usr%rowtype;
  begin

      hdbk.log_api.LOG_ADD(p_proc_name=>'reg_task_list', p_msg_type=>'ok',
      p_msg=>'p_task='||p_task||',p_tenant_id='||p_tenant_id||',p_pnr_id='||p_pnr_id);      
--      if p_user_id is null or p_amount <= 0 then raise VALUE_ERROR; end if;
      
      open v_results for
        select task,pnr_id,result,error, contract_oid tenant_id from event
        where amnd_state = 'A'
        and status = 'A'
        and contract_oid = nvl(to_number(p_tenant_id),contract_oid)
        and task = nvl(p_task,task)
        and pnr_id = nvl(p_pnr_id,pnr_id);
        
      return v_results;
    
  exception 
    when VALUE_ERROR then 
      hdbk.log_api.LOG_ADD(p_proc_name=>'reg_task_list', p_msg_type=>'VALUE_ERROR');      

    when hdbk.dtype.not_authorized then 
      hdbk.log_api.LOG_ADD(p_proc_name=>'reg_task_list', p_msg_type=>'NOT_AUTHORIZED');      

    when NO_DATA_FOUND then 
      hdbk.log_api.LOG_ADD(p_proc_name=>'reg_task_list', p_msg_type=>'NO_DATA_FOUND');      

    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'reg_task_list', p_msg_type=>'UNHANDLED_ERROR');      

  end;




END FWDR;
/
