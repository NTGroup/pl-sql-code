create or replace package blng.fwdr as

  function get_tenant (p_email in ntg.dtype.t_name default null)
  return ntg.dtype.t_id;  

  function company_insteadof_client(p_company in ntg.dtype.t_id)
  return ntg.dtype.t_id;
  
  function balance( P_TENANT_ID in ntg.dtype.t_id  default null
                          )
  return SYS_REFCURSOR;  

  function whoami(p_user in ntg.dtype.t_name)
  return SYS_REFCURSOR;

  function client_data_edit(p_data in ntg.dtype.t_clob)
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
    r_contract blng.contract%rowtype;
    r_domain blng.domain%rowtype;
    v_client_count ntg.dtype.t_id;
  begin
  --all emails must be in lower case
    begin
      r_client:=blng.blng_api.client_get_info_r(p_email=>lower(p_email));
      
--      if r_client.id is null then raise no_data_found; end if;
--      if r_client.id is null then raise TOO_MANY_ROWS; end if;
      v_company := r_client.company_oid;
    exception     
      when TOO_MANY_ROWS then return null;
      when NO_DATA_FOUND then
        begin
          r_domain:=blng.blng_api.domain_get_info_r(p_name => REGEXP_SUBSTR ( lower(p_email), '[^@]*$' ));
          if r_domain.id is null then
            r_domain:=blng.blng_api.domain_get_info_r(p_name => lower(p_email) );
            if r_domain.id is null then
              raise no_data_found;
            else
              blng.blng_api.domain_edit(p_id=>r_domain.id, p_status=>'C' );                
            end if;
          end if;
          v_company:=r_domain.company_oid;
--          r_company:=blng.blng_api.COMPANY_get_info_r(p_company => REGEXP_SUBSTR ( lower(p_email), '[^.]*$' ));
          r_contract:=blng.blng_api.contract_get_info_r(p_company=>v_company);
          select count(*) into v_client_count from blng.client where amnd_state = 'A' and company_oid = v_company and amnd_date > sysdate-1/24/60;
          -- auto user registration stoper 10 user per minute
          if v_client_count>=10 then return null; end if;
          v_client := blng.BLNG_API.client_add(P_last_NAME => REGEXP_SUBSTR ( lower(p_email), '^[^@]*' ), p_company => v_company,p_email=>p_email);
          blng.BLNG_API.client2contract_add(P_client => v_client, p_permission=> 'B', p_contract => r_contract.id);
          commit;
        exception 
          when NO_DATA_FOUND then
            raise NO_DATA_FOUND;
          when others then
            rollback;
            raise;
        end;
      when others then return null;
    end;
    return v_company;
  exception 
    when NO_DATA_FOUND then
     -- CLOSE c_delay;
      NTG.LOG_API.LOG_ADD(p_proc_name=>'get_tenant', p_msg_type=>'NO_DATA_FOUND',
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '||  sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=client&\p_date='
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
--      RAISE_APPLICATION_ERROR(-20002,'select row into client error. '||SQLERRM);
      return null;
    when others then
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
    acc.*,
    nvl(total.UNBLOCK_SUM,0) UNBLOCK_SUM,
    nvl(total.NEAR_UNBLOCK_SUM,0) NEAR_UNBLOCK_SUM,
    to_char(total.BLOCK_DATE,'dd.mm.yyyy') BLOCK_DATE
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
      select clt.id client_id, INITCAP(clt.last_name) last_name, INITCAP(clt.first_name) first_name,clt.email,
      clt.company_oid tenant_id, to_char(clt.birth_date,'dd.mm.yyyy') birth_date,
      clt.gender,
      clt.nationality,
      ntg.ntg_api.gds_nationality_get_info_name(clt.nationality) nls_nationality,
      cld.id doc_id,   
      to_char(cld.expiry_date,'dd.mm.yyyy') doc_expiry_date,
      cld.doc_number,
      INITCAP(cld.last_name) doc_last_name,
      INITCAP(cld.first_name) doc_first_name,
      cld.owner doc_owner,
      cld.gender doc_gender,
      to_char(cld.birth_date,'dd.mm.yyyy') doc_birth_date,
      cld.nationality doc_nationality,
      ntg.ntg_api.gds_nationality_get_info_name(cld.nationality) doc_nls_nationality
      from blng.client clt, blng.client_data cld where 
      clt.amnd_state = 'A' 
      and clt.status = 'A'
      and clt.email = p_user
      and clt.id = cld.client_oid(+)
      and cld.amnd_state(+) = 'A' 
        ;

    return v_results;
  exception when others then 
    NTG.LOG_API.LOG_ADD(p_proc_name=>'whoami', p_msg_type=>'UNHANDLED_ERROR', 
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select&\p_table=client&\p_date=' 
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
            NESTED PATH '$.docs[*]' COLUMNS (
               doc_expiry_date VARCHAR2(256 CHAR) PATH '$.doc_expiry_date',
               doc_gender VARCHAR2(256 CHAR) PATH '$.doc_gender',
               doc_first_name VARCHAR2(256 CHAR) PATH '$.doc_first_name',
               doc_last_name VARCHAR2(256 CHAR) PATH '$.doc_last_name',
               doc_number VARCHAR2(256 CHAR) PATH '$.doc_number',
               doc_owner VARCHAR2(256 CHAR) PATH '$.doc_owner',
               doc_id number PATH '$.doc_id',
               doc_nationality VARCHAR2(256 CHAR) PATH '$.doc_nationality',
               doc_birth_date VARCHAR2(256 CHAR) PATH '$.doc_birth_date'
                  
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
                                p_birth_date=>to_date(i.birth_date,'dd.mm.yyyy'),
                                p_nationality=>i.nationality,
                                p_email=>i.email
                                );
      if i.doc_number is not null then                           
        if i.doc_id is null then 
          v_id:=blng.blng_api.client_data_add(
                                    p_client=>r_client.id,
                                    p_last_name=>i.doc_last_name,
                                    p_first_name=>i.doc_first_name,
                                    p_gender=>i.doc_gender,
                                    p_birth_date=>to_date(i.doc_birth_date,'dd.mm.yyyy'),
                                    p_nationality=>i.doc_nationality,
                                    p_doc_number=>i.doc_number,
                                    p_expiry_date=>to_date(i.doc_expiry_date,'dd.mm.yyyy'),
                                    p_owner=>i.doc_owner
                                    );      
        else
          r_client_data:=blng.blng_api.client_data_get_info_r(p_id=>i.doc_id,p_client => r_client.id);
          if r_client_data.id is null then RAISE no_data_found; end if;
          blng.blng_api.client_data_edit(p_id=>r_client_data.id,
                                    p_client=>r_client.id,
                                    p_last_name=>i.doc_last_name,
                                    p_first_name=>i.doc_first_name,
                                    p_gender=>i.doc_gender,
                                    p_birth_date=>to_date(i.doc_birth_date,'dd.mm.yyyy'),
                                    p_nationality=>i.doc_nationality,
                                    p_doc_number=>i.doc_number,
                                    p_expiry_date=>to_date(i.doc_expiry_date,'dd.mm.yyyy'),
                                    p_owner=>i.doc_owner
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


end;
/