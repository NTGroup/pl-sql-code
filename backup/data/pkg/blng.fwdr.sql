create or replace package blng.fwdr as
/*
$pkg: blng.fwdr
*/

/*
$obj_type: function
$obj_name: get_tenant
$obj_desc: return tenant. tenant is contract/company identifire. tenant using 
$obj_desc: for checking is client registered in the system.
$obj_param: p_email: user email
$obj_return: contract(now company) identifire
*/
  function get_tenant (p_email in ntg.dtype.t_name default null)
  return ntg.dtype.t_id;  

/*
$obj_type: function
$obj_name: company_insteadof_client
$obj_desc: return client  
$obj_desc: for checking is client registered in the system.
$obj_param: p_email: user email
$obj_return: contract(now company) identifire
*/
  function company_insteadof_client(p_company in ntg.dtype.t_id)
  return ntg.dtype.t_id;
  
  function balance( P_TENANT_ID in ntg.dtype.t_id  default null
                          )
  return SYS_REFCURSOR;  

  function whoami(p_user in ntg.dtype.t_name)
  return SYS_REFCURSOR;

  function client_data_edit(p_data in ntg.dtype.t_clob)
  return SYS_REFCURSOR;

  function statement(p_email  in ntg.dtype.t_name,
                      p_date_from in ntg.dtype.t_code,
                      p_date_to in ntg.dtype.t_code,
                      p_rownum  in ntg.dtype.t_id default null
                    )
  return SYS_REFCURSOR;

  function loan_list( p_email  in ntg.dtype.t_name,
                      p_rownum  in ntg.dtype.t_id default null
                    )
  return SYS_REFCURSOR;



end;
/
create  or replace package BODY blng.fwdr as

  function get_tenant (p_email in ntg.dtype.t_name default null)
  return ntg.dtype.t_id
  is
    r_client blng.client%rowtype;
--    r_company blng.company%rowtype;
    v_client ntg.dtype.t_id;
    v_company ntg.dtype.t_id;
    r_company blng.company%rowtype;
    r_contract blng.contract%rowtype;
    r_domain blng.domain%rowtype;
    v_client_count ntg.dtype.t_id;
  begin
  --all emails must be in lower case
    begin
      r_client:=blng.blng_api.client_get_info_r(p_email=>lower(p_email));
      v_company := r_client.company_oid;
    exception 
      when NO_DATA_FOUND then
        begin
          r_domain:=blng.blng_api.domain_get_info_r(p_name => REGEXP_SUBSTR ( lower(p_email), '[^@]*$' ));
        exception 
          when NO_DATA_FOUND then
            begin
--dbms_output.put_line(sysdate||'1');
              r_domain:=blng.blng_api.domain_get_info_r(p_name => lower(p_email) );
              blng.blng_api.domain_edit(p_id=>r_domain.id, p_status=>'C' );                
--dbms_output.put_line(sysdate||'2');
            exception when NO_DATA_FOUND then raise;
            end;
        end;
        v_company:=r_domain.company_oid;
--dbms_output.put_line(sysdate||'3');
        r_company:=blng.blng_api.company_get_info_r(p_id=>v_company);        
        r_contract:=blng.blng_api.contract_get_info_r(p_company=>v_company);
--dbms_output.put_line(sysdate||'4');
        select count(*) into v_client_count from blng.client where amnd_state = 'A' and company_oid = v_company and amnd_date > sysdate-1/24/60;
        -- auto user registration stoper 10 user per minute
        if v_client_count>=10 then return null; end if;
--dbms_output.put_line(sysdate||'5');
        v_client := blng.BLNG_API.client_add(P_last_NAME => REGEXP_SUBSTR ( lower(p_email), '^[^@]*' ), p_company => v_company,p_email=>p_email,p_utc_offset=>r_company.utc_offset);
