  CREATE OR REPLACE PACKAGE ORD.CORE AS 


/*

pkg: ORD.CORE

*/

/*

$obj_type: procedure
$obj_name: bill_pay
$obj_desc: procedure perform transit bills with status [W]aiting to billing system. 
$obj_desc: that means bill requested for pay. after that bill marked as [T]ransported
$obj_desc: this procedure executed from job scheduler
*/

  procedure buy;
  
/*
$obj_type: procedure
$obj_name: doc_task_list
$obj_desc: procedure perform document tasks like pay for bills, set cledit limit and others money tasks. 
$obj_desc: main idea of function is to separate BUY process from others.
$obj_desc: this procedure executed from job scheduler
*/ 
  procedure doc_task_list;


END CORE;

/

--------------------------------------------------------
--  DDL for Package Body CORE
--------------------------------------------------------

  CREATE OR REPLACE  PACKAGE BODY ORD.CORE AS

  procedure buy
  is
--    v_ord_row ord%rowtype;
    v_id hdbk.dtype.t_id;
    v_order hdbk.dtype.t_id;
    v_avia hdbk.dtype.t_id;
    r_item_avia item_avia%rowtype;
    r_item_avia_status item_avia_status%rowtype;
    r_order ord%rowtype;
    v_bill hdbk.dtype.t_id;
    v_contract hdbk.dtype.t_id;
    r_document blng.document%rowtype;
    
    c_bill  SYS_REFCURSOR;
    r_bill bill%rowtype;

    v_DOC hdbk.dtype.t_id;
    
  begin
    --begin
      c_bill := ord_api.bill_get_info(p_status=>'W', p_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>'BUY'));
    --exception when NO_DATA_FOUND then return;
    --end;
    
    LOOP
      FETCH c_bill INTO r_bill;
      EXIT WHEN c_bill%NOTFOUND;
        begin
          hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'start',
            P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',item_avia='|| r_item_avia.id||'p_process=update,p_table=item_avia_status,p_date='
            || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
  
          v_DOC := blng.BLNG_API.document_add(P_CONTRACT => r_bill.contract_oid,
                                              P_AMOUNT => r_bill.amount,
                                              P_TRANS_TYPE => blng.blng_api.trans_type_get_id(p_code=>'b'),
                                              p_bill => r_bill.id);
--          hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'start',P_MSG => '1',P_ALERT_LEVEL=>10);          
  
  
          r_document:=blng.BLNG_API.document_get_info_r(p_id => v_DOC);
--          hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'start',P_MSG => '2',P_ALERT_LEVEL=>10);          
          blng.core.buy(r_document);
          blng.core.debit_online(r_document.id);
--          hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'start',P_MSG => '3',P_ALERT_LEVEL=>10);          
  
          blng.blng_api.document_edit(r_document.id, 'P');
--          hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'start',P_MSG => '4',P_ALERT_LEVEL=>10);          
  
          ORD_API.bill_edit( P_id => r_bill.id, P_STATUS => 'P');   --[P]osted
--          hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'start',P_MSG => '5',P_ALERT_LEVEL=>10);          
  
          -- edit PNR
          r_item_avia := ord_api.item_avia_get_info_r(p_order => r_bill.order_oid);
--          hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'start',P_MSG => '6',P_ALERT_LEVEL=>10);          
          r_item_avia_status := ord_api.item_avia_status_get_info_r(p_item_avia => r_item_avia.id);
          hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'try set status SUCCESS',
            P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',item_avia='|| r_item_avia.id||'p_process=update,p_table=item_avia_status,p_date='
            || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
          ord_api.item_avia_status_edit (  p_item_avia => r_item_avia.id, p_po_status => 'SUCCESS',
                                  p_nqt_status_cur => r_item_avia.nqt_status) ;  
          hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'finish',
            P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',item_avia='|| r_item_avia.id||'p_process=update,p_table=item_avia_status,p_date='
            || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
          commit;             
      exception
        when hdbk.dtype.dead_lock then
          rollback;
          hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'DEAD_LOCK', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || r_document.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
        when hdbk.dtype.insufficient_funds then
          rollback;
          hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'Warning', P_MSG => 'insufficient_funds '||to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20001)),p_info => ',p_process=set,p_status=D,p_doc=' || r_document.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>2);
          r_item_avia := ord_api.item_avia_get_info_r(p_order => r_bill.order_oid);
          r_item_avia_status := ord_api.item_avia_status_get_info_r(p_item_avia => r_item_avia.id);
          hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'ERROR',
            P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',item_avia='|| r_item_avia.id||'p_process=update,p_table=item_avia_status,p_date='
            || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
          ord_api.item_avia_status_edit (  p_item_avia => r_item_avia.id, p_po_status => 'ERROR',
                                  p_nqt_status_cur => r_item_avia.nqt_status) ;  
          ORD_API.bill_edit( P_id => r_bill.id, P_STATUS => 'M');   --[M]anaged
          commit;
        when hdbk.dtype.doc_waiting then
          rollback;
