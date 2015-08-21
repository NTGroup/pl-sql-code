create or replace package blng.fwdr as
/*
$pkg: BLNG.FWDR
*/

/*
$obj_type: function
$obj_name: get_tenant
$obj_desc: return tenant. tenant is contract identifire. tenant using 
$obj_desc: for checking is user registered in the system.
$obj_param: p_email(t_name): is not null. user email
$obj_return: contract identifire (t_id)
*/
  function get_tenant (p_email in hdbk.dtype.t_name default null)
  return hdbk.dtype.t_id;  

/*
$obj_type: function
$obj_name: client_insteadof_user
$obj_desc: return id of user with max id across client
$obj_param: p_client(t_id): is not null. client id where we looking for user
$obj_return: user id
*/
  function client_insteadof_user(p_client in hdbk.dtype.t_id)
  return hdbk.dtype.t_id;

/*
$obj_type: function
$obj_name: balance
$obj_desc: return info of contract for show balance to the client. 
$obj_param: P_TENANT_ID(t_id): is not null. contract id
$obj_return: SYS_REFCURSOR {
$obj_return:   CONTRACT_OID(t_id) is not null - contract id
$obj_return:   DEPOSIT(t_amount) is not null - self money
$obj_return:   LOAN(t_amount) is not null - money thatspent from credit limit
$obj_return:   CREDIT_LIMIT(t_amount) is not null - credit limit
$obj_return:   UNUSED_CREDIT_LIMIT(t_amount) is not null - credit limit - abs(loan)
$obj_return:   AVAILABLE(t_amount) is not null - credit limit + deposit - abs(loan). if contract bills are expired and contract blocked then 0. if contract bills are expired and contract unblocked then ussual summ.
$obj_return:   BLOCK_DATE(t_long_code) is null - expiration date of the next bill. format yyyy-mm-dd
$obj_return:   UNBLOCK_SUM(t_amount) is not null - sum next neares bills (with one day) + all bills before current day
$obj_return:   NEAR_UNBLOCK_SUM(t_amount) is not null - unblock sum + bills for 2 next days after after first bill
$obj_return:   EXPIRY_DATE(t_long_code) is null - date of first expired bill. format yyyy-mm-dd
$obj_return:   EXPIRY_SUM(t_amount) is not null - summ of all expired bills
$obj_return:   STATUS(t_long_code) is not null - if bills are expired and contract blocked then 'BLOCK', if bills are expired and contract unblocked then 'UNBLOCK', else 'ACTIVE'
$obj_return: }

*/
  function balance( P_TENANT_ID in hdbk.dtype.t_id  default null
                          )
  return SYS_REFCURSOR;  

/*
$obj_type: function
$obj_name: whoami
$obj_desc: return info for user
$obj_param: p_user(t_name): is nt null. email
$obj_return: SYS_REFCURSOR {
$obj_return:   USER_ID(t_id) is not null - user id
$obj_return:   LAST_NAME(t_name) is null - user last name 
$obj_return:   FIRST_NAME(t_name) is null - user first name
$obj_return:   EMAIL(t_name) is not null - user email
$obj_return:   PHONE(t_long_code) is null - user phone
$obj_return:   BIRTH_DATE(t_long_code) is null - user birth date
$obj_return:   GENDER(t_status) is null - user gender
$obj_return:   NATIONALITY(t_code) is null - user nationality code. like RU
$obj_return:   NLS_NATIONALITY(t_name) is null - user nationality name. like russia
$obj_return:   DOC_ID(t_id) is null - id of identity card(document). users or other persons traveler cards. like family or friends
$obj_return:   DOC_EXPIRY_DATE(t_long_code) is null - document expiration date
$obj_return:   DOC_NUMBER(t_long_code) is null - document number
$obj_return:   DOC_LAST_NAME(t_name) is null - document last name
$obj_return:   DOC_FIRST_NAME(t_name) is null - document first name
$obj_return:   DOC_OWNER(t_status) is null - document owner status. is it users document?
$obj_return:   DOC_GENDER(t_status) is null - document gender
$obj_return:   DOC_BIRTH_DATE(t_long_code) is null - document birth date
$obj_return:   DOC_NATIONALITY(t_code) is null - document nationality code. like RU
$obj_return:   DOC_NLS_NATIONALITY(t_name) is null - document nationality name. like russia
$obj_return:   DOC_PHONE(t_long_code) is null - document additionl info phone
$obj_return:   CLIENT_ID(t_id) is not null - client id
$obj_return:   CLIENT_NAME(t_name) is not null - client name
$obj_return:   IS_TESTER(t_status) is not null - is this user tester. if 'Y' then possible to get info about some application errors
$obj_return: }

*/
  function whoami(p_user in hdbk.dtype.t_name)
  return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: user_data_edit
$obj_desc: update user documents. if success return true else false. if doc_id is null then add document
$obj_param: p_data(t_clob): is null. data for update. format json {
$obj_param: p_data(t_clob):   LAST_NAME(t_name) is null - user last name 
$obj_param: p_data(t_clob):   FIRST_NAME(t_name) is null - user first name
$obj_param: p_data(t_clob):   EMAIL(t_name) is not null - user email
$obj_param: p_data(t_clob):   PHONE(t_long_code) is null - user phone
$obj_param: p_data(t_clob):   BIRTH_DATE(t_long_code) is null - user birth date
$obj_param: p_data(t_clob):   GENDER(t_status) is null - user gender
$obj_param: p_data(t_clob):   NATIONALITY(t_code) is null - user nationality code. like RU
$obj_param: p_data(t_clob):   NLS_NATIONALITY(t_name) is null - user nationality name. like russia
$obj_param: p_data(t_clob):   DOC_ID(t_id) is null - id of identity card(document). users or other persons traveler cards. like family or friends
$obj_param: p_data(t_clob):   DOC_EXPIRY_DATE(t_long_code) is null - document expiration date
$obj_param: p_data(t_clob):   DOC_NUMBER(t_long_code) is null - document number
$obj_param: p_data(t_clob):   DOC_LAST_NAME(t_name) is null - document last name
$obj_param: p_data(t_clob):   DOC_FIRST_NAME(t_name) is null - document first name
$obj_param: p_data(t_clob):   DOC_OWNER(t_status) is null - document owner status. is it users document?
$obj_param: p_data(t_clob):   DOC_GENDER(t_status) is null - document gender
$obj_param: p_data(t_clob):   DOC_BIRTH_DATE(t_long_code) is null - document birth date
$obj_param: p_data(t_clob):   DOC_NATIONALITY(t_code) is null - document nationality code. like RU
$obj_param: p_data(t_clob):   DOC_NLS_NATIONALITY(t_name) is null - document nationality name. like russia
$obj_param: p_data(t_clob):   DOC_PHONE(t_long_code) is null - document additionl info phone
$obj_param: p_data(t_clob):   CLIENT_ID(t_id) is not null - client id
$obj_param: p_data(t_clob):   CLIENT_NAME(t_name) is not null - client name
$obj_param: p_data(t_clob):   IS_TESTER(t_status) is not null - is this user tester. if 'Y' then possible to get info about some application errors
$obj_param: p_data(t_clob): }
$obj_return: SYS_REFCURSOR {
$obj_return:   res(t_code) is not null - true/false
$obj_return: }
*/
  function user_data_edit(p_data in hdbk.dtype.t_clob)
  return SYS_REFCURSOR;


