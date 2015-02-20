
  CREATE OR REPLACE EDITIONABLE PACKAGE "BLNG"."BLNG_API" as

  
/*
$pkg: BLNG.BLNG_API
*/
  
/*
$obj_desc: ***_add insert row into table ***. could return id of new row.
$obj_desc: ***_edit update row into table ***. object have always one id. first, old data with amnd_state = [I]nactive
$obj_desc: inserted as row with link to new row(amnd_prev). new data just update object row, 
$obj_desc: amnd_date updates to sysdate and amnd_user to current user who called api.
$obj_desc: ***_get_info return data from table *** with format SYS_REFCURSOR.
$obj_desc: ***_get_info_r return one row from table *** with format ***%rowtype.
*/
  function company_add(p_name in ntg.dtype.t_name,
                  p_utc_offset in ntg.dtype.t_id default null)
  return ntg.dtype.t_id;


  procedure company_edit(p_id in ntg.dtype.t_id, p_name in ntg.dtype.t_name,
                  p_utc_offset in ntg.dtype.t_id default null);

  function company_get_info(p_id in ntg.dtype.t_id default null,
                  p_utc_offset in ntg.dtype.t_id default null)
  return SYS_REFCURSOR;

  function company_get_info_r(p_id in ntg.dtype.t_id default null,
                  p_utc_offset in ntg.dtype.t_id default null)
  return blng.company%rowtype;


  function client_add(p_company in ntg.dtype.t_id default null, 
                  p_last_name in ntg.dtype.t_name default null, 
                  p_first_name in ntg.dtype.t_name default null, 
                  p_birth_date in ntg.dtype.t_date default null, 
                  p_gender in ntg.dtype.t_status default null, 
                  p_nationality in ntg.dtype.t_code default null, 
                  p_email in ntg.dtype.t_name default null,
                  p_phone in ntg.dtype.t_name default null,
                  p_utc_offset in ntg.dtype.t_id default null
                  )
  return ntg.dtype.t_id;

  procedure client_edit(p_id in ntg.dtype.t_id, 
                          p_company in ntg.dtype.t_id default null, 
                          p_last_name in ntg.dtype.t_name default null, 
                          p_first_name in ntg.dtype.t_name default null, 
                          p_birth_date in ntg.dtype.t_date default null, 
                          p_gender in ntg.dtype.t_status default null, 
                          p_nationality in ntg.dtype.t_code default null, 
                          p_email in ntg.dtype.t_name default null,
                  p_phone in ntg.dtype.t_name default null,
                  p_utc_offset in ntg.dtype.t_id default null
  );

  function client_get_info( p_id in ntg.dtype.t_id  default null,
                            p_company in ntg.dtype.t_id default null, 
                            p_last_name in ntg.dtype.t_name default null, 
                            p_first_name in ntg.dtype.t_name default null, 
                            p_birth_date in ntg.dtype.t_date default null, 
                            p_gender in ntg.dtype.t_status default null, 
                            p_nationality in ntg.dtype.t_code default null, 
                            p_email in ntg.dtype.t_name default null,
                  p_phone in ntg.dtype.t_name default null,
                  p_utc_offset in ntg.dtype.t_id default null
  )
  return SYS_REFCURSOR;

  function client_get_info_r ( p_id in ntg.dtype.t_id default null,
                              p_company in ntg.dtype.t_id default null, 
                                p_last_name in ntg.dtype.t_name default null, 
                                p_first_name in ntg.dtype.t_name default null, 
                                p_birth_date in ntg.dtype.t_date default null, 
                                p_gender in ntg.dtype.t_status default null, 
                                p_nationality in ntg.dtype.t_code default null, 
                                p_email in ntg.dtype.t_name default null,
                  p_phone in ntg.dtype.t_name default null,
                  p_utc_offset in ntg.dtype.t_id default null
                            )
  return blng.client%rowtype;

  procedure client2contract_add( p_client in ntg.dtype.t_id,
                                p_permission in ntg.dtype.t_status,
                                p_contract in ntg.dtype.t_id
                              );

  procedure client2contract_edit( p_id in ntg.dtype.t_id default null,
                                   p_client in ntg.dtype.t_id default null,
                                  p_contract in ntg.dtype.t_id default null,
                                  p_status in ntg.dtype.t_status default null
                                  );

  function client2contract_get_info(  p_id in ntg.dtype.t_id default null,
                                      p_client in ntg.dtype.t_id default null,
                                      p_contract in ntg.dtype.t_id default null,
                                      p_permission in ntg.dtype.t_status default null
                                    )
  return SYS_REFCURSOR;

  function contract_add( p_company in ntg.dtype.t_id default null,
                  p_utc_offset in ntg.dtype.t_id default null)
  return ntg.dtype.t_id;

  procedure contract_edit(p_id in ntg.dtype.t_id default null, p_number in ntg.dtype.t_long_code default null,
                  p_utc_offset in ntg.dtype.t_id default null);

  function contract_get_info(p_id in ntg.dtype.t_id default null,p_company  in ntg.dtype.t_id default null,
                  p_utc_offset in ntg.dtype.t_id default null)
  return SYS_REFCURSOR;

  function contract_get_info_r(p_id in ntg.dtype.t_id default null,p_company  in ntg.dtype.t_id default null,
                  p_utc_offset in ntg.dtype.t_id default null)
  return blng.contract%rowtype;

  procedure account_init(p_contract in ntg.dtype.t_id);

 procedure account_edit(       p_id in ntg.dtype.t_id default null,
                               -- p_contract in ntg.dtype.t_id default null,
                               -- p_account_type in ntg.dtype.t_id default null,
                               -- p_code in ntg.dtype.t_code default null,
                                p_amount in ntg.dtype.t_amount default null
                              )  ;


  function account_get_info ( p_id in ntg.dtype.t_id default null,
                              p_contract in ntg.dtype.t_id default null,
                              p_code in ntg.dtype.t_code default null,
                              p_account_type in ntg.dtype.t_id default null,
                              p_filter_amount in ntg.dtype.t_amount  default null
                            )
  return SYS_REFCURSOR;

  function account_get_info_r ( p_id in ntg.dtype.t_id default null,
                              p_contract in ntg.dtype.t_id default null,
                              p_code in ntg.dtype.t_code default null,
                              p_account_type in ntg.dtype.t_id default null
                            )
  return blng.account%rowtype;


  function document_add ( p_contract in ntg.dtype.t_id default null,
                          p_amount in ntg.dtype.t_amount default null,
                          p_trans_type in ntg.dtype.t_id default null,
                          p_bill in ntg.dtype.t_id default null
                        )
  return ntg.dtype.t_id;

  procedure document_edit(p_id in ntg.dtype.t_id, p_status in ntg.dtype.t_status default null);

  function document_get_info( p_id in ntg.dtype.t_id default null,
                              p_contract in ntg.dtype.t_id  default null,
                              p_trans_type in ntg.dtype.t_id  default null,
                              p_status in ntg.dtype.t_status  default null,
                              p_bill in ntg.dtype.t_id default null
                            )
  return SYS_REFCURSOR;

  function document_get_info_r( p_id in ntg.dtype.t_id default null,
                              p_contract in ntg.dtype.t_id  default null,
                              p_trans_type in ntg.dtype.t_id  default null,
                              p_status in ntg.dtype.t_status  default null,
                              p_bill in ntg.dtype.t_id default null
                            )
  return blng.document%rowtype;

  function transaction_add ( p_doc in ntg.dtype.t_id  default null,
                          p_amount in ntg.dtype.t_amount  default null,
                          p_trans_type in ntg.dtype.t_id  default null,
                          p_trans_date in ntg.dtype.t_date default null,
                          p_target_account in ntg.dtype.t_id  default null,
                          p_status in ntg.dtype.t_status  default 'P',
                          p_prev in ntg.dtype.t_id  default null
                        )
  return ntg.dtype.t_id;

  function transaction_add_with_acc ( p_doc in ntg.dtype.t_id  default null,
                          p_amount in ntg.dtype.t_amount  default null,
                          p_trans_type in ntg.dtype.t_id  default null,
                          p_trans_date in ntg.dtype.t_date default null,
                          p_target_account in ntg.dtype.t_id  default null,
                          p_status in ntg.dtype.t_status  default 'P',
                          p_prev in ntg.dtype.t_id  default null
                        )
  return ntg.dtype.t_id;

  procedure transaction_edit(p_id in ntg.dtype.t_id, p_status ntg.dtype.t_status default 'P');

  function transaction_get_info( p_id in ntg.dtype.t_id default null,
                              p_doc in ntg.dtype.t_id default null,
                              p_trans_type in ntg.dtype.t_id default null,
                              p_target_account in ntg.dtype.t_id default null,
                              p_status in ntg.dtype.t_status default null
                            )
  return SYS_REFCURSOR;

  function event_add( p_contract in ntg.dtype.t_id default null,
                      p_amount in ntg.dtype.t_amount default null,
                      p_transaction in ntg.dtype.t_id default null,
                      p_date_to in ntg.dtype.t_date default null,
                      p_event_type in ntg.dtype.t_id default null,
                      p_status in ntg.dtype.t_status default null,
                      p_priority in ntg.dtype.t_id default null
                    )
  return ntg.dtype.t_id;

  procedure event_edit ( p_id in ntg.dtype.t_id default null,
                        p_status in ntg.dtype.t_status default null,
                        p_amount in ntg.dtype.t_amount default null
                      );

  function event_get_info ( p_id in ntg.dtype.t_id default null,
                            p_contract in ntg.dtype.t_id default null,
                            p_date_to in ntg.dtype.t_date default null,
                            p_event_type in ntg.dtype.t_id default null,
                            p_status in ntg.dtype.t_status default null,
                            p_priority in ntg.dtype.t_id default null
                          )
  return SYS_REFCURSOR;

  function status_type_add( p_name in ntg.dtype.t_name default null,
                            p_code in ntg.dtype.t_code default null,
                            p_details in ntg.dtype.t_msg default null
                          )
  return ntg.dtype.t_id;

  procedure status_type_edit ( p_id in ntg.dtype.t_id default null,
                        p_name in ntg.dtype.t_name default null,
                        p_code in ntg.dtype.t_code default null,
                        p_details in ntg.dtype.t_msg default null
                      );

  function status_type_get_info ( p_id in ntg.dtype.t_id default null,
                                  p_name in ntg.dtype.t_name default null,
                                  p_code in ntg.dtype.t_code default null,
                                  p_details in ntg.dtype.t_msg default null
                                )
  return SYS_REFCURSOR;

  function event_type_add( p_name in ntg.dtype.t_name default null,
                            p_code in ntg.dtype.t_code default null,
                            p_details in ntg.dtype.t_msg default null
                          )
  return ntg.dtype.t_id;

  procedure event_type_edit ( p_id in ntg.dtype.t_id default null,
                        p_name in ntg.dtype.t_name default null,
                        p_code in ntg.dtype.t_code default null,
                        p_details in ntg.dtype.t_msg default null
                      );

  function event_type_get_info ( p_id in ntg.dtype.t_id default null,
                                  p_name in ntg.dtype.t_name default null,
                                  p_code in ntg.dtype.t_code default null
                                )
  return SYS_REFCURSOR;

  function event_type_get_id (    p_name in ntg.dtype.t_name default null,
                                  p_code in ntg.dtype.t_code default null
                                )
  return ntg.dtype.t_id;

  function trans_type_add( p_name in ntg.dtype.t_name default null,
                            p_code in ntg.dtype.t_code default null,
                            p_details in ntg.dtype.t_msg default null
                          )
  return ntg.dtype.t_id;

  procedure trans_type_edit ( p_id in ntg.dtype.t_id default null,
                        p_name in ntg.dtype.t_name default null,
                        p_code in ntg.dtype.t_code default null,
                        p_details in ntg.dtype.t_msg default null
                      );

  function trans_type_get_info ( p_id in ntg.dtype.t_id default null,
                                  p_name in ntg.dtype.t_name default null,
                                  p_code in ntg.dtype.t_code default null
                                )
  return SYS_REFCURSOR;

  function trans_type_get_id (    p_name in ntg.dtype.t_name default null,
                                  p_code in ntg.dtype.t_code default null
                                )
  return ntg.dtype.t_id;

  function account_type_add( p_name in ntg.dtype.t_name default null,
                            p_code in ntg.dtype.t_code default null,
                            p_priority in ntg.dtype.t_id default null,
                            p_details in ntg.dtype.t_msg default null
                          )
  return ntg.dtype.t_id;

  procedure account_type_edit ( p_id in ntg.dtype.t_id default null,
                        p_name in ntg.dtype.t_name default null,
                        p_code in ntg.dtype.t_code default null,
                        p_details in ntg.dtype.t_msg default null,
                        p_priority in ntg.dtype.t_id default null
                      );

  function account_type_get_info ( p_id in ntg.dtype.t_id default null,
                                  p_name in ntg.dtype.t_name default null,
                                  p_code in ntg.dtype.t_code default null,
                                  p_details in ntg.dtype.t_msg default null,
                                  p_priority in ntg.dtype.t_id default null
                                )
  return SYS_REFCURSOR;


  procedure delay_add( p_contract in ntg.dtype.t_id default null,
                      p_amount in ntg.dtype.t_amount default null,
                      p_transaction in ntg.dtype.t_id default null,
                      p_date_to in ntg.dtype.t_date default null,
                      p_event_type in ntg.dtype.t_id default null,
                      p_status in ntg.dtype.t_status default null,
                      p_priority in ntg.dtype.t_id default null,
                      p_parent_id in ntg.dtype.t_id default null
                    );

  procedure delay_edit ( p_id in ntg.dtype.t_id default null,
                        p_status in ntg.dtype.t_status default null,
                        p_amount in ntg.dtype.t_amount default null,
                        p_event_type   in ntg.dtype.t_id default null,
                        p_transaction  in ntg.dtype.t_id default null,
                        p_parent_id  in ntg.dtype.t_id default null
                      );

  function delay_get_info ( p_id in ntg.dtype.t_id default null,
                            p_contract in ntg.dtype.t_id default null,
                            p_date_to in ntg.dtype.t_date default null,
                            p_event_type in ntg.dtype.t_id default null,
                            p_transaction in ntg.dtype.t_id default null,
                            p_priority in ntg.dtype.t_id default null,
                            p_parent_id in ntg.dtype.t_id default null
                          )
  return SYS_REFCURSOR;

  function delay_get_info_r ( p_id in ntg.dtype.t_id default null,
                            p_contract in ntg.dtype.t_id default null,
                            p_date_to in ntg.dtype.t_date default NULL,
                            p_event_type in ntg.dtype.t_id default null,
                            p_transaction in ntg.dtype.t_id default null,
                            p_priority in ntg.dtype.t_id default null
                          )
  return blng.delay%rowtype;
  
  procedure domain_add( p_name in ntg.dtype.t_name default null,
                      p_company in ntg.dtype.t_id default null,
--                      p_status in ntg.dtype.t_id default null,
                      p_is_domain in ntg.dtype.t_status default null
                    );

  procedure domain_edit ( p_id in ntg.dtype.t_id default null,
                        p_name in ntg.dtype.t_name default null,
                      p_company in ntg.dtype.t_id default null,
                      p_status in ntg.dtype.t_status default null,
                      p_is_domain in ntg.dtype.t_status default null
                      );

  function domain_get_info (p_id in ntg.dtype.t_id default null,
                            p_name in ntg.dtype.t_name default null,
                          p_company in ntg.dtype.t_id default null,
                          p_status in ntg.dtype.t_status default null,
                          p_is_domain in ntg.dtype.t_status default null
                            
                          )
  return SYS_REFCURSOR;

  function domain_get_info_r (p_id in ntg.dtype.t_id default null,
                            p_name in ntg.dtype.t_name default null,
                          p_company in ntg.dtype.t_id default null,
                          p_status in ntg.dtype.t_status default null,
                          p_is_domain in ntg.dtype.t_status default null
                            
                          )
  return blng.domain%rowtype;

  function client_data_add(p_client in ntg.dtype.t_id default null, 
                  p_last_name in ntg.dtype.t_name default null, 
                  p_first_name in ntg.dtype.t_name default null, 
                  p_birth_date in ntg.dtype.t_date default null, 
                  p_gender in ntg.dtype.t_status default null, 
                  p_nationality in ntg.dtype.t_code default null, 
                  p_doc_number in ntg.dtype.t_long_code default null,
                  p_open_date in ntg.dtype.t_date default null, 
                  p_expiry_date in ntg.dtype.t_date default null, 
                  p_owner in ntg.dtype.t_status default null,
                  p_phone in ntg.dtype.t_name default null)
  return ntg.dtype.t_id;

  procedure client_data_edit(p_id in ntg.dtype.t_id, 
                          p_client in ntg.dtype.t_id default null, 
                          p_last_name in ntg.dtype.t_name default null, 
                          p_first_name in ntg.dtype.t_name default null, 
                          p_birth_date in ntg.dtype.t_date default null, 
                          p_gender in ntg.dtype.t_status default null, 
                          p_nationality in ntg.dtype.t_code default null, 
                  p_doc_number in ntg.dtype.t_long_code default null,
                  p_open_date in ntg.dtype.t_date default null, 
                  p_expiry_date in ntg.dtype.t_date default null, 
                  p_owner in ntg.dtype.t_status default null,
                  p_phone in ntg.dtype.t_name default null
  );

  function client_data_get_info( p_id in ntg.dtype.t_id  default null,
                            p_client in ntg.dtype.t_id default null, 
                            p_last_name in ntg.dtype.t_name default null, 
                            p_first_name in ntg.dtype.t_name default null, 
                            p_birth_date in ntg.dtype.t_date default null, 
                            p_gender in ntg.dtype.t_status default null, 
                            p_nationality in ntg.dtype.t_code default null, 
                  p_doc_number in ntg.dtype.t_long_code default null,
                  p_open_date in ntg.dtype.t_date default null, 
                  p_expiry_date in ntg.dtype.t_date default null, 
                  p_owner in ntg.dtype.t_status default null,
                  p_phone in ntg.dtype.t_name default null
  )
  return SYS_REFCURSOR;

  function client_data_get_info_r ( p_id in ntg.dtype.t_id default null,
                                    p_client in ntg.dtype.t_id default null, 
                                    p_last_name in ntg.dtype.t_name default null, 
                                    p_first_name in ntg.dtype.t_name default null, 
                                    p_birth_date in ntg.dtype.t_date default null, 
                                    p_gender in ntg.dtype.t_status default null, 
                                    p_nationality in ntg.dtype.t_code default null, 
                                    p_doc_number in ntg.dtype.t_long_code default null,
                                    p_open_date in ntg.dtype.t_date default null, 
                                    p_expiry_date in ntg.dtype.t_date default null, 
                                    p_owner in ntg.dtype.t_status default null,
                  p_phone in ntg.dtype.t_name default null
                            )
  return blng.client_data%rowtype;



