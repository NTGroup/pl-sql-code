--------------------------------------------------------
--  DDL for Package FWDR
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "ORD"."FWDR" AS 

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 

  function order_create(p_date  in ntg.dtype.t_date default null, 
                    p_order_number  in ntg.dtype.t_long_code default null, 
                    p_client in ntg.dtype.t_id default null,
                    p_status in ntg.dtype.t_status default null
                    )
  return ntg.dtype.t_id;


  function item_add(p_order_oid in ntg.dtype.t_id default null,
                          p_pnr_id in ntg.dtype.t_long_code default null,
                          p_time_limit  in ntg.dtype.t_date default null,
                          p_total_amount in ntg.dtype.t_amount default null,
                          p_total_markup in ntg.dtype.t_amount default null,
                          p_pnr_object in ntg.dtype.t_clob default null,
                          p_nqt_id in ntg.dtype.t_long_code default null
                          )
  return ntg.dtype.t_id;

  procedure avia_register(      p_nqt_id in ntg.dtype.t_long_code default null,
                          p_pnr_id in ntg.dtype.t_long_code default null,
                          p_time_limit  in ntg.dtype.t_date default null,
                          p_total_amount in ntg.dtype.t_amount default null,
                          p_total_markup in ntg.dtype.t_amount default null,
                          p_pnr_object in ntg.dtype.t_clob default null,
                          p_nqt_status in  ntg.dtype.t_status default null,
                          p_client  in  ntg.dtype.t_id default null
                          );

  procedure avia_pay( p_nqt_id in ntg.dtype.t_long_code default null);
  
  function order_get(p_id in ntg.dtype.t_id)
  return SYS_REFCURSOR;

  function item_get(p_id in ntg.dtype.t_id)
  return SYS_REFCURSOR;

  function item_list(p_order in ntg.dtype.t_id)
  return SYS_REFCURSOR;
  
  function pnr_list(p_nqt_status_list in ntg.dtype.t_clob, p_rownum in ntg.dtype.t_id default null)
  return SYS_REFCURSOR;
 
  function pnr_list(p_nqt_id_list in ntg.dtype.t_clob)
  return SYS_REFCURSOR;
  
  procedure commission_get(p_nqt_id in ntg.dtype.t_long_code, o_fix out  ntg.dtype.t_amount, o_percent out  ntg.dtype.t_amount);

  function order_number_generate (p_client in ntg.dtype.t_id)
  return ntg.dtype.t_long_code;

  procedure avia_manual( p_nqt_id in ntg.dtype.t_long_code default null, p_result in ntg.dtype.t_long_code default null);
  
    procedure cash_back(p_nqt_id in ntg.dtype.t_long_code);
END FWDR;

/

--------------------------------------------------------
--  DDL for Package Body FWDR
--------------------------------------------------------

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
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=insert&p_table=ord&p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into ord error. '||SQLERRM);
    return null;
  end;

  function item_add(p_order_oid in ntg.dtype.t_id default null,
                          p_pnr_id in ntg.dtype.t_long_code default null,
                          p_time_limit  in ntg.dtype.t_date default null,
                          p_total_amount in ntg.dtype.t_amount default null,
                          p_total_markup in ntg.dtype.t_amount default null,
                          p_pnr_object in ntg.dtype.t_clob default null,
                          p_nqt_id in ntg.dtype.t_long_code default null
                          )
  return ntg.dtype.t_id
  is
    v_ord_row ord%rowtype;
    v_id ntg.dtype.t_id;
  begin
    v_id:=ord_api.item_avia_add(  p_order_oid,
                                  p_pnr_id,
                                  p_time_limit,
                                  p_total_amount,
                                  p_total_markup,
                                  p_pnr_object,
                                  p_nqt_id);
    return v_id;
  exception when others then
    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'item_add', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=insert&p_table=item_avia&p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'insert row into item_avia error. '||SQLERRM);
    return null;
  end;

  procedure avia_register( p_nqt_id in ntg.dtype.t_long_code default null,
                          p_pnr_id in ntg.dtype.t_long_code default null,
                          p_time_limit  in ntg.dtype.t_date default null,
                          p_total_amount in ntg.dtype.t_amount default null,
                          p_total_markup in ntg.dtype.t_amount default null,
                          p_pnr_object in ntg.dtype.t_clob default null,
                          p_nqt_status in  ntg.dtype.t_status default null,
                          p_client in ntg.dtype.t_id default null
                          )
  is