/*
$obj_type: function
$obj_name: statement
$obj_desc: return list of transactions between dates in user timezone format. page and row parameters are fake
$obj_param: p_email(t_name): is not null. user email which request statement
$obj_param: p_row_count(t_id): null
$obj_param: p_page_number(t_id): null
$obj_param: p_date_from(t_code): is null. date from filter.
$obj_param: p_date_to(t_code): is null. date to filter.
$obj_return: SYS_REFCURSOR {
$obj_return:   RN(t_id) is not null - row number
$obj_return:   DOC_ID(t_id) is not null - document id
$obj_return:   TRANSACTION_ID(t_id) is not null - transaction id
$obj_return:   TRANSACTION_DATE(t_code) is not null - date of transaction. format YYYY-MM-DD
$obj_return:   TRANSACTION_TIME(t_code) is not null - time of transaction. format HH24:MI:SS
$obj_return:   AMOUNT_BEFORE(t_amount) is not null - amount before transaction
$obj_return:   AMOUNT(t_amount) is not null - amount of transaction
$obj_return:   AMOUNT_AFTER(t_amount) is not null - amount after transaction
$obj_return:   TRANSACTION_TYPE(t_long_code) is not null - name of transaction
$obj_return:   PNR_ID(t_long_code) is null - pnr id from NQT
$obj_return:   ORDER_NUMBER(t_long_code) is null - order number
$obj_return:   LAST_NAME(t_name) is null - last name of transaction owner(user)
$obj_return:   FIRST_NAME(t_name) is null - first name of transaction owner(user)
$obj_return:   EMAIL(t_name) is null - email of transaction owner(user)
$obj_return:   AMOUNT_BUY(t_amount) is not null - summ of buy transactions across result
$obj_return:   AMOUNT_CASH_IN(t_amount) is not null - summ of cash_in transactions across result
$obj_return:   AMOUNT_FROM(t_amount) is not null - amount before of first transaction across result
$obj_return:   AMOUNT_TO(t_amount) is not null - amount after of last transaction across result
$obj_return:   PAGE_COUNT(t_id) is not null - count of pages across all contract transactions
$obj_return:   ROW_COUNT(t_id) is not null - count of rows across all contract transactions
$obj_return: }
*/
  function statement(p_email  in hdbk.dtype.t_name, 
                      p_row_count  in hdbk.dtype.t_id, 
                      p_page_number  in hdbk.dtype.t_id, 
                      p_date_from  in hdbk.dtype.t_code,
                      p_date_to in hdbk.dtype.t_code
                    )
  return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: statement
$obj_desc: return list of transactions in user timezone format by pages. result is a rows only for one page with number p_page_number
$obj_param: p_email(t_name): is not null. user email which request statement
$obj_param: p_row_count(t_id): is null. count rows per page
$obj_param: p_page_number(t_id): is null. page number to show
$obj_return: SYS_REFCURSOR {
$obj_return:   RN(t_id) is not null - row number
$obj_return:   DOC_ID(t_id) is not null - document id
$obj_return:   TRANSACTION_ID(t_id) is not null - transaction id
$obj_return:   TRANSACTION_DATE(t_code) is not null - date of transaction. format YYYY-MM-DD
$obj_return:   TRANSACTION_TIME(t_code) is not null - time of transaction. format HH24:MI:SS
$obj_return:   AMOUNT_BEFORE(t_amount) is not null - amount before transaction
$obj_return:   AMOUNT(t_amount) is not null - amount of transaction
$obj_return:   AMOUNT_AFTER(t_amount) is not null - amount after transaction
$obj_return:   TRANSACTION_TYPE(t_long_code) is not null - name of transaction
$obj_return:   PNR_ID(t_long_code) is null - pnr id from NQT
$obj_return:   ORDER_NUMBER(t_long_code) is null - order number
$obj_return:   LAST_NAME(t_name) is null - last name of transaction owner(user)
$obj_return:   FIRST_NAME(t_name) is null - first name of transaction owner(user)
$obj_return:   EMAIL(t_name) is null - email of transaction owner(user)
$obj_return:   AMOUNT_BUY(t_amount) is not null - summ of buy transactions across result
$obj_return:   AMOUNT_CASH_IN(t_amount) is not null - summ of cash_in transactions across result
$obj_return:   AMOUNT_FROM(t_amount) is not null - amount before of first transaction across result
$obj_return:   AMOUNT_TO(t_amount) is not null - amount after of last transaction across result
$obj_return:   PAGE_COUNT(t_id) is not null - count of pages across all contract transactions
$obj_return:   ROW_COUNT(t_id) is not null - count of rows across all contract transactions
$obj_return: }
*/
  function statement(p_email  in hdbk.dtype.t_name, 
                      p_row_count  in hdbk.dtype.t_id, 
                      p_page_number  in hdbk.dtype.t_id
                    )
  return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: loan_list
$obj_desc: return list of loans with expired flag
$obj_param: p_email(t_name): is not null. user email who request loan_list
$obj_param: p_rownum(t_id): is null. cuts rows for paging. null
$obj_return: SYS_REFCURSOR {
$obj_return:   ID(t_id) is not null - delay id
$obj_return:   CONTRACT_OID(t_id) is not null - contract id
$obj_return:   AMOUNT(t_amount) is not null - amount of delay
$obj_return:   ORDER_NUMBER(t_long_code) is not null - order number
$obj_return:   PNR_ID(t_long_code) is not null - pnr id from NQT
$obj_return:   DATE_TO(t_long_code) is not null - date of delay expiration. last day when client must bring money. format yyyy-mm-dd
$obj_return:   IS_OVERDUE(t_status) is not null - did delay was expired?
$obj_return: }
*/
  function loan_list( p_email  in hdbk.dtype.t_name,
                      p_rownum  in hdbk.dtype.t_id default null
                    )
  return SYS_REFCURSOR;

  
/*
$obj_type: function
$obj_name: v_account_get_info_r
$obj_desc: inturnal function. (may be have to move to core) return all fields from blng.v_account view
$obj_param: p_contract(t_id): is not null. contract id
$obj_return: SYS_REFCURSOR(blng.v_account%rowtype). all v_statemen fields
*/
 
  function v_account_get_info_r ( p_contract in hdbk.dtype.t_id default null
                            )
  return blng.v_account%rowtype;


/*
$obj_type: function
$obj_name: contract_get
$obj_desc: return list of contract with client
$obj_param: p_contract(t_id): is not null. contract id
$obj_return: SYS_REFCURSOR {
$obj_return:   client_ID(t_id) is not null - id of client
$obj_return:   CONTRACT_ID(t_id) is not null - id of contract
$obj_return:   client_NAME(t_name) is not null - name of client
$obj_return:   CONTRACT_name(t_name) is not null - name of contarct
$obj_return:   CONTRACT_NUMBER(t_long_code) is not null - number of contract
$obj_return: }
*/
  function contract_get(
                        p_contract  in hdbk.dtype.t_id default null
                        )
  return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: check_tenant
$obj_desc: return tenant. tenant is contract identifire. tenant using 
$obj_desc: for checking is user registered in the system. if user dosnt exist then return NULL
$obj_param: p_email(t_name): is not null. user email
$obj_return: if user exist then
$obj_return: SYS_REFCURSOR {
$obj_return:   tenant_id(t_id) is not null - contract identifire
$obj_return: }
$obj_return: if user dose not exist then
$obj_return: SYS_REFCURSOR {
$obj_return:   res(t_long_code) is not null - error code. NO_DATA_FOUND, ERROR
$obj_return: }

*/
  function check_tenant (p_email in hdbk.dtype.t_name default null)
  return SYS_REFCURSOR;  

/*
$obj_type: function
$obj_name: god_unblock
$obj_desc: unblock user god@ntg-one.com. this user must be usually at blocked status [C]losed
$obj_return: SYS_REFCURSOR {
$obj_return:   res(t_long_code) is not null - result code. SUCCESS, NO_DATA_FOUND, ERROR
$obj_return: }
*/
  function god_unblock  
  return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: god_block
$obj_desc: block user god@ntg-one.com. this user must be usually at blocked status [C]losed
$obj_return: SYS_REFCURSOR {
$obj_return:   res(t_long_code) is not null - result code. SUCCESS, NO_DATA_FOUND, ERROR
$obj_return: }
*/
  function god_block  
  return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: god_move