end blng_api;

/

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "BLNG"."BLNG_API" as

  function company_add(p_name in ntg.dtype.t_name,
                  p_utc_offset in ntg.dtype.t_id default null)
  return ntg.dtype.t_id
  is
    v_company_row blng.company%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_company_row.name := p_name;
    v_company_row.utc_offset := nvl(p_utc_offset,3);
    v_company_row.status := 'A';
    insert into blng.company values v_company_row returning id into v_id;
    return v_id;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'company_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=company,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into company error. '||SQLERRM);
  end;

  procedure company_edit(p_id in ntg.dtype.t_id, p_name in ntg.dtype.t_name,
                  p_utc_offset in ntg.dtype.t_id default null)
  is
    v_company_row_new blng.company%rowtype;
    v_company_row_old blng.company%rowtype;
    v_mess ntg.dtype.t_msg;
  begin
    select * into v_company_row_old from blng.company where id = p_id;
    v_company_row_new := v_company_row_old;

    v_company_row_old.amnd_state:='I';
    v_company_row_old.id:=null;
    insert into blng.company values v_company_row_old;

    v_company_row_new.name:=p_name;
    v_company_row_new.utc_offset:=p_utc_offset;
    v_company_row_new.amnd_date:=sysdate;
    v_company_row_new.amnd_user:=user;
    --v_client_row_new.amnd_user:=null;
    update blng.company set row = v_company_row_new where id = p_id;

  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'company_edit', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=company,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'update row into company error. '||SQLERRM);
  end;


  function company_get_info(p_id in ntg.dtype.t_id default null,
                  p_utc_offset in ntg.dtype.t_id default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from blng.company 
        where  id = nvl(p_id,id)
        order by id;
    return v_results;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'company_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=company,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into company error. '||SQLERRM);
  end;


  function company_get_info_r(p_id in ntg.dtype.t_id default null,
                  p_utc_offset in ntg.dtype.t_id default null)
  return blng.company%rowtype
  is
    r_obj  blng.company%rowtype;
  begin
    if p_id is null then raise NO_DATA_FOUND; end if;   
    SELECT
    *
    into r_obj
    from blng.company 
    where id = nvl(p_id,id)
    order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;  
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'company_get_info', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=company,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into company error. '||SQLERRM);
  end;
  
  function client_add(
                        p_company in ntg.dtype.t_id default null, 
                        p_last_name in ntg.dtype.t_name default null, 
                        p_first_name in ntg.dtype.t_name default null, 
                        p_birth_date in ntg.dtype.t_date default null, 
                        p_gender in ntg.dtype.t_status default null, 
                        p_nationality in ntg.dtype.t_code default null, 
                        p_email in ntg.dtype.t_name default null,
                        p_phone in ntg.dtype.t_name default null,
                  p_utc_offset in ntg.dtype.t_id default null
                        )
  return ntg.dtype.t_id
  is
    v_obj_row blng.client%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_obj_row.company_oid := p_company;
    v_obj_row.last_name := upper(p_last_name);
    v_obj_row.first_name := upper(p_first_name);
    v_obj_row.email := lower(p_email);
    v_obj_row.phone := lower(p_phone);
    v_obj_row.birth_date := p_birth_date;
    v_obj_row.nationality := p_nationality;
    v_obj_row.gender := upper(p_gender);
    v_obj_row.utc_offset := nvl(p_utc_offset,3);
    v_obj_row.status := 'A';
    insert into blng.client values v_obj_row returning id into v_id;

    return v_id;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'client_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=client,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into client error. '||SQLERRM);
  end;

  procedure client_edit(p_id in ntg.dtype.t_id,
                        p_company in ntg.dtype.t_id default null, 
                        p_last_name in ntg.dtype.t_name default null, 
                        p_first_name in ntg.dtype.t_name default null, 
                        p_birth_date in ntg.dtype.t_date default null, 
                        p_gender in ntg.dtype.t_status default null, 
                        p_nationality in ntg.dtype.t_code default null, 
                        p_email in ntg.dtype.t_name default null,
                        p_phone in ntg.dtype.t_name default null,
                  p_utc_offset in ntg.dtype.t_id default null)
  is
    v_obj_row_new blng.client%rowtype;
    v_obj_row_old blng.client%rowtype;
    v_mess ntg.dtype.t_msg;
  begin
    select * into v_obj_row_old from blng.client where id = p_id;
    v_obj_row_new := v_obj_row_old;


    v_obj_row_new.last_name:=nvl(upper(p_last_name), v_obj_row_new.last_name);
    v_obj_row_new.first_name:=nvl(upper(p_first_name), v_obj_row_new.first_name);
    v_obj_row_new.birth_date:=nvl(p_birth_date, v_obj_row_new.birth_date);
    v_obj_row_new.gender:=nvl(upper(p_gender), v_obj_row_new.gender);
    v_obj_row_new.company_oid:=nvl(p_company, v_obj_row_new.company_oid);
    v_obj_row_new.nationality:=nvl(p_nationality, v_obj_row_new.nationality);
    v_obj_row_new.email:=nvl(lower(p_email), v_obj_row_new.email);
    v_obj_row_new.phone:=nvl(lower(p_phone), v_obj_row_new.phone);
    v_obj_row_new.utc_offset:=nvl(p_utc_offset, v_obj_row_new.utc_offset);
    --v_obj_row_new.amnd_user:=null;
    
    if 
      nvl(v_obj_row_new.last_name,'X') = nvl(v_obj_row_old.last_name,'X') and
      nvl(v_obj_row_new.first_name,'X') = nvl(v_obj_row_old.first_name,'X') and 
      nvl(to_char(v_obj_row_new.birth_date,'ddmmyyyy'),'X') = nvl(to_char(v_obj_row_old.birth_date,'ddmmyyyy'),'X') and
      nvl(v_obj_row_new.gender,'X') = nvl(v_obj_row_old.gender,'X') and
      v_obj_row_new.company_oid = v_obj_row_old.company_oid and
      nvl(v_obj_row_new.nationality,'X') = nvl(v_obj_row_old.nationality,'X') and
      nvl(v_obj_row_new.email,'X') = nvl(v_obj_row_old.email,'X') and
      v_obj_row_new.utc_offset = v_obj_row_old.utc_offset

    then return; 
    else     
      v_obj_row_new.amnd_date:=sysdate;
      v_obj_row_new.amnd_user:=user;
      v_obj_row_old.amnd_state:='I';
      v_obj_row_old.id:=null;
      insert into blng.client values v_obj_row_old;  
      update blng.client set row = v_obj_row_new where id = p_id;
    end if;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;    
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'client_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=client,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into client error. '||SQLERRM);
  end;


  function client_get_info(p_id in ntg.dtype.t_id,
                        p_company in ntg.dtype.t_id default null, 
                        p_last_name in ntg.dtype.t_name default null, 
                        p_first_name in ntg.dtype.t_name default null, 
                        p_birth_date in ntg.dtype.t_date default null, 
                        p_gender in ntg.dtype.t_status default null, 
                        p_nationality in ntg.dtype.t_code default null, 
                        p_email in ntg.dtype.t_name default null,
                        p_phone in ntg.dtype.t_name default null,
                  p_utc_offset in ntg.dtype.t_id default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from blng.client 
        where id = nvl(p_id,id)
--        and last_name = nvl(p_last_name, last_name)
--        and first_name = nvl(p_first_name, first_name)
--        and birth_date = nvl(p_birth_date, birth_date)
--        and gender = nvl(p_gender, gender)
        and company_oid = nvl(p_company, company_oid)
--        and nationality = nvl(p_nationality, nationality)
        and amnd_state = 'A'
        and email = nvl(lower(p_email), email)
        order by id;
    return v_results;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'client_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=client,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into client error. '||SQLERRM);
  end;

  function client_get_info_r ( p_id in ntg.dtype.t_id,
                        p_company in ntg.dtype.t_id default null, 
                        p_last_name in ntg.dtype.t_name default null, 
                        p_first_name in ntg.dtype.t_name default null, 
                        p_birth_date in ntg.dtype.t_date default null, 
                        p_gender in ntg.dtype.t_status default null, 
                        p_nationality in ntg.dtype.t_code default null, 
                        p_email in ntg.dtype.t_name default null,
                        p_phone in ntg.dtype.t_name default null,
                  p_utc_offset in ntg.dtype.t_id default null
                            )
  return blng.client%rowtype
  is
    r_obj blng.client%rowtype;
  begin
    if p_id is null and p_email is null then raise NO_DATA_FOUND; end if;   
  
    SELECT
    * into r_obj
    from blng.client 
    where id = nvl(p_id,id)
    and email = nvl(lower(p_email), email)
    and amnd_state = 'A'
    order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'client_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=client,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into client error. '||SQLERRM);
  end client_get_info_r;




  procedure client2contract_add( p_client in ntg.dtype.t_id,
                                p_permission in ntg.dtype.t_status,
                                p_contract in ntg.dtype.t_id
                              )
  is
    v_client2contract_row blng.client2contract%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_client2contract_row.client_oid := p_client;
    v_client2contract_row.permission := p_permission;
    v_client2contract_row.contract_oid := p_contract;
    insert into blng.client2contract values v_client2contract_row;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'client2contract_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=client2contract,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into client2contract error. '||SQLERRM);
  end;

  procedure client2contract_edit( 
                                  p_id in ntg.dtype.t_id default null,
                                  p_client in ntg.dtype.t_id default null,
                                  p_contract in ntg.dtype.t_id default null,
                                  p_status in ntg.dtype.t_status default null)
  is
    v_client2contract_row_new blng.client2contract%rowtype;
    v_client2contract_row_old blng.client2contract%rowtype;
    v_mess ntg.dtype.t_msg;
    v_id ntg.dtype.t_id;
  begin
    if p_status is null then raise NO_DATA_FOUND; end if;
    if p_id is null then raise NO_DATA_FOUND; end if; 
    
    select * into v_client2contract_row_old from blng.client2contract
    where id = nvl(p_id,id);

    v_id := v_client2contract_row_old.id;
    v_client2contract_row_new := v_client2contract_row_old;

    v_client2contract_row_old.amnd_state:='I';
    v_client2contract_row_old.id:=null;
    insert into blng.client2contract values v_client2contract_row_old;

    v_client2contract_row_new.amnd_state:=p_status;
    v_client2contract_row_new.amnd_date:=sysdate;
    v_client2contract_row_new.amnd_user:=user;
    --v_client_row_new.amnd_user:=null;
    update blng.client2contract set row = v_client2contract_row_new where id = v_id;
