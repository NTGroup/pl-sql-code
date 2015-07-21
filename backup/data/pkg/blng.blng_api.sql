
  CREATE OR REPLACE EDITIONABLE PACKAGE BLNG.BLNG_API as

  
/*
$pkg: BLNG.BLNG_API 
*/
  
/*
$obj_desc: *_add: insert row into table *. Could return id of new row.
$obj_desc: *_edit: update row into table *. Object have always one id. first, old data with amnd_state = [I]nactive
$obj_desc: *_edit: inserted as row with link to new row(amnd_prev). new data just update object row, 
$obj_desc: *_edit: amnd_date updates to sysdate and amnd_user to current user who called api.
$obj_desc: *_get_info: return data from table * with format SYS_REFCURSOR.
$obj_desc: *_get_info_r: return one row from table * with format *%rowtype.
*/
  function client_add(p_name in hdbk.dtype.t_name,
                  p_utc_offset in hdbk.dtype.t_id default null)
  return hdbk.dtype.t_id;


  procedure client_edit(p_id in hdbk.dtype.t_id, p_name in hdbk.dtype.t_name,
                  p_utc_offset in hdbk.dtype.t_id default null);

  function client_get_info(p_id in hdbk.dtype.t_id default null,
                  p_utc_offset in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR;

  function client_get_info_r(p_id in hdbk.dtype.t_id default null,
                  p_utc_offset in hdbk.dtype.t_id default null)
  return blng.client%rowtype;


  function usr_add(p_client in hdbk.dtype.t_id default null, 
                  p_last_name in hdbk.dtype.t_name default null, 
                  p_first_name in hdbk.dtype.t_name default null, 
                  p_birth_date in hdbk.dtype.t_date default null, 
                  p_gender in hdbk.dtype.t_status default null, 
                  p_nationality in hdbk.dtype.t_code default null, 
                  p_email in hdbk.dtype.t_name default null,
                  p_phone in hdbk.dtype.t_name default null,
                  p_utc_offset in hdbk.dtype.t_id default null,
                        p_is_tester in hdbk.dtype.t_status default null
                  )
  return hdbk.dtype.t_id;

  procedure usr_edit(p_id in hdbk.dtype.t_id, 
                          p_client in hdbk.dtype.t_id default null, 
                          p_last_name in hdbk.dtype.t_name default null, 
                          p_first_name in hdbk.dtype.t_name default null, 
                          p_birth_date in hdbk.dtype.t_date default null, 
                          p_gender in hdbk.dtype.t_status default null, 
                          p_nationality in hdbk.dtype.t_code default null, 
                          p_email in hdbk.dtype.t_name default null,
                  p_phone in hdbk.dtype.t_name default null,
                  p_utc_offset in hdbk.dtype.t_id default null,
                        p_is_tester in hdbk.dtype.t_status default null,
                        p_status in hdbk.dtype.t_status default null
  );

  function usr_get_info( p_id in hdbk.dtype.t_id  default null,
                            p_client in hdbk.dtype.t_id default null, 
                            p_last_name in hdbk.dtype.t_name default null, 
                            p_first_name in hdbk.dtype.t_name default null, 
                            p_birth_date in hdbk.dtype.t_date default null, 
                            p_gender in hdbk.dtype.t_status default null, 
                            p_nationality in hdbk.dtype.t_code default null, 
                            p_email in hdbk.dtype.t_name default null,
                  p_phone in hdbk.dtype.t_name default null,
                  p_utc_offset in hdbk.dtype.t_id default null,
                        p_is_tester in hdbk.dtype.t_status default null
  )
  return SYS_REFCURSOR;

  function usr_get_info_r ( p_id in hdbk.dtype.t_id default null,
                              p_client in hdbk.dtype.t_id default null, 
                                p_last_name in hdbk.dtype.t_name default null, 
                                p_first_name in hdbk.dtype.t_name default null, 
                                p_birth_date in hdbk.dtype.t_date default null, 
                                p_gender in hdbk.dtype.t_status default null, 
                                p_nationality in hdbk.dtype.t_code default null, 
                                p_email in hdbk.dtype.t_name default null,
                  p_phone in hdbk.dtype.t_name default null,
                  p_utc_offset in hdbk.dtype.t_id default null,
                        p_is_tester in hdbk.dtype.t_status default null
                            )
  return blng.usr%rowtype;

  procedure usr2contract_add( p_user in hdbk.dtype.t_id,
                                p_permission in hdbk.dtype.t_status,
                                p_contract in hdbk.dtype.t_id
                              );

  procedure usr2contract_edit( p_id in hdbk.dtype.t_id default null,
                                   p_user in hdbk.dtype.t_id default null,
                                  p_contract in hdbk.dtype.t_id default null,
                                  p_status in hdbk.dtype.t_status default null
                                  );

  function usr2contract_get_info(  p_id in hdbk.dtype.t_id default null,
                                      p_user in hdbk.dtype.t_id default null,
                                      p_contract in hdbk.dtype.t_id default null,
                                      p_permission in hdbk.dtype.t_status default null
                                    )
  return SYS_REFCURSOR;

  function usr2contract_get_info_r(  p_id in hdbk.dtype.t_id default null,
                                      p_user in hdbk.dtype.t_id default null,
                                      p_contract in hdbk.dtype.t_id default null,
                                      p_permission in hdbk.dtype.t_status default null
                                    )
  return blng.usr2contract%rowtype;

  function contract_add( p_client in hdbk.dtype.t_id default null,
                         p_name in hdbk.dtype.t_name default null,
                         p_utc_offset in hdbk.dtype.t_id default null,
                         p_contact_name in hdbk.dtype.t_name default null,
                         p_contact_phone in hdbk.dtype.t_long_code default null
                  )
  return hdbk.dtype.t_id;

  procedure contract_edit(  p_id in hdbk.dtype.t_id default null, 
                            p_number in hdbk.dtype.t_long_code default null,
                            p_name in hdbk.dtype.t_name default null,
                            p_utc_offset in hdbk.dtype.t_id default null,
                            p_contact_name in hdbk.dtype.t_name default null,
                            p_contact_phone in hdbk.dtype.t_long_code default null,
                            p_status in hdbk.dtype.t_status default null
                  );

  function contract_get_info(p_id in hdbk.dtype.t_id default null,p_client  in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR;

  function contract_get_info_r(p_id in hdbk.dtype.t_id default null,p_client  in hdbk.dtype.t_id default null)
  return blng.contract%rowtype;


/*
$obj_type: procedure
$obj_name: account_init
$obj_desc: create all accounts under the contract
$obj_param: p_contract: contract id
*/
  procedure account_init(p_contract in hdbk.dtype.t_id);

 procedure account_edit(       p_id in hdbk.dtype.t_id default null,
                               -- p_contract in hdbk.dtype.t_id default null,
                               -- p_account_type in hdbk.dtype.t_id default null,
                               -- p_code in hdbk.dtype.t_code default null,
                                p_amount in hdbk.dtype.t_amount default null
                              )  ;


  function account_get_info ( p_id in hdbk.dtype.t_id default null,
                              p_contract in hdbk.dtype.t_id default null,
                              p_code in hdbk.dtype.t_long_code default null,
                              p_account_type in hdbk.dtype.t_id default null,
                              p_filter_amount in hdbk.dtype.t_amount  default null
                            )
  return SYS_REFCURSOR;

  function account_get_info_r ( p_id in hdbk.dtype.t_id default null,
                              p_contract in hdbk.dtype.t_id default null,
                              p_code in hdbk.dtype.t_long_code default null,
                              p_account_type in hdbk.dtype.t_id default null
                            )
  return blng.account%rowtype;


  function document_add ( p_contract in hdbk.dtype.t_id default null,
                          p_amount in hdbk.dtype.t_amount default null,
                          p_trans_type in hdbk.dtype.t_id default null,
                          p_bill in hdbk.dtype.t_id default null,
                          p_account_trans_type in hdbk.dtype.t_id default null
                        )
  return hdbk.dtype.t_id;

  procedure document_edit(p_id in hdbk.dtype.t_id, p_status in hdbk.dtype.t_status default null,
                          p_account_trans_type in hdbk.dtype.t_id default null);

  function document_get_info( p_id in hdbk.dtype.t_id default null,
                              p_contract in hdbk.dtype.t_id  default null,
                              p_trans_type in hdbk.dtype.t_id  default null,
                              p_status in hdbk.dtype.t_status  default null,
                              p_bill in hdbk.dtype.t_id default null,
                              p_account_trans_type in hdbk.dtype.t_id default null
                            )
  return SYS_REFCURSOR;

  function document_get_info_r( p_id in hdbk.dtype.t_id default null,
                              p_contract in hdbk.dtype.t_id  default null,
                              p_trans_type in hdbk.dtype.t_id  default null,
                              p_status in hdbk.dtype.t_status  default null,
                              p_bill in hdbk.dtype.t_id default null,
                              p_account_trans_type in hdbk.dtype.t_id default null
                            )
  return blng.document%rowtype;

  function transaction_add ( p_doc in hdbk.dtype.t_id  default null,
                          p_amount in hdbk.dtype.t_amount  default null,
                          p_trans_type in hdbk.dtype.t_id  default null,
                          p_trans_date in hdbk.dtype.t_date default null,
                          p_target_account in hdbk.dtype.t_id  default null,
                          p_status in hdbk.dtype.t_status  default 'P',
                          p_prev in hdbk.dtype.t_id  default null
                        )
  return hdbk.dtype.t_id;

  function transaction_add_with_acc ( p_doc in hdbk.dtype.t_id  default null,
                          p_amount in hdbk.dtype.t_amount  default null,
                          p_trans_type in hdbk.dtype.t_id  default null,
                          p_trans_date in hdbk.dtype.t_date default null,
                          p_target_account in hdbk.dtype.t_id  default null,
                          p_status in hdbk.dtype.t_status  default 'P',
                          p_prev in hdbk.dtype.t_id  default null
                        )
  return hdbk.dtype.t_id;

  procedure transaction_edit(p_id in hdbk.dtype.t_id, p_status hdbk.dtype.t_status default 'P');

  function transaction_get_info( p_id in hdbk.dtype.t_id default null,
                              p_doc in hdbk.dtype.t_id default null,
                              p_trans_type in hdbk.dtype.t_id default null,
                              p_target_account in hdbk.dtype.t_id default null,
                              p_status in hdbk.dtype.t_status default null
                            )
  return SYS_REFCURSOR;

  function transaction_get_info_r( p_id in hdbk.dtype.t_id default null,
                              p_document in hdbk.dtype.t_id default null,
                              p_trans_type in hdbk.dtype.t_id default null,
                              p_target_account in hdbk.dtype.t_id default null,
                              p_status in hdbk.dtype.t_status default null
                            )
  return transaction%rowtype;

  function event_add( p_contract in hdbk.dtype.t_id default null,
                      p_amount in hdbk.dtype.t_amount default null,
                      p_transaction in hdbk.dtype.t_id default null,
                      p_date_to in hdbk.dtype.t_date default null,
                      p_event_type in hdbk.dtype.t_id default null,
                      p_status in hdbk.dtype.t_status default null,
                      p_priority in hdbk.dtype.t_id default null
                    )
  return hdbk.dtype.t_id;

  procedure event_edit ( p_id in hdbk.dtype.t_id default null,
                        p_status in hdbk.dtype.t_status default null,
                        p_amount in hdbk.dtype.t_amount default null
                      );

  function event_get_info ( p_id in hdbk.dtype.t_id default null,
                            p_contract in hdbk.dtype.t_id default null,
                            p_date_to in hdbk.dtype.t_date default null,
                            p_event_type in hdbk.dtype.t_id default null,
                            p_status in hdbk.dtype.t_status default null,
                            p_priority in hdbk.dtype.t_id default null
                          )
  return SYS_REFCURSOR;

/*
  function status_type_add( p_name in hdbk.dtype.t_name default null,
                            p_code in hdbk.dtype.t_code default null,
                            p_details in hdbk.dtype.t_msg default null
                          )
  return hdbk.dtype.t_id;

  procedure status_type_edit ( p_id in hdbk.dtype.t_id default null,
                        p_name in hdbk.dtype.t_name default null,
                        p_code in hdbk.dtype.t_code default null,
                        p_details in hdbk.dtype.t_msg default null
                      );

  function status_type_get_info ( p_id in hdbk.dtype.t_id default null,
                                  p_name in hdbk.dtype.t_name default null,
                                  p_code in hdbk.dtype.t_code default null,
                                  p_details in hdbk.dtype.t_msg default null
                                )
  return SYS_REFCURSOR;
*/
/*  function event_type_add( p_name in hdbk.dtype.t_name default null,
                            p_code in hdbk.dtype.t_code default null,
                            p_details in hdbk.dtype.t_msg default null
                          )
  return hdbk.dtype.t_id;

  procedure event_type_edit ( p_id in hdbk.dtype.t_id default null,
                        p_name in hdbk.dtype.t_name default null,
                        p_code in hdbk.dtype.t_code default null,
                        p_details in hdbk.dtype.t_msg default null
                      );

  function event_type_get_info ( p_id in hdbk.dtype.t_id default null,
                                  p_name in hdbk.dtype.t_name default null,
                                  p_code in hdbk.dtype.t_code default null
                                )
  return SYS_REFCURSOR;

  function event_type_get_id (    p_name in hdbk.dtype.t_name default null,
                                  p_code in hdbk.dtype.t_code default null
                                )
  return hdbk.dtype.t_id;*/

/*  function trans_type_add( p_name in hdbk.dtype.t_name default null,
                            p_code in hdbk.dtype.t_code default null,
                            p_details in hdbk.dtype.t_msg default null
                          )
  return hdbk.dtype.t_id;

  procedure trans_type_edit ( p_id in hdbk.dtype.t_id default null,
                        p_name in hdbk.dtype.t_name default null,
                        p_code in hdbk.dtype.t_code default null,
                        p_details in hdbk.dtype.t_msg default null
                      );

  function trans_type_get_info ( p_id in hdbk.dtype.t_id default null,
                                  p_name in hdbk.dtype.t_name default null,
                                  p_code in hdbk.dtype.t_code default null
                                )
  return SYS_REFCURSOR;

  function trans_type_get_id (    p_name in hdbk.dtype.t_name default null,
                                  p_code in hdbk.dtype.t_code default null
                                )
  return hdbk.dtype.t_id;*/

/*  function account_type_add( p_name in hdbk.dtype.t_name default null,
                            p_code in hdbk.dtype.t_code default null,
                            p_priority in hdbk.dtype.t_id default null,
                            p_details in hdbk.dtype.t_msg default null
                          )
  return hdbk.dtype.t_id;

  procedure account_type_edit ( p_id in hdbk.dtype.t_id default null,
                        p_name in hdbk.dtype.t_name default null,
                        p_code in hdbk.dtype.t_code default null,
                        p_details in hdbk.dtype.t_msg default null,
                        p_priority in hdbk.dtype.t_id default null
                      );

  function account_type_get_info ( p_id in hdbk.dtype.t_id default null,
                                  p_name in hdbk.dtype.t_name default null,
                                  p_code in hdbk.dtype.t_code default null,
                                  p_details in hdbk.dtype.t_msg default null,
                                  p_priority in hdbk.dtype.t_id default null
                                )
  return SYS_REFCURSOR;
*/

  function delay_add( p_contract in hdbk.dtype.t_id default null,
                      p_amount in hdbk.dtype.t_amount default null,
                      p_date_to in hdbk.dtype.t_date default null,
                      p_event_type in hdbk.dtype.t_id default null,
                      p_status in hdbk.dtype.t_status default null,
                      p_priority in hdbk.dtype.t_id default null,
                      p_parent_id in hdbk.dtype.t_id default null,
                      p_doc  in hdbk.dtype.t_id default null
                    )
  return hdbk.dtype.t_id;

  procedure delay_edit ( p_id in hdbk.dtype.t_id default null,
                        p_status in hdbk.dtype.t_status default null,
                        p_amount in hdbk.dtype.t_amount default null,
                        p_event_type   in hdbk.dtype.t_id default null,
                        p_parent_id  in hdbk.dtype.t_id default null,
                        p_doc  in hdbk.dtype.t_id default null
                      );

  function delay_get_info ( p_id in hdbk.dtype.t_id default null,
                            p_contract in hdbk.dtype.t_id default null,
                            p_date_to in hdbk.dtype.t_date default null,
                            p_event_type in hdbk.dtype.t_id default null,
                            p_priority in hdbk.dtype.t_id default null,
                            p_parent_id in hdbk.dtype.t_id default null,
                            p_doc  in hdbk.dtype.t_id default null
                          )
  return SYS_REFCURSOR;

  function delay_get_info_r ( p_id in hdbk.dtype.t_id default null,
                            p_contract in hdbk.dtype.t_id default null,
                            p_date_to in hdbk.dtype.t_date default NULL,
                            p_event_type in hdbk.dtype.t_id default null,
                            p_priority in hdbk.dtype.t_id default null,
                            p_doc  in hdbk.dtype.t_id default null
                          )
  return blng.delay%rowtype;
  
  function domain_add( p_name in hdbk.dtype.t_name default null,
                      p_contract in hdbk.dtype.t_id default null,
--                      p_status in hdbk.dtype.t_id default null,
                      p_is_domain in hdbk.dtype.t_status default null
                    )
  return hdbk.dtype.t_id;

  procedure domain_edit ( p_id in hdbk.dtype.t_id default null,
                        p_name in hdbk.dtype.t_name default null,
                      p_contract in hdbk.dtype.t_id default null,
                      p_status in hdbk.dtype.t_status default null,
                      p_is_domain in hdbk.dtype.t_status default null
                      );

  function domain_get_info (p_id in hdbk.dtype.t_id default null,
                            p_name in hdbk.dtype.t_name default null,
                          p_contract in hdbk.dtype.t_id default null,
                          p_status in hdbk.dtype.t_status default null,
                          p_is_domain in hdbk.dtype.t_status default null
                            
                          )
  return SYS_REFCURSOR;

  function domain_get_info_r (p_id in hdbk.dtype.t_id default null,
                            p_name in hdbk.dtype.t_name default null,
                          p_contract in hdbk.dtype.t_id default null,
                          p_status in hdbk.dtype.t_status default null,
                          p_is_domain in hdbk.dtype.t_status default null
                            
                          )
  return domain%rowtype;

  function usr_data_add(p_user in hdbk.dtype.t_id default null, 
                  p_last_name in hdbk.dtype.t_name default null, 
                  p_first_name in hdbk.dtype.t_name default null, 
                  p_birth_date in hdbk.dtype.t_date default null, 
                  p_gender in hdbk.dtype.t_status default null, 
                  p_nationality in hdbk.dtype.t_code default null, 
                  p_doc_number in hdbk.dtype.t_long_code default null,
                  p_open_date in hdbk.dtype.t_date default null, 
                  p_expiry_date in hdbk.dtype.t_date default null, 
                  p_owner in hdbk.dtype.t_status default null,
                  p_phone in hdbk.dtype.t_name default null)
  return hdbk.dtype.t_id;

  procedure usr_data_edit(p_id in hdbk.dtype.t_id, 
                          p_user in hdbk.dtype.t_id default null, 
                          p_last_name in hdbk.dtype.t_name default null, 
                          p_first_name in hdbk.dtype.t_name default null, 
                          p_birth_date in hdbk.dtype.t_date default null, 
                          p_gender in hdbk.dtype.t_status default null, 
                          p_nationality in hdbk.dtype.t_code default null, 
                  p_doc_number in hdbk.dtype.t_long_code default null,
                  p_open_date in hdbk.dtype.t_date default null, 
                  p_expiry_date in hdbk.dtype.t_date default null, 
                  p_owner in hdbk.dtype.t_status default null,
                  p_phone in hdbk.dtype.t_name default null,
                  p_status in hdbk.dtype.t_status default null
                  
  );

  function usr_data_get_info( p_id in hdbk.dtype.t_id  default null,
                            p_user in hdbk.dtype.t_id default null, 
                            p_last_name in hdbk.dtype.t_name default null, 
                            p_first_name in hdbk.dtype.t_name default null, 
                            p_birth_date in hdbk.dtype.t_date default null, 
                            p_gender in hdbk.dtype.t_status default null, 
                            p_nationality in hdbk.dtype.t_code default null, 
                  p_doc_number in hdbk.dtype.t_long_code default null,
                  p_open_date in hdbk.dtype.t_date default null, 
                  p_expiry_date in hdbk.dtype.t_date default null, 
                  p_owner in hdbk.dtype.t_status default null,
                  p_phone in hdbk.dtype.t_name default null
  )
  return SYS_REFCURSOR;

  function usr_data_get_info_r ( p_id in hdbk.dtype.t_id default null,
                                    p_user in hdbk.dtype.t_id default null, 
                                    p_last_name in hdbk.dtype.t_name default null, 
                                    p_first_name in hdbk.dtype.t_name default null, 
                                    p_birth_date in hdbk.dtype.t_date default null, 
                                    p_gender in hdbk.dtype.t_status default null, 
                                    p_nationality in hdbk.dtype.t_code default null, 
                                    p_doc_number in hdbk.dtype.t_long_code default null,
                                    p_open_date in hdbk.dtype.t_date default null, 
                                    p_expiry_date in hdbk.dtype.t_date default null, 
                                    p_owner in hdbk.dtype.t_status default null,
                  p_phone in hdbk.dtype.t_name default null
                            )
  return blng.usr_data%rowtype;



end blng_api;

/

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY BLNG.BLNG_API as

  function client_add(p_name in hdbk.dtype.t_name,
                  p_utc_offset in hdbk.dtype.t_id default null)
  return hdbk.dtype.t_id
  is
    v_client_row blng.client%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_client_row.name := p_name;
    v_client_row.utc_offset := nvl(p_utc_offset,3);
    v_client_row.status := 'A';
    insert into blng.client values v_client_row returning id into v_id;
    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'client_add', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'insert row into client error. '||SQLERRM);
  end;

  procedure client_edit(p_id in hdbk.dtype.t_id, p_name in hdbk.dtype.t_name,
                  p_utc_offset in hdbk.dtype.t_id default null)
  is
    v_client_row_new blng.client%rowtype;
    v_client_row_old blng.client%rowtype;
    v_mess hdbk.dtype.t_msg;
  begin
    select * into v_client_row_old from blng.client where id = p_id;
    v_client_row_new := v_client_row_old;

    v_client_row_old.amnd_state:='I';
    v_client_row_old.id:=null;
    insert into blng.client values v_client_row_old;

    v_client_row_new.name:=p_name;
    v_client_row_new.utc_offset:=p_utc_offset;
    v_client_row_new.amnd_date:=sysdate;
    v_client_row_new.amnd_user:=user;
    --v_usr_row_new.amnd_user:=null;
    update blng.client set row = v_client_row_new where id = p_id;

  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'client_edit', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'update row into client error. '||SQLERRM);
  end;


  function client_get_info(p_id in hdbk.dtype.t_id default null,
                  p_utc_offset in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from blng.client 
        where  id = nvl(p_id,id)
        order by id;
    return v_results;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'client_get_info', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into client error. '||SQLERRM);
  end;


  function client_get_info_r(p_id in hdbk.dtype.t_id default null,
                  p_utc_offset in hdbk.dtype.t_id default null)
  return blng.client%rowtype
  is
    r_obj  blng.client%rowtype;
  begin
    if p_id is null then raise NO_DATA_FOUND; end if;   
    SELECT
    *
    into r_obj
    from blng.client 
    where id = nvl(p_id,id)
    order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;  
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'client_get_info', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'select row into client error. '||SQLERRM);
  end;
  
  function usr_add(
                        p_client in hdbk.dtype.t_id default null, 
                        p_last_name in hdbk.dtype.t_name default null, 
                        p_first_name in hdbk.dtype.t_name default null, 
                        p_birth_date in hdbk.dtype.t_date default null, 
                        p_gender in hdbk.dtype.t_status default null, 
                        p_nationality in hdbk.dtype.t_code default null, 
                        p_email in hdbk.dtype.t_name default null,
                        p_phone in hdbk.dtype.t_name default null,
                        p_utc_offset in hdbk.dtype.t_id default null,
                        p_is_tester in hdbk.dtype.t_status default null
                        )
  return hdbk.dtype.t_id
  is
    v_obj_row blng.usr%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_obj_row.client_oid := p_client;
    v_obj_row.last_name := upper(p_last_name);
    v_obj_row.first_name := upper(p_first_name);
    v_obj_row.email := lower(p_email);
    v_obj_row.phone := lower(p_phone);
    v_obj_row.birth_date := p_birth_date;
    v_obj_row.nationality := p_nationality;
    v_obj_row.gender := upper(p_gender);
    v_obj_row.utc_offset := nvl(p_utc_offset,3);
    v_obj_row.is_tester := nvl(p_is_tester,'N');
    v_obj_row.status := 'A';
    insert into blng.usr values v_obj_row returning id into v_id;

    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'usr_add', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'insert row into usr error. '||SQLERRM);
  end;

  procedure usr_edit(p_id in hdbk.dtype.t_id,
                        p_client in hdbk.dtype.t_id default null, 
                        p_last_name in hdbk.dtype.t_name default null, 
                        p_first_name in hdbk.dtype.t_name default null, 
                        p_birth_date in hdbk.dtype.t_date default null, 
                        p_gender in hdbk.dtype.t_status default null, 
                        p_nationality in hdbk.dtype.t_code default null, 
                        p_email in hdbk.dtype.t_name default null,
                        p_phone in hdbk.dtype.t_name default null,
                        p_utc_offset in hdbk.dtype.t_id default null,
                        p_is_tester in hdbk.dtype.t_status default null,
                        p_status in hdbk.dtype.t_status default null
                        )
  is
    v_obj_row_new blng.usr%rowtype;
    v_obj_row_old blng.usr%rowtype;
    v_mess hdbk.dtype.t_msg;
  begin
    select * into v_obj_row_old from blng.usr where id = p_id;
    v_obj_row_new := v_obj_row_old;


    v_obj_row_new.last_name:=nvl(upper(p_last_name), v_obj_row_new.last_name);
    v_obj_row_new.first_name:=nvl(upper(p_first_name), v_obj_row_new.first_name);
    v_obj_row_new.birth_date:=nvl(p_birth_date, v_obj_row_new.birth_date);
    v_obj_row_new.gender:=nvl(upper(p_gender), v_obj_row_new.gender);
    v_obj_row_new.client_oid:=nvl(p_client, v_obj_row_new.client_oid);
    v_obj_row_new.nationality:=nvl(p_nationality, v_obj_row_new.nationality);
    v_obj_row_new.email:=nvl(lower(p_email), v_obj_row_new.email);
    v_obj_row_new.phone:=nvl(lower(p_phone), v_obj_row_new.phone);
    v_obj_row_new.utc_offset:=nvl(p_utc_offset, v_obj_row_new.utc_offset);
    v_obj_row_new.is_tester:=nvl(p_is_tester, v_obj_row_new.is_tester);
    --v_obj_row_new.amnd_user:=null;
    if p_status in ('C','D') then v_obj_row_new.amnd_state :='C'; v_obj_row_new.status :='C'; end if;
    if p_status in ('A') then v_obj_row_new.amnd_state :='A'; v_obj_row_new.status :='A'; end if;
    
    if 
      nvl(v_obj_row_new.last_name,'X') = nvl(v_obj_row_old.last_name,'X') and
      nvl(v_obj_row_new.first_name,'X') = nvl(v_obj_row_old.first_name,'X') and 
      nvl(to_char(v_obj_row_new.birth_date,'ddmmyyyy'),'X') = nvl(to_char(v_obj_row_old.birth_date,'ddmmyyyy'),'X') and
      nvl(v_obj_row_new.gender,'X') = nvl(v_obj_row_old.gender,'X') and
      v_obj_row_new.client_oid = v_obj_row_old.client_oid and
      nvl(v_obj_row_new.nationality,'X') = nvl(v_obj_row_old.nationality,'X') and
      nvl(v_obj_row_new.email,'X') = nvl(v_obj_row_old.email,'X') and
      v_obj_row_new.utc_offset = v_obj_row_old.utc_offset
      and v_obj_row_new.is_tester = v_obj_row_old.is_tester
      and v_obj_row_new.amnd_state = v_obj_row_old.amnd_state
    then return; 
    else     
      v_obj_row_new.amnd_date:=sysdate;
      v_obj_row_new.amnd_user:=user;
      v_obj_row_old.amnd_state:='I';
      v_obj_row_old.id:=null;
      insert into blng.usr values v_obj_row_old;  
      update blng.usr set row = v_obj_row_new where id = p_id;
    end if;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;    
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'usr_edit', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'update row into usr error. '||SQLERRM);
  end;


  function usr_get_info(p_id in hdbk.dtype.t_id,
                        p_client in hdbk.dtype.t_id default null, 
                        p_last_name in hdbk.dtype.t_name default null, 
                        p_first_name in hdbk.dtype.t_name default null, 
                        p_birth_date in hdbk.dtype.t_date default null, 
                        p_gender in hdbk.dtype.t_status default null, 
                        p_nationality in hdbk.dtype.t_code default null, 
                        p_email in hdbk.dtype.t_name default null,
                        p_phone in hdbk.dtype.t_name default null,
                        p_utc_offset in hdbk.dtype.t_id default null,
                        p_is_tester in hdbk.dtype.t_status default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from blng.usr 
        where id = nvl(p_id,id)
--        and last_name = nvl(p_last_name, last_name)
--        and first_name = nvl(p_first_name, first_name)
--        and birth_date = nvl(p_birth_date, birth_date)
--        and gender = nvl(p_gender, gender)
        and client_oid = nvl(p_client, client_oid)
--        and nationality = nvl(p_nationality, nationality)
        and amnd_state = 'A'
        and email = nvl(lower(p_email), email)
        order by id;
    return v_results;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'usr_get_info', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into usr error. '||SQLERRM);
  end;

  function usr_get_info_r ( p_id in hdbk.dtype.t_id,
                        p_client in hdbk.dtype.t_id default null, 
                        p_last_name in hdbk.dtype.t_name default null, 
                        p_first_name in hdbk.dtype.t_name default null, 
                        p_birth_date in hdbk.dtype.t_date default null, 
                        p_gender in hdbk.dtype.t_status default null, 
                        p_nationality in hdbk.dtype.t_code default null, 
                        p_email in hdbk.dtype.t_name default null,
                        p_phone in hdbk.dtype.t_name default null,
                        p_utc_offset in hdbk.dtype.t_id default null,
                        p_is_tester in hdbk.dtype.t_status default null
                            )
  return blng.usr%rowtype
  is
    r_obj blng.usr%rowtype;
  begin
    if p_id is null and p_email is null then raise NO_DATA_FOUND; end if;   
  
    SELECT
    * into r_obj
    from blng.usr 
    where id = nvl(p_id,id)
    and email = nvl(lower(p_email), email)
    and amnd_state != 'I'
    order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'usr_get_info_r', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'select row into usr error. '||SQLERRM);
  end usr_get_info_r;




  procedure usr2contract_add( p_user in hdbk.dtype.t_id,
                                p_permission in hdbk.dtype.t_status,
                                p_contract in hdbk.dtype.t_id
                              )
  is
    v_usr2contract_row blng.usr2contract%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_usr2contract_row.user_oid := p_user;
    v_usr2contract_row.permission := p_permission;
    v_usr2contract_row.contract_oid := p_contract;
    insert into blng.usr2contract values v_usr2contract_row;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'usr2contract_add', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'insert row into usr2contract error. '||SQLERRM);
  end;

  procedure usr2contract_edit( 
                                  p_id in hdbk.dtype.t_id default null,
                                  p_user in hdbk.dtype.t_id default null,
                                  p_contract in hdbk.dtype.t_id default null,
                                  p_status in hdbk.dtype.t_status default null)
  is
    v_obj_row_new blng.usr2contract%rowtype;
    v_obj_row_old blng.usr2contract%rowtype;
    v_mess hdbk.dtype.t_msg;
    v_id hdbk.dtype.t_id;
  begin
    if p_id is null and p_status is null then raise NO_DATA_FOUND; end if; 
    
    select * into v_obj_row_old from blng.usr2contract
    where id = nvl(p_id,id);

    v_id := v_obj_row_old.id;
    v_obj_row_new := v_obj_row_old;

    v_obj_row_old.amnd_state:='I';
    v_obj_row_old.id:=null;
    insert into blng.usr2contract values v_obj_row_old;

    v_obj_row_new.amnd_state:=nvl(p_status,v_obj_row_new.amnd_state);
    v_obj_row_new.contract_oid:=nvl(p_contract,v_obj_row_new.contract_oid);
    v_obj_row_new.user_oid:=nvl(p_user,v_obj_row_new.user_oid);
    v_obj_row_new.amnd_date:=sysdate;
    v_obj_row_new.amnd_user:=user;
    --v_usr_row_new.amnd_user:=null;
    update blng.usr2contract set row = v_obj_row_new where id = v_id;