$obj_desc: move user god@ntg-one.com to contract with id equals p_tenant. 
$obj_desc: mission of god@ntg-one.com is to login under one of a contract and check errors.
$obj_desc: god can help others to understand some problems 
$obj_param: p_tenant(t_id): is not null. id of contract where god user must be moved
$obj_return: SYS_REFCURSOR {
$obj_return:   res(t_long_code) is not null - result code. SUCCESS, NO_DATA_FOUND, ERROR
$obj_return: }
*/
  function god_move(p_tenant in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR;


/*
$obj_type: function
$obj_name: client_list
$obj_desc: return list of clients. 
$obj_param: p_id(t_id): is null. id of client for filter one client
$obj_return: on success SYS_REFCURSOR { 
$obj_return:   client_id(t_id) is not null - id of client
$obj_return:   name(t_name) is not null - name of client
$obj_return: }
$obj_return: on error SYS_REFCURSOR {
$obj_return:   res(t_long_code) is not null - result code. SUCCESS, NO_DATA_FOUND, ERROR
$obj_return: }
*/

  function client_list(p_id in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: client_add
$obj_desc: create client and return info about this new client. 
$obj_param: p_name(t_name): is not null. name of client
$obj_return: on success SYS_REFCURSOR { 
$obj_return:   client_id(t_id) is not null - id of client
$obj_return:   name(t_name) is not null - name of client
$obj_return: }
$obj_return: on error SYS_REFCURSOR {
$obj_return:   res(t_long_code) is not null - result code. SUCCESS, NO_DATA_FOUND, ERROR
$obj_return: }
*/
  function client_add(p_name in hdbk.dtype.t_name default null)
  return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: contract_list
$obj_desc: return list of contracts filtered by client id and contarct id 
$obj_param: p_client(t_id): is null. id of client
$obj_param: p_idt(t_id): is null. id of contract
$obj_return: on success SYS_REFCURSOR {
$obj_return:   CLIENT_ID(t_id) is not null - id of client
$obj_return:   CONTRACT_ID(t_id) is not null - id of contract
$obj_return:   TENANT_ID(t_id) is not null - contract id
$obj_return:   IS_BLOCKED(t_status) is not null - flag. is contract blocked
$obj_return:   CONTRACT_NAME(t_name) is not null - contract name
$obj_return:   CONTRACT_NUMBER(t_long_code) is not null - contract number
$obj_return:   CREDIT_LIMIT(t_amount) is not null - credit limit of contract
$obj_return:   DELAY_DAYS(t_id) is not null - delay days parameter on contract
$obj_return:   MAX_CREDIT(t_amount) is not null - max credit amount parameter on contract
$obj_return:   UTC_OFFSET(t_id) is not null - utc offset parameter on contract
$obj_return:   CONTACT_NAME(t_name) is not null - name of contact person
$obj_return:   CONTACT_PHONE(t_long_code) is not null - phone of contact person
$obj_return:   LEGAL_NAME(t_msg) is not null - legal name of client. for correct bill info filling to client
$obj_return:   INN(t_long_code) is not null - inn of contract. for correct bill info filling to client. 10-12 numbers
$obj_return:   KPP(t_long_code) is not null - kpp of contract. for correct bill info filling to client. 9 numbers
$obj_return:   OGRN(t_long_code) is not null - ogrn of contract. for correct bill info filling to client. 13 numbers
$obj_return:   LEGAL_ADDRESS(t_msg) is not null - legal address of client. for correct bill info filling to client
$obj_return:   BANK_BIK(t_long_code) is not null - bank bik of contract. for correct bill info filling to client. 9 numbers started from 04 for russia
$obj_return:   BANK_ACCOUNT(t_long_code) is not null - bank account of contract. for correct bill info filling to client. 20 numbers
$obj_return:   SIGNATORY_NAME(t_msg) is not null - name of signator on contract. for correct bill info filling to client
$obj_return:   SIGNATORY_TITLE(t_name) is not null - title of signatir on contarct. for correct bill info filling to client
$obj_return: }
$obj_return: on error SYS_REFCURSOR {
$obj_return:   res(t_long_code) is not null - result code. SUCCESS, NO_DATA_FOUND, ERROR
$obj_return: }
*/
  function contract_list(p_client in hdbk.dtype.t_id default null,
                          p_id in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: contract_add
$obj_desc: add contract for client and return info about this new contract. 
$obj_param: p_client(t_id): is not null. id of client
$obj_param: p_data(t_clob): is null. json {
$obj_param: p_data(t_clob):   CONTRACT_NAME(t_name) is not null - contract name
$obj_param: p_data(t_clob):   CREDIT_LIMIT(t_amount) is not null - credit limit of contract
$obj_param: p_data(t_clob):   DELAY_DAYS(t_id) is not null - delay days parameter on contract
$obj_param: p_data(t_clob):   MAX_CREDIT(t_amount) is not null - max credit amount parameter on contract
$obj_param: p_data(t_clob):   UTC_OFFSET(t_id) is not null - utc offset parameter on contract
$obj_param: p_data(t_clob):   CONTACT_NAME(t_name) is not null - name of contact person
$obj_param: p_data(t_clob):   CONTACT_PHONE(t_long_code) is not null - phone of contact person
$obj_param: p_data(t_clob):   LEGAL_NAME(t_msg) is not null - legal name of client. for correct bill info filling to client
$obj_param: p_data(t_clob):   INN(t_long_code) is not null - inn of contract. for correct bill info filling to client. 10-12 numbers
$obj_param: p_data(t_clob):   KPP(t_long_code) is not null - kpp of contract. for correct bill info filling to client. 9 numbers
$obj_param: p_data(t_clob):   OGRN(t_long_code) is not null - ogrn of contract. for correct bill info filling to client. 13 numbers
$obj_param: p_data(t_clob):   LEGAL_ADDRESS(t_msg) is not null - legal address of client. for correct bill info filling to client
$obj_param: p_data(t_clob):   BANK_BIK(t_long_code) is not null - bank bik of contract. for correct bill info filling to client. 9 numbers started from 04 for russia
$obj_param: p_data(t_clob):   BANK_ACCOUNT(t_long_code) is not null - bank account of contract. for correct bill info filling to client. 20 numbers
$obj_param: p_data(t_clob):   SIGNATORY_NAME(t_msg) is not null - name of signator on contract. for correct bill info filling to client
$obj_param: p_data(t_clob):   SIGNATORY_TITLE(t_name) is not null - title of signatir on contarct. for correct bill info filling to client
$obj_param: p_data(t_clob): }
$obj_return: on success return contract_list() for added contract
$obj_return: on error SYS_REFCURSOR {
$obj_return:   res(t_long_code) is not null - result code. SUCCESS, NO_DATA_FOUND, ERROR
$obj_return: }
*/
  function contract_add(p_client in hdbk.dtype.t_id default null, p_data in hdbk.dtype.t_clob default null)
  return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: contract_update
$obj_desc: update contract info for client and return info about this new contract. 
$obj_param: p_contract(t_id): is not null. id of contract
$obj_param: p_data(t_clob): is null. json {
$obj_param: p_data(t_clob):   CONTRACT_NAME(t_name) is not null - contract name
$obj_param: p_data(t_clob):   CREDIT_LIMIT(t_amount) is not null - credit limit of contract
$obj_param: p_data(t_clob):   DELAY_DAYS(t_id) is not null - delay days parameter on contract
$obj_param: p_data(t_clob):   MAX_CREDIT(t_amount) is not null - max credit amount parameter on contract
$obj_param: p_data(t_clob):   UTC_OFFSET(t_id) is not null - utc offset parameter on contract
$obj_param: p_data(t_clob):   CONTACT_NAME(t_name) is not null - name of contact person
$obj_param: p_data(t_clob):   CONTACT_PHONE(t_long_code) is not null - phone of contact person
$obj_param: p_data(t_clob):   LEGAL_NAME(t_msg) is not null - legal name of client. for correct bill info filling to client
$obj_param: p_data(t_clob):   INN(t_long_code) is not null - inn of contract. for correct bill info filling to client. 10-12 numbers
$obj_param: p_data(t_clob):   KPP(t_long_code) is not null - kpp of contract. for correct bill info filling to client. 9 numbers
$obj_param: p_data(t_clob):   OGRN(t_long_code) is not null - ogrn of contract. for correct bill info filling to client. 13 numbers
$obj_param: p_data(t_clob):   LEGAL_ADDRESS(t_msg) is not null - legal address of client. for correct bill info filling to client
$obj_param: p_data(t_clob):   BANK_BIK(t_long_code) is not null - bank bik of contract. for correct bill info filling to client. 9 numbers started from 04 for russia
$obj_param: p_data(t_clob):   BANK_ACCOUNT(t_long_code) is not null - bank account of contract. for correct bill info filling to client. 20 numbers
$obj_param: p_data(t_clob):   SIGNATORY_NAME(t_msg) is not null - name of signator on contract. for correct bill info filling to client
$obj_param: p_data(t_clob):   SIGNATORY_TITLE(t_name) is not null - title of signatir on contarct. for correct bill info filling to client
$obj_param: p_data(t_clob): }
$obj_return: on success return contract_list() for added contract
$obj_return: on error SYS_REFCURSOR {
$obj_return:   res(t_long_code) is not null - result code. SUCCESS, NO_DATA_FOUND, ERROR
$obj_return: }
*/
  function contract_update(p_contract in hdbk.dtype.t_id default null, p_data in hdbk.dtype.t_clob default null)
  return SYS_REFCURSOR;


end;
/
create  or replace package BODY blng.fwdr as

  function get_tenant (p_email in hdbk.dtype.t_name default null)
  return hdbk.dtype.t_id
  is
    r_usr blng.usr%rowtype;
    v_user hdbk.dtype.t_id;
    v_contract hdbk.dtype.t_id;
    r_client blng.client%rowtype;
    r_contract blng.contract%rowtype;
    r_domain blng.domain%rowtype;
    v_user_count hdbk.dtype.t_id;
  begin
-- for authorization we have to return tenant_id.
-- tenant_id is a identifire that user is valid. if function doesnt return tenant its mean user/email not valid.
-- second process of function is creating valid users. its mean checking emails in domain table. if its valid then create user.
-- 1. check user email exists at usr table then authorise(return tenant_id)
-- 2. check domain of email (example: "gmail.com") in the domain table. if exists then create user in usr table and authorise.
-- 3. check full email address in domain table. if exists then create user in usr table and authorise.
-- 3.a. after creating user we must delete it from domain table.
-- 4. else return exception
-- 5. to pretend attack i initialise stopper v_user_count. this variable equal count of new users last 1 minute.
-- if its more than 10 users than stop creating users. 

-- all emails must be in lower case
    begin
      r_usr:=blng.blng_api.usr_get_info_r(p_email=>lower(p_email));
      v_contract := blng.core.pay_contract_by_user(r_usr.id);
    exception 
      when NO_DATA_FOUND then
        begin
--dbms_output.put_line(sysdate||'1');
          r_domain:=blng.blng_api.domain_get_info_r(p_name => lower(p_email) );
          blng.blng_api.domain_edit(p_id=>r_domain.id, p_status=>'C' );                
        exception 
          when NO_DATA_FOUND then
            begin
--dbms_output.put_line(sysdate||'2');
              r_domain:=blng.blng_api.domain_get_info_r(p_name => REGEXP_SUBSTR ( lower(p_email), '[^@]*$' ));
            exception when NO_DATA_FOUND then raise;
            end;
        end;
--dbms_output.put_line(sysdate||'3');
        r_contract:=blng.blng_api.contract_get_info_r(p_id=>r_domain.contract_oid);
        r_client:=blng.blng_api.client_get_info_r(p_id=>r_contract.client_oid);  

        v_contract:=r_contract.id;
--dbms_output.put_line(sysdate||'4');
        select count(*) into v_user_count from blng.usr where amnd_state = 'A' and client_oid = r_client.id and amnd_date > sysdate-1/24/60;
-- auto user registration stoper 10 user per minute
        if v_user_count>=10 then return null; end if;
--dbms_output.put_line(sysdate||'5');
        v_user := blng.BLNG_API.usr_add(P_last_NAME => REGEXP_SUBSTR ( lower(p_email), '^[^@]*' ), p_client => r_client.id,p_email=>p_email,p_utc_offset=>r_client.utc_offset);
--dbms_output.put_line(sysdate||'6');
        blng.BLNG_API.usr2contract_add(p_user => v_user, p_permission=> 'B', p_contract => r_contract.id);
        commit;
    end;
    return v_contract;
  exception 
    when NO_DATA_FOUND then
      rollback;
     -- CLOSE c_delay;
      hdbk.log_api.LOG_ADD(p_proc_name=>'get_tenant', p_msg_type=>'NO_DATA_FOUND');
      return null;
    when others then
      rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'get_tenant', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'select row into usr error. '||SQLERRM);
--      return null;
  end;

  
  function client_insteadof_user(p_client in hdbk.dtype.t_id)
  return hdbk.dtype.t_id
  is
    v_result hdbk.dtype.t_id;
  begin
    select max(id) into v_result from blng.usr where client_oid = p_client and amnd_state = 'A';
    return v_result;
  exception when others then 
    hdbk.log_api.LOG_ADD(p_proc_name=>'client_insteadof_user', p_msg_type=>'UNHANDLED_ERROR');      
    return null;
  end;



  function balance( P_TENANT_ID in hdbk.dtype.t_id  default null
                          )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_contract hdbk.dtype.t_id;
  begin

    v_contract:= P_TENANT_ID;
      OPEN v_results FOR
        select
        acc.CONTRACT_OID, acc.DEPOSIT, abs(acc.LOAN) loan, acc.CREDIT_LIMIT, 
/*        case when total.expiry_sum<>0 then 0
        else acc.UNUSED_CREDIT_LIMIT
        end UNUSED_CREDIT_LIMIT,*/
        acc.UNUSED_CREDIT_LIMIT,
        case when contract.status = 'B' then 0
        else acc.AVAILABLE
        end available,
        to_char(total.BLOCK_DATE,'yyyy-mm-dd') BLOCK_DATE,
        nvl(total.UNBLOCK_SUM,0) UNBLOCK_SUM,
        nvl(total.NEAR_UNBLOCK_SUM,0) NEAR_UNBLOCK_SUM,
        to_char(total.expiry_date,'yyyy-mm-dd') expiry_date,
        total.expiry_sum,
        case
        when total.expiry_sum<>0 and contract.status = 'B' then 'BLOCK'
        when total.expiry_sum<>0 and contract.status = 'A' then 'UNBLOCK'
        else 'ACTIVE'
        end status        
        from blng.v_account acc, blng.v_total total, blng.contract 
        where acc.contract_oid = P_TENANT_ID
        and acc.contract_oid = contract.id
        and contract.amnd_state = 'A'
        and acc.contract_oid = total.contract_oid(+)
    ;
    return v_results;
  exception when others then 
    hdbk.log_api.LOG_ADD(p_proc_name=>'balance', p_msg_type=>'UNHANDLED_ERROR');      
    RAISE_APPLICATION_ERROR(-20002,'select row into v_account error. '||SQLERRM);
 --   return null;
  end;

  function whoami(p_user in hdbk.dtype.t_name)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_contract hdbk.dtype.t_id;
  begin


    OPEN v_results FOR
      select usr.id user_id, INITCAP(usr.last_name) last_name, INITCAP(usr.first_name) first_name,usr.email,usr.phone,
      to_char(usr.birth_date,'yyyy-mm-dd') birth_date,
      usr.gender,
      usr.nationality,
      hdbk.hdbk_api.gds_nationality_get_info_name(usr.nationality) nls_nationality,
      usrd.id doc_id,   
      to_char(usrd.expiry_date,'yyyy-mm-dd') doc_expiry_date,
      usrd.doc_number,
      INITCAP(usrd.last_name) doc_last_name,
      INITCAP(usrd.first_name) doc_first_name,
      usrd.owner doc_owner,
      usrd.gender doc_gender,
      to_char(usrd.birth_date,'yyyy-mm-dd') doc_birth_date,
      usrd.nationality doc_nationality,
      hdbk.hdbk_api.gds_nationality_get_info_name(usrd.nationality) doc_nls_nationality,usrd.phone doc_phone,
      client.id client_id,
      client.name client_name,
      usr.is_tester
      from blng.usr usr, blng.usr_data usrd, blng.client
      where 
      usr.amnd_state = 'A' 
      and usr.status = 'A'
      and usr.email = p_user
      and usr.client_oid = client.id
      and usr.id = usrd.user_oid(+)
      and usrd.amnd_state(+) = 'A' 
        ;

    return v_results;
  exception when others then 
    hdbk.log_api.LOG_ADD(p_proc_name=>'whoami', p_msg_type=>'UNHANDLED_ERROR');      
    RAISE_APPLICATION_ERROR(-20002,'select row into usr error. '||SQLERRM);
  end;


  function user_data_edit(p_data in hdbk.dtype.t_clob)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_id hdbk.dtype.t_id; 
    r_usr blng.usr%rowtype;
    r_usr_data blng.usr_data%rowtype;
  begin
-- first update user info. then if doc_number is not null then update usr_data 
    for i in (
      select 
      dd.*
      from --tmp1,
      json_table(p_data, '$'
        COLUMNS 
          (
           email VARCHAR2(256 CHAR) PATH '$.email',
           first_name VARCHAR2(256 CHAR) PATH '$.first_name',
           last_name VARCHAR2(256 CHAR) PATH '$.last_name',
           gender VARCHAR2(256 CHAR) PATH '$.gender',
           birth_date VARCHAR2(256 CHAR) PATH '$.birth_date',
           nationality VARCHAR2(256 CHAR) PATH '$.nationality',
           phone VARCHAR2(256 CHAR) PATH '$.phone',
            NESTED PATH '$.docs[*]' COLUMNS (
               doc_expiry_date VARCHAR2(256 CHAR) PATH '$.doc_expiry_date',
               doc_gender VARCHAR2(256 CHAR) PATH '$.doc_gender',
               doc_first_name VARCHAR2(256 CHAR) PATH '$.doc_first_name',
               doc_last_name VARCHAR2(256 CHAR) PATH '$.doc_last_name',
               doc_number VARCHAR2(256 CHAR) PATH '$.doc_number',
               doc_owner VARCHAR2(256 CHAR) PATH '$.doc_owner',
               doc_id number PATH '$.doc_id',
               doc_nationality VARCHAR2(256 CHAR) PATH '$.doc_nationality',
               doc_birth_date VARCHAR2(256 CHAR) PATH '$.doc_birth_date',
               doc_phone VARCHAR2(256 CHAR) PATH '$.doc_phone'
                  
            )
          )
        ) dd
    )
    loop

      r_usr:=blng.blng_api.usr_get_info_r(p_email=>i.email);
      if r_usr.id is null then RAISE no_data_found; end if;
      blng.blng_api.usr_edit(p_id=>r_usr.id,
                                p_last_name=>i.last_name,
                                p_first_name=>i.first_name,
                                p_gender=>i.gender,
                                p_birth_date=>to_date(i.birth_date,'yyyy-mm-dd'),
                                p_nationality=>i.nationality,
                                p_email=>i.email,
                                p_phone=>i.phone
                                );
      if i.doc_number is not null then                           
        if i.doc_id is null then 
          v_id:=blng.blng_api.usr_data_add(
                                    p_user=>r_usr.id,
                                    p_last_name=>i.doc_last_name,
                                    p_first_name=>i.doc_first_name,
                                    p_gender=>i.doc_gender,
                                    p_birth_date=>to_date(i.doc_birth_date,'yyyy-mm-dd'),
                                    p_nationality=>i.doc_nationality,
                                    p_doc_number=>i.doc_number,
                                    p_expiry_date=>to_date(i.doc_expiry_date,'yyyy-mm-dd'),
                                    p_owner=>i.doc_owner,
                                    p_phone=>i.doc_phone
                                    );      
        else
          r_usr_data:=blng.blng_api.usr_data_get_info_r(p_id=>i.doc_id,p_user => r_usr.id);
          if r_usr_data.id is null then RAISE no_data_found; end if;
          blng.blng_api.usr_data_edit(p_id=>r_usr_data.id,
                                    p_user=>r_usr.id,
                                    p_last_name=>i.doc_last_name,
                                    p_first_name=>i.doc_first_name,
                                    p_gender=>i.doc_gender,
                                    p_birth_date=>to_date(i.doc_birth_date,'yyyy-mm-dd'),
                                    p_nationality=>i.doc_nationality,
                                    p_doc_number=>i.doc_number,
                                    p_expiry_date=>to_date(i.doc_expiry_date,'yyyy-mm-dd'),
                                    p_owner=>i.doc_owner,
                                    p_phone=>i.doc_phone
                                    );
        end if;      
      end if;      
    end loop;
    
    commit;
      open v_results for
        select 'true' res from dual;
      return v_results;
  exception 
    when NO_DATA_FOUND then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'usr_data_edit', p_msg_type=>'NO_DATA_FOUND');
      open v_results for
        select 'false' res from dual;
      return v_results;
    when others then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'usr_data_edit', p_msg_type=>'UNHANDLED_ERROR');      

      open v_results for
        select 'false' res from dual;
      return v_results;
  end;


  function statement(p_email  in hdbk.dtype.t_name,
                      p_row_count  in hdbk.dtype.t_id,
                      p_page_number  in hdbk.dtype.t_id
                    )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_contract hdbk.dtype.t_id;
