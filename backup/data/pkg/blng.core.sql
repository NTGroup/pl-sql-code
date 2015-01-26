--------------------------------------------------------
--  DDL for Package CORE
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "BLNG"."CORE" as

    g_delay_days CONSTANT     ntg.dtype.t_id := 30;

  -- TO DO: is it good to put id in choice


  /* TODO enter package declarations (types, exceptions, methods etc) here */


  procedure approve_documents;

  procedure buy (p_doc in blng.document%rowtype);

  procedure cash_in ( p_doc in blng.document%rowtype);


  procedure credit_online;


  procedure debit_online;

  procedure delay_remove(p_contract in ntg.dtype.t_id, p_amount in ntg.dtype.t_amount, p_transaction in ntg.dtype.t_id default null);

  procedure delay_expire;

  procedure contract_unblock(p_contract in ntg.dtype.t_id, p_days in ntg.dtype.t_id default 1);

  procedure revoke_document(p_document in ntg.dtype.t_id);

  function pay_contract_by_client(p_client in ntg.dtype.t_id)
  return ntg.dtype.t_id;
  
end core;

/

--------------------------------------------------------
--  DDL for Package Body CORE
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "BLNG"."CORE" as

  procedure approve_documents
  is
    mess ntg.dtype.t_msg;
    c_doc SYS_REFCURSOR;
    r_doc blng.document%rowtype;
    r_account blng.account%rowtype;
    v_item_avia_r ord.item_avia%rowtype;
    v_bill_r ord.bill%rowtype;
    v_transaction ntg.dtype.t_id;
    v_item_avia_status ntg.dtype.t_id;
    v_waiting_contract ntg.dtype.t_id;
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
          if v_waiting_contract is not null and v_waiting_contract = r_doc.contract_oid then raise ntg.dtype.doc_waiting; end if;
          blng.core.buy(r_doc);
        end if;
        if r_doc.TRANS_TYPE_OID in (blng_api.trans_type_get_id(p_code=>'ci')) then
          if v_waiting_contract is not null and v_waiting_contract = r_doc.contract_oid then raise ntg.dtype.doc_waiting; end if;
          blng.core.cash_in(r_doc);
        end if;
        if r_doc.TRANS_TYPE_OID in (blng_api.trans_type_get_id(p_code=>'cl')) then 
          if r_doc.amount < 0 then raise VALUE_ERROR; end if;
          r_account := blng.blng_api.account_get_info_r(p_contract => r_doc.contract_oid, p_code => 'cl'  );
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => r_doc.id,P_AMOUNT => abs(r_doc.amount)-abs(r_account.amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'cl'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
          --BLNG.BLNG_API.account_edit(P_id => r_account.id, P_AMOUNT => abs(r_doc.amount)-abs(r_account.amount), p_last_document => r_doc.id);
        end if;
        if r_doc.TRANS_TYPE_OID in (blng_api.trans_type_get_id(p_code=>'ult')) then 
          if r_doc.amount < 0 then raise VALUE_ERROR; end if;
          r_account := blng.blng_api.account_get_info_r(p_contract => r_doc.contract_oid, p_code => 'ult'  );
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => r_doc.id,P_AMOUNT => abs(r_doc.amount)-abs(r_account.amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ult'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
          --BLNG.BLNG_API.account_edit(P_id => r_account.id, P_AMOUNT => abs(r_doc.amount)-abs(r_account.amount), p_last_document => r_doc.id);
        end if;
        if r_doc.TRANS_TYPE_OID in (blng_api.trans_type_get_id(p_code=>'dd')) then
          if r_doc.amount < 0 then raise VALUE_ERROR; end if;
          r_account := blng.blng_api.account_get_info_r(p_contract => r_doc.contract_oid, p_code => 'dd'  );
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => r_doc.id,P_AMOUNT => abs(r_doc.amount)-abs(r_account.amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'dd'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
          --BLNG.BLNG_API.account_edit(P_id => r_account.id, P_AMOUNT => abs(r_doc.amount)-abs(r_account.amount), p_last_document => r_doc.id);
        end if;
        blng.blng_api.document_edit(r_doc.id, 'P');
        if r_doc.bill_oid is not null then 
          --edit bill
          ord.ORD_API.bill_edit( P_id => r_doc.bill_oid, P_STATUS => 'P'); -- transported to payed
          --edit PNR
          v_bill_r := ord.ord_api.bill_get_info_r(p_id=>r_doc.bill_oid);
          v_item_avia_r := ord.ord_api.item_avia_get_info_r(p_order => v_bill_r.order_oid);
--          ord.ORD_API.item_avia_edit (  P_ID => v_item_avia_r.id, p_po_status => 'SUCCESS',p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
          --begin
          r_item_avia_status := ord.ord_api.item_avia_status_get_info_r(p_item_avia => v_item_avia_r.id);
          if r_item_avia_status.id is null then
            NTG.LOG_API.LOG_ADD(p_proc_name=>'approve_document', p_msg_type=>'second try set status SUCCESS',
              P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => '&\item_avia='|| v_item_avia_r.id||'p_process=update&\p_table=item_avia_status&\p_date='
              || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
            v_item_avia_status := ord.ord_api.item_avia_status_add (  p_item_avia => v_item_avia_r.id, p_po_status => 'SUCCESS',
                                    p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
          else            
            NTG.LOG_API.LOG_ADD(p_proc_name=>'approve_document', p_msg_type=>'try set status SUCCESS',
              P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => '&\item_avia='|| v_item_avia_r.id||'p_process=update&\p_table=item_avia_status&\p_date='
              || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
            ord.ord_api.item_avia_status_edit (  p_item_avia => v_item_avia_r.id, p_po_status => 'SUCCESS',
                                    p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
          end if;
        end if;
        commit;
      exception
        when ntg.dtype.insufficient_funds then
          rollback;
          NTG.LOG_API.LOG_ADD(p_proc_name=>'approve_documents', p_msg_type=>'Warning', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20001)),p_info => '&\p_process=set&\p_status=D&\p_doc=' || r_doc.id || '&\p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>2);
          blng.blng_api.document_edit(r_doc.id, 'D');
          if r_doc.bill_oid is not null then 
            --edit bill
            ord.ORD_API.bill_edit( P_id => r_doc.bill_oid, P_STATUS => 'M'); -- transported to managed
            --edit PNR
            v_bill_r := ord.ord_api.bill_get_info_r(p_id=>r_doc.bill_oid);
            v_item_avia_r := ord.ord_api.item_avia_get_info_r(p_order => v_bill_r.order_oid);
--            ord.ORD_API.item_avia_edit (  P_ID => v_item_avia_r.id, p_po_status => 'ERROR',p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
            r_item_avia_status := ord.ord_api.item_avia_status_get_info_r(p_item_avia => v_item_avia_r.id);
            if r_item_avia_status.id is null then
              NTG.LOG_API.LOG_ADD(p_proc_name=>'approve_document', p_msg_type=>'second try set status ERROR',
                P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => '&\item_avia='|| v_item_avia_r.id||'p_process=update&\p_table=item_avia_status&\p_date='
                || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
              v_item_avia_status := ord.ord_api.item_avia_status_add (  p_item_avia => v_item_avia_r.id, p_po_status => 'ERROR',
                                      p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
            else            
              NTG.LOG_API.LOG_ADD(p_proc_name=>'approve_document', p_msg_type=>'try set status ERROR',
                P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => '&\item_avia='|| v_item_avia_r.id||'p_process=update&\p_table=item_avia_status&\p_date='
                || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
              ord.ord_api.item_avia_status_edit (  p_item_avia => v_item_avia_r.id, p_po_status => 'ERROR',
                                      p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
            end if;
          end if;
          commit;
        when ntg.dtype.doc_waiting then
          rollback;
          v_waiting_contract := r_doc.contract_oid;
          NTG.LOG_API.LOG_ADD(p_proc_name=>'approve_documents', p_msg_type=>'Warning', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20000)),p_info => 'p_doc=' || r_doc.id || '&\p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
--          commit;
        when VALUE_ERROR then
          rollback;
          NTG.LOG_API.LOG_ADD(p_proc_name=>'approve_documents', p_msg_type=>'Error', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20000)),p_info => 'p_doc=' || r_doc.id || '&\p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
          blng.blng_api.document_edit(r_doc.id, 'E');
          if r_doc.bill_oid is not null then 
            --edit bill
            ord.ORD_API.bill_edit( P_id => r_doc.bill_oid, P_STATUS => 'M'); -- transported to managed
            --edit PNR
            v_bill_r := ord.ord_api.bill_get_info_r(p_id=>r_doc.bill_oid);
            v_item_avia_r := ord.ord_api.item_avia_get_info_r(p_order => v_bill_r.order_oid);
--            ord.ORD_API.item_avia_edit (  P_ID => v_item_avia_r.id, p_po_status => 'ERROR',p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
            r_item_avia_status := ord.ord_api.item_avia_status_get_info_r(p_item_avia => v_item_avia_r.id);
            if r_item_avia_status.id is null then
              NTG.LOG_API.LOG_ADD(p_proc_name=>'approve_document', p_msg_type=>'second try set status ERROR',
                P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => '&\item_avia='|| v_item_avia_r.id||'p_process=update&\p_table=item_avia_status&\p_date='
                || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
              v_item_avia_status := ord.ord_api.item_avia_status_add (  p_item_avia => v_item_avia_r.id, p_po_status => 'ERROR',
                                      p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
            else            
              NTG.LOG_API.LOG_ADD(p_proc_name=>'approve_document', p_msg_type=>'try set status ERROR',
                P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => '&\item_avia='|| v_item_avia_r.id||'p_process=update&\p_table=item_avia_status&\p_date='
                || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
              ord.ord_api.item_avia_status_edit (  p_item_avia => v_item_avia_r.id, p_po_status => 'ERROR',
                                      p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
            end if;
          end if;
          commit;
          raise_application_error(-20003,'Wrong account amount value');--outside error
        when others then
          rollback;
          NTG.LOG_API.LOG_ADD(p_proc_name=>'approve_documents.c_doc', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || r_doc.id || '&\p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
          blng.blng_api.document_edit(r_doc.id, 'E');
          if r_doc.bill_oid is not null then 
            --edit bill
            ord.ORD_API.bill_edit( P_id => r_doc.bill_oid, P_STATUS => 'M'); -- transported to managed
            --edit PNR
            v_bill_r := ord.ord_api.bill_get_info_r(p_id=>r_doc.bill_oid);
            v_item_avia_r := ord.ord_api.item_avia_get_info_r(p_order => v_bill_r.order_oid);
--            ord.ORD_API.item_avia_edit (  P_ID => v_item_avia_r.id, p_po_status => 'ERROR',p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
            r_item_avia_status := ord.ord_api.item_avia_status_get_info_r(p_item_avia => v_item_avia_r.id);
            if r_item_avia_status.id is null then
              NTG.LOG_API.LOG_ADD(p_proc_name=>'approve_document', p_msg_type=>'second try set status ERROR',
                P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => '&\item_avia='|| v_item_avia_r.id||'p_process=update&\p_table=item_avia_status&\p_date='
                || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
              v_item_avia_status := ord.ord_api.item_avia_status_add (  p_item_avia => v_item_avia_r.id, p_po_status => 'ERROR',
                                      p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
            else            
              NTG.LOG_API.LOG_ADD(p_proc_name=>'approve_document', p_msg_type=>'try set status ERROR',
                P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => '&\item_avia='|| v_item_avia_r.id||'p_process=update&\p_table=item_avia_status&\p_date='
                || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
              ord.ord_api.item_avia_status_edit (  p_item_avia => v_item_avia_r.id, p_po_status => 'ERROR',
                                      p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
            end if;
          commit;
          end if;
      end;
    END LOOP;
    CLOSE c_doc;

  exception
    when others then
      rollback;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'approve_documents', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || r_doc.id || '&\p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      blng.blng_api.document_edit(r_doc.id, 'E'); --commited inside. its wrong.
      if r_doc.bill_oid is not null then 
        --edit bill
        ord.ORD_API.bill_edit( P_id => r_doc.bill_oid, P_STATUS => 'M'); -- transported to managed
        --edit PNR
        v_bill_r := ord.ord_api.bill_get_info_r(p_id=>r_doc.bill_oid);
        v_item_avia_r := ord.ord_api.item_avia_get_info_r(p_order => v_bill_r.order_oid);
--        ord.ORD_API.item_avia_edit (  P_ID => v_item_avia_r.id, p_po_status => 'ERROR',p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
        r_item_avia_status := ord.ord_api.item_avia_status_get_info_r(p_item_avia => v_item_avia_r.id);
        if r_item_avia_status.id is null then
          NTG.LOG_API.LOG_ADD(p_proc_name=>'approve_document', p_msg_type=>'second try set status ERROR',
            P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => '&\item_avia='|| v_item_avia_r.id||'p_process=update&\p_table=item_avia_status&\p_date='
            || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
          v_item_avia_status := ord.ord_api.item_avia_status_add (  p_item_avia => v_item_avia_r.id, p_po_status => 'ERROR',
                                  p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
        else            
          NTG.LOG_API.LOG_ADD(p_proc_name=>'approve_document', p_msg_type=>'try set status ERROR',
            P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => '&\item_avia='|| v_item_avia_r.id||'p_process=update&\p_table=item_avia_status&\p_date='
            || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
          ord.ord_api.item_avia_status_edit (  p_item_avia => v_item_avia_r.id, p_po_status => 'ERROR',
                                  p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
        end if;
      end if;
--      commit;
  end;


  procedure buy ( p_doc in blng.document%rowtype
                )
  is
    v_transaction ntg.dtype.t_id;
    r_account blng.account%rowtype;
    r_contract_info blng.v_account%rowtype;
    v_msg ntg.dtype.t_msg;

  begin

    r_contract_info := blng.info.contract_info_r(p_contract => p_doc.contract_oid);

    if r_contract_info.debit_online<>0 or r_contract_info.credit_online<>0 then
      raise_application_error(-20000,'last trunsaction not approved. wait.');
      --raise ntg.dtype.doc_waiting;
    end if;

    if r_contract_info.available <= 0
    or abs(r_contract_info.available) < abs(p_doc.amount)
    then
      raise_application_error(-20001,'insufficient funds');
--      raise ntg.dtype.insufficient_funds;
      --- TO DO: raise set doc status D.
      -- update doc cline
    end if;
    if r_contract_info.max_loan_trans_amount<>0
    and abs(r_contract_info.deposit) < abs(p_doc.amount)
    and r_contract_info.max_loan_trans_amount < abs(abs(r_contract_info.deposit)-abs(p_doc.amount))  then
      --raise ntg.dtype.max_loan_transaction_block;
      raise_application_error(-20001,'loan transaction amount > max_loan_trans_amount');
    end if;

    r_account := blng.blng_api.account_get_info_r(p_contract => p_doc.contract_oid,
            p_code => 'do'  );

  -- + transaction
    v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => P_DOC.id,P_AMOUNT => -abs(p_doc.AMOUNT),
      P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'b'), P_TRANS_DATE => p_doc.doc_date, P_TARGET_ACCOUNT => r_account.id, p_status => 'W');
  -- + account
      --BLNG.BLNG_API.account_edit(P_ID => r_account.id, P_AMOUNT => -abs(p_doc.AMOUNT), p_last_document => p_doc.id);
--    commit;
  exception
    when ntg.dtype.insufficient_funds then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'buy', p_msg_type=>'Warning', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20001)),p_info => 'p_doc=' || p_doc.id || '&\p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>2);
      raise;
    when ntg.dtype.doc_waiting then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'buy', p_msg_type=>'Warning', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20000)),p_info => 'p_doc=' || p_doc.id || '&\p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
      raise;
    when others then
--      rollback;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'buy', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || p_doc.id || '&\p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      raise;
  end buy;

  procedure cash_in (p_doc in blng.document%rowtype)
  is
    v_transaction ntg.dtype.t_id;
    r_account blng.account%rowtype;
    r_contract_info blng.v_account%rowtype;
    v_msg ntg.dtype.t_msg;
  begin

    r_contract_info := blng.info.contract_info_r(p_contract => p_doc.contract_oid);

    if r_contract_info.debit_online<>0 or r_contract_info.credit_online<>0 then

      raise_application_error(-20000,'last trunsaction not approved. wait.');
      --raise ntg.dtype.doc_waiting;
    end if;

    DBMS_OUTPUT.PUT_LINE('doc = '|| p_doc.id);

    r_account := blng.blng_api.account_get_info_r(p_contract => p_doc.contract_oid,
            p_code => 'co'  );
  -- + transaction
    v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => P_DOC.id,P_AMOUNT => abs(p_doc.AMOUNT),
      P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ci'), P_TRANS_DATE => p_doc.doc_date, P_TARGET_ACCOUNT => r_account.id, p_status => 'W');
  -- + account
            DBMS_OUTPUT.PUT_LINE('r_account.id = '|| r_account.id);
     -- BLNG.BLNG_API.account_edit(P_ID => r_account.id, P_AMOUNT => abs(p_doc.AMOUNT), p_last_document => p_doc.id);

--    commit;
  exception
    when ntg.dtype.doc_waiting then
      NTG.LOG_API.LOG_ADD(p_proc_name=>'cash_in', p_msg_type=>'Warning', P_MSG => to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20000)),p_info => 'p_doc=' || p_doc.id || '&\p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
      raise;
    when others then
--      rollback;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'cash_in', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || p_doc.id || '&\p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      raise;
  end cash_in;


  procedure credit_online
  is
    v_transaction ntg.dtype.t_id;
    v_transaction_2delay ntg.dtype.t_id;
    v_doc ntg.dtype.t_id;
    c_transaction SYS_REFCURSOR;
    r_credit_online blng.account%rowtype;
    r_transaction blng.transaction%rowtype;
    r_deposit blng.account%rowtype;
    r_loan blng.account%rowtype;
    v_msg ntg.dtype.t_msg;
    v_amount ntg.dtype.t_amount;
    v_settlement_amount ntg.dtype.t_amount;
  begin
  -- get all cash_in transaction with status Waiting
    c_transaction := blng.blng_api.transaction_get_info(p_trans_type => blng_api.trans_type_get_id(p_code=>'ci'),p_status => 'W');

    --DBMS_OUTPUT.put_line (1);
    LOOP
      FETCH c_transaction INTO r_transaction;
      EXIT WHEN c_transaction%NOTFOUND;

      begin
      r_credit_online:=blng_api.account_get_info_r(p_id =>r_transaction.target_account_oid);
      v_amount:=r_transaction.amount;
      v_doc := r_transaction.doc_oid;

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

        blng.core.delay_remove(r_credit_online.contract_oid, r_credit_online.amount, p_transaction => r_transaction.id);
        blng_api.transaction_edit(p_id => r_transaction.id, p_status => 'P');
        commit;

      exception when others then
        rollback;
        NTG.LOG_API.LOG_ADD(p_proc_name=>'credit_online.c_credit_online', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_account=' || r_credit_online.id || '&\p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
--        commit;
      end;
    END LOOP;
    CLOSE c_transaction;

--    commit;
  exception when others then
    rollback;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'credit_online', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_account=' || r_credit_online.id || '&\p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
--    commit;
  end credit_online;

  procedure debit_online
  is
    v_transaction ntg.dtype.t_id;
    v_transaction_2delay ntg.dtype.t_id;
    v_doc ntg.dtype.t_id;
    c_transaction SYS_REFCURSOR;
    r_transaction blng.transaction%rowtype;
    r_debit_online blng.account%rowtype;
    r_deposit blng.account%rowtype;
    r_loan blng.account%rowtype;
    v_msg ntg.dtype.t_msg;
    v_amount ntg.dtype.t_amount;
    v_settlement_amount ntg.dtype.t_amount;
    v_delay_amount  ntg.dtype.t_amount;

    r_contract_info blng.v_account%rowtype;
  begin
  -- get all not empty credit_online accounts
    c_transaction := blng.blng_api.transaction_get_info(p_trans_type => blng_api.trans_type_get_id(p_code=>'b'),p_status => 'W');

    --DBMS_OUTPUT.put_line (1);
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

        elsif abs(v_amount) <= abs(r_deposit.amount) then
        --deposit
        --deposit
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => -abs(v_amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'da'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_deposit.id);
        --debit_online
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => v_doc,P_AMOUNT => abs(v_amount),
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'ca'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_debit_online.id);

          v_delay_amount:= 0;

        end if;

        if v_delay_amount != 0 then
          r_contract_info := blng.info.contract_info_r(p_contract => r_debit_online.contract_oid);
          if r_contract_info.delay_days = 0 or r_contract_info.delay_days is null then r_contract_info.delay_days:= g_delay_days; end if;
          BLNG_API.delay_add( P_CONTRACT => r_debit_online.contract_oid,
                              p_date_to => trunc(sysdate)+r_contract_info.delay_days,
                              P_AMOUNT => abs(v_delay_amount),
                              P_EVENT_TYPE => blng_api.event_type_get_id(p_code=>'b'),
                              P_PRIORITY => 10,
                              p_transaction => r_transaction.id
                            );
        end if;
        blng_api.transaction_edit(p_id => r_transaction.id, p_status => 'P');
        commit; --after each account
      exception when others then
        rollback;
        NTG.LOG_API.LOG_ADD(p_proc_name=>'debit_online.c_debit_online', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_account=' || r_debit_online.id || '&\p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    --    commit;
      end;
    END LOOP;
    CLOSE c_transaction;

 --   commit;
  exception when others then
    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'debit_online.c_debit_online', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_account=' || r_debit_online.id || '&\p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    --commit;
  end debit_online;


  procedure delay_remove(p_contract in ntg.dtype.t_id, p_amount in ntg.dtype.t_amount, p_transaction in ntg.dtype.t_id default null)
  is
    v_amount  ntg.dtype.t_amount;
    v_next_delay_date  blng.delay.date_to%type;
    --r_contract_info blng.v_account%rowtype;
    c_delay SYS_REFCURSOR;
    r_delay blng.delay%rowtype;
    r_account blng.account%rowtype;
    v_transaction ntg.dtype.t_id;
    v_delay_id  ntg.dtype.t_id;
    --v_amount  in ntg.dtype.t_amount;
  begin
        DBMS_OUTPUT.PUT_LINE('start = ' );
    v_amount := p_amount;
    -- get cursor with event_type credit limit block order by date asc
--    c_delay := BLNG_API.delay_get_info(P_CONTRACT => P_CONTRACT,P_EVENT_TYPE => blng_api.event_type_get_id(p_code=>'clb'));

    --r_contract_info := info.contract_info(p_contract => p_contract);
    for i_delay in (
                    select
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
                    order by contract_oid asc, date_to asc, id asc
    )
    LOOP
--      FETCH c_delay INTO r_delay;
--      EXIT WHEN c_delay%NOTFOUND;
      begin
        v_delay_id := i_delay.id;
        v_next_delay_date:= i_delay.date_to;
        if v_amount = 0 then exit; end if;
        if v_amount < abs(i_delay.amount_need) then
          BLNG_API.delay_add( P_CONTRACT => p_contract,
                              p_date_to => null,
                              P_AMOUNT => abs(v_amount),
                              P_EVENT_TYPE => blng_api.event_type_get_id(p_code=>'ci'),
--                              P_PRIORITY => 10,
                              p_transaction => p_transaction,
                              p_parent_id => i_delay.id
                            );        
          --BLNG_API.delay_edit(p_id => i_delay.id,p_amount => abs(v_amount), p_transaction => p_transaction);
          exit;
        else
          BLNG_API.delay_add( P_CONTRACT => p_contract,
                              p_date_to => null,
                              P_AMOUNT => abs(i_delay.amount_need),
                              P_EVENT_TYPE => blng_api.event_type_get_id(p_code=>'ci'),
--                              P_PRIORITY => 10,
                              p_transaction => p_transaction,
                              p_parent_id => i_delay.id
                            );        

          BLNG_API.delay_edit(p_id => i_delay.id, p_status => 'C');
          v_amount := v_amount - abs(i_delay.amount_need);
        end if;
--        commit;
      exception when others then
--        CLOSE c_delay;  --process stop. so, we need to close cursor
--        rollback;
        NTG.LOG_API.LOG_ADD(p_proc_name=>'delay_remove.c_delay', p_msg_type=>'UNHANDLED_ERROR',
          P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_delay=' || r_delay.id || '&\p_date=' ||
          to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
--        commit;
        raise;
      end;
    END LOOP;
--    CLOSE c_delay;
    -- unblock
    if v_next_delay_date > sysdate then
      r_account := blng.blng_api.account_get_info_r(p_contract => p_contract, p_code => 'clb');
      if r_account.amount <> 0 then
     --   BLNG_API.account_edit(P_ID => r_account.id,P_AMOUNT => -r_account.amount,P_LAST_DOCUMENT =>  null);
        v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_AMOUNT => -r_account.amount,
          P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'clu'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
      end if;
    end if;
--    commit;
      DBMS_OUTPUT.PUT_LINE ('exit.');
  exception when others then
--    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'delay_remove', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_delay=' || v_delay_id || '&\p_date=' ||
      to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    raise;
--    commit;
  end delay_remove;

  procedure delay_expire
  is
    v_amount  ntg.dtype.t_amount;
    v_next_delay_date  blng.delay.date_to%type;
    --r_contract_info blng.v_account%rowtype;
    c_delay SYS_REFCURSOR;
    --r_delay blng.delay%rowtype;
    r_account blng.account%rowtype;
    v_transaction ntg.dtype.t_id;
    log_contract ntg.dtype.t_id;
    log_proc ntg.dtype.t_code;
    r_contract_info blng.v_account%rowtype;
    --v_amount  in ntg.dtype.t_amount;
  begin
--delete expired unblock

    log_proc:='UNBLOCK';
    for r_delay in (
    --TODO delay select problem blng.blng_api.delay_get_info
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
        NTG.LOG_API.LOG_ADD(p_proc_name=>'delay_expire.unblock', p_msg_type=>'UNHANDLED_ERROR',
          P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_proc=' || log_proc || '&\p_contract=' || log_contract || '&\p_date=' ||
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
        r_contract_info := blng.info.contract_info_r(p_contract => r_delay.contract_oid);
        if r_account.amount = 0 then
        --  BLNG_API.account_edit(P_ID => r_account.id,P_AMOUNT => -r_contract_info.credit_limit);
          v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_AMOUNT => -r_contract_info.credit_limit,
            P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'clb'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
        end if;
        commit;
      exception when others then
        rollback;
        NTG.LOG_API.LOG_ADD(p_proc_name=>'delay_expire.block', p_msg_type=>'UNHANDLED_ERROR',
          P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_proc=' || log_proc || '&\p_contract=' || log_contract || '&\p_date=' ||
          to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      end;

    end loop;

    --commit;

  exception 
    when NO_DATA_FOUND then
      rollback;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'delay_expire', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_proc=' || log_proc || '&\p_contract=' || log_contract || '&\p_date=' ||
        to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    when others then
      rollback;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'delay_expire', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_proc=' || log_proc || '&\p_contract=' || log_contract || '&\p_date=' ||
        to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
  end delay_expire;


  procedure contract_unblock(p_contract in ntg.dtype.t_id, p_days in ntg.dtype.t_id default 1)
  is
    r_account blng.account%rowtype;
    v_transaction ntg.dtype.t_id;
  begin
      DBMS_OUTPUT.PUT_LINE ('start');
    r_account := blng.blng_api.account_get_info_r(p_contract => p_contract, p_code => 'clb');

    if r_account.amount <> 0 then
        DBMS_OUTPUT.PUT_LINE ('r_account.amount <> 0');
        DBMS_OUTPUT.PUT_LINE ('r_account.ID='||r_account.ID);

  --    BLNG_API.account_edit(P_ID => r_account.id,P_AMOUNT => -r_account.amount,P_LAST_DOCUMENT =>  null);
      v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_AMOUNT => -r_account.amount,
        P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'clu'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
      BLNG_API.delay_add(P_CONTRACT => p_contract, P_EVENT_TYPE => blng_api.event_type_get_id(p_code=>'clu'),P_PRIORITY => 20,
        p_transaction=>v_transaction,p_date_to => trunc(sysdate)+p_days);

    end if;

    commit;
  exception 
    when NO_DATA_FOUND then
      rollback;
      raise_application_error(-20003,'contract_unblock error. call wrong contract id');
    when others then
      rollback;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'contract_unblock', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_contract=' || p_contract || '&\p_date=' ||
      to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      raise_application_error(-20003,'contract_unblock error');
  end contract_unblock;


  procedure revoke_document(p_document in ntg.dtype.t_id)
  is
    c_transaction SYS_REFCURSOR;
    r_transaction blng.transaction%rowtype;
    r_document blng.document%rowtype;
    v_transaction ntg.dtype.t_id;
    v_buy ntg.dtype.t_id;
    v_cash_in ntg.dtype.t_id;

    v_amount  ntg.dtype.t_amount;
    v_next_delay_date  blng.delay.date_to%type;
    --r_contract_info blng.v_account%rowtype;
    c_delay SYS_REFCURSOR;
    r_delay blng.delay%rowtype;
    r_account blng.account%rowtype;
--    v_transaction ntg.dtype.t_id;
    r_contract_info blng.v_account%rowtype;
    v_prev_amount ntg.dtype.t_amount;
    v_first_amount ntg.dtype.t_amount;
    v_last_amount ntg.dtype.t_amount;
  begin
--    DBMS_OUTPUT.PUT_LINE ('start');
    r_document:=BLNG_API.document_get_info_r(p_id => P_document);
--        DBMS_OUTPUT.PUT_LINE (r_document.id);
    v_buy:=blng_api.trans_type_get_id(p_code=>'b');
    v_cash_in:=blng_api.trans_type_get_id(p_code=>'ci');
    if r_document.trans_type_oid not in (v_buy,v_cash_in) then raise_application_error(-20005,'document can not be revoked'); end if;

    c_transaction := BLNG_API.transaction_get_info(P_doc => P_document);

    LOOP
      FETCH c_transaction INTO r_transaction;
      EXIT WHEN c_transaction%NOTFOUND;
      begin
--        DBMS_OUTPUT.PUT_LINE ('r_transaction.ID='||r_transaction.ID);

        --add transaction with amount = -(amount of parent transaction)
        v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => r_transaction.doc_oid,P_AMOUNT => -r_transaction.amount,
          P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'rvk'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_transaction.target_account_oid,
          p_prev=>r_transaction.amnd_prev,p_status=>'R');

        --remove delays
        if r_transaction.trans_type_oid = v_buy then --buy
--        DBMS_OUTPUT.PUT_LINE ('r_transaction.buy='||r_transaction.ID);
--delay will be one so just find this row, update status and move cash_in's
          r_delay := BLNG_API.delay_get_info_r(P_transaction => r_transaction.id);
          if r_delay.id is not null then 
            BLNG_API.delay_edit(P_id => r_delay.id, p_status => 'R');
            for i_cash_in in (
              select * from blng.delay 
              where parent_id = r_delay.id
              and amnd_state = 'A'
            )
            loop
              --start remove_delay for each cash_in amount
              --v_prev_amount:=i_delay.AMOUNT;
              CORE.delay_remove (  P_CONTRACT => r_delay.contract_oid,
                P_AMOUNT => i_cash_in.amount,P_TRANSACTION => i_cash_in.transaction_oid);
              blng_api.delay_edit(P_id => i_cash_in.id, p_status => 'I');
            end loop;        
          end if;      
        elsif r_transaction.trans_type_oid = v_cash_in then --cash_in
--    DBMS_OUTPUT.PUT_LINE ('cash_in');
        
--          r_delay := BLNG_API.delay_get_info_r(P_transaction => r_transaction.id);
--          BLNG_API.delay_edit(P_id => r_delay.id, p_status => 'R');
          for i_cash_in in (
            select * from blng.delay 
            where parent_id is not null
            and  transaction_oid = r_transaction.id
            and amnd_state = 'A'
          )
          loop
            --start remove_delay for each cash_in amount
            blng_api.delay_edit(P_id => i_cash_in.id, p_status => 'R');
            --if buy closed then open it
            r_delay := BLNG_API.delay_get_info_r(p_id => i_cash_in.parent_id);
            if r_delay.amnd_state = 'C' then
              blng_api.delay_edit(P_id => r_delay.id, p_status => 'A');
            end if;
          end loop;
        end if;
--        commit;
      exception when others then
        CLOSE c_transaction;  --process stop. so, we need to close cursor
--        rollback;
        NTG.LOG_API.LOG_ADD(p_proc_name=>'revoke_document.c_transaction', p_msg_type=>'UNHANDLED_ERROR',
          P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_delay=' || r_transaction.id || '&\p_date=' ||
          to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
--        commit;
        raise;
      end;
    END LOOP;
    CLOSE c_transaction;
--    DBMS_OUTPUT.PUT_LINE ('delay');

    --check for wrong balance
    r_contract_info := blng.info.contract_info_r(p_contract => r_document.contract_oid);
--    DBMS_OUTPUT.PUT_LINE ('delay1');
-- TODO ACCOUNT_AMOUNT flow
    if r_contract_info.loan > 0 then
      r_account := blng.blng_api.account_get_info_r(p_contract => r_document.contract_oid, p_code => 'l'  );
      v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => p_document,P_AMOUNT => -r_contract_info.loan,
        P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'rvk'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
      r_account := blng.blng_api.account_get_info_r(p_contract => r_document.contract_oid, p_code => 'd'  );
      v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => p_document,P_AMOUNT => r_contract_info.loan,
        P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'rvk'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
    end if;
--    DBMS_OUTPUT.PUT_LINE ('delay2');

    if r_contract_info.deposit < 0 then
      r_account := blng.blng_api.account_get_info_r(p_contract => r_document.contract_oid, p_code => 'd'  );
      v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => p_document,P_AMOUNT => -r_contract_info.deposit,
        P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'rvk'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
      r_account := blng.blng_api.account_get_info_r(p_contract => r_document.contract_oid, p_code => 'l'  );
      v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => p_document,P_AMOUNT => r_contract_info.deposit,
        P_TRANS_TYPE => blng_api.trans_type_get_id(p_code=>'rvk'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
    end if;
--    DBMS_OUTPUT.PUT_LINE ('delay3');

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
--    DBMS_OUTPUT.PUT_LINE ('delay4');

    blng.blng_api.document_edit(p_document, 'R');
--    DBMS_OUTPUT.PUT_LINE ('delay5');
    if  r_document.bill_oid is not null then 
      ord.ORD_API.bill_edit( P_id => r_document.bill_oid, P_STATUS => 'R');   -- transported to reversed
    end if;
--    DBMS_OUTPUT.PUT_LINE ('delay6');

    NTG.LOG_API.LOG_ADD(p_proc_name=>'revoke_document.finish', p_msg_type=>'Successful',
      P_MSG => 'ok',p_info => 'p_transaction=' || v_transaction || '&\p_date=' ||
      to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>0);

    commit;
  exception when others then
    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'revoke_document', p_msg_type=>'UNHANDLED_ERROR',
    P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_contract=' || p_document || '&\p_date=' ||
    to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    raise_application_error(-20003,'revoke_document error');
  end revoke_document;

  function pay_contract_by_client(p_client in ntg.dtype.t_id)
  return ntg.dtype.t_id
  is
    v_contract ntg.dtype.t_id;
  begin
    select max(contract_oid) into v_contract from blng.client2contract 
    where client_oid = p_client 
    --and permission = 'I'
    and amnd_state = 'A';
    
    return v_contract;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'pay_contract_by_client', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=client2contract&\p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into client2contract error. '||SQLERRM);
    return null;
  end;

end core;

/