--???          v_waiting_contract := r_document.contract_oid;
          hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'Warning', P_MSG => 'doc_waiting ' || to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20000)),p_info => 'p_doc=' || r_document.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
          ORD_API.bill_edit( P_id => r_bill.id, P_STATUS => 'M');   --[M]anaged
          commit;
        when VALUE_ERROR then
          rollback;
          hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'Warning', P_MSG => 'VALUE_ERROR ' || to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20001)),p_info => ',p_process=set,p_status=D,p_doc=' || r_document.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>2);
          r_item_avia := ord_api.item_avia_get_info_r(p_order => r_bill.order_oid);
          r_item_avia_status := ord_api.item_avia_status_get_info_r(p_item_avia => r_item_avia.id);
          hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'ERROR',
            P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',item_avia='|| r_item_avia.id||'p_process=update,p_table=item_avia_status,p_date='
            || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
          ord_api.item_avia_status_edit (  p_item_avia => r_item_avia.id, p_po_status => 'ERROR',
                                  p_nqt_status_cur => r_item_avia.nqt_status) ;  
          ORD_API.bill_edit( P_id => r_bill.id, P_STATUS => 'M');   --[M]anaged
          commit;
        when others then
          rollback;
          hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'Warning', P_MSG =>  'others ' || to_char(SQLCODE) || ' '|| TO_CHAR(SQLERRM(-20001)),p_info => ',p_process=set,p_status=D,p_doc=' || r_document.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>2);
          r_item_avia := ord_api.item_avia_get_info_r(p_order => r_bill.order_oid);
          r_item_avia_status := ord_api.item_avia_status_get_info_r(p_item_avia => r_item_avia.id);
          hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'ERROR',
            P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',item_avia='|| r_item_avia.id||'p_process=update,p_table=item_avia_status,p_date='
            || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
          ord_api.item_avia_status_edit (  p_item_avia => r_item_avia.id, p_po_status => 'ERROR',
                                  p_nqt_status_cur => r_item_avia.nqt_status) ; 
          ORD_API.bill_edit( P_id => r_bill.id, P_STATUS => 'M');   --[M]anaged                                  
          commit;
      end;

    END LOOP;
    CLOSE c_bill;    

    

  exception 
    when NO_DATA_FOUND then null;
    when others then
      rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=bill,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      --RAISE_APPLICATION_ERROR(-20002,'doc_task_list error. '||SQLERRM);
  end;



  procedure doc_task_list
  is
--    v_ord_row ord%rowtype;
    v_id hdbk.dtype.t_id;
    v_order hdbk.dtype.t_id;
    v_avia hdbk.dtype.t_id;
    r_item_avia item_avia%rowtype;
    r_item_avia_status item_avia_status%rowtype;
    r_order ord%rowtype;
    v_bill hdbk.dtype.t_id;
    v_contract hdbk.dtype.t_id;
    v_transaction hdbk.dtype.t_id;
    r_document blng.document%rowtype;
    r_account blng.account%rowtype;
    r_transaction blng.transaction%rowtype;
    
    c_bill  SYS_REFCURSOR;
    c_doc  SYS_REFCURSOR;
    r_bill bill%rowtype;

    v_DOC hdbk.dtype.t_id;
    
  begin
/*    hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'RUN',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',item_avia='|| r_item_avia.id||'p_process=update,p_table=item_avia_status,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
*/
    --begin
      c_bill := ord_api.bill_get_info(p_status=>'W', p_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>'CASH_IN'));
    --exception when NO_DATA_FOUND then return;
    --end;
    
    LOOP
      FETCH c_bill INTO r_bill;
      EXIT WHEN c_bill%NOTFOUND;
        begin
          hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'start',
            P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',item_avia='|| r_item_avia.id||'p_process=update,p_table=item_avia_status,p_date='
            || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
  
          v_DOC := blng.BLNG_API.document_add(P_CONTRACT => r_bill.contract_oid,
                                              P_AMOUNT => r_bill.amount,
                                              P_TRANS_TYPE => blng.blng_api.trans_type_get_id(p_code=>'ci'),
                                              P_ACCOUNT_TRANS_TYPE => hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'CASH_IN'),
                                              p_bill => r_bill.id);
  
  
          r_document:=blng.BLNG_API.document_get_info_r(p_id => v_DOC);
          blng.core.cash_in(r_document);
          blng.core.credit_online(r_document.id);
  
          blng.blng_api.document_edit(r_document.id, 'P');
  
          ORD_API.bill_edit( P_id => r_bill.id, P_STATUS => 'P');   --[P]osted
  
          -- edit PNR