--    v_contract
    r_usr blng.usr%rowtype;
    --r_usr
  begin
  
      r_usr:=blng.blng_api.usr_get_info_r(p_email => p_email);
      v_contract:=blng.core.pay_contract_by_user(r_usr.id);        

--    v_results:=blng.blng_api.usr_get_info(p_email=>p_user);
      OPEN v_results FOR
              
      select 
      rn,
      doc_id,
      transaction_id,
      TRANSACTION_DATE,TRANSACTION_TIME,AMOUNT_BEFORE,AMOUNT,AMOUNT_AFTER,TRANSACTION_TYPE,pnr_id,ORDER_NUMBER,LAST_NAME,FIRST_NAME,EMAIL,
      sum(case when TRANSACTION_TYPE in ('BUY','LOAN') then amount else 0 end)  over (partition by one) amount_buy,
      sum(case when TRANSACTION_TYPE in ('CASH_IN','PAY_BILL') then amount else 0 end) over (partition by one) amount_cash_in,
      MAX(amount_before) KEEP (DENSE_RANK LAST ORDER BY trans_date desc) over (partition by one) amount_from,
      MIN(amount_after) KEEP (DENSE_RANK FIRST ORDER BY trans_date desc) over (partition by one) amount_to,
      page_count,
      row_count
      from (
        select
        row_number() over (order by trans_date desc) rn,
        st.*,
        ceil((count(*) over()) / nvl(decode(p_row_count,0,1,p_row_count),1)  ) page_count,
        count(*) over() row_count
        from 
        blng.v_statement st
        where contract_id = v_contract
        order by trans_date desc 
      )
      where rn >= p_row_count*(p_page_number-1)+1 -- p_row_count*(p_page_number-1)+1
      and rn <= case  when p_row_count=0 and p_page_number=1 then rn
                      when p_row_count*p_page_number is null then 0
                      else p_row_count*p_page_number
                end -- p_row_count*p_page_number

      order by trans_date desc
        ;
        
    return v_results;
  exception when others then 
    hdbk.log_api.LOG_ADD(p_proc_name=>'statement', p_msg_type=>'UNHANDLED_ERROR');      
    RAISE_APPLICATION_ERROR(-20002,'select row into user error. '||SQLERRM);
  end;

  function statement(p_email  in hdbk.dtype.t_name, 
                      p_row_count  in hdbk.dtype.t_id, 
                      p_page_number  in hdbk.dtype.t_id, 
                      p_date_from  in hdbk.dtype.t_code,
                      p_date_to in hdbk.dtype.t_code
                    )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_contract hdbk.dtype.t_id;
    r_usr blng.usr%rowtype;
  begin
  
      r_usr:=blng.blng_api.usr_get_info_r(p_email => p_email);
      v_contract:=blng.core.pay_contract_by_user(r_usr.id);        

      OPEN v_results FOR
              
      select 
      rn,
      doc_id,
      transaction_id,
      TRANSACTION_DATE,TRANSACTION_TIME,AMOUNT_BEFORE,AMOUNT,AMOUNT_AFTER,TRANSACTION_TYPE,pnr_id,ORDER_NUMBER,LAST_NAME,FIRST_NAME,EMAIL,
      sum(case when TRANSACTION_TYPE in ('BUY','LOAN') then amount else 0 end)  over (partition by docs.one) amount_buy,
      sum(case when TRANSACTION_TYPE in ('CASH_IN','PAY_BILL') then amount else 0 end) over (partition by docs.one)  amount_cash_in,
      amount_from,
      amount_to,
      page_count,
      row_count
      from
      (
      select 
      case  
       when (
          select 
          max(doc_id) doc_id 
          from 
          blng.v_statement
          where contract_id = v_contract
          --and ( trans_date < to_date(p_date_from,'yyyy-mm-dd')-utc_offset/24 or (p_page_number=0 and p_row_count=0))
          and  trans_date < to_date(p_date_from,'yyyy-mm-dd')-utc_offset/24
        ) is null 
       then 0
      else 
        (select amount_after from blng.v_statement where doc_id
        =
        (
          select 
          max(doc_id) doc_id 
          from 
          blng.v_statement
          where contract_id = v_contract
          --and (trans_date < to_date(p_date_from,'yyyy-mm-dd')-utc_offset/24 or (p_page_number=0 and p_row_count=0))
          and trans_date < to_date(p_date_from,'yyyy-mm-dd')-utc_offset/24 
        )
          and contract_id = v_contract
        )
      end amount_from,
      case  
       when (
          select 
          max(doc_id) doc_id 
          from 
          blng.v_statement
          where contract_id = v_contract
          --and (trans_date < to_date(p_date_to,'yyyy-mm-dd')+1-utc_offset/24 or (p_page_number=0 and p_row_count=0))
          and trans_date < to_date(p_date_to,'yyyy-mm-dd')+1-utc_offset/24
        ) is null 
       then 0
      else 
        (select amount_after from blng.v_statement where doc_id
        =
        (
          select 
          max(doc_id) doc_id 
          from 
          blng.v_statement
          where contract_id = v_contract
          --and (trans_date < to_date(p_date_to,'yyyy-mm-dd')+1-utc_offset/24 or (p_page_number=0 and p_row_count=0))
          and trans_date < to_date(p_date_to,'yyyy-mm-dd')+1-utc_offset/24
        )
        and contract_id = v_contract
        )
        end amount_to,
        1 one
        from dual) amount,
        (
          select * from (
            select
            row_number() over (order by trans_date desc) rn,
            st.*, 
            --ceil((count(*) over()) / nvl(decode(p_row_count,0,1,p_row_count),1)  ) page_count,
            1 page_count,
            count(*) over() row_count
            from 
            blng.v_statement st
            where contract_id = v_contract
            --and (trans_date >= to_date(p_date_from,'yyyy-mm-dd')-utc_offset/24 or (p_page_number=0 and p_row_count=0))
            --and (trans_date < to_date(p_date_to,'yyyy-mm-dd')+1-utc_offset/24 or (p_page_number=0 and p_row_count=0))
            and trans_date >= to_date(p_date_from,'yyyy-mm-dd')-utc_offset/24
            and trans_date < to_date(p_date_to,'yyyy-mm-dd')+1-utc_offset/24 
          )
          /*
          where rn >= p_row_count*(p_page_number-1)+1 -- p_row_count*(p_page_number-1)+1
          and rn <= case  when p_row_count=0 and p_page_number=0 then rn
                          when p_row_count*p_page_number is null then 0
                          else p_row_count*p_page_number
                    end -- p_row_count*p_page_number */
        ) docs
        where 
        amount.one = docs.one(+)
        order by trans_date desc
        ;
        
    return v_results;
  exception when others then 
    hdbk.log_api.LOG_ADD(p_proc_name=>'statement', p_msg_type=>'UNHANDLED_ERROR');      
    RAISE_APPLICATION_ERROR(-20002,'select row into user error. '||SQLERRM);
  end;


  function loan_list(p_email  in hdbk.dtype.t_name,
                      p_rownum  in hdbk.dtype.t_id default null
                    )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_contract hdbk.dtype.t_id;
  begin
      OPEN v_results FOR
  
        select
        del.id,
        del.contract_oid,
        del.amount - nvl((select sum(amount) from blng.delay where parent_id is not null and parent_id = del.id and amnd_state = 'A' and EVENT_TYPE_oid = hdbk.core.dictionary_get_id(p_dictionary_type=>'EVENT_TYPE',p_code=> 'CASH_IN')),0) amount,
        --nvl((select sum(amount) from blng.delay where parent_id is not null and parent_id = d.id and amnd_state = 'A' and EVENT_TYPE_oid = blng.blng_api.event_type_get_id(p_code=>'ci')),0) amount_have,
        item_avia.pnr_locator order_number,
        item_avia.pnr_id pnr_id,
        to_char(del.date_to - 1,'yyyy-mm-dd') date_to ,
        case when trunc(date_to) <= sysdate then 'Y' else 'N' end is_overdue
        from blng.delay del,blng.document, ord.bill, ord.item_avia,
          blng.usr,
          blng.contract,
          blng.usr2contract
        where del.amnd_state = 'A'
        and document.amnd_state = 'A'
        and item_avia.amnd_state = 'A'
        and bill.amnd_state = 'A'
        and del.parent_id is null
    --    and del.contract_oid = 21
        and del.contract_oid = contract.id
        and del.EVENT_TYPE_oid = hdbk.core.dictionary_get_id(p_dictionary_type=>'EVENT_TYPE',p_code=> 'BUY')
        and del.doc_oid = document.id
        and document.bill_oid = bill.id
        and document.bill_oid is not null
        and document.contract_oid = contract.id
        and item_avia.order_oid = bill.order_oid
        
        and usr.email = p_email
     --  and usr.email = 's.popinevskiy@ntg-one.com'

        and usr2contract.user_oid = usr.id
        and usr2contract.amnd_state = 'A'
        and usr.amnd_state = 'A'
        and contract.amnd_state = 'A'
        and usr2contract.contract_oid = contract.id
        and usr2contract.permission = 'B'
        order by del.contract_oid asc, del.date_to asc, del.id asc