--    v_order_r ord%rowtype;
--    v_item_avia_r item_avia%rowtype;
    v_id ntg.dtype.t_id;
    v_order ntg.dtype.t_id;
    v_avia ntg.dtype.t_id;
    v_bill ntg.dtype.t_id;
    v_client ntg.dtype.t_id;
    v_contract ntg.dtype.t_id;
    r_item_avia item_avia%rowtype;
  begin
    v_client := nvl(p_client,ntg.dtype.p_client);
    r_item_avia := ord_api.item_avia_get_info_r(p_nqt_id => p_nqt_id);
        
    if r_item_avia.id is not null then
    -- po_status not nulled when register calls
      ORD_API.item_avia_edit (  --P_ID => P_ID,
    --    P_ORDER_OID => P_ORDER_OID,
        P_PNR_ID => P_PNR_ID,
        P_TIME_LIMIT => P_TIME_LIMIT,
        P_TOTAL_AMOUNT => P_TOTAL_AMOUNT,
        P_TOTAL_MARKUP => P_TOTAL_MARKUP,
        P_PNR_OBJECT => P_PNR_OBJECT,
        P_NQT_ID => P_NQT_ID,
        p_nqt_status => p_nqt_status,
        p_po_status => null
        ) ;  
    else
        v_order := fwdr.order_create(p_client=> v_client);
        
        v_avia := ORD_API.item_avia_add(P_ORDER_OID => v_ORDER,
          P_PNR_ID => P_PNR_ID,
          P_TIME_LIMIT => P_TIME_LIMIT,
          P_TOTAL_AMOUNT => P_TOTAL_AMOUNT,
          P_TOTAL_MARKUP => P_TOTAL_MARKUP,
          P_PNR_OBJECT => P_PNR_OBJECT,
          P_NQT_ID => P_NQT_ID,
          p_nqt_status => p_nqt_status,
          p_po_status => null
          );        

        --v_item_avia_r := ord_api.item_avia_get_info_r(p_nqt_id=>p_nqt_id);
--        v_order_r:=ord_api.ord_get_info_r(v_order);
        v_contract := blng.core.pay_contract_by_client(v_client);
        v_bill := ORD_API.bill_add( P_ORDER => v_order,
                                    P_AMOUNT => P_TOTAL_AMOUNT + p_total_markup,
                                    P_DATE => sysdate,
                                    P_STATUS => 'M', --managing
                                    P_CONTRACT => v_contract);

    end if;
    
      commit;          
  exception when others then
    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_register', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=insert&p_table=item_avia&p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'avia_register error. '||SQLERRM);
  end;


  procedure avia_pay( p_nqt_id in ntg.dtype.t_long_code default null
                            )
  is
--    v_ord_row ord%rowtype;
    v_id ntg.dtype.t_id;
    v_order ntg.dtype.t_id;
    v_item_avia_status ntg.dtype.t_id;
    v_item_avia_r item_avia%rowtype;
    r_item_avia_status item_avia_status%rowtype;
    v_order_r ord%rowtype;
    v_bill ntg.dtype.t_id;
    v_contract ntg.dtype.t_id;
    
    c_bill  SYS_REFCURSOR;
    r_bill bill%rowtype;
  begin
    v_item_avia_r := ord_api.item_avia_get_info_r(p_nqt_id=>p_nqt_id);