--dbms_output.put_line(sysdate||'6');
        blng.BLNG_API.client2contract_add(P_client => v_client, p_permission=> 'B', p_contract => r_contract.id);
        commit;
    end;
    return v_company;
  exception 
    when NO_DATA_FOUND then
      rollback;
     -- CLOSE c_delay;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'get_tenant', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '||  sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=client&\p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
--      RAISE_APPLICATION_ERROR(-20002,'select row into client error. '||SQLERRM);
      return null;
    when others then
      rollback;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'get_tenant', p_msg_type=>'UNHANDLED_ERROR',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=delay&\p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
      RAISE_APPLICATION_ERROR(-20002,'select row into client error. '||SQLERRM);
      return null;
  end;

  function company_insteadof_client(p_company in ntg.dtype.t_id)
  return ntg.dtype.t_id
  is
    v_result ntg.dtype.t_id;
  begin
    select max(id) into v_result from blng.client where company_oid = p_company and amnd_state = 'A';
    return v_result;
  exception when others then 
    NTG.LOG_API.LOG_ADD(p_proc_name=>'company_insteadof_client', p_msg_type=>'UNHANDLED_ERROR', 
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=update&\p_table=client&\p_date=' 
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
    --RAISE_APPLICATION_ERROR(-20002,'cash_back error. '||SQLERRM);  
    return null;
  end;



  function balance( P_TENANT_ID in ntg.dtype.t_id  default null
                          )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_contract ntg.dtype.t_id;
  begin
    v_contract:= blng.core.pay_contract_by_client(blng.fwdr.company_insteadof_client(P_TENANT_ID)) ;
      OPEN v_results FOR
        select
        acc.CONTRACT_OID, acc.DEPOSIT, abs(acc.LOAN) loan, acc.CREDIT_LIMIT, 
        acc.UNUSED_CREDIT_LIMIT, acc.CREDIT_LIMIT_BLOCK, acc.DEBIT_ONLINE, 
        acc.MAX_LOAN_TRANS_AMOUNT, acc.CREDIT_ONLINE, acc.DELAY_DAYS, acc.AVAILABLE,
        --acc.*,
        nvl(total.UNBLOCK_SUM,0) UNBLOCK_SUM,
        nvl(total.NEAR_UNBLOCK_SUM,0) NEAR_UNBLOCK_SUM,
        to_char(total.BLOCK_DATE,'yyyy-mm-dd') BLOCK_DATE
        from blng.v_account acc, blng.v_total total 
        where acc.contract_oid = v_contract
        and acc.contract_oid = total.contract_oid(+)

    
    ;
    return v_results;
  exception when others then 
    NTG.LOG_API.LOG_ADD(p_proc_name=>'balance', p_msg_type=>'UNHANDLED_ERROR', 
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=v_account&\p_date=' 
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
    RAISE_APPLICATION_ERROR(-20002,'select row into v_account error. '||SQLERRM);
    return null;
  end;

  function whoami(p_user in ntg.dtype.t_name)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_contract ntg.dtype.t_id;
  begin

--    v_results:=blng.blng_api.client_get_info(p_email=>p_user);
      OPEN v_results FOR
      select clt.id client_id, INITCAP(clt.last_name) last_name, INITCAP(clt.first_name) first_name,clt.email,clt.phone,
      clt.company_oid tenant_id, to_char(clt.birth_date,'yyyy-mm-dd') birth_date,
      clt.gender,
      clt.nationality,
      ntg.ntg_api.gds_nationality_get_info_name(clt.nationality) nls_nationality,
      cld.id doc_id,   
      to_char(cld.expiry_date,'yyyy-mm-dd') doc_expiry_date,
      cld.doc_number,
      INITCAP(cld.last_name) doc_last_name,
      INITCAP(cld.first_name) doc_first_name,
      cld.owner doc_owner,
      cld.gender doc_gender,
      to_char(cld.birth_date,'yyyy-mm-dd') doc_birth_date,
      cld.nationality doc_nationality,
      ntg.ntg_api.gds_nationality_get_info_name(cld.nationality) doc_nls_nationality,cld.phone doc_phone,
      company.name company_name
      from blng.client clt, blng.client_data cld, blng.company
      where 
      clt.amnd_state = 'A' 
      and clt.status = 'A'
      and clt.email = p_user
      and clt.company_oid = company.id
      and clt.id = cld.client_oid(+)
      and cld.amnd_state(+) = 'A' 
        ;

    return v_results;
  exception when others then 
    NTG.LOG_API.LOG_ADD(p_proc_name=>'whoami', p_msg_type=>'UNHANDLED_ERROR', 
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=client&\p_user='||p_user||'&\p_date=' 
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
    RAISE_APPLICATION_ERROR(-20002,'select row into client error. '||SQLERRM);
    return null;
  end;


  function client_data_edit(p_data in ntg.dtype.t_clob)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_id ntg.dtype.t_id; 
    r_client blng.client%rowtype;
    r_client_data blng.client_data%rowtype;
  begin

    for i in (
      select 
      dd.*
      from --tmp1,
      json_table(p_data, '$'
        COLUMNS 
          (
--           client_id number PATH '$.client_id',
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
--      r_client:=blng.blng_api.client_get_info_r(p_id=>i.client_id);
      r_client:=blng.blng_api.client_get_info_r(p_email=>i.email);
      if r_client.id is null then RAISE no_data_found; end if;
      blng.blng_api.client_edit(p_id=>r_client.id,
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
          v_id:=blng.blng_api.client_data_add(
                                    p_client=>r_client.id,
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
          r_client_data:=blng.blng_api.client_data_get_info_r(p_id=>i.doc_id,p_client => r_client.id);
          if r_client_data.id is null then RAISE no_data_found; end if;
          blng.blng_api.client_data_edit(p_id=>r_client_data.id,
                                    p_client=>r_client.id,
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
      NTG.LOG_API.LOG_ADD(p_proc_name=>'get_tenant', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '||  sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=client&\p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
--      RAISE_APPLICATION_ERROR(-20002,'select row into client error. '||SQLERRM);
      open v_results for
        select 'false' res from dual;
      return v_results;
    when others then
      ROLLBACK;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'whoami', p_msg_type=>'UNHANDLED_ERROR', 
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=client&\p_date=' 
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
--      RAISE_APPLICATION_ERROR(-20002,'select row into client error. '||SQLERRM);
      open v_results for
        select 'false' res from dual;
      return v_results;
  end;


  function statement(p_email  in ntg.dtype.t_name,
                      p_date_from in ntg.dtype.t_code,
                      p_date_to in ntg.dtype.t_code,
                      p_rownum  in ntg.dtype.t_id default null
                    )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_contract ntg.dtype.t_id;
--    r_company blng.company%rowtype;
  begin
--      r_client
--      r_company:=blng.blng_api.company_get_info_r(p_id=>v_company);        

--    v_results:=blng.blng_api.client_get_info(p_email=>p_user);
      OPEN v_results FOR
              
      select 
      doc_id,
      doc_id transaction_id,
      TRANSACTION_DATE,TRANSACTION_TIME,AMOUNT_BEFORE,AMOUNT,AMOUNT_AFTER,TRANSACTION_TYPE,NQT_ID,ORDER_NUMBER,LAST_NAME,FIRST_NAME,EMAIL,
      sum(case when docs.doc_trans_code = 'b' then amount else 0 end)  over (partition by docs.one) amount_buy,
      sum(case when docs.doc_trans_code = 'ci' then amount else 0 end) over (partition by docs.one)  amount_cash_in,

      amount_from,
      amount_to
      from
      (
      select 
      case  
       when (
          select 
          max(doc_id) doc_id 
          from 
          blng.v_statement
          where email = p_email
          and trans_date < to_date(p_date_from,'yyyy-mm-dd')-utc_offset/24
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
          where email = p_email
          and trans_date < to_date(p_date_from,'yyyy-mm-dd')-utc_offset/24
        )
        and email = p_email
        )
      end amount_from,
      case  
       when (
          select 
          max(doc_id) doc_id 
          from 
          blng.v_statement
          where email = p_email
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
          where email = p_email
          and trans_date < to_date(p_date_to,'yyyy-mm-dd')+1-utc_offset/24
        )
        and email = p_email
        )
        end amount_to,
        1 one
        from dual) amount,
        (
        select * from (
          select
          row_number() over (order by trans_date) rn,
          st.*
          from 
          blng.v_statement st
          where 
          email = p_email
          and trans_date >= to_date(p_date_from,'yyyy-mm-dd')-utc_offset/24
          and trans_date < to_date(p_date_to,'yyyy-mm-dd')+1-utc_offset/24
        )
        where  rn <= nvl(p_rownum,rn)
        ) docs
        where 
        amount.one = docs.one(+)
        order by trans_date
        ;
        
    return v_results;
  exception when others then 
    NTG.LOG_API.LOG_ADD(p_proc_name=>'statement', p_msg_type=>'UNHANDLED_ERROR', 
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=client&\p_date=' 
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
    RAISE_APPLICATION_ERROR(-20002,'select row into client error. '||SQLERRM);
    return null;
  end;

  function loan_list(p_email  in ntg.dtype.t_name,
                      p_rownum  in ntg.dtype.t_id default null
                    )
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    v_contract ntg.dtype.t_id;
  begin

--    v_results:=blng.blng_api.client_get_info(p_email=>p_user);
      OPEN v_results FOR
  
        select
        del.id,
        del.contract_oid,
        del.amount - nvl((select sum(amount) from blng.delay where parent_id is not null and parent_id = del.id and amnd_state = 'A' and EVENT_TYPE_oid = blng.blng_api.event_type_get_id(p_code=>'ci')),0) amount,
        --nvl((select sum(amount) from blng.delay where parent_id is not null and parent_id = d.id and amnd_state = 'A' and EVENT_TYPE_oid = blng.blng_api.event_type_get_id(p_code=>'ci')),0) amount_have,
        item_avia.pnr_id order_number,
        item_avia.nqt_id,
        to_char(del.date_to - 1,'yyyy-mm-dd') date_to ,
        case when trunc(date_to) <= sysdate then 'Y' else 'N' end is_overdue
        from blng.delay del,blng.transaction,blng.document, ord.bill, ord.item_avia,
          blng.client,
          blng.contract,
          blng.client2contract
        where del.amnd_state = 'A'
        and transaction.amnd_state = 'A'
        and document.amnd_state = 'A'
        and item_avia.amnd_state = 'A'
        and bill.amnd_state = 'A'
        and del.parent_id is null
    --    and del.contract_oid = 21
        and del.contract_oid = contract.id
        and del.EVENT_TYPE_oid = blng.blng_api.event_type_get_id(p_code=>'b')
        and del.transaction_oid = transaction.id
        and transaction.doc_oid = document.id
        and document.bill_oid = bill.id
        and document.bill_oid is not null
        and document.contract_oid = contract.id
        and item_avia.order_oid = bill.order_oid
        
        and client.email = p_email
     --  and client.email = 's.popinevskiy@ntg-one.com'

        and client2contract.client_oid = client.id
        and client2contract.amnd_state = 'A'
        and client.amnd_state = 'A'
        and contract.amnd_state = 'A'
        and client2contract.contract_oid = contract.id
        and client2contract.permission = 'B'
        order by del.contract_oid asc, del.date_to asc, del.id asc
;
        
    return v_results;
  exception when others then 
    NTG.LOG_API.LOG_ADD(p_proc_name=>'statement', p_msg_type=>'UNHANDLED_ERROR', 
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=client&\p_date=' 
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
    RAISE_APPLICATION_ERROR(-20002,'select row into client error. '||SQLERRM);
    return null;
  end;



end;
/