;
        
    return v_results;
  exception when others then 
    hdbk.log_api.LOG_ADD(p_proc_name=>'loan_list', p_msg_type=>'UNHANDLED_ERROR');      
    RAISE_APPLICATION_ERROR(-20002,'select row into usr error. '||SQLERRM);
    return null;
  end;

  

  function v_account_get_info_r ( p_contract in hdbk.dtype.t_id default null
                            )
  return blng.v_account%rowtype
  is
    r_account blng.v_account%rowtype;
    v_contract hdbk.dtype.t_id;
  begin

    v_contract:=p_contract;
    select * into r_account from blng.v_account where contract_oid = v_contract;
    return r_account;
  exception when others then 
    hdbk.log_api.LOG_ADD(p_proc_name=>'v_account_get_info_r', p_msg_type=>'UNHANDLED_ERROR');      
    RAISE_APPLICATION_ERROR(-20002,''||SQLERRM);
    return null;
  end v_account_get_info_r;


  function contract_get(
                        p_contract  in hdbk.dtype.t_id default null
                        )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_contract hdbk.dtype.t_id;
  begin
      OPEN v_results FOR
  
        select 
        client.id client_id,
        contract.id contract_id,
        client.name client_name,
        contract.name contract_name,
        contract.contract_number contract_number
        from blng.contract, blng.client
        where contract.amnd_state = 'A'
        and client.amnd_state = 'A'
        and client.id = contract.client_oid
        and contract.id = nvl(p_contract, contract.id)
        ;
        
    return v_results;
  exception when others then 
    hdbk.log_api.LOG_ADD(p_proc_name=>'contract_get', p_msg_type=>'UNHANDLED_ERROR');      
    RAISE_APPLICATION_ERROR(-20002,'select row into contract error. '||SQLERRM);
    return null;
  end;


  function check_tenant (p_email in hdbk.dtype.t_name default null)
  return SYS_REFCURSOR
  is
    r_usr blng.usr%rowtype;
    v_contract hdbk.dtype.t_id;
    v_results SYS_REFCURSOR;
  begin
    r_usr:=blng.blng_api.usr_get_info_r(p_email=>lower(p_email));

    open v_results for
      select blng.core.pay_contract_by_user(r_usr.id) tenant_id from dual;
    return v_results;