--    commit;
  exception
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;    
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'usr2contract_edit', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'update row into usr2contract error. '||SQLERRM);
  end;


  function usr2contract_get_info(  p_id in hdbk.dtype.t_id default null,
                                      p_user in hdbk.dtype.t_id default null,
                                      p_contract in hdbk.dtype.t_id default null,
                                      p_permission in hdbk.dtype.t_status default null
                                    )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from blng.usr2contract
        where user_oid = nvl(p_user,user_oid)
        and contract_oid = nvl(p_contract,contract_oid)
        and permission = nvl(p_permission,permission)

        order by id;
    return v_results;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'usr2contract_get_info', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into usr2contract error. '||SQLERRM);
  end;


  function usr2contract_get_info_r(  p_id in hdbk.dtype.t_id default null,
                                      p_user in hdbk.dtype.t_id default null,
                                      p_contract in hdbk.dtype.t_id default null,
                                      p_permission in hdbk.dtype.t_status default null
                                    )
  return blng.usr2contract%rowtype
  is
    v_results blng.usr2contract%rowtype;
  begin
    SELECT
    * into v_results
    from blng.usr2contract
    where user_oid = nvl(p_user,user_oid)
    and contract_oid = nvl(p_contract,contract_oid)
    and permission = nvl(p_permission,permission)
    and amnd_state <> 'I'
    order by id;
    return v_results;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'usr2contract_get_info', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into usr2contract error. '||SQLERRM);
  end;


  function contract_add(p_client in hdbk.dtype.t_id default null,
                        p_name in hdbk.dtype.t_name default null,
                        p_utc_offset in hdbk.dtype.t_id default null,
                            p_contact_name in hdbk.dtype.t_name default null,
                            p_contact_phone in hdbk.dtype.t_long_code default null
                      )
  return hdbk.dtype.t_id
  is
    v_contract_row blng.contract%rowtype;
    v_id hdbk.dtype.t_id;
    v_number hdbk.dtype.t_long_code;
  begin

    select to_char(sysdate,'yyyymmdd')||'-'||p_client||'-'||(count(*) + 1) into v_number from blng.contract where
    id in (select contract_oid from blng.usr2contract where user_oid in 
              (select id from blng.usr where client_oid = p_client and amnd_state = 'A')
               and amnd_state = 'A'
          ) 
          and amnd_state = 'A';
    v_contract_row.contract_number := v_number;
    v_contract_row.name := p_name;
    v_contract_row.client_oid := p_client;
    v_contract_row.utc_offset := nvl(p_utc_offset,3);
    v_contract_row.status := 'A';
    v_contract_row.contact_name := p_contact_name;
    v_contract_row.contact_phone := p_contact_phone;
    insert into blng.contract values v_contract_row returning id into v_id;
    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'contract_add', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'insert row into contract error. '||SQLERRM);
  end;

  procedure contract_edit(  p_id in hdbk.dtype.t_id default null, 
                            p_number in hdbk.dtype.t_long_code default null,
                            p_name in hdbk.dtype.t_name default null,
                            p_utc_offset in hdbk.dtype.t_id default null,
                            p_contact_name in hdbk.dtype.t_name default null,
                            p_contact_phone in hdbk.dtype.t_long_code default null,
                            p_status in hdbk.dtype.t_status default null
                            
                         )
  is
    v_mess hdbk.dtype.t_msg;
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
    v_contract_row_new.contract_number := nvl(p_number,v_contract_row_new.contract_number);
    v_contract_row_new.name := nvl(p_name,v_contract_row_new.name);
    v_contract_row_new.utc_offset := nvl(p_utc_offset,v_contract_row_new.utc_offset);
    v_contract_row_new.status := nvl(p_status,v_contract_row_new.status);
    v_contract_row_new.contact_name := nvl(p_contact_name,v_contract_row_new.contact_name);
    v_contract_row_new.contact_phone := nvl(p_contact_phone,v_contract_row_new.contact_phone);

    update blng.contract set row = v_contract_row_new where id = p_id;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
  when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'contract_edit', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'update row into contract error. '||SQLERRM);
  end;


  function contract_get_info(p_id in hdbk.dtype.t_id default null,p_client  in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
    OPEN v_results FOR
      SELECT *
      from blng.contract 
      where id = nvl(p_id,id)
      and client_oid = nvl(p_client,client_oid)
      order by id;
    return v_results;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'contract_get_info', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into contract error. '||SQLERRM);
  end;

  function contract_get_info_r(p_id in hdbk.dtype.t_id default null,p_client  in hdbk.dtype.t_id default null)
  return blng.contract%rowtype
  is
    r_obj blng.contract%rowtype;
  begin
    if p_id is null and p_client is null then raise NO_DATA_FOUND; end if; 
    SELECT *
    into r_obj
    from blng.contract 
    where id = nvl(p_id,id)
    and client_oid = nvl(p_client,client_oid)
    order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;        
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'contract_get_info', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'select row into contract error. '||SQLERRM);
  end;


  procedure account_init(p_contract in hdbk.dtype.t_id)
  is
  begin
    if p_contract is null then raise NO_DATA_FOUND; end if; 
    insert into blng.account (contract_oid,code ,amount,priority,account_type_oid)
   /* select --null id,null amnd_date,user amnd_user,'A' amnd_state,null amnd_prev,
    p_contract contract_oid,code,0 amount,priority, id account_type_oid
    from blng.account_type
    where id not in (select account_type_oid from blng.account where contract_oid = p_contract);
    */
    select  --null id,null amnd_date,user amnd_user,'A' amnd_state,null amnd_prev,
    p_contract contract_oid,
    code,
    0 amount,
    0 priority,
    id account_type_oid
    from hdbk.dictionary act
    where amnd_state = 'A'
    and dictionary_type = 'ACCOUNT_TYPE'
    and id not in (select account_type_oid from blng.account where contract_oid = p_contract);

  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'account_init', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'insert row into account error. '||SQLERRM);
  end;


  procedure account_edit(       p_id in hdbk.dtype.t_id default null,
                               -- p_contract in hdbk.dtype.t_id default null,
                               -- p_account_type in hdbk.dtype.t_id default null,
                               -- p_code in hdbk.dtype.t_code default null,
                                p_amount in hdbk.dtype.t_amount default null
                              )
  is
    v_mess hdbk.dtype.t_msg;
    v_account_row_new blng.account%rowtype;
    v_account_row_old blng.account%rowtype;
    v_id  hdbk.dtype.t_id default null;
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
    when hdbk.dtype.dead_lock then
      raise hdbk.dtype.dead_lock;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'account_edit', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'update row into account error. '||SQLERRM);
  end;

  function account_get_info ( p_id in hdbk.dtype.t_id default null,
                              p_contract in hdbk.dtype.t_id default null,
                              p_code in hdbk.dtype.t_long_code default null,
                              p_account_type in hdbk.dtype.t_id default null,
                              p_filter_amount in hdbk.dtype.t_amount  default null
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'account_get_info', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into account error. '||SQLERRM);
  end account_get_info;

  function account_get_info_r ( p_id in hdbk.dtype.t_id default null,
                              p_contract in hdbk.dtype.t_id default null,
                              p_code in hdbk.dtype.t_long_code default null,
                              p_account_type in hdbk.dtype.t_id default null
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
    and amnd_state != 'I'
    order by contract_oid, priority;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'account_get_info_r', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'select row into account error. '||SQLERRM);
  end account_get_info_r;

  function document_add ( p_contract in hdbk.dtype.t_id default null,
                          p_amount in hdbk.dtype.t_amount default null,
                          p_trans_type in hdbk.dtype.t_id default null,
                          p_bill in hdbk.dtype.t_id default null,
                          p_account_trans_type in hdbk.dtype.t_id default null
                        )
  return hdbk.dtype.t_id
  is
    v_document_row blng.document%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_document_row.contract_oid := p_contract;
    v_document_row.amount := p_amount;
    v_document_row.trans_type_oid := p_trans_type;
    v_document_row.doc_date := sysdate;
    v_document_row.bill_oid := p_bill;
    v_document_row.account_trans_type_oid := p_account_trans_type;
    insert into blng.document values v_document_row returning id into v_id;
    return v_id;
  exception 
    when hdbk.dtype.dead_lock then
      raise hdbk.dtype.dead_lock;
  when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'document_add', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'insert row into document error. '||SQLERRM);
  end;

  procedure document_edit(p_id in hdbk.dtype.t_id, p_status in hdbk.dtype.t_status default null,
                          p_account_trans_type in hdbk.dtype.t_id default null)
  is
    v_mess hdbk.dtype.t_msg;
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
    v_document_row_new.status := nvl(p_status,v_document_row_new.status);
    v_document_row_new.account_trans_type_oid := nvl(p_account_trans_type,v_document_row_new.account_trans_type_oid);

    update blng.document set row = v_document_row_new where id = v_document_row_new.id;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
    when hdbk.dtype.dead_lock then
      raise hdbk.dtype.dead_lock;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'document_edit', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'update row into document error. '||SQLERRM);
  end;

  function document_get_info( p_id in hdbk.dtype.t_id default null,
                              p_contract in hdbk.dtype.t_id  default null,
                              p_trans_type in hdbk.dtype.t_id  default null,
                              p_status in hdbk.dtype.t_status  default null,
                              p_bill in hdbk.dtype.t_id default null,
                              p_account_trans_type in hdbk.dtype.t_id default null
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
        and status <> 'D'
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
        and account_trans_type_oid = nvl(p_account_trans_type,account_trans_type_oid)
        and status = nvl(p_status,status)
        and amnd_state = 'A'
        order by contract_oid, id asc;    
    end if;
    return v_results;
  exception
    when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'document_get_info', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into document error. '||SQLERRM);
  end;

  function document_get_info_r( p_id in hdbk.dtype.t_id default null,
                              p_contract in hdbk.dtype.t_id  default null,
                              p_trans_type in hdbk.dtype.t_id  default null,
                              p_status in hdbk.dtype.t_status  default null,
                          p_bill in hdbk.dtype.t_id default null,
                              p_account_trans_type in hdbk.dtype.t_id default null
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
        and amnd_state != 'I'
        and status <> 'D'
        order by contract_oid, id asc;
    else
        SELECT
        * into r_obj
        from blng.document
        where id = nvl(p_id,id)
--        and account_trans_type_oid = nvl(p_account_trans_type,account_trans_type_oid)
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
      hdbk.log_api.LOG_ADD(p_proc_name=>'document_get_info_r', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'select row into document error. '||SQLERRM);
  end document_get_info_r;


  function transaction_add ( p_doc in hdbk.dtype.t_id  default null,
                          p_amount in hdbk.dtype.t_amount  default null,
                          p_trans_type in hdbk.dtype.t_id  default null,
                          p_trans_date in hdbk.dtype.t_date  default null,
                          p_target_account in hdbk.dtype.t_id  default null,
                          p_status in hdbk.dtype.t_status  default 'P',
                          p_prev in hdbk.dtype.t_id  default null

                        )
  return hdbk.dtype.t_id
  is
    v_transaction_row blng.transaction%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    if p_amount = 0 or p_amount is null then raise hdbk.dtype.exit_alert; end if;
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
    when hdbk.dtype.dead_lock then
      raise hdbk.dtype.dead_lock;
    when hdbk.dtype.exit_alert then
      hdbk.log_api.LOG_ADD(p_proc_name=>'transaction_add', p_msg_type=>'hdbk.dtype.exit_alert');
      raise;
    when hdbk.dtype.value_error then
      hdbk.log_api.LOG_ADD(p_proc_name=>'transaction_add', p_msg_type=>'hdbk.dtype.value_error');
      raise;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'transaction_add', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'insert row into transaction error. '||SQLERRM);
  end;

  function transaction_add_with_acc ( p_doc in hdbk.dtype.t_id  default null,
                          p_amount in hdbk.dtype.t_amount  default null,
                          p_trans_type in hdbk.dtype.t_id  default null,
                          p_trans_date in hdbk.dtype.t_date  default null,
                          p_target_account in hdbk.dtype.t_id  default null,
                          p_status in hdbk.dtype.t_status  default 'P',
                          p_prev in hdbk.dtype.t_id  default null
                        )
  return hdbk.dtype.t_id
  is
    v_transaction  hdbk.dtype.t_id;
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
    when hdbk.dtype.dead_lock then
      raise hdbk.dtype.dead_lock;
    when hdbk.dtype.exit_alert then
      hdbk.log_api.LOG_ADD(p_proc_name=>'transaction_add_with_acc', p_msg_type=>'hdbk.dtype.exit_alert');
      raise;
    when hdbk.dtype.value_error then
      hdbk.log_api.LOG_ADD(p_proc_name=>'transaction_add_with_acc', p_msg_type=>'hdbk.dtype.value_error');
      raise;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'transaction_add_with_acc', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'insert row into transaction error. '||SQLERRM);
  end;

  procedure transaction_edit(p_id in hdbk.dtype.t_id, p_status hdbk.dtype.t_status default 'P')
  is
    v_mess hdbk.dtype.t_msg;
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
    when hdbk.dtype.dead_lock then
      raise hdbk.dtype.dead_lock;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'transaction_edit', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'update row into transaction error. '||SQLERRM);
  end;

  function transaction_get_info( p_id in hdbk.dtype.t_id default null,
                              p_doc in hdbk.dtype.t_id default null,
                              p_trans_type in hdbk.dtype.t_id default null,
                              p_target_account in hdbk.dtype.t_id default null,
                              p_status in hdbk.dtype.t_status default null
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
      hdbk.log_api.LOG_ADD(p_proc_name=>'transaction_get_info', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'select row into transaction error. '||SQLERRM);
  end;

  function transaction_get_info_r( p_id in hdbk.dtype.t_id default null,
                              p_document in hdbk.dtype.t_id default null,
                              p_trans_type in hdbk.dtype.t_id default null,
                              p_target_account in hdbk.dtype.t_id default null,
                              p_status in hdbk.dtype.t_status default null
                            )
  return transaction%rowtype
  is
    r_obj transaction%rowtype;
  begin
   -- OPEN v_results FOR
      SELECT 
      * into r_obj
      from transaction
      where id = nvl(p_id,id)
      and doc_oid = nvl(p_document,doc_oid)
      and trans_type_oid = nvl(p_trans_type,trans_type_oid)
      and target_account_oid = nvl(p_target_account,target_account_oid)
      and status = nvl(p_status,status)
      and amnd_state = 'A'
      order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;    
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'transaction_get_info_r', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'select row into transaction error. '||SQLERRM);
  end;




  function event_add( p_contract in hdbk.dtype.t_id default null,
                      p_amount in hdbk.dtype.t_amount default null,
                      p_transaction in hdbk.dtype.t_id default null,
                      p_date_to in hdbk.dtype.t_date default null,
                      p_event_type in hdbk.dtype.t_id default null,
                      p_status in hdbk.dtype.t_status default null,
                      p_priority in hdbk.dtype.t_id default null
                    )
  return hdbk.dtype.t_id 
  is
    v_event_row blng.event%rowtype;
    v_id hdbk.dtype.t_id;
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'event_add', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'insert row into event error. '||SQLERRM);
  end;

  procedure event_edit ( p_id in hdbk.dtype.t_id default null,
                        p_status in hdbk.dtype.t_status default null,
                        p_amount in hdbk.dtype.t_amount default null
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
      hdbk.log_api.LOG_ADD(p_proc_name=>'eventn_edit', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'update row into event error. '||SQLERRM);
  end;

  function event_get_info ( p_id in hdbk.dtype.t_id default null,
                            p_contract in hdbk.dtype.t_id default null,
                            p_date_to in hdbk.dtype.t_date default null,
                            p_event_type in hdbk.dtype.t_id default null,
                            p_status in hdbk.dtype.t_status default null,
                            p_priority in hdbk.dtype.t_id default null
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'event_get_info', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into event error. '||SQLERRM);
  end;

/*
  function status_type_add( p_name in hdbk.dtype.t_name default null,
                            p_code in hdbk.dtype.t_code default null,
                            p_details in hdbk.dtype.t_msg default null
                          )
  return hdbk.dtype.t_id 
  is
    v_status_type_row blng.status_type%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_status_type_row.name := p_name;
    v_status_type_row.code := p_code;
    v_status_type_row.details := p_details;
    insert into blng.status_type values v_status_type_row returning id into v_id;
    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'status_type_add', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'insert row into status_type error. '||SQLERRM);
  end;

  function event_type_add( p_name in hdbk.dtype.t_name default null,
                            p_code in hdbk.dtype.t_code default null,
                            p_details in hdbk.dtype.t_msg default null
                          )
  return hdbk.dtype.t_id
  is
    v_event_type_row blng.event_type%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_event_type_row.name := p_name;
    v_event_type_row.code := p_code;
    v_event_type_row.details := p_details;
    insert into blng.event_type values v_event_type_row returning id into v_id;
    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'event_type_add', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'insert row into event_type error. '||SQLERRM);
  end;

  function account_type_add( p_name in hdbk.dtype.t_name default null,
                            p_code in hdbk.dtype.t_code default null,
                            p_priority in hdbk.dtype.t_id default null,
                            p_details in hdbk.dtype.t_msg default null
                          )
  return hdbk.dtype.t_id
  is
    v_account_type_row blng.account_type%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_account_type_row.name := p_name;
    v_account_type_row.code := p_code;
    v_account_type_row.priority := p_priority;
    v_account_type_row.details := p_details;
    insert into blng.account_type values v_account_type_row returning id into v_id;
    return v_id;
  exception 
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'account_type_add', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'insert row into account_type error. '||SQLERRM);
  end;

  function trans_type_add( p_name in hdbk.dtype.t_name default null,
                            p_code in hdbk.dtype.t_code default null,
                            p_details in hdbk.dtype.t_msg default null
                          )
  return hdbk.dtype.t_id
  is
    v_trans_type_row blng.trans_type%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_trans_type_row.name := p_name;
    v_trans_type_row.code := p_code;
    v_trans_type_row.details := p_details;
    insert into blng.trans_type values v_trans_type_row returning id into v_id;
    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'trans_type_add', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'insert row into trans_type error. '||SQLERRM);
  end;

  procedure status_type_edit ( p_id in hdbk.dtype.t_id default null,
                        p_name in hdbk.dtype.t_name default null,
                        p_code in hdbk.dtype.t_code default null,
                        p_details in hdbk.dtype.t_msg default null
                      )
  is
    v_mess hdbk.dtype.t_msg;
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'status_type_edit', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'update row into status_type error. '||SQLERRM);
  end;

  procedure trans_type_edit ( p_id in hdbk.dtype.t_id default null,
                        p_name in hdbk.dtype.t_name default null,
                        p_code in hdbk.dtype.t_code default null,
                        p_details in hdbk.dtype.t_msg default null
                      )
  is
    v_mess hdbk.dtype.t_msg;
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'trans_type_edit', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'update row into trans_type error. '||SQLERRM);
  end;

  procedure event_type_edit ( p_id in hdbk.dtype.t_id default null,
                        p_name in hdbk.dtype.t_name default null,
                        p_code in hdbk.dtype.t_code default null,
                        p_details in hdbk.dtype.t_msg default null
                      )
  is
    v_mess hdbk.dtype.t_msg;
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'event_type_edit', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'update row into event_type error. '||SQLERRM);
  end;


  procedure account_type_edit ( p_id in hdbk.dtype.t_id default null,
                        p_name in hdbk.dtype.t_name default null,
                        p_code in hdbk.dtype.t_code default null,
                        p_details in hdbk.dtype.t_msg default null,
                        p_priority in hdbk.dtype.t_id default null
                      )
  is
    v_mess hdbk.dtype.t_msg;
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'account_type_edit', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'update row into account_type error. '||SQLERRM);
  end;

  function account_type_get_info ( p_id in hdbk.dtype.t_id default null,
                                  p_name in hdbk.dtype.t_name default null,
                                  p_code in hdbk.dtype.t_code default null,
                                  p_details in hdbk.dtype.t_msg default null,
                                  p_priority in hdbk.dtype.t_id default null
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'account_type_get_info', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into account_type error. '||SQLERRM);
  end;

  function trans_type_get_info ( p_id in hdbk.dtype.t_id default null,
                                  p_name in hdbk.dtype.t_name default null,
                                  p_code in hdbk.dtype.t_code default null
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'trans_type_get_info', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into trans_type error. '||SQLERRM);
  end;

  function trans_type_get_id (    p_name in hdbk.dtype.t_name default null,
                                  p_code in hdbk.dtype.t_code default null
                                )
  return hdbk.dtype.t_id
  is
    v_results  hdbk.dtype.t_id;
  begin
    SELECT id into v_results
      from blng.trans_type
      where name = nvl(p_name,name)
      and code = nvl(p_code,code)
      and amnd_state != 'I';
    return v_results;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
  when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'trans_type_get_id', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into trans_type error. '||SQLERRM);
  end;

  function event_type_get_info ( p_id in hdbk.dtype.t_id default null,
                                  p_name in hdbk.dtype.t_name default null,
                                  p_code in hdbk.dtype.t_code default null
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'event_type_get_info', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into event_type error. '||SQLERRM);
  end;

  function event_type_get_id (    p_name in hdbk.dtype.t_name default null,
                                  p_code in hdbk.dtype.t_code default null
                                )
  return hdbk.dtype.t_id
  is
    v_results hdbk.dtype.t_id;
  begin
      SELECT id into v_results
      from blng.event_type
      where name = nvl(p_name,name)
      and code = nvl(p_code,code)
      and amnd_state != 'I';
    return v_results;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
  when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'event_type_get_id', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into event_type error. '||SQLERRM);
  end;


  function status_type_get_info ( p_id in hdbk.dtype.t_id default null,
                                  p_name in hdbk.dtype.t_name default null,
                                  p_code in hdbk.dtype.t_code default null,
                                  p_details in hdbk.dtype.t_msg default null
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'status_type_get_info', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into status_type error. '||SQLERRM);
  end;
*/

  function delay_add( p_contract in hdbk.dtype.t_id default null,
                      p_amount in hdbk.dtype.t_amount default null,
                      p_date_to in hdbk.dtype.t_date default null,
                      p_event_type in hdbk.dtype.t_id default null,
                      p_status in hdbk.dtype.t_status default null,
                      p_priority in hdbk.dtype.t_id default null,
                      p_parent_id in hdbk.dtype.t_id default null,
                            p_doc  in hdbk.dtype.t_id default null
                    )
  return hdbk.dtype.t_id
  is
    v_obj_row blng.delay%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_obj_row.contract_oid := p_contract;
    v_obj_row.amount := p_amount;
    v_obj_row.date_to := nvl(p_date_to,trunc(sysdate));
    v_obj_row.event_type_oid := p_event_type;
    v_obj_row.priority := p_priority;
    v_obj_row.parent_id := p_parent_id;
    v_obj_row.doc_oid := p_doc;
    v_obj_row.status := 'A';
    insert into delay values v_obj_row returning id into v_id;
    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'delay_add', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'insert row into delay error. '||SQLERRM);
  end;

  procedure delay_edit ( p_id in hdbk.dtype.t_id default null,
                        p_status in hdbk.dtype.t_status default null,
                        p_amount in hdbk.dtype.t_amount default null,
                        p_event_type   in hdbk.dtype.t_id default null,
                        p_parent_id  in hdbk.dtype.t_id default null,
                            p_doc  in hdbk.dtype.t_id default null
                      )
  is
    v_mess hdbk.dtype.t_msg;
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
    v_delay_row_new.doc_oid:=nvl(p_doc, v_delay_row_new.doc_oid);
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
    hdbk.log_api.LOG_ADD(p_proc_name=>'delay_edit', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'update row into delay error. '||SQLERRM);
  end;

  function delay_get_info ( p_id in hdbk.dtype.t_id default null,
                            p_contract in hdbk.dtype.t_id default null,
                            p_date_to in hdbk.dtype.t_date default NULL,
                            p_event_type in hdbk.dtype.t_id default null,
                            p_priority in hdbk.dtype.t_id default null,
                            p_parent_id in hdbk.dtype.t_id default null,
                            p_doc  in hdbk.dtype.t_id default null
                            
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
      and doc_oid = nvl(p_doc,doc_oid)
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
      hdbk.log_api.LOG_ADD(p_proc_name=>'delay_get_info', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'select row into delay error. '||SQLERRM);
  end;


  function delay_get_info_r ( p_id in hdbk.dtype.t_id default null,
                            p_contract in hdbk.dtype.t_id default null,
                            p_date_to in hdbk.dtype.t_date default NULL,
                            p_event_type in hdbk.dtype.t_id default null,
                            p_priority in hdbk.dtype.t_id default null,
                            p_doc  in hdbk.dtype.t_id default null
                          )
  return blng.delay%rowtype
  is
    msg hdbk.dtype.t_msg;
    c_delay  SYS_REFCURSOR;
    r_obj blng.delay%rowtype;
  begin
      SELECT 
      * into r_obj
      from blng.delay
      where id = nvl(p_id,id)
      and contract_oid = nvl(p_contract,contract_oid)
      and doc_oid = nvl(p_doc,doc_oid)
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
      hdbk.log_api.LOG_ADD(p_proc_name=>'delay_get_info_r', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'select row into delay error. '||SQLERRM);
  end delay_get_info_r;


  function domain_add( p_name in hdbk.dtype.t_name default null,
                      p_contract in hdbk.dtype.t_id default null,
--                      p_status in hdbk.dtype.t_id default null,
                      p_is_domain in hdbk.dtype.t_status default null
                    )
  return hdbk.dtype.t_id
  is
    v_obj_row domain%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_obj_row.name := p_name;
    v_obj_row.contract_oid := p_contract;
    v_obj_row.is_domain := p_is_domain;
    v_obj_row.status := 'A';
    insert into domain values v_obj_row returning id into v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'domain_add', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'insert row into domain error. '||SQLERRM);
  end;


  procedure domain_edit ( p_id in hdbk.dtype.t_id default null,
                        p_name in hdbk.dtype.t_name default null,
                      p_contract in hdbk.dtype.t_id default null,
                      p_status in hdbk.dtype.t_status default null,
                      p_is_domain in hdbk.dtype.t_status default null
                      )
  is
    v_mess hdbk.dtype.t_msg;
    v_obj_row_new domain%rowtype;
    v_obj_row_old domain%rowtype;
  begin

    select * into v_obj_row_old from domain
    where id = p_id
    ;

    v_obj_row_new := v_obj_row_old;

    v_obj_row_old.id:=null;
    v_obj_row_old.amnd_state :='I';
    insert into domain values v_obj_row_old;

    v_obj_row_new.amnd_date:=sysdate;
    v_obj_row_new.amnd_user:=user;
    v_obj_row_new.name:=nvl(p_name, v_obj_row_new.name);
    v_obj_row_new.contract_oid := nvl(p_contract, v_obj_row_new.contract_oid);
    v_obj_row_new.is_domain := nvl(p_is_domain, v_obj_row_new.is_domain);

    if p_status in ('C') then v_obj_row_new.amnd_state :='C'; v_obj_row_new.status :='C'; end if;
    if p_status in ('I') then v_obj_row_new.status :='I'; end if;
    if p_status in ('A') then v_obj_row_new.status :='A'; end if;


    update domain set row = v_obj_row_new where id = v_obj_row_new.id;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;      
  when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'delay_edit', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'update row into domain error. '||SQLERRM);
  end;



  function domain_get_info (p_id in hdbk.dtype.t_id default null,
                            p_name in hdbk.dtype.t_name default null,
                          p_contract in hdbk.dtype.t_id default null,
                          p_status in hdbk.dtype.t_status default null,
                          p_is_domain in hdbk.dtype.t_status default null
                            
                          )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
    OPEN v_results FOR
      SELECT 
      *
      from domain
      where id = nvl(p_id,id)
      and contract_oid = nvl(p_contract,contract_oid)
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
      hdbk.log_api.LOG_ADD(p_proc_name=>'domain_get_info', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'select row into domain error. '||SQLERRM);
  end;

  function domain_get_info_r (p_id in hdbk.dtype.t_id default null,
                            p_name in hdbk.dtype.t_name default null,
                          p_contract in hdbk.dtype.t_id default null,
                          p_status in hdbk.dtype.t_status default null,
                          p_is_domain in hdbk.dtype.t_status default null
                            
                          )
  return domain%rowtype
  is
    r_obj domain%rowtype;
  begin
      SELECT 
      * into r_obj
      from domain
      where id = nvl(p_id,id)
      and name = nvl(p_name,name)
      and amnd_state != 'I';
    return r_obj;
  exception 
    when NO_DATA_FOUND then
      hdbk.log_api.LOG_ADD(p_proc_name=>'domain_get_info_r', p_msg_type=>'NO_DATA_FOUND');
        raise;
    when TOO_MANY_ROWS then
      hdbk.log_api.LOG_ADD(p_proc_name=>'domain_get_info_r', p_msg_type=>'TOO_MANY_ROWS');
        raise;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'domain_get_info_r', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'select row into domain error. '||SQLERRM);
  end;


  function usr_data_add(
                          p_user in hdbk.dtype.t_id default null, 
                          p_last_name in hdbk.dtype.t_name default null, 
                          p_first_name in hdbk.dtype.t_name default null, 
                          p_birth_date in hdbk.dtype.t_date default null, 
                          p_gender in hdbk.dtype.t_status default null, 
                          p_nationality in hdbk.dtype.t_code default null, 
                          p_doc_number in hdbk.dtype.t_long_code default null,
                          p_open_date in hdbk.dtype.t_date default null, 
                          p_expiry_date in hdbk.dtype.t_date default null, 
                          p_owner in hdbk.dtype.t_status default null,
                        p_phone in hdbk.dtype.t_name default null
                          )
  return hdbk.dtype.t_id
  is
    v_obj_row blng.usr_data%rowtype;
    v_id hdbk.dtype.t_id;
  begin
    v_obj_row.user_oid := p_user;
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

    insert into blng.usr_data values v_obj_row returning id into v_id;
    return v_id;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'usr_data_add', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'insert row into usr_data error. '||SQLERRM);
  end;

  procedure usr_data_edit(p_id in hdbk.dtype.t_id,
                          p_user in hdbk.dtype.t_id default null, 
                          p_last_name in hdbk.dtype.t_name default null, 
                          p_first_name in hdbk.dtype.t_name default null, 
                          p_birth_date in hdbk.dtype.t_date default null, 
                          p_gender in hdbk.dtype.t_status default null, 
                          p_nationality in hdbk.dtype.t_code default null, 
                          p_doc_number in hdbk.dtype.t_long_code default null,
                          p_open_date in hdbk.dtype.t_date default null, 
                          p_expiry_date in hdbk.dtype.t_date default null, 
                          p_owner in hdbk.dtype.t_status default null,
                        p_phone in hdbk.dtype.t_name default null,
                        p_status in hdbk.dtype.t_status default null)
  is
    v_obj_row_new blng.usr_data%rowtype;
    v_obj_row_old blng.usr_data%rowtype;
    v_mess hdbk.dtype.t_msg;
  begin
    select * into v_obj_row_old from blng.usr_data where id = p_id;
    v_obj_row_new := v_obj_row_old;

    v_obj_row_new.last_name:=nvl(upper(p_last_name), v_obj_row_new.last_name);
    v_obj_row_new.first_name:=nvl(upper(p_first_name), v_obj_row_new.first_name);
    v_obj_row_new.birth_date:=nvl(p_birth_date, v_obj_row_new.birth_date);
    v_obj_row_new.gender:=nvl(upper(p_gender), v_obj_row_new.gender);
    v_obj_row_new.user_oid:=nvl(p_user, v_obj_row_new.user_oid);
    v_obj_row_new.nationality:=nvl(p_nationality, v_obj_row_new.nationality);