/*          r_item_avia := ord_api.item_avia_get_info_r(p_order => r_bill.order_oid);
          r_item_avia_status := ord_api.item_avia_status_get_info_r(p_item_avia => r_item_avia.id);
          hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'try set status SUCCESS',
            P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',item_avia='|| r_item_avia.id||'p_process=update,p_table=item_avia_status,p_date='
            || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
          ord_api.item_avia_status_edit (  p_item_avia => r_item_avia.id, p_po_status => 'SUCCESS',
                                  p_nqt_status_cur => r_item_avia.nqt_status) ;  
          hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'finish',
            P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',item_avia='|| r_item_avia.id||'p_process=update,p_table=item_avia_status,p_date='
            || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);       */   
          commit;             
      exception
        when hdbk.dtype.doc_waiting then
          rollback;
--???          v_waiting_contract := r_document.contract_oid;
          hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'Warning', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || r_document.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
        when hdbk.dtype.dead_lock then
          rollback;
          hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'DEAD_LOCK', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || r_document.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
        when others then
          rollback;
          hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'Warning', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',p_process=set,p_status=D,p_doc=' || r_document.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>2);
      end;

    END LOOP;
    CLOSE c_bill;    
    
/*    hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'PAY_BILL',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',item_avia='|| r_item_avia.id||'p_process=update,p_table=item_avia_status,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
*/
      c_bill := ord_api.bill_get_info(p_status=>'W', p_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'TRANS_TYPE',p_code=>'PAY_BILL'));
    
    LOOP
      FETCH c_bill INTO r_bill;
      EXIT WHEN c_bill%NOTFOUND;
        begin
          hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'start',
            P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',item_avia='|| r_item_avia.id||'p_process=update,p_table=item_avia_status,p_date='
            || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);          
  
          v_DOC := blng.BLNG_API.document_add(P_CONTRACT => r_bill.contract_oid,
                                              P_AMOUNT => r_bill.amount,
                                              P_TRANS_TYPE => blng.blng_api.trans_type_get_id(p_code=>'ci'),
                                              P_ACCOUNT_TRANS_TYPE => hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'PAY_BILL'),
                                              p_bill => r_bill.id);
  
  
          r_document:=blng.BLNG_API.document_get_info_r(p_id => v_DOC);
          blng.core.pay_bill(r_document);
          blng.core.credit_online(r_document.id);
  
          blng.blng_api.document_edit(r_document.id, 'P');
  
          ORD_API.bill_edit( P_id => r_bill.id, P_STATUS => 'P');   --[P]osted
          commit;             
      exception
        when hdbk.dtype.doc_waiting then
          rollback;