--    return v_contract;
  exception 
    when NO_DATA_FOUND then
      open v_results for
        select 'NO_DATA_FOUND' res from dual;
      return v_results;
    when others then

      open v_results for
        select 'ERROR' res from dual;
      return v_results;
  end;


  function god_unblock
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
    r_usr blng.usr%rowtype;
    v_god_email hdbk.dtype.t_name:='god@ntg-one.com';
  begin
    r_usr:=blng.blng_api.usr_get_info_r(p_email=>v_god_email);
    --dbms_output.put_line('r_usr='||r_usr.id);    
    blng.blng_api.usr_edit(p_id=>r_usr.id, p_status=>'A');
    commit;    
      open v_results for
        select 'SUCCESS' res from dual;
      return v_results;
  exception 
    when NO_DATA_FOUND then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'god_unblock', p_msg_type=>'NO_DATA_FOUND');

      open v_results for
        select 'NO_DATA_FOUND' res from dual;
      return v_results;
    when others then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'god_unblock', p_msg_type=>'UNHANDLED_ERROR');      

      open v_results for
        select 'ERROR' res from dual;
      return v_results;
  end;

  function god_block
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
    r_usr blng.usr%rowtype;
    v_god_email hdbk.dtype.t_name:='god@ntg-one.com';
  begin
    r_usr:=blng.blng_api.usr_get_info_r(p_email=>v_god_email);
    blng.blng_api.usr_edit(p_id=>r_usr.id, p_status=>'C');
    commit;    
    

      open v_results for
        select 'SUCCESS' res from dual;
      return v_results;
  exception 
    when NO_DATA_FOUND then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'god_block', p_msg_type=>'NO_DATA_FOUND');

      open v_results for
        select 'NO_DATA_FOUND' res from dual;
      return v_results;
    when others then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'god_block', p_msg_type=>'UNHANDLED_ERROR');      

      open v_results for
        select 'ERROR' res from dual;
      return v_results;
  end;


  function god_move(p_tenant in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR
  is
    r_usr blng.usr%rowtype;
    r_usr2contract blng.usr2contract%rowtype;
    r_contract_to blng.contract%rowtype;
    v_god_email hdbk.dtype.t_name:='god@ntg-one.com';
    v_results SYS_REFCURSOR;
  begin
    r_usr:=blng.blng_api.usr_get_info_r(p_email=>v_god_email);
    r_usr2contract:=blng.blng_api.usr2contract_get_info_r(p_user=>r_usr.id, p_permission=>'B');
    r_contract_to:=blng.blng_api.contract_get_info_r(p_id=>p_tenant);

    blng.blng_api.usr_edit(p_id=>r_usr.id, p_client=>r_contract_to.client_oid);
    blng.blng_api.usr2contract_edit(p_id=>r_usr2contract.id, p_contract=>r_contract_to.id);
    commit;
      open v_results for
        select 'SUCCESS' res from dual;
      return v_results;
  exception 
    when NO_DATA_FOUND then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'god_move', p_msg_type=>'NO_DATA_FOUND');

      open v_results for
        select 'NO_DATA_FOUND' res from dual;
      return v_results;
    when others then
      ROLLBACK;
      hdbk.log_api.LOG_ADD(p_proc_name=>'god_move', p_msg_type=>'UNHANDLED_ERROR');      

      open v_results for
        select 'ERROR' res from dual;
      return v_results;
  end;

  function client_list(p_id in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_contract hdbk.dtype.t_id;
  begin
      OPEN v_results FOR
  
        select 
        client.id client_id,
        client.name name
        from blng.client
        where client.amnd_state = 'A'
        and id = nvl(p_id,id)
        order by id
        ;

    return v_results;

  exception when others then 
    hdbk.log_api.LOG_ADD(p_proc_name=>'client_list', p_msg_type=>'UNHANDLED_ERROR');    
    open v_results for
      select 'ERROR' res from dual;
    return v_results;
  end;


  function client_add(p_name in hdbk.dtype.t_name default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_client hdbk.dtype.t_id;
  begin
    v_client:=blng_api.client_add(p_name=>p_name);
    commit;    
      OPEN v_results FOR
  
        select 
        v_client client_id,
        p_name name
        from dual
        ;
        
    return v_results;
  exception when others then 
    hdbk.log_api.LOG_ADD(p_proc_name=>'client_add', p_msg_type=>'UNHANDLED_ERROR');      
      open v_results for
        select 'ERROR' res from dual;
      return v_results;
  end;


  function contract_list(p_client in hdbk.dtype.t_id default null,
                          p_id in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_contract hdbk.dtype.t_id;
  begin
      OPEN v_results FOR
  
        select 
        contract.client_oid client_id,
        contract.id contract_id,
        contract.id tenant_id,
        decode(contract.status,'B','Y','N') is_blocked,
        contract.name contract_name,
        contract.contract_number,
        v_account.credit_limit,
        v_account.delay_days,
        v_account.max_loan_trans_amount max_credit,
        contract.utc_offset,
        contract.contact_name,
        contract.contact_phone,
        legal_name,
        inn, --'1657138342'
        kpp,--'165701001' 
        ogrn,--'1141690010967' 
        legal_address,
        bank_bik,--'049205804' 
        bank_account,--'40702810211010000481' 
        signatory_name,
        signatory_title
        from blng.contract, blng.v_account
        where contract.amnd_state = 'A'
        and contract.id = v_account.contract_oid
        and contract.client_oid = nvl(p_client,contract.client_oid)
        and contract.id = nvl(p_id,contract.id)
        order by id
        ;
        
    return v_results;
  exception when others then 
    hdbk.log_api.LOG_ADD(p_proc_name=>'contract_list', p_msg_type=>'UNHANDLED_ERROR');      
      open v_results for
        select 'ERROR' res from dual;
      return v_results;
  end;


  function contract_add(p_client in hdbk.dtype.t_id default null, p_data in hdbk.dtype.t_clob default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_contract hdbk.dtype.t_id;
    v_doc hdbk.dtype.t_id;
  begin
  
    for i in (
      select 
      *
      from 
      json_table(p_data, '$'
        COLUMNS 
          (
           contract_name VARCHAR2(256 CHAR) PATH '$.contract_name',
           credit_limit number PATH '$.credit_limit',
           delay_days number PATH '$.delay_days',
           max_credit number PATH '$.max_credit',
           utc_offset number PATH '$.utc_offset',
           contact_name VARCHAR2(256 CHAR) PATH '$.contact_name',
           contact_phone VARCHAR2(256 CHAR) PATH '$.contact_phone',
           legal_name VARCHAR2(4000 CHAR) PATH '$.legal_name',
           inn VARCHAR2(256 CHAR) PATH '$.inn',
           kpp VARCHAR2(256 CHAR) PATH '$.kpp',
           ogrn VARCHAR2(256 CHAR) PATH '$.ogrn',
           legal_address VARCHAR2(4000 CHAR) PATH '$.legal_address',
           bank_bik VARCHAR2(256 CHAR) PATH '$.bank_bik',
           bank_account VARCHAR2(256 CHAR) PATH '$.bank_account',
           signatory_name VARCHAR2(4000 CHAR) PATH '$.signatory_name',
           signatory_title VARCHAR2(256 CHAR) PATH '$.signatory_title'
          )
        ) 
    )
    loop
      if i.inn is not null and length(trim(i.inn)) not in (10,12) then raise VALUE_ERROR; end if;
      if i.kpp is not null and length(trim(i.kpp)) not in (9) then raise VALUE_ERROR; end if;
      if i.ogrn is not null and length(trim(i.ogrn)) not in (13) then raise VALUE_ERROR; end if;
      if i.bank_bik is not null and length(trim(i.bank_bik)) not in (9) then raise VALUE_ERROR; end if;
      if i.bank_account is not null and length(trim(i.bank_account)) not in (20,25) then raise VALUE_ERROR; end if;
          
      v_contract := blng.BLNG_API.contract_add( P_client => p_client, 
                                                p_name=>i.contract_name, 
                                                p_utc_offset=>i.utc_offset,
                                                 p_contact_name=>i.contact_name,
                                                p_contact_phone=>i.contact_phone,
                                                p_legal_name=>i.legal_name,
                                                p_inn=>i.inn,
                                                p_kpp=>i.kpp,
                                                p_ogrn=>i.ogrn,
                                                p_legal_address=>i.legal_address,
                                                p_bank_bik=>i.bank_bik,
                                                p_bank_account=>i.bank_account,
                                                p_signatory_name=>i.signatory_name,
                                                p_signatory_title=>i.signatory_title              
                                                );
      BLNG.BLNG_API.account_init(v_contract);
    
      v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => i.credit_limit,
        p_account_trans_type=>hdbk.core.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>'CREDIT_LIMIT'));
      v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => i.delay_days,
        p_account_trans_type=>hdbk.core.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>'DELAY_DAYS'));
      v_DOC := blng.BLNG_API.document_add(P_CONTRACT => v_contract,P_AMOUNT => i.max_credit,
        p_account_trans_type=>hdbk.core.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>'UP_LIM_TRANS'));
      commit;
    end loop;

  /*  OPEN v_results FOR
      select 
      contract.client_oid client_id,
      contract.id contract_id,
      contract.id tenant_id,
      decode(contract.status,'B','Y','N') is_blocked,
      contract.name contract_name,
      contract.contract_number,
      v_account.credit_limit,
      v_account.delay_days,
      v_account.max_loan_trans_amount max_credit,
      contract.utc_offset,
      contract.contact_name,
      contract.contact_phone
      from blng.contract, blng.v_account
      where contract.amnd_state = 'A'
      and contract.id = v_account.contract_oid
      and contract.id = v_contract
      order by id
      ;   */ 
    return fwdr.contract_list(p_id => v_contract);
  exception when others then 
    hdbk.log_api.LOG_ADD(p_proc_name=>'contract_add', p_msg_type=>'UNHANDLED_ERROR');      
      open v_results for
        select 'ERROR' res from dual;
      return v_results;
  end;



  function contract_update(p_contract in hdbk.dtype.t_id default null, p_data in hdbk.dtype.t_clob default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    --v_contract hdbk.dtype.t_id;
    r_account_info blng.v_account%rowtype;
    v_doc hdbk.dtype.t_id;
  begin
  
    for i in (
      select 
      *
      from 
      json_table(p_data, '$'
        COLUMNS 
          (

           contract_name VARCHAR2(256 CHAR) PATH '$.contract_name',
           credit_limit number PATH '$.credit_limit',
           delay_days number PATH '$.delay_days',
           max_credit number PATH '$.max_credit',
           utc_offset number PATH '$.utc_offset',
           contact_name VARCHAR2(256 CHAR) PATH '$.contact_name',
           contact_phone VARCHAR2(256 CHAR) PATH '$.contact_phone',
           legal_name VARCHAR2(4000 CHAR) PATH '$.legal_name',
           inn VARCHAR2(256 CHAR) PATH '$.inn',
           kpp VARCHAR2(256 CHAR) PATH '$.kpp',
           ogrn VARCHAR2(256 CHAR) PATH '$.ogrn',
           legal_address VARCHAR2(4000 CHAR) PATH '$.legal_address',
           bank_bik VARCHAR2(256 CHAR) PATH '$.bank_bik',
           bank_account VARCHAR2(256 CHAR) PATH '$.bank_account',
           signatory_name VARCHAR2(4000 CHAR) PATH '$.signatory_name',
           signatory_title VARCHAR2(256 CHAR) PATH '$.signatory_title'   
          )
        ) 
    )
    loop
      if i.inn is not null and length(trim(i.inn)) not in (10,12) then raise VALUE_ERROR; end if;
      if i.kpp is not null and length(trim(i.kpp)) not in (9) then raise VALUE_ERROR; end if;
      if i.ogrn is not null and length(trim(i.ogrn)) not in (13) then raise VALUE_ERROR; end if;
      if i.bank_bik is not null and length(trim(i.bank_bik)) not in (9) then raise VALUE_ERROR; end if;
      if i.bank_account is not null and length(trim(i.bank_account)) not in (20,25) then raise VALUE_ERROR; end if;

      blng.BLNG_API.contract_edit( P_id => p_contract, 
                                                p_name=>i.contract_name, 
                                                p_utc_offset=>i.utc_offset,
                                                p_contact_name=>i.contact_name,
                                                p_contact_phone=>i.contact_phone,
                                                p_legal_name=>i.legal_name,
                                                p_inn=>i.inn,
                                                p_kpp=>i.kpp,
                                                p_ogrn=>i.ogrn,
                                                p_legal_address=>i.legal_address,
                                                p_bank_bik=>i.bank_bik,
                                                p_bank_account=>i.bank_account,
                                                p_signatory_name=>i.signatory_name,
                                                p_signatory_title=>i.signatory_title     
                                                );
                                                      
      r_account_info := fwdr.v_account_get_info_r(p_contract);
      
      if    i.credit_limit is null 
        or  i.delay_days is null 
        or  i.max_credit is null 
        or  i.contract_name is null 
        or  i.utc_offset is null 
      then raise VALUE_ERROR; 
      end if;
      
      if r_account_info.loan <> 0 and abs(r_account_info.loan)> i.credit_limit then raise VALUE_ERROR; end if;
    
      v_DOC := blng.BLNG_API.document_add(P_CONTRACT => p_contract,P_AMOUNT => i.credit_limit,
        p_account_trans_type=>hdbk.core.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>'CREDIT_LIMIT'));
      v_DOC := blng.BLNG_API.document_add(P_CONTRACT => p_contract,P_AMOUNT => i.delay_days,
        p_account_trans_type=>hdbk.core.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>'DELAY_DAYS'));
      v_DOC := blng.BLNG_API.document_add(P_CONTRACT => p_contract,P_AMOUNT => i.max_credit,
        p_account_trans_type=>hdbk.core.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>'UP_LIM_TRANS'));
      commit;
    end loop;