--    v_obj_row_new.email:=nvl(p_email, v_obj_row_new.email);
    v_obj_row_new.doc_number:=nvl(upper(p_doc_number), v_obj_row_new.doc_number);
    v_obj_row_new.open_date:=nvl(p_open_date, v_obj_row_new.open_date);
    v_obj_row_new.expiry_date:=nvl(p_expiry_date, v_obj_row_new.expiry_date);
    v_obj_row_new.owner:=nvl(upper(p_owner), v_obj_row_new.owner);
    v_obj_row_new.phone:=nvl(p_phone, v_obj_row_new.phone);
    if p_status in ('C','D') then  v_obj_row_new.amnd_state := 'C'; end if;

    if  
      nvl(v_obj_row_new.last_name,'X') = nvl(v_obj_row_old.last_name,'X') AND
      nvl(v_obj_row_new.first_name,'X') = nvl(v_obj_row_old.first_name,'X') AND
      nvl(to_char(v_obj_row_new.birth_date,'ddmmyyyy'),'X') = nvl(to_char(v_obj_row_old.birth_date,'ddmmyyyy'),'X') and
      nvl(v_obj_row_new.gender,'X') = nvl(v_obj_row_old.gender,'X') and
      v_obj_row_new.user_oid = v_obj_row_old.user_oid and
      nvl(v_obj_row_new.nationality,'X') = nvl(v_obj_row_old.nationality,'X') and
  --    v_obj_row_new.email:=nvl(p_email, v_obj_row_new.email);
      nvl(v_obj_row_new.doc_number,'X') = nvl(v_obj_row_old.doc_number,'X') and 
      nvl(to_char(v_obj_row_new.open_date,'ddmmyyyy'),'X') = nvl(to_char(v_obj_row_old.open_date,'ddmmyyyy'),'X') and
      nvl(to_char(v_obj_row_new.expiry_date,'ddmmyyyy'),'X') = nvl(to_char(v_obj_row_old.expiry_date,'ddmmyyyy'),'X') and
      nvl(v_obj_row_new.owner,'X') = nvl(v_obj_row_old.owner,'X') and  
      nvl(v_obj_row_new.phone,'X') = nvl(v_obj_row_old.phone,'X')  
      and v_obj_row_new.amnd_state = v_obj_row_old.amnd_state
    then return; 
    else
      v_obj_row_new.amnd_date:=sysdate;
      v_obj_row_new.amnd_user:=user;
      v_obj_row_old.amnd_state:='I';
      v_obj_row_old.id:=null;
      insert into blng.usr_data values v_obj_row_old;
      update blng.usr_data set row = v_obj_row_new where id = p_id;
    end if;  

  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;    
  when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'usr_data_edit', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'update row into usr_data error. '||SQLERRM);
  end;


  function usr_data_get_info(p_id in hdbk.dtype.t_id, 
                          p_user in hdbk.dtype.t_id default null, 
                          p_last_name in hdbk.dtype.t_name default null, 
                          p_first_name in hdbk.dtype.t_name default null, 
                          p_birth_date in hdbk.dtype.t_date default null, 
                          p_gender in hdbk.dtype.t_status default null, 
                          p_nationality in hdbk.dtype.t_code default null, 
                  p_doc_number in hdbk.dtype.t_long_code default null,
                  p_open_date in hdbk.dtype.t_date default null, 
                  p_expiry_date in hdbk.dtype.t_date default null, 
                  p_owner in hdbk.dtype.t_status default null,
                        p_phone in hdbk.dtype.t_name default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        *
        from blng.usr_data 
        where id = nvl(p_id,id)
        and amnd_state = 'A'
        and user_oid = nvl(p_user,user_oid)
        order by id;
    return v_results;
  exception 
    when NO_DATA_FOUND then 
      raise NO_DATA_FOUND;
    when TOO_MANY_ROWS then 
      raise NO_DATA_FOUND;     
  when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'usr_data_get_info', p_msg_type=>'UNHANDLED_ERROR');
    RAISE_APPLICATION_ERROR(-20002,'select row into usr_data error. '||SQLERRM);
  end;

  function usr_data_get_info_r ( p_id in hdbk.dtype.t_id, 
                          p_user in hdbk.dtype.t_id default null, 
                          p_last_name in hdbk.dtype.t_name default null, 
                          p_first_name in hdbk.dtype.t_name default null, 
                          p_birth_date in hdbk.dtype.t_date default null, 
                          p_gender in hdbk.dtype.t_status default null, 
                          p_nationality in hdbk.dtype.t_code default null, 
                          p_doc_number in hdbk.dtype.t_long_code default null,
                          p_open_date in hdbk.dtype.t_date default null, 
                          p_expiry_date in hdbk.dtype.t_date default null, 
                          p_owner in hdbk.dtype.t_status default null,
                        p_phone in hdbk.dtype.t_name default null
                            )
  return blng.usr_data%rowtype
  is
    r_obj blng.usr_data%rowtype;
  begin

        SELECT
        * into r_obj
        from blng.usr_data 
        where id = nvl(p_id,id)
        and user_oid = nvl(p_user,user_oid)
        and amnd_state != 'I'
        order by id;
    return r_obj;
  exception 
    when NO_DATA_FOUND then
      hdbk.log_api.LOG_ADD(p_proc_name=>'usr_data_get_info_r', p_msg_type=>'NO_DATA_FOUND');
      RAISE;
    when TOO_MANY_ROWS then
      hdbk.log_api.LOG_ADD(p_proc_name=>'usr_data_get_info_r', p_msg_type=>'TOO_MANY_ROWS');
      RAISE;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'usr_data_get_info_r', p_msg_type=>'UNHANDLED_ERROR');
      RAISE_APPLICATION_ERROR(-20002,'select row into usr_data error. '||SQLERRM);
  end usr_data_get_info_r;

end blng_api;

/