--???          v_waiting_contract := r_document.contract_oid;
          hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'Warning', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || r_document.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
          ORD_API.bill_edit( P_id => r_bill.id, P_STATUS => 'E');   --[E]rror
          commit;             
        when hdbk.dtype.dead_lock then
          rollback;
          hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'DEAD_LOCK', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || r_document.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
        when others then
          rollback;
          hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'Warning', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => ',p_process=set,p_status=D,p_doc=' || r_document.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>2);
          ORD_API.bill_edit( P_id => r_bill.id, P_STATUS => 'E');   --[E]rror
          commit;             
      end;

    END LOOP;
    CLOSE c_bill;    


    c_doc := blng.blng_api.document_get_info(p_status=>'W', p_account_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'UP_LIM_TRANS'));
    LOOP
      FETCH c_doc INTO r_document;
      EXIT WHEN c_doc%NOTFOUND;

      begin
        if r_document.amount < 0 then raise VALUE_ERROR; end if;
        r_account := blng.blng_api.account_get_info_r(p_contract => r_document.contract_oid, p_code => 'ult'  );
        v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => r_document.id,P_AMOUNT => abs(r_document.amount)-abs(r_account.amount),
          P_TRANS_TYPE => BLNG.blng_api.trans_type_get_id(p_code=>'ult'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
        blng.blng_api.document_edit(r_document.id, 'P');
        commit;
      exception
        when hdbk.dtype.dead_lock then
          rollback;
          hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'DEAD_LOCK', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || r_document.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
        when others then
          rollback;
          hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || r_document.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
          blng.blng_api.document_edit(r_document.id, 'E');
          commit;
      end;
    END LOOP;
    CLOSE c_doc;

    c_doc := blng.blng_api.document_get_info(p_status=>'W', p_account_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'CREDIT_LIMIT'));
    LOOP
      FETCH c_doc INTO r_document;
      EXIT WHEN c_doc%NOTFOUND;

      begin
        if r_document.amount < 0 then raise VALUE_ERROR; end if;
        r_account := blng.blng_api.account_get_info_r(p_contract => r_document.contract_oid, p_code => 'cl'  );
        v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => r_document.id,P_AMOUNT => abs(r_document.amount)-abs(r_account.amount),
          P_TRANS_TYPE => BLNG.blng_api.trans_type_get_id(p_code=>'cl'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
        --blng.blng_api.document_edit(r_document.id, p_account_trans_type=> hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'CREDIT_LIMIT'), p_status_ );
        blng.blng_api.document_edit(r_document.id, 'P');
        commit;
      exception
        when hdbk.dtype.dead_lock then
          rollback;
          hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'DEAD_LOCK', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || r_document.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
        when others then
          rollback;
          hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || r_document.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
          blng.blng_api.document_edit(r_document.id, 'E');
          commit;
      end;
    END LOOP;
    CLOSE c_doc;

    c_doc := blng.blng_api.document_get_info(p_status=>'W', p_account_trans_type=>hdbk.hdbk_api.dictionary_get_id(p_dictionary_type=>'ACCOUNT_TYPE',p_code=>'DELAY_DAY'));
    LOOP
      FETCH c_doc INTO r_document;
      EXIT WHEN c_doc%NOTFOUND;

      begin
        if r_document.amount < 0 then raise VALUE_ERROR; end if;
        r_account := blng.blng_api.account_get_info_r(p_contract => r_document.contract_oid, p_code => 'dd'  );
        v_transaction := BLNG.BLNG_API.transaction_add_with_acc(P_DOC => r_document.id,P_AMOUNT => abs(r_document.amount)-abs(r_account.amount),
          P_TRANS_TYPE => BLNG.blng_api.trans_type_get_id(p_code=>'dd'), P_TRANS_DATE => sysdate, P_TARGET_ACCOUNT => r_account.id);
        blng.blng_api.document_edit(r_document.id, 'P');
        commit;
      exception
        when hdbk.dtype.dead_lock then
          rollback;
          hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'DEAD_LOCK', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || r_document.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>5);
        when others then
          rollback;
          hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'UNHANDLED_ERROR', P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_doc=' || r_document.id || ',p_date=' || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
          blng.blng_api.document_edit(r_document.id, 'E');
          commit;
      end;
    END LOOP;
    CLOSE c_doc;

  exception 
    when NO_DATA_FOUND then 
      hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=bill,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      --RAISE_APPLICATION_ERROR(-20002,'doc_task_list error. '||SQLERRM);
    
    when others then
      rollback;
      hdbk.log_api.LOG_ADD(p_proc_name=>'doc_task_list', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=bill,p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      --RAISE_APPLICATION_ERROR(-20002,'doc_task_list error. '||SQLERRM);
  end;




  procedure bill_pay_back( p_pnr_id in hdbk.dtype.t_long_code default null
                    )
  is
--    v_ord_row ord%rowtype;
    v_id hdbk.dtype.t_id;
    v_order hdbk.dtype.t_id;
    v_avia hdbk.dtype.t_id;
    v_item_avia_r item_avia%rowtype;
    v_order_r ord%rowtype;
    v_bill hdbk.dtype.t_id;
    v_contract hdbk.dtype.t_id;
    
    c_bill  SYS_REFCURSOR;
    r_bill bill%rowtype;

    v_DOC hdbk.dtype.t_id;
    
  begin

      c_bill := ord_api.bill_get_info(p_status=>'W');

    LOOP
      FETCH c_bill INTO r_bill;
      EXIT WHEN c_bill%NOTFOUND;
        if r_bill.amount > 0 then -- buy
          v_DOC := blng.BLNG_API.document_add(P_CONTRACT => r_bill.contract_oid,
                                              P_AMOUNT => r_bill.amount,
                                              P_TRANS_TYPE => blng.blng_api.trans_type_get_id(p_code=>'b'),
                                              p_bill => r_bill.id);
        elsif r_bill.amount < 0 then -- cach_in
          v_DOC := blng.BLNG_API.document_add(P_CONTRACT => r_bill.contract_oid,
                                              P_AMOUNT => r_bill.amount,
                                              P_TRANS_TYPE => blng.blng_api.trans_type_get_id(p_code=>'ci'),
                                              p_bill => r_bill.id
                                              );
        end if;
        ORD_API.bill_edit( P_id => r_bill.id, P_STATUS => 'T');   --[T]ransported

    END LOOP;
    CLOSE c_bill;    
    commit;             
  exception when others then
    rollback;
    hdbk.log_api.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=bill,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'bill_pay error. '||SQLERRM);
  end;


END CORE;

/