--    commit;
  exception
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;    
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'client2contract_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=client2contract,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into client2contract error. '||SQLERRM);
  end;


  function client2contract_get_info(  p_id in ntg.dtype.t_id default null,
                                      p_client in ntg.dtype.t_id default null,
                                      p_contract in ntg.dtype.t_id default null,
                                      p_permission in ntg.dtype.t_status default null
                                    )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from blng.client2contract
        where client_oid = nvl(p_client,client_oid)
        and contract_oid = nvl(p_contract,contract_oid)
        and permission = nvl(p_permission,permission)

        order by id;
    return v_results;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'client2contract_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=client2contract,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into client2contract error. '||SQLERRM);
  end;



  function contract_add(p_company in ntg.dtype.t_id default null,
                  p_utc_offset in ntg.dtype.t_id default null)
  return ntg.dtype.t_id
  is
    v_contract_row blng.contract%rowtype;
    v_id ntg.dtype.t_id;
    v_number ntg.dtype.t_long_code;
  begin

    select to_char(sysdate,'yyyymmdd')||'-'||p_company||'-'||(count(*) + 1) into v_number from blng.contract where
    id in (select contract_oid from blng.client2contract where client_oid in 
              (select id from blng.client where company_oid = p_company and amnd_state = 'A')
               and amnd_state = 'A'
          ) 
          and amnd_state = 'A';
    v_contract_row.contract_number := v_number;
    v_contract_row.company_oid := p_company;
    v_contract_row.status := 'A';
    insert into blng.contract values v_contract_row returning id into v_id;
    return v_id;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'contract_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=contract,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into contract error. '||SQLERRM);
  end;

  procedure contract_edit(p_id in ntg.dtype.t_id default null, p_number in ntg.dtype.t_long_code default null,
                  p_utc_offset in ntg.dtype.t_id default null)
  is
    v_mess ntg.dtype.t_msg;
    v_contract_row_new blng.contract%rowtype;
    v_contract_row_old blng.contract%rowtype;
  begin
  
    if p_id is null then raise NO_DATA_FOUND; end if; 
    
    select * into v_contract_row_old from blng.contract where id = p_id;
    v_contract_row_new := v_contract_row_old;

    v_contract_row_old.amnd_state:='I';
    v_contract_row_old.id:=null;
    insert into blng.contract values v_contract_row_old;


    v_contract_row_new.amnd_date:=sysdate;
    v_contract_row_new.amnd_user:=user;
    v_contract_row_new.contract_number := p_number;

    update blng.contract set row = v_contract_row_new where id = p_id;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
  when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'contract_edit', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=contract,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'update row into contract error. '||SQLERRM);
  end;


  function contract_get_info(p_id in ntg.dtype.t_id default null,p_company  in ntg.dtype.t_id default null,
                  p_utc_offset in ntg.dtype.t_id default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
    OPEN v_results FOR
      SELECT *
      from blng.contract 
      where id = nvl(p_id,id)
      and company_oid = nvl(p_company,company_oid)
      order by id;
    return v_results;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'contract_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=contract,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into contract error. '||SQLERRM);
  end;

  function contract_get_info_r(p_id in ntg.dtype.t_id default null,p_company  in ntg.dtype.t_id default null,
                  p_utc_offset in ntg.dtype.t_id default null)
  return blng.contract%rowtype
  is
    r_obj blng.contract%rowtype;
  begin
    if p_id is null and p_company is null then raise NO_DATA_FOUND; end if; 
    SELECT *
    into r_obj
    from blng.contract 
    where id = nvl(p_id,id)
    and company_oid = nvl(p_company,company_oid)
    order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;        
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'contract_get_info', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=contract,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into contract error. '||SQLERRM);
  end;


  procedure account_init(p_contract in ntg.dtype.t_id)
  is
  begin
    if p_contract is null then raise NO_DATA_FOUND; end if; 
    insert into blng.account (contract_oid,code ,amount,priority,account_type_oid)
    select --null id,null amnd_date,user amnd_user,'A' amnd_state,null amnd_prev,
    p_contract contract_oid,code,0 amount,priority, id account_type_oid
    from blng.account_type
    where id not in (select account_type_oid from blng.account where contract_oid = p_contract);
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'account_init', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=account,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'insert row into account error. '||SQLERRM);
  end;


  procedure account_edit(       p_id in ntg.dtype.t_id default null,
                               -- p_contract in ntg.dtype.t_id default null,
                               -- p_account_type in ntg.dtype.t_id default null,
                               -- p_code in ntg.dtype.t_code default null,
                                p_amount in ntg.dtype.t_amount default null
                              )
  is
    v_mess ntg.dtype.t_msg;
    v_account_row_new blng.account%rowtype;
    v_account_row_old blng.account%rowtype;
    v_id  ntg.dtype.t_id default null;
  begin
  --if incoming amount is 0 then exit
    if p_amount = 0 then return; end if;
    if p_id is null then raise NO_DATA_FOUND; end if;     
    select * into v_account_row_old from blng.account
      where id = nvl(p_id,id)
      and amnd_state = 'A';

    v_id := v_account_row_old.id;

    v_account_row_new := v_account_row_old;
    --change status for OLD and insert as history
    v_account_row_old.amnd_state:='I';
    v_account_row_old.id:=null;
    insert into blng.account values v_account_row_old;

    -- change date ,etc for new and update with incoming info. update row.
    v_account_row_new.amnd_date:=sysdate;
    v_account_row_new.amnd_user:=user;
    v_account_row_new.amount := v_account_row_new.amount + p_amount;

    update blng.account set row = v_account_row_new where id = v_id;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'account_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=account,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into account error. '||SQLERRM);
  end;

  function account_get_info ( p_id in ntg.dtype.t_id default null,
                              p_contract in ntg.dtype.t_id default null,
                              p_code in ntg.dtype.t_code default null,
                              p_account_type in ntg.dtype.t_id default null,
                              p_filter_amount in ntg.dtype.t_amount  default null
                            )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
    OPEN v_results FOR
      SELECT
      *
      from blng.account
      where id = nvl(p_id,id)
      and contract_oid = nvl(p_contract,contract_oid)
      and code = nvl(p_code,code)
      and account_type_oid = nvl(p_account_type,account_type_oid)
      and amnd_state = 'A'
      and decode(p_filter_amount,null,0,amount)<> decode(p_filter_amount,null,-1,p_filter_amount)
      order by contract_oid, priority
      ;
    return v_results;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'account_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=account,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into account error. '||SQLERRM);
  end account_get_info;

  function account_get_info_r ( p_id in ntg.dtype.t_id default null,
                              p_contract in ntg.dtype.t_id default null,
                              p_code in ntg.dtype.t_code default null,
                              p_account_type in ntg.dtype.t_id default null
                            )
  return blng.account%rowtype
  is
    r_obj blng.account%rowtype;
  begin
    SELECT
    * into r_obj
    from blng.account
    where id = nvl(p_id,id)
    and contract_oid = nvl(p_contract,contract_oid)
    and code = nvl(p_code,code)
    and account_type_oid = nvl(p_account_type,account_type_oid)
    and amnd_state = 'A'
    order by contract_oid, priority;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'account_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=account,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into account error. '||SQLERRM);
  end account_get_info_r;

  function document_add ( p_contract in ntg.dtype.t_id default null,
                          p_amount in ntg.dtype.t_amount default null,
                          p_trans_type in ntg.dtype.t_id default null,
                          p_bill in ntg.dtype.t_id default null
                        )
  return ntg.dtype.t_id
  is
    v_document_row blng.document%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_document_row.contract_oid := p_contract;
    v_document_row.amount := p_amount;
    v_document_row.trans_type_oid := p_trans_type;
    v_document_row.doc_date := sysdate;
    v_document_row.bill_oid := p_bill;
    insert into blng.document values v_document_row returning id into v_id;
    return v_id;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'document_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=document,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into document error. '||SQLERRM);
  end;

  procedure document_edit(p_id in ntg.dtype.t_id, p_status in ntg.dtype.t_status default null)
  is
    v_mess ntg.dtype.t_msg;
    v_document_row_new blng.document%rowtype;
    v_document_row_old blng.document%rowtype;
  begin

    select * into v_document_row_old from blng.document where id = p_id;
    v_document_row_new := v_document_row_old;

    v_document_row_old.amnd_state:='I';
    v_document_row_old.id:=null;
    insert into blng.document values v_document_row_old;


    v_document_row_new.amnd_date:=sysdate;
    v_document_row_new.amnd_user:=user;
    v_document_row_new.status := p_status;

    update blng.document set row = v_document_row_new where id = v_document_row_new.id;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'document_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=document,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into document error. '||SQLERRM);
  end;

  function document_get_info( p_id in ntg.dtype.t_id default null,
                              p_contract in ntg.dtype.t_id  default null,
                              p_trans_type in ntg.dtype.t_id  default null,
                              p_status in ntg.dtype.t_status  default null,
                              p_bill in ntg.dtype.t_id default null
                            )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