/*    OPEN v_results FOR
      select 
      contract.client_oid client_id,
      contract.id contract_id,
      contract.id tenant_id,
      decode(contract.status,'B','Y','N') is_blocked,
      contract.name contract_name,
      contract.contract_number,
      v_account.credit_limit,
      v_account.delay_days,
      v_account.max_loan_trans_amount max_credit,
      contract.utc_offset,
      contract.contact_name,
      contract.contact_phone
      from blng.contract, blng.v_account
      where contract.amnd_state = 'A'
      and contract.id = v_account.contract_oid
      and contract.id = p_contract
      order by id
      ;    */
    return fwdr.contract_list(p_id => p_contract);
  exception 
    when VALUE_ERROR then 
      hdbk.log_api.LOG_ADD(p_proc_name=>'contract_update', p_msg_type=>'VALUE_ERROR');      
        open v_results for
          select 'VALUE_ERROR' res from dual;
        return v_results;
    when NO_DATA_FOUND then 
      hdbk.log_api.LOG_ADD(p_proc_name=>'contract_update', p_msg_type=>'NO_DATA_FOUND');      
        open v_results for
          select 'NO_DATA_FOUND' res from dual;
        return v_results;
    when others then
      rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'contract_update', p_msg_type=>'UNHANDLED_ERROR');      
        open v_results for
          select 'ERROR' res from dual;
        return v_results;
  end;


end;
/