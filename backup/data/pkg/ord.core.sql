  CREATE OR REPLACE PACKAGE "ORD"."CORE" AS 


/*

pkg: ORD.CORE

*/

/*

$obj_type: procedure
$obj_name: bill_pay
$obj_desc: procedure perform transit bills with status [W]aiting to billing system. 
$obj_desc: that means bill requested for pay. after that bill marked as [T]ransported
$obj_desc: this procedure executed from job scheduler
$obj_param: p_nqt_id: id from NQT. search perform by this id
*/

  procedure bill_pay( p_nqt_id in ntg.dtype.t_long_code default null
                    );
END CORE;

/

--------------------------------------------------------
--  DDL for Package Body CORE
--------------------------------------------------------

  CREATE OR REPLACE  PACKAGE BODY "ORD"."CORE" AS

  procedure bill_pay( p_nqt_id in ntg.dtype.t_long_code default null
                    )
  is
--    v_ord_row ord%rowtype;
    v_id ntg.dtype.t_id;
    v_order ntg.dtype.t_id;
    v_avia ntg.dtype.t_id;
    v_item_avia_r item_avia%rowtype;
    v_order_r ord%rowtype;
    v_bill ntg.dtype.t_id;
    v_contract ntg.dtype.t_id;
    
    c_bill  SYS_REFCURSOR;
    r_bill bill%rowtype;

    v_DOC ntg.dtype.t_id;
    
  begin
    --begin
      c_bill := ord_api.bill_get_info(p_status=>'W');
    --exception when NO_DATA_FOUND then return;
    --end;
    
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
        ORD_API.bill_edit( P_id => r_bill.id, P_STATUS => 'T');   --transported

    END LOOP;
    CLOSE c_bill;    
    commit;             
  exception when others then
    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'bill_pay', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update,p_table=bill,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'bill_pay error. '||SQLERRM);
  end;


END CORE;

/