/*
$TODO: all this nullable fields are bad. document_get_info
*/  
    if p_bill is not null then  
      OPEN v_results FOR
        SELECT
        *
        from blng.document
        where id = nvl(p_id,id)
        and contract_oid = nvl(p_contract,contract_oid)
        and trans_type_oid = nvl(p_trans_type,trans_type_oid)
        and status = nvl(p_status,status)
        and bill_oid = p_bill
        and amnd_state = 'A'
        order by contract_oid, id asc;
    else
      OPEN v_results FOR
        SELECT
        *
        from blng.document
        where id = nvl(p_id,id)
        and contract_oid = nvl(p_contract,contract_oid)
        and trans_type_oid = nvl(p_trans_type,trans_type_oid)
        and status = nvl(p_status,status)
        and amnd_state = 'A'
        order by contract_oid, id asc;    
    end if;
    return v_results;
  exception
    when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'document_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=document,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into document error. '||SQLERRM);
  end;

  function document_get_info_r( p_id in ntg.dtype.t_id default null,
                              p_contract in ntg.dtype.t_id  default null,
                              p_trans_type in ntg.dtype.t_id  default null,
                              p_status in ntg.dtype.t_status  default null,
                          p_bill in ntg.dtype.t_id default null
                            )
  return blng.document%rowtype
  is

    r_obj blng.document%rowtype;
  begin
    if p_bill is not null then  
        SELECT
        * into r_obj
        from blng.document
        where bill_oid = p_bill
        and amnd_state = 'A'
        order by contract_oid, id asc;
    else
        SELECT
        * into r_obj
        from blng.document
        where id = nvl(p_id,id)
        and amnd_state = 'A'
        order by contract_oid, id asc;    
    end if;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;    
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'document_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=document,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into document error. '||SQLERRM);
  end document_get_info_r;


  function transaction_add ( p_doc in ntg.dtype.t_id  default null,
                          p_amount in ntg.dtype.t_amount  default null,
                          p_trans_type in ntg.dtype.t_id  default null,
                          p_trans_date in ntg.dtype.t_date  default null,
                          p_target_account in ntg.dtype.t_id  default null,
                          p_status in ntg.dtype.t_status  default 'P',
                          p_prev in ntg.dtype.t_id  default null

                        )
  return ntg.dtype.t_id
  is
    v_transaction_row blng.transaction%rowtype;
    v_id ntg.dtype.t_id;
  begin
    if p_amount = 0 or p_amount is null then raise ntg.dtype.exit_alert; end if;
    --if p_doc is null then raise_application_error(-20003, 'doc is null'); end if;
    if p_trans_type is null then raise_application_error(-20003, 'p_trans_type is null'); end if;
    if p_target_account is null then  raise_application_error(-20003, 'p_target_account is null'); end if;


    v_transaction_row.doc_oid := p_doc;
    v_transaction_row.target_account_oid := p_target_account;
    v_transaction_row.trans_date := nvl(p_trans_date,sysdate);
    v_transaction_row.amount := p_amount;
    v_transaction_row.trans_type_oid := p_trans_type;
    v_transaction_row.status := p_status;
    v_transaction_row.amnd_prev := p_prev;
    insert into blng.transaction values v_transaction_row returning id into v_id;

    return v_id;
  exception
    when ntg.dtype.exit_alert then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'transaction_add', p_msg_type=>'ntg.dtype.exit_alert',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=transaction,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      raise;
    when ntg.dtype.value_error then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'transaction_add', p_msg_type=>'ntg.dtype.value_error',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=transaction,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      raise;
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'transaction_add', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=transaction,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'insert row into transaction error. '||SQLERRM);
  end;

  function transaction_add_with_acc ( p_doc in ntg.dtype.t_id  default null,
                          p_amount in ntg.dtype.t_amount  default null,
                          p_trans_type in ntg.dtype.t_id  default null,
                          p_trans_date in ntg.dtype.t_date  default null,
                          p_target_account in ntg.dtype.t_id  default null,
                          p_status in ntg.dtype.t_status  default 'P',
                          p_prev in ntg.dtype.t_id  default null
                        )
  return ntg.dtype.t_id
  is
    v_transaction  ntg.dtype.t_id;
  begin
    v_transaction := BLNG.BLNG_API.transaction_add( P_DOC,
                                                    P_AMOUNT,
                                                    P_TRANS_TYPE,
                                                    P_TRANS_DATE,
                                                    P_TARGET_ACCOUNT,
                                                    p_status,
                                                    p_prev
                                                  );
      BLNG.BLNG_API.account_edit(                   P_ID => P_TARGET_ACCOUNT,
                                                    P_AMOUNT => P_AMOUNT
                                );

    return v_transaction;
  exception
    when ntg.dtype.exit_alert then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'transaction_add_with_acc', p_msg_type=>'ntg.dtype.exit_alert',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      raise;
    when ntg.dtype.value_error then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'transaction_add_with_acc', p_msg_type=>'ntg.dtype.value_error',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      raise;
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'transaction_add_with_acc', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'insert row into transaction error. '||SQLERRM);
  end;

  procedure transaction_edit(p_id in ntg.dtype.t_id, p_status ntg.dtype.t_status default 'P')
  is
    v_mess ntg.dtype.t_msg;
    v_transaction_row_new blng.transaction%rowtype;
    v_transaction_row_old blng.transaction%rowtype;
  begin
    if p_id is null then raise NO_DATA_FOUND; end if; 
    
    select * into v_transaction_row_old from blng.transaction where id = p_id;
    v_transaction_row_new := v_transaction_row_old;

    v_transaction_row_old.amnd_state:='I';
    v_transaction_row_old.id:=null;
    insert into blng.transaction values v_transaction_row_old;


    v_transaction_row_new.amnd_date:=sysdate;
    v_transaction_row_new.amnd_user:=user;
    v_transaction_row_new.status := p_status;

    update blng.transaction set row = v_transaction_row_new where id = v_transaction_row_new.id;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'transaction_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=transaction,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into transaction error. '||SQLERRM);
  end;

  function transaction_get_info( p_id in ntg.dtype.t_id default null,
                              p_doc in ntg.dtype.t_id default null,
                              p_trans_type in ntg.dtype.t_id default null,
                              p_target_account in ntg.dtype.t_id default null,
                              p_status in ntg.dtype.t_status default null
                            )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
    OPEN v_results FOR
      SELECT 
      *
      from blng.transaction
      where id = nvl(p_id,id)
      and doc_oid = nvl(p_doc,doc_oid)
      and trans_type_oid = nvl(p_trans_type,trans_type_oid)
      and target_account_oid = nvl(p_target_account,target_account_oid)
      and status = nvl(p_status,status)
      and amnd_state = 'A'
      order by id;
    return v_results;
  exception 
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'transaction_get_info', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=transaction,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into transaction error. '||SQLERRM);
  end;




  function event_add( p_contract in ntg.dtype.t_id default null,
                      p_amount in ntg.dtype.t_amount default null,
                      p_transaction in ntg.dtype.t_id default null,
                      p_date_to in ntg.dtype.t_date default null,
                      p_event_type in ntg.dtype.t_id default null,
                      p_status in ntg.dtype.t_status default null,
                      p_priority in ntg.dtype.t_id default null
                    )
  return ntg.dtype.t_id 
  is
    v_event_row blng.event%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_event_row.contract_oid := p_contract;
    v_event_row.amount := p_amount;
    v_event_row.transaction_oid := p_transaction;
    v_event_row.date_to := p_date_to;
    v_event_row.event_type_oid := p_event_type;
    v_event_row.status := p_status;
    v_event_row.priority := p_priority;
    insert into blng.event values v_event_row returning id into v_id;
    return v_id;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'event_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=event,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into event error. '||SQLERRM);
  end;

  procedure event_edit ( p_id in ntg.dtype.t_id default null,
                        p_status in ntg.dtype.t_status default null,
                        p_amount in ntg.dtype.t_amount default null
                      )
  is
    v_event_row_new blng.event%rowtype;
    v_event_row_old blng.event%rowtype;
  begin
    select * into v_event_row_old from blng.event where id = p_id;
    v_event_row_new := v_event_row_old;

    v_event_row_old.id:=null;
    v_event_row_old.amnd_state :='I';
    insert into blng.event values v_event_row_old;

    v_event_row_new.amnd_date:=sysdate;
    v_event_row_new.amnd_user:=user;
    v_event_row_new.status:=p_status;
    v_event_row_new.amount:=p_amount;

    update blng.event set row = v_event_row_new where id = p_id;
    
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'eventn_edit', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=event,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'update row into event error. '||SQLERRM);
  end;

  function event_get_info ( p_id in ntg.dtype.t_id default null,
                            p_contract in ntg.dtype.t_id default null,
                            p_date_to in ntg.dtype.t_date default null,
                            p_event_type in ntg.dtype.t_id default null,
                            p_status in ntg.dtype.t_status default null,
                            p_priority in ntg.dtype.t_id default null
                          )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
    OPEN v_results FOR
      SELECT id, event_type_oid, transaction_oid, date_to, contract_oid, amount, status, priority
      from blng.event
      where id = nvl(p_id,id)
      and contract_oid = nvl(p_contract,contract_oid)
      and date_to = nvl(p_date_to,date_to)
      and event_type_oid = nvl(p_event_type,event_type_oid)
      and status = nvl(p_status,status)
      and priority = nvl(p_priority,priority)
      and amnd_state = 'A'
      order by id desc;
    return v_results;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
  when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'event_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=event,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into event error. '||SQLERRM);
  end;


  function status_type_add( p_name in ntg.dtype.t_name default null,
                            p_code in ntg.dtype.t_code default null,
                            p_details in ntg.dtype.t_msg default null
                          )
  return ntg.dtype.t_id 
  is
    v_status_type_row blng.status_type%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_status_type_row.name := p_name;
    v_status_type_row.code := p_code;
    v_status_type_row.details := p_details;
    insert into blng.status_type values v_status_type_row returning id into v_id;
    return v_id;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'status_type_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=status_type,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into status_type error. '||SQLERRM);
  end;

  function event_type_add( p_name in ntg.dtype.t_name default null,
                            p_code in ntg.dtype.t_code default null,
                            p_details in ntg.dtype.t_msg default null
                          )
  return ntg.dtype.t_id
  is
    v_event_type_row blng.event_type%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_event_type_row.name := p_name;
    v_event_type_row.code := p_code;
    v_event_type_row.details := p_details;
    insert into blng.event_type values v_event_type_row returning id into v_id;
    return v_id;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'event_type_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=event_type,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into event_type error. '||SQLERRM);
  end;

  function account_type_add( p_name in ntg.dtype.t_name default null,
                            p_code in ntg.dtype.t_code default null,
                            p_priority in ntg.dtype.t_id default null,
                            p_details in ntg.dtype.t_msg default null
                          )
  return ntg.dtype.t_id
  is
    v_account_type_row blng.account_type%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_account_type_row.name := p_name;
    v_account_type_row.code := p_code;
    v_account_type_row.priority := p_priority;
    v_account_type_row.details := p_details;
    insert into blng.account_type values v_account_type_row returning id into v_id;
    return v_id;
  exception 
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'account_type_add', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=account_type,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'insert row into account_type error. '||SQLERRM);
  end;

  function trans_type_add( p_name in ntg.dtype.t_name default null,
                            p_code in ntg.dtype.t_code default null,
                            p_details in ntg.dtype.t_msg default null
                          )
  return ntg.dtype.t_id
  is
    v_trans_type_row blng.trans_type%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_trans_type_row.name := p_name;
    v_trans_type_row.code := p_code;
    v_trans_type_row.details := p_details;
    insert into blng.trans_type values v_trans_type_row returning id into v_id;
    return v_id;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'trans_type_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=trans_type,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into trans_type error. '||SQLERRM);
  end;

  procedure status_type_edit ( p_id in ntg.dtype.t_id default null,
                        p_name in ntg.dtype.t_name default null,
                        p_code in ntg.dtype.t_code default null,
                        p_details in ntg.dtype.t_msg default null
                      )
  is
    v_mess ntg.dtype.t_msg;
    v_status_type_row_new blng.status_type%rowtype;
    v_status_type_row_old blng.status_type%rowtype;
  begin
    select * into v_status_type_row_old from blng.status_type where id = p_id;
    v_status_type_row_new := v_status_type_row_old;

    v_status_type_row_new.amnd_date:=sysdate;
    v_status_type_row_new.amnd_user:=user;
    v_status_type_row_new.name:=nvl(p_name,v_status_type_row_new.name);
    v_status_type_row_new.code:=nvl(p_code,v_status_type_row_new.code);
    v_status_type_row_new.details:=nvl(p_details,v_status_type_row_new.details);

    if  (   v_status_type_row_new.code <> v_status_type_row_old.code
        or  v_status_type_row_new.details <> v_status_type_row_old.details
        or  v_status_type_row_new.name <> v_status_type_row_old.name
        )
    then
      v_status_type_row_old.id:=null;
      v_status_type_row_old.amnd_state :='I';
      insert into blng.status_type values v_status_type_row_old;


      update blng.status_type set row = v_status_type_row_new where id = p_id;

    end if;

  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
  when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'status_type_edit', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=status_type,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'update row into status_type error. '||SQLERRM);
  end;

  procedure trans_type_edit ( p_id in ntg.dtype.t_id default null,
                        p_name in ntg.dtype.t_name default null,
                        p_code in ntg.dtype.t_code default null,
                        p_details in ntg.dtype.t_msg default null
                      )
  is
    v_mess ntg.dtype.t_msg;
    v_trans_type_row_new blng.trans_type%rowtype;
    v_trans_type_row_old blng.trans_type%rowtype;
  begin
    select * into v_trans_type_row_old from blng.trans_type where id = p_id;
    v_trans_type_row_new := v_trans_type_row_old;

    v_trans_type_row_new.amnd_date:=sysdate;
    v_trans_type_row_new.amnd_user:=user;
    v_trans_type_row_new.name:=nvl(p_name,v_trans_type_row_new.name);
    v_trans_type_row_new.code:=nvl(p_code,v_trans_type_row_new.code);
    v_trans_type_row_new.details:=nvl(p_details,v_trans_type_row_new.details);

    if  (   v_trans_type_row_new.code <> v_trans_type_row_old.code
        or  v_trans_type_row_new.details <> v_trans_type_row_old.details
        or  v_trans_type_row_new.name <> v_trans_type_row_old.name
        )
    then
      v_trans_type_row_old.id:=null;
      v_trans_type_row_old.amnd_state :='I';
      insert into blng.trans_type values v_trans_type_row_old;

      update blng.trans_type set row = v_trans_type_row_new where id = v_trans_type_row_new.id;

    end if;

  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
  when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'trans_type_edit', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=trans_type,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'update row into trans_type error. '||SQLERRM);
  end;

  procedure event_type_edit ( p_id in ntg.dtype.t_id default null,
                        p_name in ntg.dtype.t_name default null,
                        p_code in ntg.dtype.t_code default null,
                        p_details in ntg.dtype.t_msg default null
                      )
  is
    v_mess ntg.dtype.t_msg;
    v_event_type_row_new blng.event_type%rowtype;
    v_event_type_row_old blng.event_type%rowtype;
  begin
    select * into v_event_type_row_old from blng.event_type where id = p_id;
    v_event_type_row_new := v_event_type_row_old;

    v_event_type_row_new.amnd_date:=sysdate;
    v_event_type_row_new.amnd_user:=user;
    v_event_type_row_new.name:=nvl(p_name,v_event_type_row_new.name);
    v_event_type_row_new.code:=nvl(p_code,v_event_type_row_new.code);
    v_event_type_row_new.details:=nvl(p_details,v_event_type_row_new.details);

    if  (   v_event_type_row_new.code <> v_event_type_row_old.code
        or  v_event_type_row_new.details <> v_event_type_row_old.details
        or  v_event_type_row_new.name <> v_event_type_row_old.name
        )
    then
      v_event_type_row_old.id:=null;
      v_event_type_row_old.amnd_state :='I';
      insert into blng.event_type values v_event_type_row_old;

      update blng.event_type set row = v_event_type_row_new where id = v_event_type_row_new.id;

    end if;

  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
  when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'event_type_edit', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=event_type,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'update row into event_type error. '||SQLERRM);
  end;


  procedure account_type_edit ( p_id in ntg.dtype.t_id default null,
                        p_name in ntg.dtype.t_name default null,
                        p_code in ntg.dtype.t_code default null,
                        p_details in ntg.dtype.t_msg default null,
                        p_priority in ntg.dtype.t_id default null
                      )
  is
    v_mess ntg.dtype.t_msg;
    v_account_type_row_new blng.account_type%rowtype;
    v_account_type_row_old blng.account_type%rowtype;
  begin
    select * into v_account_type_row_old from blng.account_type where id = p_id;
    v_account_type_row_new := v_account_type_row_old;

    v_account_type_row_new.amnd_date:=sysdate;
    v_account_type_row_new.amnd_user:=user;
    v_account_type_row_new.name:=nvl(p_name,v_account_type_row_new.name);
    v_account_type_row_new.code:=nvl(p_code,v_account_type_row_new.code);
    v_account_type_row_new.details:=nvl(p_details,v_account_type_row_new.details);
    v_account_type_row_new.priority:=nvl(p_priority,v_account_type_row_new.priority);

    if  (   v_account_type_row_new.code <> v_account_type_row_old.code
        or  v_account_type_row_new.details <> v_account_type_row_old.details
        or  v_account_type_row_new.priority <> v_account_type_row_old.priority
        or  v_account_type_row_new.name <> v_account_type_row_old.name
        )
    then
      v_account_type_row_old.id:=null;
      v_account_type_row_old.amnd_state :='I';
      insert into blng.account_type values v_account_type_row_old;

      update blng.account_type set row = v_account_type_row_new where id = v_account_type_row_new.id;

    end if;

  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
  when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'account_type_edit', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=account_type,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'update row into account_type error. '||SQLERRM);
  end;

  function account_type_get_info ( p_id in ntg.dtype.t_id default null,
                                  p_name in ntg.dtype.t_name default null,
                                  p_code in ntg.dtype.t_code default null,
                                  p_details in ntg.dtype.t_msg default null,
                                  p_priority in ntg.dtype.t_id default null
                                )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
    OPEN v_results FOR
      SELECT 
      *
      from blng.account_type
      where id = nvl(p_id,id)
      and name = nvl(p_name,name)
      and code = nvl(p_code,code)
      and details = nvl(p_details,details)
      and priority = nvl(p_priority,priority)
      and amnd_state = 'A';
    return v_results;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
  when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'account_type_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=account_type,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into account_type error. '||SQLERRM);
  end;

  function trans_type_get_info ( p_id in ntg.dtype.t_id default null,
                                  p_name in ntg.dtype.t_name default null,
                                  p_code in ntg.dtype.t_code default null
                                )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
    OPEN v_results FOR
      SELECT 
      *
      from blng.trans_type
      where id = nvl(p_id,id)
      and name = nvl(p_name,name)
      and code = nvl(p_code,code)
      and amnd_state = 'A';
    return v_results;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
  when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'trans_type_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=trans_type,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into trans_type error. '||SQLERRM);
  end;

  function trans_type_get_id (    p_name in ntg.dtype.t_name default null,
                                  p_code in ntg.dtype.t_code default null
                                )
  return ntg.dtype.t_id
  is
    v_results  ntg.dtype.t_id;
  begin
    SELECT id into v_results
      from blng.trans_type
      where name = nvl(p_name,name)
      and code = nvl(p_code,code)
      and amnd_state = 'A';
    return v_results;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
  when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'trans_type_get_id', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=trans_type,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into trans_type error. '||SQLERRM);
  end;

  function event_type_get_info ( p_id in ntg.dtype.t_id default null,
                                  p_name in ntg.dtype.t_name default null,
                                  p_code in ntg.dtype.t_code default null
                                )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
    OPEN v_results FOR
      SELECT 
      *
      from blng.event_type
      where id = nvl(p_id,id)
      and name = nvl(p_name,name)
      and code = nvl(p_code,code)
      and amnd_state = 'A';
    return v_results;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
  when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'event_type_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=event_type,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into event_type error. '||SQLERRM);
  end;

  function event_type_get_id (    p_name in ntg.dtype.t_name default null,
                                  p_code in ntg.dtype.t_code default null
                                )
  return ntg.dtype.t_id
  is
    v_results ntg.dtype.t_id;
  begin
      SELECT id into v_results
      from blng.event_type
      where name = nvl(p_name,name)
      and code = nvl(p_code,code)
      and amnd_state = 'A';
    return v_results;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
  when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'event_type_get_id', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=event_type,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into event_type error. '||SQLERRM);
  end;


  function status_type_get_info ( p_id in ntg.dtype.t_id default null,
                                  p_name in ntg.dtype.t_name default null,
                                  p_code in ntg.dtype.t_code default null,
                                  p_details in ntg.dtype.t_msg default null
                                )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
    OPEN v_results FOR
      SELECT 
      *
      from blng.status_type
      where id = nvl(p_id,id)
      and name = nvl(p_name,name)
      and code = nvl(p_code,code)
      and details = nvl(p_details,details)
      and amnd_state = 'A';
    return v_results;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
  when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'status_type_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=status_type,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into status_type error. '||SQLERRM);
  end;


  procedure delay_add( p_contract in ntg.dtype.t_id default null,
                      p_amount in ntg.dtype.t_amount default null,
                      p_transaction in ntg.dtype.t_id default null,
                      p_date_to in ntg.dtype.t_date default null,
                      p_event_type in ntg.dtype.t_id default null,
                      p_status in ntg.dtype.t_status default null,
                      p_priority in ntg.dtype.t_id default null,
                      p_parent_id in ntg.dtype.t_id default null
                    )
  is
    v_delay_row blng.delay%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_delay_row.contract_oid := p_contract;
    v_delay_row.amount := p_amount;
    v_delay_row.transaction_oid := p_transaction;
    v_delay_row.date_to := nvl(p_date_to,trunc(sysdate));
    v_delay_row.event_type_oid := p_event_type;
    v_delay_row.priority := p_priority;
    v_delay_row.parent_id := p_parent_id;
    v_delay_row.status := 'A';
    insert into blng.delay values v_delay_row;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'delay_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=delay,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into delay error. '||SQLERRM);
  end;

  procedure delay_edit ( p_id in ntg.dtype.t_id default null,
                        p_status in ntg.dtype.t_status default null,
                        p_amount in ntg.dtype.t_amount default null,
                        p_event_type   in ntg.dtype.t_id default null,
                        p_transaction  in ntg.dtype.t_id default null,
                        p_parent_id  in ntg.dtype.t_id default null
                      )
  is
    v_mess ntg.dtype.t_msg;
    v_delay_row_new blng.delay%rowtype;
    v_delay_row_old blng.delay%rowtype;
  begin
