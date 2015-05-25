  CREATE OR REPLACE PACKAGE BLNG.CORE as

/*
pkg: blng.core
*/  

/*
$obj_type: constant
$obj_name: g_delay_days
$obj_desc: means how many days client has for pay loan
*/
    g_delay_days CONSTANT     hdbk.dtype.t_id := 30;

/*
$obj_type: procedure
$obj_name: approve_documents
$obj_desc: calls from scheduler. get list of document and separate it by transaction type.
$obj_desc: documents like increase credit limit or loan days approve immediately
$obj_desc: docs like cash_in/buy push to credit/debit_online accounts.
*/
  procedure approve_documents;

/*
$obj_type: procedure
$obj_name: buy
$obj_desc: calls inside approve_documents and push buy documents to debit_online account
$obj_param: p_doc: id of document
*/
  procedure buy (p_doc in blng.document%rowtype);

/*
$obj_type: procedure
$obj_name: cash_in
$obj_desc: calls inside approve_documents and push cash_in documents to credit_online account
$obj_param: p_doc: row from document
*/
  procedure cash_in ( p_doc in blng.document%rowtype);

/*
$obj_type: procedure
$obj_name: pay_bill
$obj_desc: procedure make paing for one bill
$obj_param: p_doc: row from document
*/
  procedure pay_bill ( p_doc in blng.document%rowtype);

/*
$obj_type: procedure
$obj_name: credit_online
$obj_desc: calls from scheduler. get list of credit_online accounts and separate money to debit or loan accounts.
$obj_desc: then close loan delay
*/
  procedure credit_online(p_document in hdbk.dtype.t_id default null);

/*
$obj_type: procedure
$obj_name: debit_online
$obj_desc: calls from scheduler. get list of debit_online accounts and separate money to debit or loan accounts.
$obj_desc: then create loan delay
*/
  procedure debit_online(p_document in hdbk.dtype.t_id default null);
  
/*
$obj_type: procedure
$obj_name: online
$obj_desc: calls from scheduler debit_online and credit_online procedures.
$obj_desc: then create loan delay
*/
  procedure online_accounts;

/*
$obj_type: procedure
$obj_name: delay_remove
$obj_desc: calls from credit_online and close loan delay
$obj_param: p_contract: id of contract
$obj_param: p_amount: how much money falls to delay list
$obj_param: p_transaction: link to transaction id. later by this id cash_in operations may revokes
*/
  procedure delay_remove(p_contract in hdbk.dtype.t_id, p_amount in hdbk.dtype.t_amount, p_transaction in hdbk.dtype.t_id default null);

  /*
$obj_type: procedure
$obj_name: delay_expire
$obj_desc: calls from scheduler at 00:00 UTC. get list of expired delays, then block credit limit
*/
  procedure delay_expire;

/*
$obj_type: procedure
$obj_name: contract_unblock
$obj_desc: calls by office user and give chance to pay smth for p_days. 
$obj_desc: due to this days expired contract have unblocked credit limit. 
$obj_desc: after p_days it blocks again
$obj_param: p_contract: id of expired contract
$obj_param: p_days: how much days gifted to client
*/
  procedure contract_unblock(p_contract in hdbk.dtype.t_id, p_days in hdbk.dtype.t_id default 1);

/*
$obj_type: procedure
$obj_name: unblock
$obj_desc: check if contract do not have expired delays and unblock it
$obj_param: p_contract: id of expired contract
*/
  procedure unblock(p_contract in hdbk.dtype.t_id);

/*
$obj_type: procedure
$obj_name: revoke_document
$obj_desc: get back money and erase transactions by p_document id
$obj_param: p_document: id of document
*/
  procedure revoke_document(p_document in hdbk.dtype.t_id);
  
  
/*
$obj_type: function
$obj_name: pay_contract_by_client
$obj_desc: get contract which client can spend money 
$obj_desc: documents like increase credit limit or loan days approve immediately
$obj_desc: docs like buy or cash_in push to credit/debit_online accounts.
$obj_param: p_client: client id
$obj_return: contract id
*/
  function pay_contract_by_client(p_client in hdbk.dtype.t_id)
  return hdbk.dtype.t_id;
  
end core;

/

  CREATE OR REPLACE PACKAGE BODY BLNG.CORE as

  procedure approve_documents
  is
    mess hdbk.dtype.t_msg;
    c_doc SYS_REFCURSOR;
    r_doc blng.document%rowtype;
    r_account blng.account%rowtype;
    v_item_avia_r ord.item_avia%rowtype;
    v_bill_r ord.bill%rowtype;
    v_transaction hdbk.dtype.t_id;
    v_item_avia_status hdbk.dtype.t_id;
    v_waiting_contract hdbk.dtype.t_id;
    r_item_avia_status ord.item_avia_status%rowtype;
  begin
--TODO in case load docs with file. load cash_in file at first
    v_waiting_contract := null;

    c_doc := blng.blng_api.document_get_info(p_status=>'W');
    LOOP
      FETCH c_doc INTO r_doc;
      EXIT WHEN c_doc%NOTFOUND;

      begin
        -- TO DO: is it good to put id in choice
        if r_doc.TRANS_TYPE_OID in (blng_api.trans_type_get_id(p_code=>'b')) then
          CONTINUE;