--sd
    if v_item_avia_r.id is null then 
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_manual', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&p_table=item_avia&p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>1);
      raise NO_DATA_FOUND;
    end if;
    r_item_avia_status := ord_api.item_avia_status_get_info_r(p_item_avia => v_item_avia_r.id);
    if r_item_avia_status.id is null then
      v_item_avia_status := ord_api.item_avia_status_add (  p_item_avia => v_item_avia_r.id, p_po_status => 'INPROGRESS',
                              p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
    else            
      ord_api.item_avia_status_edit (  p_item_avia => v_item_avia_r.id, p_po_status => 'INPROGRESS',
                              p_nqt_status_cur => v_item_avia_r.nqt_status) ;  
    end if;

    c_bill := ord_api.bill_get_info(p_order=>v_item_avia_r.order_oid,p_status=>'M');
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
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update&p_table=item_avia_status&p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'avia_pay error. '||SQLERRM);
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
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&p_table=item_avia&p_date='
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
        ia.nqt_id, ia.nqt_status, ias.po_status, ias.nqt_status_cur, null po_msg, 'avia' item_type, ia.pnr_id
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
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&p_table=item_avia&p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into item_avia error. '||SQLERRM);
    return null;    
  end;
  

  function pnr_list(p_nqt_id_list in ntg.dtype.t_clob)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
      OPEN v_results FOR
        SELECT
        ia.nqt_id, ia.nqt_status, ias.po_status, ias.nqt_status_cur, null po_msg, 'avia' item_type, ia.pnr_id
        from ord.item_avia ia, ord.item_avia_status ias,
        json_table  
          ( p_nqt_id_list,'$[*]' 
          columns (id VARCHAR2(250) path '$.id')
          ) as j
        where ia.nqt_id = lower(j.id) 
        and ia.amnd_state = 'A'
        and ias.amnd_state = 'A'
        and ia.id = ias.item_avia_oid
        order by ia.time_limit asc; --, ia.id;
    return v_results;
  exception when others then
    NTG.LOG_API.LOG_ADD(p_proc_name=>'pnr_list', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&p_table=item_avia&p_date='
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
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&p_table=item_avia&p_date='
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
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&p_table=ord&p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into ord error. '||SQLERRM);
    return null;
  end;



  procedure commission_get_old(p_id in ntg.dtype.t_id, o_fix out  ntg.dtype.t_amount, o_percent out  ntg.dtype.t_amount)
  is
    v_iata varchar2(255); 
    v_out number := null;
    r_json v_json%rowtype;
    f_chs_VCeqMC number;  
    f_chs_MCneOC number;  
    f_rule_r number;  
    f_template_type number;  
    f_details_r number;  
  begin
    select distinct validatingcarrier into v_iata from ord.v_json where id = p_id;
    for rule_r in (
      select cmn_oid, priority, percent, fix from v_commission_bak where iata = v_iata group by cmn_oid, priority, percent, fix order by priority desc --cmn_oid desc
    )
    loop
-- several rules can be true. each of them we need to check and get minimum commission value.
-- its mean we need to check all rules.
      f_rule_r := 1; 
      for template_type in (
        select template_type, template_type_oid from v_commission_bak where cmn_oid = rule_r.cmn_oid group by  template_type,template_type_oid order by template_type_oid desc
      )
      loop
-- template_type its is a distributes rule by types. for examples geo type and class type.
-- each of types must be true inside rule.
-- thats why order of types is dosnt matter
        f_template_type := 0; 
          f_details_r := 0;

        if  template_type.template_type = 'constant' then 
          if o_fix is null or o_fix > rule_r.fix then 
            o_fix := rule_r.fix; 
          end if;
          if o_percent is null or o_percent > rule_r.percent then 
            o_percent := rule_r.percent; 
          end if;
          exit;  --constant - is the last rule. so if values have not been set before, they must be set
        end if;
        for details_r in (
          select * from ord.v_commission_bak where cmn_oid = rule_r.cmn_oid and template_type_oid = template_type.template_type_oid
        )
        loop
-- we go throwgh each commission row. if one of dedails_r is true then current type is true.
-- if one of types is not true then rule is not true.
-- some of template_types could be right at one of segment, 
-- some on full flight.
          f_chs_VCeqMC := 1;
          f_chs_MCneOC := 0;
          for json in (select * from ord.v_json where id = p_id)
          loop
-- json is just iteration for each segment. some conditions must be true for each segment.
            if  template_type.template_type = 'class' then 
              if details_r.value = json.bookingcode then
                f_details_r:=1;
                exit;
              end if;
            end if;      

            if template_type.template_type = 'interline' then 
              if v_iata != json.m_airline then
                f_details_r:=1;
                exit;
                
              end if;
            end if;      

            if  template_type.template_type = 'code-share' then 
              if v_iata != json.m_airline then f_chs_VCeqMC := 0; end if;
              if json.o_airline != json.m_airline then f_chs_MCneOC := 1; end if;
            end if;      
          end loop; --json
-- if some epressoin true then details_r is true
-- else nothing
          if f_chs_VCeqMC = 1 and f_chs_MCneOC = 1 then
            f_details_r := 1;
          end if;
-- if f_details_r true then f_template_type true and exit. its mean that one of the clause is true
-- and we can 
          if f_details_r = 1 then
            f_template_type:=1;
            exit; 
          end if;
        end loop; --details_r
        
        if f_template_type = 0 then 
          f_rule_r := 0;
          exit;
        end if;
      end loop; --template_type
      
      if f_rule_r = 1 then
        if o_fix is null or o_fix > rule_r.fix then 
          o_fix := rule_r.fix; 
        end if;
        if o_percent is null or o_percent > rule_r.percent then 
          o_percent := rule_r.percent; 
        end if;
      end if;
    end loop;  --rule_r
    if o_fix is not null then o_percent := null; end if;
    dbms_output.put_line(' p_id='||p_id||' v_iata='||v_iata||' o_fix='||o_fix||' o_percent='||o_percent);          
  end;

  procedure commission_get(p_nqt_id in ntg.dtype.t_long_code, o_fix out  ntg.dtype.t_amount, o_percent out  ntg.dtype.t_amount)
  is
    v_iata varchar2(255); 
  --  v_out number := null;
    r_json v_json%rowtype;
    r_item_avia item_avia%rowtype;
--    f_chs_VCeqMC number;  
--    f_chs_MCneOC number;  
    f_VCeqMC ntg.dtype.t_id;  
    f_MCeqOC ntg.dtype.t_id;  
    f_rule ntg.dtype.t_id;  
    f_template_type ntg.dtype.t_id;  
    f_list ntg.dtype.t_id;  
    v_contract_type ntg.dtype.t_id;
    v_template_type varchar2(255);
    v_airline ntg.dtype.t_id;
    v_id ntg.dtype.t_id;
    
  begin

--o_percent:=0.6;
--o_fix:= 2.3;

    NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_get', p_msg_type=>'STARTED',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&p_table=commission&p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
        
    r_item_avia := ord_api.item_avia_get_info_r(p_nqt_id => p_nqt_id);
    if r_item_avia.id is null then
      dbms_output.put_line(' p_id='||p_nqt_id);          
     
      --raise NO_DATA_FOUND;
      null;
    end if;
    dbms_output.put_line('NN p_id='||r_item_avia.id);          
    v_id:= r_item_avia.id;
  
    select distinct al.id, al.iata  into v_airline, v_iata from ord.v_json j, ntg.airline al where j.id = v_id
    and al.AMND_STATE = 'A'
    and j.validatingcarrier = al.iata
    ;
    dbms_output.put_line('1');          

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
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&p_table=commission&p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
  --    RAISE_APPLICATION_ERROR(-20002,'commission_get error. '||SQLERRM);
      o_fix := null; o_percent:=5;
    end;
 
 
-- if some epressoin true then details_r is true
-- else nothing
    if f_VCeqMC = 0 then
      v_contract_type := ord_api.commission_template_get_id('interline');
    elsif f_MCeqOC = 0 then
      v_contract_type := ord_api.commission_template_get_id('code-share');
    else 
      v_contract_type := ord_api.commission_template_get_id('self');
    end if;

    dbms_output.put_line('2');

    for i_rule in (
      select com.id id, com.fix, com.percent, priority, details from  ord.commission com
      where com.amnd_state = 'A'
      and com.airline = v_airline
      and trunc(sysdate) between NVL(com.date_from,trunc(sysdate)) and NVL(com.date_to,trunc(sysdate))
      and exists(
        select * from ord.commission_details
        where amnd_state = 'A'
        and commission_oid = com.id
        and commission_template_oid = v_contract_type
      )
      and not exists(
        select * from ord.commission_details
        where amnd_state = 'A'
        and commission_oid = com.id
        and commission_template_oid = ord_api.commission_template_get_id('default')
      )
      group by com.id, com.fix, com.percent, priority, details
      order by priority desc
    )
    loop
-- several rules can be true. each of them we need to check and get minimum commission value.
-- its mean we need to check all rules.
      f_rule := 1; 
      for i_template_type in (
        select commission_template_oid from ord.commission_details 
        where commission_oid = i_rule.id 
        and amnd_state = 'A'
        and commission_template_oid not in ( v_contract_type, ord_api.commission_template_get_id('default'))
        group by commission_template_oid
      )
      loop
-- template_type its is a distributes rule by types. for examples geo type and class type.
-- each of types must be true inside rule.
-- thats why order of types is dosnt matter
        f_template_type := 0; 
        select template_type into v_template_type from ord.commission_template where id = i_template_type.commission_template_oid; 
        f_list := 0;

        for i_list in (
          select value from ord.commission_details 
          where commission_oid = i_rule.id 
          and commission_template_oid = i_template_type.commission_template_oid
          and amnd_state = 'A'
          group by value
        )
        loop
-- we go throwgh each commission row. if one of dedails_r is true then current type is true.
-- if one of types is not true then rule is not true.
-- some of template_types could be right at one of segment, 
-- some on full flight.

            for i_json in (select bookingcode from ord.v_json where id = v_id)
  --          for i_json in (select * from ord.v_json where book_id = p_nqt_id)
            loop
  -- json is just iteration for each segment. some conditions must be true for each segment.
              if  v_template_type = 'class' then 
                if i_list.value = i_json.bookingcode then
                  f_list:=1;
                  exit;
                end if;
              end if;      
            end loop; --json

-- if some epressoin true then details_r is true
-- else nothing
-- if f_details_r true then f_template_type true and exit. its mean that one of the clause is true
-- and we can 
          if f_list = 1 then
            f_template_type:=1;
            exit; 
          end if;
        end loop; --details_r
        
        if f_template_type = 0 then 
          f_rule := 0;
          exit;
        end if;
      end loop; --template_type
      
      if f_rule = 1 then
        if o_fix is null or o_fix > i_rule.fix then 
          o_fix := i_rule.fix; 
        end if;
        if o_percent is null or o_percent > i_rule.percent then 
          o_percent := i_rule.percent; 
        end if;
      end if;
    dbms_output.put_line(' p_id='||i_rule.details||' v_iata='||v_iata||' o_fix='||o_fix||' o_percent='||o_percent);          
    end loop; --i_rule
    dbms_output.put_line('3');          

-- get airline default commission by contract_type
    if o_fix is null and o_percent is null then 
      begin       
        select fix, percent into o_fix, o_percent 
        from  ord.commission com where id = (
          select distinct commission_oid
          from ord.commission_details
          where amnd_state = 'A'
          and commission_template_oid = ord_api.commission_template_get_id('default')
          and commission_oid in (
            select commission_oid from ord.commission_details cd,  ord.commission cmn
            where cmn.amnd_state = 'A'
            and cd.amnd_state = 'A'
            and cmn.airline = v_airline 
            and cd.commission_oid = cmn.id
            and cd.commission_template_oid = v_contract_type
          )
        )
        group by fix, percent ;
      exception when NO_DATA_FOUND then null;
      end;
    end if;
    
-- get airline default commission
    if o_fix is null and o_percent is null then 
      begin
        select fix, percent into o_fix, o_percent 
        from  ord.commission com where 
        amnd_state = 'A'
        and airline = v_airline
        and (select count(*) from ord.commission_details where amnd_state = 'A'
          and commission_oid = com.id
          ) = 1
        and exists 
          (select commission_template_oid from ord.commission_details where amnd_state = 'A'
          and commission_oid = com.id
          and commission_template_oid = ord_api.commission_template_get_id('default')
          )
        group by fix, percent ;
      exception when NO_DATA_FOUND then null;
      end;
    end if;
 
    if o_fix is not null then o_percent := null; end if;
    --c_fix := to_char(o);
    dbms_output.put_line(' p_id='||v_id||' v_iata='||v_iata||' o_fix='||o_fix||' o_percent='||o_percent);        
  exception 
    WHEN NO_DATA_FOUND then 
      dbms_output.put_line(' p_id='||v_id||' v_iata='||v_iata||' o_fix='||o_fix||' o_percent='||o_percent);        
      NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_get', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&p_table=commission&p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      return;
    when others then
    
--    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'commission_get', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&p_table=commission&p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
--    RAISE_APPLICATION_ERROR(-20002,'commission_get error. '||SQLERRM);
    o_fix := null; o_percent:=5;
  end;

  function order_number_generate (p_client in ntg.dtype.t_id)
  return ntg.dtype.t_long_code
  is
    v_client_oid number;
    v_order_count number;
  begin
    select count(*) into v_order_count from ord.ord where client_oid = p_client;
    return lpad(p_client,6,'0')||lpad(v_order_count+1,4,'0');
  end;



  procedure avia_manual( p_nqt_id in ntg.dtype.t_long_code default null, p_result in ntg.dtype.t_long_code default null)
  is
--    v_ord_row ord%rowtype;
    v_id ntg.dtype.t_id;
    v_order ntg.dtype.t_id;
    v_item_avia_status ntg.dtype.t_id;
    r_item_avia item_avia%rowtype;
    r_item_avia_status item_avia_status%rowtype;
    v_order_r ord%rowtype;
    v_bill ntg.dtype.t_id;
    v_contract ntg.dtype.t_id;
    
    c_bill  SYS_REFCURSOR;
    r_bill bill%rowtype;
  begin

    r_item_avia := ord_api.item_avia_get_info_r(p_nqt_id=>p_nqt_id);

    if r_item_avia.id is null then 
      NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_manual', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&p_table=item_avia&p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>1);
      raise NO_DATA_FOUND;
    end if;
  
    r_item_avia_status := ord_api.item_avia_status_get_info_r(p_item_avia => r_item_avia.id);
    if r_item_avia_status.id is null then
      v_item_avia_status := ord_api.item_avia_status_add (  p_item_avia => r_item_avia.id, p_po_status => nvl(p_result,'INPROGRESS'),
                              p_nqt_status_cur => r_item_avia.nqt_status) ;  
    else            
      ord_api.item_avia_status_edit (  p_item_avia => r_item_avia.id, p_po_status => nvl(p_result,'INPROGRESS'),
                              p_nqt_status_cur => r_item_avia.nqt_status) ;  
    end if;
    
    if p_result = 'ERROR' then 
      fwdr.cash_back(p_nqt_id);
    end if;
    
/*    c_bill := ord_api.bill_get_info(p_order=>v_item_avia_r.order_oid,p_status=>'M');
    LOOP
      FETCH c_bill INTO r_bill;
      EXIT WHEN c_bill%NOTFOUND;
        ORD_API.bill_edit( P_id => r_bill.id, P_STATUS => 'W');
    END LOOP;
    CLOSE c_bill;    */
    commit;             
  exception 
    WHEN NO_DATA_FOUND then return;
    when others then
    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'avia_manual', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update&p_table=item_avia_status&p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'avia_manual error. '||SQLERRM);
  end;

  procedure cash_back(p_nqt_id in ntg.dtype.t_long_code)
  is
    r_item_avia item_avia%rowtype;
    r_bill bill%rowtype;
    r_document blng.document%rowtype;
    c_bill SYS_REFCURSOR;
  begin
    r_item_avia:=ord_api.item_avia_get_info_r(p_nqt_id=>p_nqt_id);
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
            P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update&p_table=bill&p_date=' 
            || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
          CLOSE c_bill;
          raise;
        end;
    END LOOP;
    CLOSE c_bill;

  exception when others then 
    rollback;
    NTG.LOG_API.LOG_ADD(p_proc_name=>'cash_back', p_msg_type=>'UNHANDLED_ERROR', 
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update&p_table=bill&p_date=' 
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
    RAISE_APPLICATION_ERROR(-20002,'cash_back error. '||SQLERRM);
  end;


END FWDR;

/