--its bad idea to add there more then id filters. all this filters can be edited.
--so it parameter cant be as filter and edited value
    select * into v_delay_row_old from blng.delay
    where id = p_id
    ;

    v_delay_row_new := v_delay_row_old;

    v_delay_row_old.id:=null;
    v_delay_row_old.amnd_state :='I';
    insert into blng.delay values v_delay_row_old;

    v_delay_row_new.amnd_date:=sysdate;
    v_delay_row_new.amnd_user:=user;
    v_delay_row_new.transaction_oid:=nvl(p_transaction, v_delay_row_new.transaction_oid);
    v_delay_row_new.event_type_oid := nvl(p_event_type, v_delay_row_new.event_type_oid);
    if p_status in ('C') then v_delay_row_new.amnd_state :='C'; v_delay_row_new.status :='C'; end if;
    if p_status in ('A') then v_delay_row_new.amnd_state :='A'; v_delay_row_new.status :='A'; end if;
    if p_status in ('R') then v_delay_row_new.amnd_state :='R'; v_delay_row_new.status :='R'; end if;
    if p_status in ('I') then v_delay_row_new.amnd_state :='I'; v_delay_row_new.status :='I'; end if;

    v_delay_row_new.amount:=v_delay_row_new.amount + nvl(p_amount,0);
    v_delay_row_new.parent_id:= nvl(p_parent_id, v_delay_row_new.parent_id);

    update blng.delay set row = v_delay_row_new where id = v_delay_row_new.id;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
  when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'delay_edit', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=delay,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'update row into delay error. '||SQLERRM);
  end;

  function delay_get_info ( p_id in ntg.dtype.t_id default null,
                            p_contract in ntg.dtype.t_id default null,
                            p_date_to in ntg.dtype.t_date default NULL,
                            p_event_type in ntg.dtype.t_id default null,
                            p_transaction in ntg.dtype.t_id default null,
                            p_priority in ntg.dtype.t_id default null,
                            p_parent_id in ntg.dtype.t_id default null
                            
                          )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
    OPEN v_results FOR
      SELECT 
      *
      from blng.delay
      where id = nvl(p_id,id)
      and contract_oid = nvl(p_contract,contract_oid)
      and transaction_oid = nvl(p_transaction,transaction_oid)
      and event_type_oid = nvl(p_event_type,event_type_oid)
      and priority = nvl(p_priority,priority)
      and amnd_state != 'I'
      order by contract_oid asc, date_to asc, id asc;
    return v_results;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;    
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'delay_get_info', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=delay,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into delay error. '||SQLERRM);
  end;


  function delay_get_info_r ( p_id in ntg.dtype.t_id default null,
                            p_contract in ntg.dtype.t_id default null,
                            p_date_to in ntg.dtype.t_date default NULL,
                            p_event_type in ntg.dtype.t_id default null,
                            p_transaction in ntg.dtype.t_id default null,
                            p_priority in ntg.dtype.t_id default null
                          )
  return blng.delay%rowtype
  is
    msg ntg.dtype.t_msg;
    c_delay  SYS_REFCURSOR;
    r_obj blng.delay%rowtype;
  begin
      SELECT 
      * into r_obj
      from blng.delay
      where id = nvl(p_id,id)
      and contract_oid = nvl(p_contract,contract_oid)
      and transaction_oid = nvl(p_transaction,transaction_oid)
      and event_type_oid = nvl(p_event_type,event_type_oid)
      and priority = nvl(p_priority,priority)
      and amnd_state != 'I'
      order by contract_oid asc, date_to asc, id asc;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;    
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'delay_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=delay,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into delay error. '||SQLERRM);
  end delay_get_info_r;


  procedure domain_add( p_name in ntg.dtype.t_name default null,
                      p_company in ntg.dtype.t_id default null,
--                      p_status in ntg.dtype.t_id default null,
                      p_is_domain in ntg.dtype.t_status default null
                    )
  is
    v_obj_row blng.domain%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_obj_row.name := p_name;
    v_obj_row.company_oid := p_company;
    v_obj_row.is_domain := p_is_domain;
    v_obj_row.status := 'A';
    insert into blng.domain values v_obj_row;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'domain_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=domain,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into domain error. '||SQLERRM);
  end;


  procedure domain_edit ( p_id in ntg.dtype.t_id default null,
                        p_name in ntg.dtype.t_name default null,
                      p_company in ntg.dtype.t_id default null,
                      p_status in ntg.dtype.t_status default null,
                      p_is_domain in ntg.dtype.t_status default null
                      )
  is
    v_mess ntg.dtype.t_msg;
    v_obj_row_new blng.domain%rowtype;
    v_obj_row_old blng.domain%rowtype;
  begin

    select * into v_obj_row_old from blng.domain
    where id = p_id
    ;

    v_obj_row_new := v_obj_row_old;

    v_obj_row_old.id:=null;
    v_obj_row_old.amnd_state :='I';
    insert into blng.domain values v_obj_row_old;

    v_obj_row_new.amnd_date:=sysdate;
    v_obj_row_new.amnd_user:=user;
    v_obj_row_new.name:=nvl(p_name, v_obj_row_new.name);
    v_obj_row_new.company_oid := nvl(p_company, v_obj_row_new.company_oid);
    v_obj_row_new.is_domain := nvl(p_is_domain, v_obj_row_new.is_domain);

    if p_status in ('C') then v_obj_row_new.amnd_state :='C'; v_obj_row_new.status :='C'; end if;
    if p_status in ('I') then v_obj_row_new.status :='I'; end if;
    if p_status in ('A') then v_obj_row_new.status :='A'; end if;


    update blng.domain set row = v_obj_row_new where id = v_obj_row_new.id;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
  when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'delay_edit', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=domain,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'update row into domain error. '||SQLERRM);
  end;



  function domain_get_info (p_id in ntg.dtype.t_id default null,
                            p_name in ntg.dtype.t_name default null,
                          p_company in ntg.dtype.t_id default null,
                          p_status in ntg.dtype.t_status default null,
                          p_is_domain in ntg.dtype.t_status default null
                            
                          )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
    OPEN v_results FOR
      SELECT 
      *
      from blng.domain
      where id = nvl(p_id,id)
      and company_oid = nvl(p_company,company_oid)
      and name = nvl(p_name,name)
      and status = nvl(p_status,'A')
      and is_domain = nvl(p_is_domain,is_domain)
      and amnd_state = 'A';
    return v_results;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;    
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'domain_get_info', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=domain,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into domain error. '||SQLERRM);
  end;

  function domain_get_info_r (p_id in ntg.dtype.t_id default null,
                            p_name in ntg.dtype.t_name default null,
                          p_company in ntg.dtype.t_id default null,
                          p_status in ntg.dtype.t_status default null,
                          p_is_domain in ntg.dtype.t_status default null
                            
                          )
  return blng.domain%rowtype
  is
    r_obj blng.domain%rowtype;
  begin
      SELECT 
      * into r_obj
      from blng.domain
      where id = nvl(p_id,id)
      and name = nvl(p_name,name)
      and amnd_state = 'A';
    return r_obj;
  exception 
    when NO_DATA_FOUND then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'domain_get_info_r', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=domain,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
        raise;
    when TOO_MANY_ROWS then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'domain_get_info_r', p_msg_type=>'TOO_MANY_ROWS',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=domain,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
        raise;
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'domain_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=domain,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into domain error. '||SQLERRM);
  end;


  function client_data_add(
                          p_client in ntg.dtype.t_id default null, 
                          p_last_name in ntg.dtype.t_name default null, 
                          p_first_name in ntg.dtype.t_name default null, 
                          p_birth_date in ntg.dtype.t_date default null, 
                          p_gender in ntg.dtype.t_status default null, 
                          p_nationality in ntg.dtype.t_code default null, 
                          p_doc_number in ntg.dtype.t_long_code default null,
                          p_open_date in ntg.dtype.t_date default null, 
                          p_expiry_date in ntg.dtype.t_date default null, 
                          p_owner in ntg.dtype.t_status default null,
                        p_phone in ntg.dtype.t_name default null
                          )
  return ntg.dtype.t_id
  is
    v_obj_row blng.client_data%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_obj_row.client_oid := p_client;
    v_obj_row.last_name := upper(p_last_name);
    v_obj_row.first_name := upper(p_first_name);
    v_obj_row.birth_date := p_birth_date;
    v_obj_row.nationality := p_nationality;
    v_obj_row.gender := upper(p_gender);
    v_obj_row.doc_number := upper(p_doc_number);
    v_obj_row.open_date := p_open_date;
    v_obj_row.expiry_date := p_expiry_date;
    v_obj_row.owner := upper(p_owner);
    v_obj_row.phone := p_phone;

    insert into blng.client_data values v_obj_row returning id into v_id;
    return v_id;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'client_data_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert,p_table=client_data,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into client_data error. '||SQLERRM);
  end;

  procedure client_data_edit(p_id in ntg.dtype.t_id,
                          p_client in ntg.dtype.t_id default null, 
                          p_last_name in ntg.dtype.t_name default null, 
                          p_first_name in ntg.dtype.t_name default null, 
                          p_birth_date in ntg.dtype.t_date default null, 
                          p_gender in ntg.dtype.t_status default null, 
                          p_nationality in ntg.dtype.t_code default null, 
                          p_doc_number in ntg.dtype.t_long_code default null,
                          p_open_date in ntg.dtype.t_date default null, 
                          p_expiry_date in ntg.dtype.t_date default null, 
                          p_owner in ntg.dtype.t_status default null,
                        p_phone in ntg.dtype.t_name default null)
  is
    v_obj_row_new blng.client_data%rowtype;
    v_obj_row_old blng.client_data%rowtype;
    v_mess ntg.dtype.t_msg;
  begin
    select * into v_obj_row_old from blng.client_data where id = p_id;
    v_obj_row_new := v_obj_row_old;

    v_obj_row_new.last_name:=nvl(upper(p_last_name), v_obj_row_new.last_name);
    v_obj_row_new.first_name:=nvl(upper(p_first_name), v_obj_row_new.first_name);
    v_obj_row_new.birth_date:=nvl(p_birth_date, v_obj_row_new.birth_date);
    v_obj_row_new.gender:=nvl(upper(p_gender), v_obj_row_new.gender);
    v_obj_row_new.client_oid:=nvl(p_client, v_obj_row_new.client_oid);
    v_obj_row_new.nationality:=nvl(p_nationality, v_obj_row_new.nationality);