/*          if v_waiting_contract is not null and v_waiting_contract = r_doc.contract_oid then raise hdbk.dtype.doc_waiting; end if;
          blng.core.buy(r_doc);*/
        end if;
        if r_doc.TRANS_TYPE_OID in (blng_api.trans_type_get_id(p_code=>'ci')) then
          if v_waiting_contract is not null and v_waiting_contract = r_doc.contract_oid then raise hdbk.dtype.doc_waiting; end if;
          blng.core.cash_in(r_doc);
        end if;
        if r_doc.TRANS_TYPE_OID in (blng_api.trans_type_get_id(p_code=>'cl')) then 
          if r_doc.amount < 0 then raise VALUE_ERROR; end if;
          r_account := blng.blng_api.account_get_info_r(p_contract => r_doc.contract_oid, p_code => 'cl'  );
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => r_doc.id,P_AMOUNT => abs(r_doc.amount)-abs(r_account.amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'cl'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
          blng.blng_api.document_edit(r_doc.id, p_account_trans_type=> hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'CREDIT_LIMIT') );
        end if;
        if r_doc.TRANS_TYPE_OID in (blng_api.trans_type_get_id(p_code=>'ult')) then 
          if r_doc.amount < 0 then raise VALUE_ERROR; end if;
          r_account := blng.blng_api.account_get_info_r(p_contract => r_doc.contract_oid, p_code => 'ult'  );
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => r_doc.id,P_AMOUNT => abs(r_doc.amount)-abs(r_account.amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ult'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
          blng.blng_api.document_edit(r_doc.id, p_account_trans_type=> hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'UP_LIM_TRANS') );
        end if;
        if r_doc.TRANS_TYPE_OID in (blng_api.trans_type_get_id(p_code=>'dd')) then
          if r_doc.amount < 0 then raise VALUE_ERROR; end if;
          r_account := blng.blng_api.account_get_info_r(p_contract => r_doc.contract_oid, p_code => 'dd'  );
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => r_doc.id,P_AMOUNT => abs(r_doc.amount)-abs(r_account.amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'dd'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
          blng.blng_api.document_edit(r_doc.id, p_account_trans_type=> hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'DELAY_DAY') );
        end if;
        blng.blng_api.document_edit(r_doc.id, 'P');
        if r_doc.bill_oid is not null then 
          -- edit bill
          ord.ORD_API.bill_edit( P_id => r_doc.bill_oid, P_STATUS => 'P'); -- transported to payed
          -- edit PNR
          v_bill_r := ord.ord_api.bill_get_info_r(p_id=>r_doc.bill_oid);
          v_item_avia_r := ord.ord_api.item_avia_get_info_r(p_order => v_bill_r.order_oid);
          r_item_avia_status := ord.ord_api.item_avia_status_get_info_r(p_item_avia => v_item_avia_r.id);
          hdbk.log_api.LOG_ADD(p_proc_name=>'approve_document', p_msg_type=>'try set status SUCCESS',
            P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',item_avia='|| v_item_avia_r.id||'p_process=update,p_table=item_avia_status,p_date='
            || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
          ord.ord_api.item_avia_status_edit (  p_item_avia => v_item_avia_r.id, p_po_status => 'SUCCESS',
                                  p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
        end if;
        commit;
      exception
        when hdbk.dtype.insufficient_funds then
          rollback;
          hdbk.log_api.LOG_ADD(p_proc_name=>'approve_documents', p_msg_type=>'Warning', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20001)),p_info => ',p_process=set,p_status=D,p_doc=' || r_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>2);
          blng.blng_api.document_edit(r_doc.id, 'D');
          if r_doc.bill_oid is not null then 
            --edit bill
            ord.ORD_API.bill_edit( P_id => r_doc.bill_oid, P_STATUS => 'M'); -- transported to managed
            --edit PNR
            v_bill_r := ord.ord_api.bill_get_info_r(p_id=>r_doc.bill_oid);
            v_item_avia_r := ord.ord_api.item_avia_get_info_r(p_order => v_bill_r.order_oid);
            r_item_avia_status := ord.ord_api.item_avia_status_get_info_r(p_item_avia => v_item_avia_r.id);
            hdbk.log_api.LOG_ADD(p_proc_name=>'approve_document', p_msg_type=>'try set status ERROR',
              P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',item_avia='|| v_item_avia_r.id||'p_process=update,p_table=item_avia_status,p_date='
              || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
            ord.ord_api.item_avia_status_edit (  p_item_avia => v_item_avia_r.id, p_po_status => 'ERROR',
                                    p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
          end if;
          commit;
        when hdbk.dtype.doc_waiting then
          rollback;
          v_waiting_contract := r_doc.contract_oid;
          hdbk.log_api.LOG_ADD(p_proc_name=>'approve_documents', p_msg_type=>'Warning', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20000)),p_info => 'p_doc=' || r_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
        when VALUE_ERROR then
          rollback;
          hdbk.log_api.LOG_ADD(p_proc_name=>'approve_documents', p_msg_type=>'Error', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20000)),p_info => 'p_doc=' || r_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
          blng.blng_api.document_edit(r_doc.id, 'E');
          if r_doc.bill_oid is not null then 
            --edit bill
            ord.ORD_API.bill_edit( P_id => r_doc.bill_oid, P_STATUS => 'M'); -- transported to managed
            --edit PNR
            v_bill_r := ord.ord_api.bill_get_info_r(p_id=>r_doc.bill_oid);
            v_item_avia_r := ord.ord_api.item_avia_get_info_r(p_order => v_bill_r.order_oid);
            r_item_avia_status := ord.ord_api.item_avia_status_get_info_r(p_item_avia => v_item_avia_r.id);
            hdbk.log_api.LOG_ADD(p_proc_name=>'approve_document', p_msg_type=>'try set status ERROR',
              P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',item_avia='|| v_item_avia_r.id||'p_process=update,p_table=item_avia_status,p_date='
              || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
            ord.ord_api.item_avia_status_edit (  p_item_avia => v_item_avia_r.id, p_po_status => 'ERROR',
                                    p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
          end if;
          commit;
          raise_application_error(-20003,'Wrong account amount value');--outside error
        when others then
          rollback;
          hdbk.log_api.LOG_ADD(p_proc_name=>'approve_documents.c_doc', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || r_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
          blng.blng_api.document_edit(r_doc.id, 'E');
          if r_doc.bill_oid is not null then 
            --edit bill
            ord.ORD_API.bill_edit( P_id => r_doc.bill_oid, P_STATUS => 'M'); -- transported to managed
            --edit PNR
            v_bill_r := ord.ord_api.bill_get_info_r(p_id=>r_doc.bill_oid);
            v_item_avia_r := ord.ord_api.item_avia_get_info_r(p_order => v_bill_r.order_oid);
            r_item_avia_status := ord.ord_api.item_avia_status_get_info_r(p_item_avia => v_item_avia_r.id);
            hdbk.log_api.LOG_ADD(p_proc_name=>'approve_document', p_msg_type=>'try set status ERROR',
              P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',item_avia='|| v_item_avia_r.id||'p_process=update,p_table=item_avia_status,p_date='
              || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
            ord.ord_api.item_avia_status_edit (  p_item_avia => v_item_avia_r.id, p_po_status => 'ERROR',
                                    p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
          commit;
          end if;
      end;
    END LOOP;
    CLOSE c_doc;

  exception
    when others then
      rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'approve_documents', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || r_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      blng.blng_api.document_edit(r_doc.id, 'E'); --commited inside. its wrong.
      if r_doc.bill_oid is not null then 
        --edit bill
        ord.ORD_API.bill_edit( P_id => r_doc.bill_oid, P_STATUS => 'M'); -- transported to managed
        --edit PNR
        v_bill_r := ord.ord_api.bill_get_info_r(p_id=>r_doc.bill_oid);
        v_item_avia_r := ord.ord_api.item_avia_get_info_r(p_order => v_bill_r.order_oid);
        r_item_avia_status := ord.ord_api.item_avia_status_get_info_r(p_item_avia => v_item_avia_r.id);
        hdbk.log_api.LOG_ADD(p_proc_name=>'approve_document', p_msg_type=>'try set status ERROR',
          P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',item_avia='|| v_item_avia_r.id||'p_process=update,p_table=item_avia_status,p_date='
          || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
        ord.ord_api.item_avia_status_edit (  p_item_avia => v_item_avia_r.id, p_po_status => 'ERROR',
                                p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
      end if;
  end;


  procedure buy ( p_doc in blng.document%rowtype
                )
  is
    v_transaction hdbk.dtype.t_id;
    r_account blng.account%rowtype;
    r_contract_info blng.v_account%rowtype;
    v_msg hdbk.dtype.t_msg;

  begin

    r_contract_info := blng.fwdr.v_account_get_info_r(p_contract => p_doc.contract_oid);

    if r_contract_info.debit_online<>0 or r_contract_info.credit_online<>0 then
      raise_application_error(-20000,'last trunsaction not approved. wait.');
    end if;

    if r_contract_info.available <= 0
    or abs(r_contract_info.available) < abs(p_doc.amount)
    then
      raise_application_error(-20001,'insufficient funds');
    end if;
    if r_contract_info.max_loan_trans_amount<>0
    and abs(r_contract_info.deposit) < abs(p_doc.amount)
    and r_contract_info.max_loan_trans_amount < abs(abs(r_contract_info.deposit)-abs(p_doc.amount))  then
      raise_application_error(-20001,'loan transaction amount > max_loan_trans_amount');
    end if;

-- push all money to debit_online account. this account only for documents that decreasing money balance such as BUY 
    r_account := blng.blng_api.account_get_info_r(p_contract => p_doc.contract_oid,
            p_code => 'do'  );
    v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => P_DOC.id,P_AMOUNT => -abs(p_doc.AMOUNT),
      P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'b'), P_TRANS_DATE => p_doc.doc_date, P_TARGET_ACCOUNT => r_account.id, p_status => 'W');
  exception
    when hdbk.dtype.insufficient_funds then
      hdbk.log_api.LOG_ADD(p_proc_name=>'buy', p_msg_type=>'Warning', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20001)),p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>2);
      raise;
    when hdbk.dtype.doc_waiting then
      hdbk.log_api.LOG_ADD(p_proc_name=>'buy', p_msg_type=>'Warning', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20000)),p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
      raise;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'buy', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      raise;
  end buy;

  procedure cash_in (p_doc in blng.document%rowtype)
  is
    v_transaction hdbk.dtype.t_id;
    r_account blng.account%rowtype;
    r_contract_info blng.v_account%rowtype;
    v_msg hdbk.dtype.t_msg;
  begin
    r_contract_info := blng.fwdr.v_account_get_info_r(p_contract => p_doc.contract_oid);
    if r_contract_info.debit_online<>0 or r_contract_info.credit_online<>0 then
      raise_application_error(-20000,'last trunsaction not approved. wait.');
    end if;

--    DBMS_OUTPUT.PUT_LINE('doc = '|| p_doc.id);
-- push all money to credit_online account. this account only for documents that increasing money balance such as CASH_IN 
    r_account := blng.blng_api.account_get_info_r(p_contract => p_doc.contract_oid,
            p_code => 'co'  );
    v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => P_DOC.id,P_AMOUNT => abs(p_doc.AMOUNT),
      P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ci'), P_TRANS_DATE => p_doc.doc_date, P_TARGET_ACCOUNT => r_account.id, p_status => 'W');
--            DBMS_OUTPUT.PUT_LINE('r_account.id = '|| r_account.id);
    blng.core.delay_remove(p_doc.contract_oid, abs(p_doc.AMOUNT), p_transaction => v_transaction);
  exception
    when hdbk.dtype.doc_waiting then
      hdbk.log_api.LOG_ADD(p_proc_name=>'cash_in', p_msg_type=>'Warning', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20000)),p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
      raise;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'cash_in', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      raise;
  end cash_in;

  procedure pay_bill (p_doc in blng.document%rowtype)
  is
    v_transaction hdbk.dtype.t_id;
    r_account blng.account%rowtype;
    r_v_delay blng.v_delay%rowtype;
    r_bill_pay ord.bill%rowtype;
    v_bill_buy hdbk.dtype.t_id;
    r_contract_info blng.v_account%rowtype;
    v_msg hdbk.dtype.t_msg;
  begin


    r_contract_info := blng.fwdr.v_account_get_info_r(p_contract => p_doc.contract_oid);
    if r_contract_info.debit_online<>0 or r_contract_info.credit_online<>0 then
      raise_application_error(-20000,'last trunsaction not approved. wait.');
    end if;

  --    hdbk.log_api.LOG_ADD(p_proc_name=>'pay_bill', p_msg_type=>'Warning', P_MSG => '1',p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
    r_bill_pay:=ord.ord_api.bill_get_info_r(p_id=>p_doc.bill_oid);
 --     hdbk.log_api.LOG_ADD(p_proc_name=>'pay_bill', p_msg_type=>'Warning', P_MSG => '2',p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
    v_bill_buy:=r_bill_pay.bill_oid;
--      hdbk.log_api.LOG_ADD(p_proc_name=>'pay_bill', p_msg_type=>'Warning', P_MSG => '3',p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
    if v_bill_buy is null then raise NO_DATA_FOUND; end if;
 --     hdbk.log_api.LOG_ADD(p_proc_name=>'pay_bill', p_msg_type=>'Warning', P_MSG => '4',p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
    select * into r_v_delay from blng.v_delay where bill_id = v_bill_buy;
 --     hdbk.log_api.LOG_ADD(p_proc_name=>'pay_bill', p_msg_type=>'Warning', P_MSG => '5',p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);

    if r_v_delay.amount_need < p_doc.amount then raise value_error; end if;
 --     hdbk.log_api.LOG_ADD(p_proc_name=>'pay_bill', p_msg_type=>'Warning', P_MSG => '6',p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);

-- push all money to credit_online account. this account only for documents that increasing money balance such as CASH_IN 
--    DBMS_OUTPUT.PUT_LINE('doc = '|| p_doc.id);
--      hdbk.log_api.LOG_ADD(p_proc_name=>'pay_bill', p_msg_type=>'Warning', P_MSG => '7',p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
    r_account := blng.blng_api.account_get_info_r(p_contract => p_doc.contract_oid,
            p_code => 'co'  );
 --     hdbk.log_api.LOG_ADD(p_proc_name=>'pay_bill', p_msg_type=>'Warning', P_MSG => '8',p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
    v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => P_DOC.id,P_AMOUNT => abs(p_doc.AMOUNT),
      P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ci'), P_TRANS_DATE => p_doc.doc_date, P_TARGET_ACCOUNT => r_account.id, p_status => 'W');
--            DBMS_OUTPUT.PUT_LINE('r_account.id = '|| r_account.id);

 --     hdbk.log_api.LOG_ADD(p_proc_name=>'pay_bill', p_msg_type=>'Warning', P_MSG => '9',p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);

    BLNG_API.delay_add( P_CONTRACT => p_doc.contract_oid,
                      p_date_to => null,
                      P_AMOUNT => abs( p_doc.amount),
                      P_EVENT_TYPE => blng_api.event_type_get_id(p_code=>'ci'),
    --                              P_PRIORITY => 10,
                      p_transaction => v_transaction,
                      p_parent_id => r_v_delay.delay_id
                    );        
  --    hdbk.log_api.LOG_ADD(p_proc_name=>'pay_bill', p_msg_type=>'Warning', P_MSG => '10',p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
    
    if r_v_delay.amount_need = p_doc.amount then 
 --     hdbk.log_api.LOG_ADD(p_proc_name=>'pay_bill', p_msg_type=>'Warning', P_MSG => '11',p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
      BLNG_API.delay_edit(p_id => r_v_delay.delay_id, p_status => 'C');
    end if;

  --    hdbk.log_api.LOG_ADD(p_proc_name=>'pay_bill', p_msg_type=>'Warning', P_MSG => '12',p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
    -- unblock
    blng.core.unblock(p_doc.contract_oid);
 --     hdbk.log_api.LOG_ADD(p_proc_name=>'pay_bill', p_msg_type=>'Warning', P_MSG => '13',p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);

  exception
    when NO_DATA_FOUND then
      hdbk.log_api.LOG_ADD(p_proc_name=>'pay_bill', p_msg_type=>'NO_DATA_FOUND', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20000)),p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
      raise;
    when VALUE_ERROR then
      hdbk.log_api.LOG_ADD(p_proc_name=>'pay_bill', p_msg_type=>'VALUE_ERROR', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20000)),p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
      raise;
    when hdbk.dtype.doc_waiting then
      hdbk.log_api.LOG_ADD(p_proc_name=>'pay_bill', p_msg_type=>'Warning', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20000)),p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
      raise;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'pay_bill', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || p_doc.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      raise;
  end;


  procedure credit_online(p_document in hdbk.dtype.t_id default null)
  is
    v_transaction hdbk.dtype.t_id;
    v_transaction_2delay hdbk.dtype.t_id;
    v_doc hdbk.dtype.t_id;
    c_transaction SYS_REFCURSOR;
    r_credit_online blng.account%rowtype;
    r_transaction blng.transaction%rowtype;
    r_deposit blng.account%rowtype;
    r_loan blng.account%rowtype;
    v_msg hdbk.dtype.t_msg;
    v_amount hdbk.dtype.t_amount;
    v_settlement_amount hdbk.dtype.t_amount;
  begin
  -- get all cash_in transaction with status Waiting
  -- we have 3 branches of this process. 
  -- 1. loan = 0. its mean client have only deposit. then just push money from crtedit_online to credit account  
  -- 2. loan <> 0 and credit_online <= loan. its mean client have loan and bring not enough money
  -- or equivalent of loan. then just push money from crtedit_online to loan account 
  -- 3. loan <> 0 and credit_online > loan. its mean client have loan and bring more money then loan.
  -- close loan and other part push to deposit.
  -- after that we need to close delay. we need to set link from delay to main transaction. 
  -- thats why we get all transaction in W status and not *_online accounts.its need to reverse document and delay  later.
    r_transaction := blng.blng_api.transaction_get_info_r(p_trans_type => blng_api.trans_type_get_id(p_code=>'ci'),p_status => 'W',p_document=>p_document);

      
      r_credit_online:=blng_api.account_get_info_r(p_id =>r_transaction.target_account_oid);
      v_amount:=r_transaction.amount;
      v_doc := r_transaction.doc_oid;
--      blng.blng_api.document_edit(r_transaction.doc_oid, p_account_trans_type=> hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'CASH_IN') );

        -- send money to loan account
        r_loan := blng.blng_api.account_get_info_r(p_code => 'l', p_contract => r_credit_online.contract_oid);
        r_deposit := blng.blng_api.account_get_info_r(p_code => 'd', p_contract => r_credit_online.contract_oid);

        if abs(r_loan.amount)=0 then
        --deposit
        --credit_online
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => -abs(v_amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'da'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_credit_online.id);
        --deposit
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => abs(v_amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ca'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_deposit.id);

        elsif abs(v_amount) > abs(r_loan.amount) then
        --loan
        --credit_online
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => -abs(r_loan.amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'da'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_credit_online.id);
        --loan
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => abs(r_loan.amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ca'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_loan.id);

        --deposit
        --credit_online
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => -abs(abs(v_amount) - abs(r_loan.amount)),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'da'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_credit_online.id);
        --deposit
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => abs(abs(v_amount) - abs(r_loan.amount)),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ca'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_deposit.id);

        elsif abs(v_amount) <= abs(r_loan.amount) then
        --loan
        --credit_online
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => -abs(v_amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'da'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_credit_online.id);
        --loan
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => abs(v_amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ca'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_loan.id);

         end if;

--        blng.core.delay_remove(r_credit_online.contract_oid, r_credit_online.amount, p_transaction => r_transaction.id);
        blng_api.transaction_edit(p_id => r_transaction.id, p_status => 'P');
--        commit;


  exception when others then
--    rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'credit_online', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_account=' || r_credit_online.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
  end;

  procedure debit_online(p_document in hdbk.dtype.t_id default null)
  is
    v_transaction hdbk.dtype.t_id;
    v_transaction_2delay hdbk.dtype.t_id;
    v_doc hdbk.dtype.t_id;
    c_transaction SYS_REFCURSOR;
    r_transaction blng.transaction%rowtype;
    r_debit_online blng.account%rowtype;
    r_deposit blng.account%rowtype;
    r_loan blng.account%rowtype;
    v_msg hdbk.dtype.t_msg;
    v_amount hdbk.dtype.t_amount;
    v_settlement_amount hdbk.dtype.t_amount;
    v_delay_amount  hdbk.dtype.t_amount;

    r_contract_info blng.v_account%rowtype;
  begin
  -- get all buy transaction with status Waiting
  -- we have 3 branches of this process. 
  -- 1. deposit = 0. its mean client have no deposit. then just get money from loan account to debit_account 
  -- 2. deposit <> 0 and debit_online <= deposit. its mean client have deposit and we can get money only fron deposit to debit_online.
  -- 3. deposit <> 0 and debit_online > deposit. its mean client have deposit, but not enough to pay document.
  -- get all money from deposit and other part from loan.
  -- if loan was created, then we have to create delay and set link to transaction.  
  -- thats why we get all transaction in W status and not *_online accounts.its need to reverse document and delay  later.
  
    r_transaction := blng.blng_api.transaction_get_info_r(p_trans_type => blng_api.trans_type_get_id(p_code=>'b'),p_status => 'W',p_document=>p_document);


      r_debit_online:=blng_api.account_get_info_r(p_id =>r_transaction.target_account_oid);
      v_amount:=r_transaction.amount;
      v_doc := r_transaction.doc_oid;

        -- send money to loan account
        r_loan := blng.blng_api.account_get_info_r(p_code => 'l', p_contract => r_debit_online.contract_oid);
        r_deposit := blng.blng_api.account_get_info_r(p_code => 'd', p_contract => r_debit_online.contract_oid);

        if abs(r_deposit.amount)=0 then
        --loan
        --loan
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => -abs(v_amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'da'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_loan.id);
          v_transaction_2delay:=v_transaction;
        --debit_online
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => abs(v_amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ca'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_debit_online.id);
          v_delay_amount:=-abs(v_amount);
    
          blng.blng_api.document_edit(v_doc, p_account_trans_type=> hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'LOAN') );

        elsif abs(v_amount) > abs(r_deposit.amount) then
        --deposit
        --deposit
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => -abs(r_deposit.amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'da'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_deposit.id);
        --debit_online
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => abs(r_deposit.amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ca'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_debit_online.id);

        --loan
        --loan
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => -abs(abs(v_amount) - abs(r_deposit.amount)),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'da'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_loan.id);
          v_transaction_2delay:=v_transaction;
        --debit_online
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => abs(abs(v_amount) - abs(r_deposit.amount)),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ca'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_debit_online.id);

          v_delay_amount:= -abs(abs(v_amount) - abs(r_deposit.amount));
          blng.blng_api.document_edit(v_doc, p_account_trans_type=> hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'LOAN') );

        elsif abs(v_amount) <= abs(r_deposit.amount) then
        --deposit
        --deposit
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => -abs(v_amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'da'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_deposit.id);
        --debit_online
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => abs(v_amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ca'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_debit_online.id);

          v_delay_amount:= 0;
--          blng.blng_api.document_edit(v_doc, p_account_trans_type=> hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'BUY') );

        end if;

        if v_delay_amount != 0 then
          r_contract_info := blng.fwdr.v_account_get_info_r(p_contract => r_debit_online.contract_oid);
          if r_contract_info.delay_days = 0 or r_contract_info.delay_days is null then r_contract_info.delay_days:= g_delay_days; end if;
          BLNG_API.delay_add( P_CONTRACT => r_debit_online.contract_oid,
--                              p_date_to => trunc(sysdate)+r_contract_info.delay_days,
-- add 1 day to let client pay bill
                              p_date_to => hdbk.core.delay_payday(P_DELAY => r_contract_info.delay_days,p_contract => r_debit_online.contract_oid) + 1,
                              P_AMOUNT => abs(v_delay_amount),
                              P_EVENT_TYPE => blng_api.event_type_get_id(p_code=>'b'),
                              P_PRIORITY => 10,
                              p_transaction => r_transaction.id
                            );
        end if;
        blng_api.transaction_edit(p_id => r_transaction.id, p_status => 'P');
--        commit; --after each transaction
  exception when others then
--    rollback;
    hdbk.log_api.LOG_ADD(p_proc_name=>'debit_online', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_account=' || r_debit_online.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
  end;



  procedure credit_online_back
  is
    v_transaction hdbk.dtype.t_id;
    v_transaction_2delay hdbk.dtype.t_id;
    v_doc hdbk.dtype.t_id;
    c_transaction SYS_REFCURSOR;
    r_credit_online blng.account%rowtype;
    r_transaction blng.transaction%rowtype;
    r_deposit blng.account%rowtype;
    r_loan blng.account%rowtype;
    v_msg hdbk.dtype.t_msg;
    v_amount hdbk.dtype.t_amount;
    v_settlement_amount hdbk.dtype.t_amount;
  begin
  -- get all cash_in transaction with status Waiting
  -- we have 3 branches of this process. 
  -- 1. loan = 0. its mean client have only deposit. then just push money from crtedit_online to credit account  
  -- 2. loan <> 0 and credit_online <= loan. its mean client have loan and bring not enough money
  -- or equivalent of loan. then just push money from crtedit_online to loan account 
  -- 3. loan <> 0 and credit_online > loan. its mean client have loan and bring more money then loan.
  -- close loan and other part push to deposit.
  -- after that we need to close delay. we need to set link from delay to main transaction. 
  -- thats why we get all transaction in W status and not *_online accounts.its need to reverse document and delay  later.
    c_transaction := blng.blng_api.transaction_get_info(p_trans_type => blng_api.trans_type_get_id(p_code=>'ci'),p_status => 'W');
    LOOP
      FETCH c_transaction INTO r_transaction;
      EXIT WHEN c_transaction%NOTFOUND;

      begin
      r_credit_online:=blng_api.account_get_info_r(p_id =>r_transaction.target_account_oid);
      v_amount:=r_transaction.amount;
      v_doc := r_transaction.doc_oid;
      blng.blng_api.document_edit(r_transaction.doc_oid, p_account_trans_type=> hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'CASH_IN') );

        -- send money to loan account
        r_loan := blng.blng_api.account_get_info_r(p_code => 'l', p_contract => r_credit_online.contract_oid);
        r_deposit := blng.blng_api.account_get_info_r(p_code => 'd', p_contract => r_credit_online.contract_oid);

        if abs(r_loan.amount)=0 then
        --deposit
        --credit_online
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => -abs(v_amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'da'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_credit_online.id);
        --deposit
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => abs(v_amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ca'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_deposit.id);

        elsif abs(v_amount) > abs(r_loan.amount) then
        --loan
        --credit_online
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => -abs(r_loan.amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'da'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_credit_online.id);
        --loan
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => abs(r_loan.amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ca'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_loan.id);

        --deposit
        --credit_online
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => -abs(abs(v_amount) - abs(r_loan.amount)),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'da'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_credit_online.id);
        --deposit
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => abs(abs(v_amount) - abs(r_loan.amount)),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ca'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_deposit.id);

        elsif abs(v_amount) <= abs(r_loan.amount) then
        --loan
        --credit_online
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => -abs(v_amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'da'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_credit_online.id);
        --loan
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => abs(v_amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ca'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_loan.id);

         end if;

--        blng.core.delay_remove(r_credit_online.contract_oid, r_credit_online.amount, p_transaction => r_transaction.id);
        blng_api.transaction_edit(p_id => r_transaction.id, p_status => 'P');
        commit;

      exception when others then
        rollback;
        hdbk.log_api.LOG_ADD(p_proc_name=>'credit_online.c_credit_online', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_account=' || r_credit_online.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      end;
    END LOOP;
    CLOSE c_transaction;
  exception when others then
    rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'credit_online', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_account=' || r_credit_online.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
  end;

  procedure debit_online_back
  is
    v_transaction hdbk.dtype.t_id;
    v_transaction_2delay hdbk.dtype.t_id;
    v_doc hdbk.dtype.t_id;
    c_transaction SYS_REFCURSOR;
    r_transaction blng.transaction%rowtype;
    r_debit_online blng.account%rowtype;
    r_deposit blng.account%rowtype;
    r_loan blng.account%rowtype;
    v_msg hdbk.dtype.t_msg;
    v_amount hdbk.dtype.t_amount;
    v_settlement_amount hdbk.dtype.t_amount;
    v_delay_amount  hdbk.dtype.t_amount;

    r_contract_info blng.v_account%rowtype;
  begin
  -- get all buy transaction with status Waiting
  -- we have 3 branches of this process. 
  -- 1. deposit = 0. its mean client have no deposit. then just get money from loan account to debit_account 
  -- 2. deposit <> 0 and debit_online <= deposit. its mean client have deposit and we can get money only fron deposit to debit_online.
  -- 3. deposit <> 0 and debit_online > deposit. its mean client have deposit, but not enough to pay document.
  -- get all money from deposit and other part from loan.
  -- if loan was created, then we have to create delay and set link to transaction.  
  -- thats why we get all transaction in W status and not *_online accounts.its need to reverse document and delay  later.
  
    c_transaction := blng.blng_api.transaction_get_info(p_trans_type => blng_api.trans_type_get_id(p_code=>'b'),p_status => 'W');
    LOOP
      FETCH c_transaction INTO r_transaction;
      EXIT WHEN c_transaction%NOTFOUND;

      begin
      r_debit_online:=blng_api.account_get_info_r(p_id =>r_transaction.target_account_oid);
      v_amount:=r_transaction.amount;
      v_doc := r_transaction.doc_oid;

        -- send money to loan account
        r_loan := blng.blng_api.account_get_info_r(p_code => 'l', p_contract => r_debit_online.contract_oid);
        r_deposit := blng.blng_api.account_get_info_r(p_code => 'd', p_contract => r_debit_online.contract_oid);

        if abs(r_deposit.amount)=0 then
        --loan
        --loan
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => -abs(v_amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'da'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_loan.id);
          v_transaction_2delay:=v_transaction;
        --debit_online
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => abs(v_amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ca'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_debit_online.id);
          v_delay_amount:=-abs(v_amount);
    
          blng.blng_api.document_edit(v_doc, p_account_trans_type=> hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'LOAN') );

        elsif abs(v_amount) > abs(r_deposit.amount) then
        --deposit
        --deposit
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => -abs(r_deposit.amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'da'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_deposit.id);
        --debit_online
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => abs(r_deposit.amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ca'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_debit_online.id);

        --loan
        --loan
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => -abs(abs(v_amount) - abs(r_deposit.amount)),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'da'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_loan.id);
          v_transaction_2delay:=v_transaction;
        --debit_online
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => abs(abs(v_amount) - abs(r_deposit.amount)),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ca'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_debit_online.id);

          v_delay_amount:= -abs(abs(v_amount) - abs(r_deposit.amount));
          blng.blng_api.document_edit(v_doc, p_account_trans_type=> hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'LOAN') );

        elsif abs(v_amount) <= abs(r_deposit.amount) then
        --deposit
        --deposit
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => -abs(v_amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'da'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_deposit.id);
        --debit_online
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => abs(v_amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ca'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_debit_online.id);

          v_delay_amount:= 0;
          blng.blng_api.document_edit(v_doc, p_account_trans_type=> hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'BUY') );

        end if;

        if v_delay_amount != 0 then
          r_contract_info := blng.fwdr.v_account_get_info_r(p_contract => r_debit_online.contract_oid);
          if r_contract_info.delay_days = 0 or r_contract_info.delay_days is null then r_contract_info.delay_days:= g_delay_days; end if;
          BLNG_API.delay_add( P_CONTRACT => r_debit_online.contract_oid,
--                              p_date_to => trunc(sysdate)+r_contract_info.delay_days,
-- add 1 day to let client pay bill
                              p_date_to => hdbk.core.delay_payday(P_DELAY => r_contract_info.delay_days,p_contract => r_debit_online.contract_oid) + 1,
                              P_AMOUNT => abs(v_delay_amount),
                              P_EVENT_TYPE => blng_api.event_type_get_id(p_code=>'b'),
                              P_PRIORITY => 10,
                              p_transaction => r_transaction.id
                            );
        end if;
        blng_api.transaction_edit(p_id => r_transaction.id, p_status => 'P');
        commit; --after each transaction
      exception when others then
        rollback;
        hdbk.log_api.LOG_ADD(p_proc_name=>'debit_online.c_debit_online', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_account=' || r_debit_online.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      end;
    END LOOP;
    CLOSE c_transaction;
  exception when others then
    rollback;
    hdbk.log_api.LOG_ADD(p_proc_name=>'debit_online.c_debit_online', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_account=' || r_debit_online.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
  end;


  procedure online_accounts
  is
  begin
--    debit_online;
--    credit_online;
null;
  end;

  procedure delay_remove(p_contract in hdbk.dtype.t_id, p_amount in hdbk.dtype.t_amount, p_transaction in hdbk.dtype.t_id default null)
  is
    v_amount  hdbk.dtype.t_amount;
    v_next_delay_date hdbk.dtype.t_date;
    c_delay SYS_REFCURSOR;
    r_delay blng.delay%rowtype;
    r_account blng.account%rowtype;
    v_transaction hdbk.dtype.t_id;
    v_delay_id  hdbk.dtype.t_id;
  begin
  -- concept of delay is a tree. root as loan amount and branches points is a credit amounts that payed that loan
  --     *      for example 100$ loan and 3 credit amounts: 20$ + 30$ + 50$. so, amount_have is a total of credit amounts, 
  --   / | \    amount_need is a loan minus total of credit amounts. after add a credit points, if amount_need = 0 then 
  --  *  *  *   unblock contract. its mean just setting to 0 credit_limit_block account

    v_amount := p_amount;

    for i_delay in (
    select * from blng.v_delay where contract_id = p_contract
    
--     AMOUNT         ID CONTRACT_OID AMOUNT_HAVE AMOUNT_NEED DATE_TO           
-- ---------- ---------- ------------ ----------- ----------- -------------------
--       9772       1004           21           0        9772 28.02.2015 00:00:00 
/*                    select
                    amount,
                    id,
                    d.contract_oid,
                    nvl((select sum(amount) from blng.delay where parent_id is not null and parent_id = d.id and amnd_state = 'A' and EVENT_TYPE_oid = blng_api.event_type_get_id(p_code=>'ci')),0) amount_have,
                    amount - nvl((select sum(amount) from blng.delay where parent_id is not null and parent_id = d.id and amnd_state = 'A' and EVENT_TYPE_oid = blng_api.event_type_get_id(p_code=>'ci')),0) amount_need,
                    date_to
                    from blng.delay d
                    where d.amnd_state = 'A'
                    and parent_id is null
                    and contract_oid = p_contract
                    and EVENT_TYPE_oid = blng_api.event_type_get_id(p_code=>'b')
                    order by contract_oid asc, date_to asc, id asc*/
    )
    LOOP
      begin
        v_delay_id := i_delay.delay_id;
        v_next_delay_date:= i_delay.date_to;
        if v_amount = 0 then exit; end if;
        if v_amount < abs(i_delay.amount_need) then
          BLNG_API.delay_add( P_CONTRACT => p_contract,
                              p_date_to => null,
                              P_AMOUNT => abs(v_amount),
                              P_EVENT_TYPE => blng_api.event_type_get_id(p_code=>'ci'),
--                              P_PRIORITY => 10,
                              p_transaction => p_transaction,
                              p_parent_id => i_delay.delay_id
                            );        
          exit;
        else
          BLNG_API.delay_add( P_CONTRACT => p_contract,
                              p_date_to => null,
                              P_AMOUNT => abs(i_delay.amount_need),
                              P_EVENT_TYPE => blng_api.event_type_get_id(p_code=>'ci'),
--                              P_PRIORITY => 10,
                              p_transaction => p_transaction,
                              p_parent_id => i_delay.delay_id
                            );        

          BLNG_API.delay_edit(p_id => i_delay.delay_id, p_status => 'C');
          v_amount := v_amount - abs(i_delay.amount_need);
        end if;
      exception when others then
        hdbk.log_api.LOG_ADD(p_proc_name=>'delay_remove.c_delay', p_msg_type=>'UNHANDLED_ERROR',
          P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_delay=' || r_delay.id || ',p_date=' ||
          to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
        raise;
      end;
    END LOOP;

    -- unblock
    blng.core.unblock(p_contract);
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'delay_remove', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_delay=' || v_delay_id || ',p_date=' ||
      to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    raise;
  end delay_remove;

  procedure delay_expire
  is
    v_amount  hdbk.dtype.t_amount;
    v_next_delay_date  hdbk.dtype.t_date;
    c_delay SYS_REFCURSOR;
    r_account blng.account%rowtype;
    v_transaction hdbk.dtype.t_id;
    log_contract hdbk.dtype.t_id;
    log_proc hdbk.dtype.t_code;
    r_contract_info blng.v_account%rowtype;
  begin
-- $TODO: select without api is bad
-- unblock delays is a delay/event that unblock (for time) blocked contract.
-- loan delay is a delay/event that have info about loan: when its happend, when client must pay for it,
-- how much client must pay for it.
-- this function close all unblock delays and block contracts with expired loan delays. 
-- 1 part. close all unblock events(delay) and close expired
-- 2 part. check all expired loan delays without unblock. if it exist then block contracts 
-- (update status to [B]locked and update account clb with -credit_limit)



--delete expired unblock
    log_proc:='UNBLOCK';
    for r_delay in (
      select id, contract_oid from blng.delay
      where amnd_state = 'A'
      and event_type_oid =  blng_api.event_type_get_id(p_code=>'clu')
      and date_to <= trunc(sysdate)
      and parent_id is null
    )
    loop
      begin
        log_contract := r_delay.contract_oid;
        -- this code expire
        BLNG_API.delay_edit(p_id => r_delay.id, p_status => 'C');
        commit; -- this process must be done anyway
      exception when others then
        rollback;
        hdbk.log_api.LOG_ADD(p_proc_name=>'delay_expire.unblock', p_msg_type=>'UNHANDLED_ERROR',
          P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_proc=' || log_proc || ',p_contract=' || log_contract || ',p_date=' ||
          to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      end;
    end loop;

    log_proc:='BLOCK';
    for r_delay in (
      select contract_oid from blng.delay block_delay
      where amnd_state = 'A'
      and event_type_oid =  blng_api.event_type_get_id(p_code=>'b')
      and date_to <= trunc(sysdate)
      and contract_oid not in (
        select contract_oid from blng.delay
        where amnd_state = 'A'
        and event_type_oid =  blng_api.event_type_get_id(p_code=>'clu')
      )
      group by contract_oid
    )
    loop
      begin
        log_contract := r_delay.contract_oid;
        r_account := blng.blng_api.account_get_info_r(p_contract => r_delay.contract_oid, p_code => 'clb');
        r_contract_info := blng.fwdr.v_account_get_info_r(p_contract => r_delay.contract_oid);
        if r_account.amount = 0 then
          blng_api.contract_edit(p_id=>log_contract,p_status=>'B');
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_AMOUNT => -r_contract_info.credit_limit,
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'clb'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
        end if;
        commit;
      exception when others then
        rollback;
        hdbk.log_api.LOG_ADD(p_proc_name=>'delay_expire.block', p_msg_type=>'UNHANDLED_ERROR',
          P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_proc=' || log_proc || ',p_contract=' || log_contract || ',p_date=' ||
          to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      end;

    end loop;
    
  exception 
    when NO_DATA_FOUND then
      rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'delay_expire', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_proc=' || log_proc || ',p_contract=' || log_contract || ',p_date=' ||
        to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    when others then
      rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'delay_expire', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_proc=' || log_proc || ',p_contract=' || log_contract || ',p_date=' ||
        to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
  end delay_expire;


  procedure unblock(p_contract in hdbk.dtype.t_id)
  is
    v_transaction hdbk.dtype.t_id;
    r_account blng.account%rowtype;
 --   v_transaction hdbk.dtype.t_id;
    v_next_delay_date hdbk.dtype.t_date:=null;
  begin
    begin
      select min(date_to) into v_next_delay_date from blng.v_delay where contract_id = p_contract; 
    exception when NO_DATA_FOUND then v_next_delay_date := null;
    end;
    -- unblock
    if v_next_delay_date > sysdate or v_next_delay_date is null then
      r_account := blng.blng_api.account_get_info_r(p_contract => p_contract, p_code => 'clb');
      if r_account.amount <> 0 then
        blng_api.contract_edit(p_id=>p_contract,p_status=>'A');      
        v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_AMOUNT => -r_account.amount,
          P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'clu'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
      end if;
    end if;
--    commit;
  exception 
    when NO_DATA_FOUND then
      null;
    when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'unblock', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_contract=' || p_contract || ',p_date=' ||
      to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      raise_application_error(-20003,'unblock error');
  end unblock;


  procedure contract_unblock(p_contract in hdbk.dtype.t_id, p_days in hdbk.dtype.t_id default 1)
  is
    r_account blng.account%rowtype;
    v_transaction hdbk.dtype.t_id;
  begin
-- executed by operators. can unblock contract for time, by adding unblock event/delay
    r_account := blng.blng_api.account_get_info_r(p_contract => p_contract, p_code => 'clb');
    --if r_account.amount <> 0 then
      blng_api.contract_edit(p_id=>p_contract,p_status=>'A');
    
      v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_AMOUNT => -r_account.amount,
        P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'clu'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
      BLNG_API.delay_add(P_CONTRACT => p_contract, P_EVENT_TYPE => blng_api.event_type_get_id(p_code=>'clu'),P_PRIORITY => 20,
        p_transaction=>v_transaction,p_date_to => trunc(sysdate)+p_days);
        
    --end if;
    commit;
  exception 
    when NO_DATA_FOUND then
      rollback;
      raise_application_error(-20003,'contract_unblock error. call wrong contract id');
    when others then
      rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'contract_unblock', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_contract=' || p_contract || ',p_date=' ||
      to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      raise_application_error(-20003,'contract_unblock error');
  end contract_unblock;


  procedure revoke_document(p_document in hdbk.dtype.t_id)
  is
    c_transaction SYS_REFCURSOR;
    r_transaction blng.transaction%rowtype;
    r_document blng.document%rowtype;
    v_transaction hdbk.dtype.t_id;
    v_buy hdbk.dtype.t_id;
    v_cash_in hdbk.dtype.t_id;
    v_amount  hdbk.dtype.t_amount;
    v_next_delay_date  hdbk.dtype.t_date;
    c_delay SYS_REFCURSOR;
    r_delay blng.delay%rowtype;
    r_account blng.account%rowtype;
    r_contract_info blng.v_account%rowtype;
    v_prev_amount hdbk.dtype.t_amount;
    v_first_amount hdbk.dtype.t_amount;
    v_last_amount hdbk.dtype.t_amount;
  begin
    r_document:=BLNG_API.document_get_info_r(p_id => P_document);
    v_buy:=blng_api.trans_type_get_id(p_code=>'b');
    v_cash_in:=blng_api.trans_type_get_id(p_code=>'ci');
    if r_document.trans_type_oid not in (v_buy,v_cash_in) then raise_application_error(-20005,'document can not be revoked'); end if;

    c_transaction := BLNG_API.transaction_get_info(P_doc => P_document);

    LOOP
      FETCH c_transaction INTO r_transaction;
      EXIT WHEN c_transaction%NOTFOUND;
      begin

-- add transaction with amount = -(amount of parent transaction)
        v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => r_transaction.doc_oid,P_AMOUNT => -r_transaction.amount,
          P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'rvk'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_transaction.target_account_oid,
          p_prev=>r_transaction.amnd_prev,p_status=>'R');

-- remove delays
        if r_transaction.trans_type_oid = v_buy then --buy
-- reverse of buy document
-- delay will be one. so just find this row, update status and move cash_in's to other delay
          begin
            r_delay := BLNG_API.delay_get_info_r(P_transaction => r_transaction.id);
            if r_delay.id is not null then 
              BLNG_API.delay_edit(P_id => r_delay.id, p_status => 'R');
              for i_cash_in in (
                select * from blng.delay 
                where parent_id = r_delay.id
                and amnd_state = 'A'
              )
              loop
  -- to move cash_in's delay just start remove_delay for each cash_in amount
                CORE.delay_remove (  P_CONTRACT => r_delay.contract_oid,
                  P_AMOUNT => i_cash_in.amount,P_TRANSACTION => i_cash_in.transaction_oid);
                blng_api.delay_edit(P_id => i_cash_in.id, p_status => 'I');
              end loop;        
            end if;      
          exception when NO_DATA_FOUND then 
-- its mean deposit > document.amount. need not reverse loan delays
            NULL; 
          end;
        elsif r_transaction.trans_type_oid = v_cash_in then --cash_in
-- reverse of cash_in document
-- there could be any cash_in delays. because big cash_in can close all loan delays.
-- for reverse delays just close they. we can found them by transaction_oid
          for i_cash_in in (
            select * from blng.delay 
            where parent_id is not null
            and  transaction_oid = r_transaction.id
            and amnd_state = 'A'
          )
          loop
-- start remove_delay for each cash_in amount
            blng_api.delay_edit(P_id => i_cash_in.id, p_status => 'R');
-- when full amount of loan delay closed then status of delay updated to Closed.            
-- due to reverse of cash_in we have to open closed loan delays.
            r_delay := BLNG_API.delay_get_info_r(p_id => i_cash_in.parent_id);
            if r_delay.amnd_state = 'C' then
              blng_api.delay_edit(P_id => r_delay.id, p_status => 'A');
            end if;
          end loop;
        end if;
      exception when others then
        CLOSE c_transaction;  --process stop. so, we need to close cursor
        hdbk.log_api.LOG_ADD(p_proc_name=>'revoke_document.c_transaction', p_msg_type=>'UNHANDLED_ERROR',
          P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'r_transaction.id=' || r_transaction.id ||',p_document=' || p_document || ',p_date=' ||
          to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
        raise;
      end;
    END LOOP;
    CLOSE c_transaction;

-- check for wrong balance. if loan >0 o deposit <0 then push money to seautable place

    r_contract_info := blng.fwdr.v_account_get_info_r(p_contract => r_document.contract_oid);
    if r_contract_info.loan > 0 then
      r_account := blng.blng_api.account_get_info_r(p_contract => r_document.contract_oid, p_code => 'l'  );
      v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => p_document,P_AMOUNT => -r_contract_info.loan,
        P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'rvk'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
      r_account := blng.blng_api.account_get_info_r(p_contract => r_document.contract_oid, p_code => 'd'  );
      v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => p_document,P_AMOUNT => r_contract_info.loan,
        P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'rvk'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
    end if;

    if r_contract_info.deposit < 0 then
      r_account := blng.blng_api.account_get_info_r(p_contract => r_document.contract_oid, p_code => 'd'  );
      v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => p_document,P_AMOUNT => -r_contract_info.deposit,
        P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'rvk'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
      r_account := blng.blng_api.account_get_info_r(p_contract => r_document.contract_oid, p_code => 'l'  );
      v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => p_document,P_AMOUNT => r_contract_info.deposit,
        P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'rvk'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
    end if;

    if r_contract_info.deposit > 0 and r_contract_info.loan < 0 then
      if abs(r_contract_info.deposit) > abs(r_contract_info.loan) then
        r_account := blng.blng_api.account_get_info_r(p_contract => r_document.contract_oid, p_code => 'd'  );
        v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => p_document,P_AMOUNT => -abs(r_contract_info.loan),
          P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'rvk'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
        r_account := blng.blng_api.account_get_info_r(p_contract => r_document.contract_oid, p_code => 'l'  );
        v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => p_document,P_AMOUNT => abs(r_contract_info.loan),
          P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'rvk'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
      else
        r_account := blng.blng_api.account_get_info_r(p_contract => r_document.contract_oid, p_code => 'd'  );
        v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => p_document,P_AMOUNT => -abs(r_contract_info.deposit),
          P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'rvk'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
        r_account := blng.blng_api.account_get_info_r(p_contract => r_document.contract_oid, p_code => 'l'  );
        v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => p_document,P_AMOUNT => abs(r_contract_info.deposit),
          P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'rvk'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
      end if;        
    end if;
    blng.blng_api.document_edit(p_document, 'R');
    if  r_document.bill_oid is not null then 
      ord.ORD_API.bill_edit( P_id => r_document.bill_oid, P_STATUS => 'R');   -- transported to reversed
    end if;
    hdbk.log_api.LOG_ADD(p_proc_name=>'revoke_document.finish', p_msg_type=>'Successful',
      P_MSG => 'ok',p_info => 'p_transaction=' || v_transaction || ',p_date=' ||
      to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>0);
    commit;
  exception when others then
    rollback;
    hdbk.log_api.LOG_ADD(p_proc_name=>'revoke_document', p_msg_type=>'UNHANDLED_ERROR',
    P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_document=' || p_document || ',p_date=' ||
    to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    raise_application_error(-20003,'revoke_document error');
  end revoke_document;

  
  function pay_contract_by_client(p_client in hdbk.dtype.t_id)
  return hdbk.dtype.t_id
  is
    r_client2contract blng.client2contract%rowtype;
  begin
    r_client2contract:=blng.blng_api.client2contract_get_info_r(p_client=>p_client, p_permission=>'B');
    return r_client2contract.contract_oid;
  exception when others then
    hdbk.log_api.LOG_ADD(p_proc_name=>'pay_contract_by_client', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=client2contract,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into client2contract error. '||SQLERRM);
    return null;
  end;

end core;

/