--    v_obj_row_new.email:=nvl(p_email, v_obj_row_new.email);
    v_obj_row_new.doc_number:=nvl(upper(p_doc_number), v_obj_row_new.doc_number);
    v_obj_row_new.open_date:=nvl(p_open_date, v_obj_row_new.open_date);
    v_obj_row_new.expiry_date:=nvl(p_expiry_date, v_obj_row_new.expiry_date);
    v_obj_row_new.owner:=nvl(upper(p_owner), v_obj_row_new.owner);
    v_obj_row_new.phone:=nvl(p_phone, v_obj_row_new.phone);

    if  
      nvl(v_obj_row_new.last_name,'X') = nvl(v_obj_row_old.last_name,'X') AND
      nvl(v_obj_row_new.first_name,'X') = nvl(v_obj_row_old.first_name,'X') AND
      nvl(to_char(v_obj_row_new.birth_date,'ddmmyyyy'),'X') = nvl(to_char(v_obj_row_old.birth_date,'ddmmyyyy'),'X') and
      nvl(v_obj_row_new.gender,'X') = nvl(v_obj_row_old.gender,'X') and
      v_obj_row_new.client_oid = v_obj_row_old.client_oid and
      nvl(v_obj_row_new.nationality,'X') = nvl(v_obj_row_old.nationality,'X') and
  --    v_obj_row_new.email:=nvl(p_email, v_obj_row_new.email);
      nvl(v_obj_row_new.doc_number,'X') = nvl(v_obj_row_old.doc_number,'X') and 
      nvl(to_char(v_obj_row_new.open_date,'ddmmyyyy'),'X') = nvl(to_char(v_obj_row_old.open_date,'ddmmyyyy'),'X') and
      nvl(to_char(v_obj_row_new.expiry_date,'ddmmyyyy'),'X') = nvl(to_char(v_obj_row_old.expiry_date,'ddmmyyyy'),'X') and
      nvl(v_obj_row_new.owner,'X') = nvl(v_obj_row_old.owner,'X') and  
      nvl(v_obj_row_new.phone,'X') = nvl(v_obj_row_old.phone,'X')   
    then return; 
    else
      v_obj_row_new.amnd_date:=sysdate;
      v_obj_row_new.amnd_user:=user;
      v_obj_row_old.amnd_state:='I';
      v_obj_row_old.id:=null;
      insert into blng.client_data values v_obj_row_old;
      update blng.client_data set row = v_obj_row_new where id = p_id;
    end if;  

  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;    
  when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'client_data_edit', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=client_data,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'update row into client_data error. '||SQLERRM);
  end;


  function client_data_get_info(p_id in ntg.dtype.t_id, 
                          p_client in ntg.dtype.t_id default null, 
                          p_last_name in ntg.dtype.t_name default null, 
                          p_first_name in ntg.dtype.t_name default null, 
                          p_birth_date in ntg.dtype.t_date default null, 
                          p_gender in ntg.dtype.t_status default null, 
                          p_nationality in ntg.dtype.t_code default null, 
                  p_doc_number in ntg.dtype.t_long_code default null,
                  p_open_date in ntg.dtype.t_date default null, 
                  p_expiry_date in ntg.dtype.t_date default null, 
                  p_owner in ntg.dtype.t_status default null,
                        p_phone in ntg.dtype.t_name default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from blng.client_data 
        where id = nvl(p_id,id)
        and amnd_state = 'A'
        and client_oid = nvl(p_client,client_oid)
        order by id;
    return v_results;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;     
  when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'client_data_get_info', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=client_data,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into client_data error. '||SQLERRM);
  end;

  function client_data_get_info_r ( p_id in ntg.dtype.t_id, 
                          p_client in ntg.dtype.t_id default null, 
                          p_last_name in ntg.dtype.t_name default null, 
                          p_first_name in ntg.dtype.t_name default null, 
                          p_birth_date in ntg.dtype.t_date default null, 
                          p_gender in ntg.dtype.t_status default null, 
                          p_nationality in ntg.dtype.t_code default null, 
                          p_doc_number in ntg.dtype.t_long_code default null,
                          p_open_date in ntg.dtype.t_date default null, 
                          p_expiry_date in ntg.dtype.t_date default null, 
                          p_owner in ntg.dtype.t_status default null,
                        p_phone in ntg.dtype.t_name default null
                            )
  return blng.client_data%rowtype
  is
    r_obj blng.client_data%rowtype;
  begin

        SELECT
        * into r_obj
        from blng.client_data 
        where id = nvl(p_id,id)
        and client_oid = nvl(p_client,client_oid)
        and amnd_state = 'A'
        order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'client_data_get_info_r', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=client_data,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE;
    when TOO_MANY_ROWS then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'client_data_get_info_r', p_msg_type=>'TOO_MANY_ROWS',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=client_data,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE;
    when others then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'client_data_get_info_r', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=client_data,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into client_data error. '||SQLERRM);
  end client_data_get_info_r;

end blng_api;

/
