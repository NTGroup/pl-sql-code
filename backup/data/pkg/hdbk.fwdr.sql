  CREATE OR REPLACE PACKAGE hdbk.fwdr AS 



/*
pkg: hdbk.fwdr
*/

function utc_offset_mow return number;

type iata_record IS record (IATA hdbk.GEO.IATA%type);
type iata_table is table of iata_record  index by pls_integer;
type iata_array is table of hdbk.GEO.IATA%type index by pls_integer;

/*
$obj_type: function
$obj_name: get_utc_offset
$obj_desc: list of airlines with utc_offset
$obj_return: SYS_REFCURSOR[iata,utc_offset]
*/
function get_utc_offset (p_iata in iata_array)
return SYS_REFCURSOR;

function get_utc_offset
return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: geo_get_list
$obj_desc: list of airports and city of airport
$obj_return: SYS_REFCURSOR[iata,name,NLS_NAME,city_iata,city_name,city_nls_name]
*/
function geo_get_list
return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: airline_get_list
$obj_desc: list of airlines names and iata codes
$obj_return: SYS_REFCURSOR[iata,name,nls_name]
*/
function airline_get_list
return SYS_REFCURSOR;

/*
$obj_type: function
$obj_name: airplane_get_list
$obj_desc: list of airplane names and iata codes
$obj_return: SYS_REFCURSOR[iata,name,nls_name]
*/
function airplane_get_list
return SYS_REFCURSOR;


/*

$obj_type: function
$obj_name: airline_commission_list
$obj_desc: list of airlines with flag commission(it means, is airline have rules for calc commission).
$obj_return: SYS_REFCURSOR[airline_oid,name,IATA,commission[Y/N]]

*/
  
  function airline_commission_list
  return SYS_REFCURSOR;



/*
$obj_type: function
$obj_name: get_full
$obj_desc: return all from v_markup
$obj_return: SYS_REFCURSOR
*/
/*  
function get_full
  return SYS_REFCURSOR;
*/
  

/*
$obj_type: function
$obj_name: markup_get
$obj_desc: when p_version is null then return all active rows. if not null then  
$obj_desc: get all active and deleted rows that changed after p_version id
$obj_param: p_version: id
$obj_return: SYS_REFCURSOR[ID, TENANT_ID, VALIDATING_CARRIER, CLASS_OF_SERVICE, 
$obj_return: SEGMENT, V_FROM, V_TO, ABSOLUT_AMOUNT, PERCENT_AMOUNT, MIN_ABSOLUT, VERSION, IS_ACTIVE, markup_type]
*/  
/*  function markup_get(p_version in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR;
*/


  function note_add(p_user in hdbk.dtype.t_name default null,
                    p_name in hdbk.dtype.t_clob default null)
  return SYS_REFCURSOR;

  function note_edit(   p_id  in hdbk.dtype.t_id default null,
                        p_user in hdbk.dtype.t_name default null,
                        p_name in hdbk.dtype.t_clob default null)
  return SYS_REFCURSOR;

  function note_delete(   p_id  in hdbk.dtype.t_id default null,
                        p_user in hdbk.dtype.t_name default null)
  return SYS_REFCURSOR;

  function note_recovery(   p_id  in hdbk.dtype.t_id default null,
                        p_user in hdbk.dtype.t_name default null)
  return SYS_REFCURSOR;

  function note_ticket_add(   p_note  in hdbk.dtype.t_id default null,
                        p_user in hdbk.dtype.t_name default null,
                        p_tickets in hdbk.dtype.t_clob default null)
  return SYS_REFCURSOR;

  function note_ticket_delete(   p_note  in hdbk.dtype.t_id default null,
                                p_user in hdbk.dtype.t_name default null,
                                p_ticket in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR;

  function note_ticket_recovery(   p_note  in hdbk.dtype.t_id default null,
                                p_user in hdbk.dtype.t_name default null,
                                p_ticket in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR;

  function note_list(     p_user in hdbk.dtype.t_name default null)
  return SYS_REFCURSOR;

  function note_ticket_list(p_note in hdbk.dtype.t_id default null,
                            p_user in hdbk.dtype.t_name default null)
  return SYS_REFCURSOR;

  function note_ticket_list(P_GUID  in hdbk.dtype.t_name default null)
  return SYS_REFCURSOR;

  function punto_switcher(p_text in hdbk.dtype.t_msg)
  return hdbk.dtype.t_msg;



/*

$obj_type: function
$obj_name: rate_list
$obj_desc: return all active rates for current moment. its not depends of p_version
$obj_param: p_version: version. not useful now. 
$obj_return: SYS_REFCURSOR[code,rate,version,is_active(Y,N)]
*/

  function rate_list( p_version in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR;




END fwdr;

/

--------------------------------------------------------
--  DDL for Package Body CORE
--------------------------------------------------------

  CREATE OR REPLACE  PACKAGE BODY hdbk.fwdr AS

  function utc_offset_mow 
  return number
  is
  begin
    return 3;
  end;
  
  function airline_commission_list
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin
  
    OPEN v_results FOR
      select 
      al.id airline_oid,
      al.nls_name name,
      al.IATA,
      case when cmn.airline is null then 'N' else 'Y' end commission
      from 
      hdbk.airline al,
      (
        select airline from ord.commission 
        where amnd_state = 'A'
        and trunc(sysdate) between NVL(date_from,trunc(sysdate)) and NVL(date_to,trunc(sysdate))
        group by airline
      ) cmn
      where 
      al.amnd_state = 'A'
      and al.iata is not null
      and al.id = cmn.airline(+)
      order by 4 desc, 2;
    return v_results;
  end;


/*  function get_full
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin
      OPEN v_results FOR
        SELECT *
        FROM v_markup;
    return v_results;
  exception when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'get_full', p_msg_type=>'UNHANDLED_ERROR', 
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=select,p_table=markup,p_date=' 
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
      RAISE_APPLICATION_ERROR(-20002,'select row into markup error. '||SQLERRM);
    return null;  
  end;*/

function get_utc_offset(p_iata in iata_array)
return SYS_REFCURSOR
is
  v_iata_tab iata_table;
  v_results SYS_REFCURSOR; 
begin
  
  if p_iata.COUNT>0 then
    FOR i IN p_iata.FIRST..p_iata.LAST loop 
    v_iata_tab(i).iata := p_iata(i);
    end loop;
   
    OPEN v_results FOR
      SELECT 
      g.iata, max(utc_offset) utc_offset
      FROM hdbk.GEO g , table(v_iata_tab) iata_list
      WHERE g.IS_ACTIVE IN ('W','Y')
      and g.iata is not null
      and g.iata not like '%@%'
      and g.iata = iata_list.IATA
      group by g.iata;
  else
    OPEN v_results FOR
      SELECT 
      g.iata, max(utc_offset) utc_offset
      FROM hdbk.GEO g --, table(v_iata_tab) iata_list
      WHERE g.IS_ACTIVE IN ('W','Y')
      and g.iata is not null
      and g.iata not like '%@%'
--      and g.iata = iata_list.IATA
      group by g.iata;    
  end if;  
  hdbk.log_api.LOG_ADD(p_proc_name=>'get_utc_offset', p_msg_type=>'Error');
  return v_results;
end;

function get_utc_offset
return SYS_REFCURSOR
is
  v_iata_tab iata_table;
  v_results SYS_REFCURSOR; 
begin

    OPEN v_results FOR
      SELECT 
      g.iata, max(utc_offset) utc_offset
      FROM hdbk.GEO g --, table(v_iata_tab) iata_list
      WHERE g.IS_ACTIVE IN ('W','Y')
      and g.iata is not null
      and g.iata not like '%@%'
--      and g.iata = iata_list.IATA
      group by g.iata;    

  return v_results;
end;



function geo_get_list
return SYS_REFCURSOR
is
  v_iata_tab iata_table;
  v_results SYS_REFCURSOR; 
begin

    OPEN v_results FOR
select  
iata,
name,
nvl(nls_name,name) NLS_NAME,
nvl(city_iata,iata) city_iata,
city_name,
nvl(city_nls_name,city_name) city_nls_name
from (
      SELECT
      g.iata,
      trim(g.name) name,
      trim(g.nls_name) nls_name,
      case
      when parents.object_type in ('region','country') then g.iata
      when parents.object_type is null then g.iata
      else parents.iata
      end city_iata,
      case
      when parents.object_type in ('region','country') then trim(g.name)
      when parents.object_type is null then trim(g.name)
      else trim(parents.name)
      end city_name,
      case
      when parents.object_type in ('region','country') then trim(g.nls_name)
      when parents.object_type is null then trim(g.nls_name)
      else trim(parents.nls_name)
      end city_nls_name
      FROM hdbk.GEO g, hdbk.geo parents --, table(v_iata_tab) iata_list
      WHERE g.IS_ACTIVE IN ('Y')
      and g.iata is not null
      and g.iata not like '%@%'
      and g.object_type in ('airport real')
      and parents.IS_ACTIVE(+) IN ('Y')
      and g.parent_id = parents.id(+)
--      and g.iata = 'OHH'
      order by 1
); 

  return v_results;
end;



function airline_get_list
return SYS_REFCURSOR
is
  v_iata_tab iata_table;
  v_results SYS_REFCURSOR; 
begin

    OPEN v_results FOR
      select 
     -- id,
      iata,
      name,
      nls_name
      from hdbk.airline
      where iata is not null
      and amnd_state = 'A';    

  return v_results;
end;


function airplane_get_list
return SYS_REFCURSOR
is
  v_iata_tab iata_table;
  v_results SYS_REFCURSOR; 
begin

    OPEN v_results FOR
      select 
      iata,
      name,
      nls_name
      from hdbk.airplane
      ;    

  return v_results;
end;


/*
  function markup_get(p_version in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
  begin
    OPEN v_results FOR
      select
      mkp.id,
      nvl(mkp.contract_oid,0) tenant_id,
      air.iata validating_carrier,
      mkp.class_of_service,
      case
      when mkp.segment is not null and mkp.segment = 'Y' then 'Y' 
      else 'N'
      end segment,
      nvl(mkp.v_from,0) v_from,
      nvl(mkp.v_to,0) v_to,
      case
      when mkp.absolut = 'Y'  then mkp.absolut_amount 
      else null
      end absolut_amount,
      case
      when mkp.percent = 'Y'  then mkp.percent_amount 
      else null
      end percent_amount,
      case
      when mkp.percent = 'Y'  then mkp.min_absolut 
      else null
      end min_absolut,
      (select max(id) from markup)  version,
      decode(mkp.amnd_state, 'A','Y','C','N','E') is_active,
      (select name from hdbk.markup_type where id = markup_type_oid) markup_type
      from markup mkp, hdbk.airline air
      where air.amnd_state = 'A'
      and air.id = mkp.validating_carrier
    and ((mkp.amnd_state in ('C','A') 
          and mkp.id in (select amnd_prev from markup where id > p_version)
          and p_version is not null)
      or
        (mkp.amnd_state = 'A'
        and p_version is null)
        );
    return v_results;
  exception when others then
      hdbk.log_api.LOG_ADD(p_proc_name=>'get_full', p_msg_type=>'UNHANDLED_ERROR', 
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=select,p_table=markup,p_date=' 
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
      RAISE_APPLICATION_ERROR(-20002,'select row into markup error. '||SQLERRM);
    return null;  
  end;
*/


  function note_add(p_user in hdbk.dtype.t_name default null,
                    p_name in hdbk.dtype.t_clob default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    r_usr blng.usr%rowtype; 
    v_note hdbk.dtype.t_id; 
    note_count hdbk.dtype.t_id; 
    OVER_LIMIT exception;
  begin
    r_usr := blng.blng_api.usr_get_info_r(p_email => p_user);
    
    select count(*) into note_count from hdbk.note where amnd_state = 'A' and user_oid = r_usr.id;
    if note_count >= 3 then raise OVER_LIMIT; end if;
    
    v_note := hdbk.hdbk_api.note_add(p_user=>r_usr.id, p_name=>p_name);    
    
    commit;   
    open v_results FOR
      select 'SUCCESS' res, v_note note_id  from dual;
    return v_results; 
  exception 
    when OVER_LIMIT then
      rollback;  
      open v_results FOR
        select 'OVER_LIMIT' res, null note_id from dual;
      return v_results;    
    when others then
      rollback;  
      open v_results FOR
        select 'NO_DATA_FOUND' res, null note_id from dual;
      return v_results;  
  end;

  function note_edit(   p_id  in hdbk.dtype.t_id default null,
                        p_user in hdbk.dtype.t_name default null,
                        p_name in hdbk.dtype.t_clob default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    r_usr blng.usr%rowtype; 
    r_note note%rowtype; 
    v_note hdbk.dtype.t_id; 
  begin
        
    r_note := hdbk.hdbk_api.note_get_info_r(p_id => p_id);
    r_usr := blng.blng_api.usr_get_info_r(p_email => p_user);
    if r_usr.id <> r_note.user_oid then raise NO_DATA_FOUND; end if;
    hdbk.hdbk_api.note_edit(p_id=>r_note.id, p_name=>p_name);   
    commit;
    open v_results FOR
      select 'SUCCESS' res from dual;
    return v_results;  
  exception when others then
    rollback;
    open v_results FOR
      select 'NO_DATA_FOUND' res from dual;
    return v_results;  
  end;

  function note_delete(   p_id  in hdbk.dtype.t_id default null,
                        p_user in hdbk.dtype.t_name default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    r_usr blng.usr%rowtype; 
    r_note note%rowtype; 
    v_note hdbk.dtype.t_id; 
  begin
        
    r_note := hdbk.hdbk_api.note_get_info_r(p_id => p_id);
    r_usr := blng.blng_api.usr_get_info_r(p_email => p_user);
    if r_usr.id <> r_note.user_oid then raise NO_DATA_FOUND; end if;
    hdbk.hdbk_api.note_edit(p_id=>r_note.id, p_status=>'D');     
    commit;
    open v_results FOR
      select 'SUCCESS' res from dual;
    return v_results;  
  exception when others then
    rollback;
    open v_results FOR
      select 'NO_DATA_FOUND' res from dual;
    return v_results;  
  end;

  function note_recovery(   p_id  in hdbk.dtype.t_id default null,
                        p_user in hdbk.dtype.t_name default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    r_usr blng.usr%rowtype; 
    r_note note%rowtype; 
    v_note hdbk.dtype.t_id; 
  begin
        
    r_note := hdbk.hdbk_api.note_get_info_r(p_id => p_id);
    r_usr := blng.blng_api.usr_get_info_r(p_email => p_user);
    if r_usr.id <> r_note.user_oid then raise NO_DATA_FOUND; end if;
    hdbk.hdbk_api.note_edit(p_id=>r_note.id, p_status=>'A');        
    commit;
    open v_results FOR
      select 'SUCCESS' res from dual;
    return v_results;  
  exception when others then
    rollback;
    open v_results FOR
      select 'NO_DATA_FOUND' res from dual;
    return v_results;  
  end;

  function note_ticket_add(   p_note  in hdbk.dtype.t_id default null,
                        p_user in hdbk.dtype.t_name default null,
                        p_tickets in hdbk.dtype.t_clob default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    r_usr blng.usr%rowtype; 
    r_note note%rowtype; 
    v_note_ticket hdbk.dtype.t_id; 
  begin
        
    r_note := hdbk.hdbk_api.note_get_info_r(p_id => p_note);
    r_usr := blng.blng_api.usr_get_info_r(p_email => p_user);
    if r_usr.id <> r_note.user_oid then raise NO_DATA_FOUND; end if;
    v_note_ticket := hdbk.hdbk_api.note_ticket_add(p_note=>r_note.id, p_tickets=>p_tickets);        
    commit;
    open v_results FOR
      select 'SUCCESS' res, v_note_ticket note_ticket_id from dual;
    return v_results;  
  exception when others then
    rollback;
    open v_results FOR
      select 'NO_DATA_FOUND' res, null note_ticket_id from dual;
    return v_results;  
  end;

  function note_ticket_delete(   p_note  in hdbk.dtype.t_id default null,
                                p_user in hdbk.dtype.t_name default null,
                                p_ticket in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    r_usr blng.usr%rowtype; 
    r_note note%rowtype; 
    r_note_ticket note_ticket%rowtype; 
    v_note_ticket hdbk.dtype.t_id; 
  begin
        
    r_note := hdbk.hdbk_api.note_get_info_r(p_id => p_note);
    --dbms_output.put_line('1');
    r_note_ticket := hdbk.hdbk_api.note_ticket_get_info_r(p_id => p_ticket);
    ---dbms_output.put_line('2');
    r_usr := blng.blng_api.usr_get_info_r(p_email => p_user);
    --dbms_output.put_line('3');
    if r_usr.id <> r_note.user_oid then     --dbms_output.put_line('NO_DATA_FOUND');
    raise NO_DATA_FOUND; end if;
    --dbms_output.put_line('4');
    hdbk.hdbk_api.note_ticket_edit(p_id=>r_note_ticket.id, p_status=>'D');       
    --dbms_output.put_line('5');
    commit;
    open v_results FOR
      select 'SUCCESS' res from dual;
    return v_results;  
  exception when others then
    rollback;
    open v_results FOR
      select 'NO_DATA_FOUND' res from dual;
    return v_results;  
  end;

  function note_ticket_recovery(   p_note  in hdbk.dtype.t_id default null,
                                p_user in hdbk.dtype.t_name default null,
                                p_ticket in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    r_usr blng.usr%rowtype; 
    r_note note%rowtype; 
    r_note_ticket note_ticket%rowtype; 
    v_note_ticket hdbk.dtype.t_id; 
  begin
        
    r_note := hdbk.hdbk_api.note_get_info_r(p_id => p_note);
    r_note_ticket := hdbk.hdbk_api.note_ticket_get_info_r(p_id => p_ticket);
    r_usr := blng.blng_api.usr_get_info_r(p_email => p_user);
    if r_usr.id <> r_note.user_oid then raise NO_DATA_FOUND; end if;
    hdbk.hdbk_api.note_ticket_edit(p_id=>r_note_ticket.id, p_status=>'A');        
    commit;
    open v_results FOR
      select 'SUCCESS' res from dual;
    return v_results;  
  exception when others then
    rollback;
    open v_results FOR
      select 'NO_DATA_FOUND' res from dual;
    return v_results;  
  end;

  function note_list(     p_user in hdbk.dtype.t_name default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    r_usr blng.usr%rowtype; 
    r_note note%rowtype; 
    r_note_ticket note_ticket%rowtype; 
    v_note_ticket hdbk.dtype.t_id; 
  begin
        
    r_usr := blng.blng_api.usr_get_info_r(p_email => p_user);
    if r_usr.id <> r_note.user_oid then raise NO_DATA_FOUND; end if;
    open v_results FOR
      select id note_id, name, guid from hdbk.note where amnd_state = 'A' and user_oid = r_usr.id order by id desc;
    return v_results;  
  exception when others then
    open v_results FOR
      select 'NO_DATA_FOUND' res from dual;
    return v_results;  
  end;

  function note_ticket_list(p_note in hdbk.dtype.t_id default null,
                            p_user in hdbk.dtype.t_name default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    r_usr blng.usr%rowtype; 
    r_note note%rowtype; 
    r_note_ticket note_ticket%rowtype; 
    v_note_ticket hdbk.dtype.t_id; 
  begin
        
    r_note := hdbk.hdbk_api.note_get_info_r(p_id => p_note);
    r_usr := blng.blng_api.usr_get_info_r(p_email => p_user);
    
    if r_usr.id <> r_note.user_oid then raise NO_DATA_FOUND; end if;
    open v_results FOR
      select note.id note_id, note_ticket.id note_ticket_id, note.name,note.guid, note_ticket.tickets from hdbk.note, hdbk.note_ticket
      where note.id = p_note
      and note.id = note_ticket.note_oid(+)
      and note.amnd_state = 'A'
      and note_ticket.amnd_state(+) = 'A'
      ;
    return v_results;  
  exception when others then
    open v_results FOR
      select 'NO_DATA_FOUND' res from dual;
    return v_results;  
  end;


  function note_ticket_list(p_guid in hdbk.dtype.t_name default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR; 
    r_usr blng.usr%rowtype; 
    r_note note%rowtype; 
    r_note_ticket note_ticket%rowtype; 
    v_note_ticket hdbk.dtype.t_id; 
  begin
        
    r_note := hdbk.hdbk_api.note_get_info_r(p_guid => p_guid);
    open v_results FOR
      select note.id note_id, note_ticket.id note_ticket_id, note.name, note.guid, note_ticket.tickets from hdbk.note, hdbk.note_ticket
      where note.id = r_note.id
      and note.id = note_ticket.note_oid(+)
      and note.amnd_state = 'A'
      and note_ticket.amnd_state(+) = 'A'
      ;
    return v_results;  
  exception when others then
    open v_results FOR
      select 'NO_DATA_FOUND' res from dual;
    return v_results;  
  end;
  
  function punto_switcher(p_text in hdbk.dtype.t_msg)
  return hdbk.dtype.t_msg
  is
    v_out hdbk.dtype.t_msg;
  begin
    v_out := p_text;
    select translate(v_out,'QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>~qwertyuiop[]asdfghjkl;''zxcvbnm,.`ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮЁйцукенгшщзхъфывапролджэячсмитьбюё','ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮЁйцукенгшщзхъфывапролджэячсмитьбюёQWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>~qwertyuiop[]asdfghjkl;''zxcvbnm,.`') into v_out from dual;
--    select translate(v_out,'ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮЁйцукенгшщзхъфывапролджэячсмитьбюё','QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>~qwertyuiop[]asdfghjkl;''zxcvbnm,.`') into v_out from dual;
    return v_out;
  end;


  function rate_list(p_version in hdbk.dtype.t_id default null)
  return SYS_REFCURSOR
  is
    v_results SYS_REFCURSOR;
  begin
  -- [a,b) 
    OPEN v_results FOR
      SELECT code,rate,(select max(id) from hdbk.rate) version , decode(amnd_state, 'A','Y','C','N','E') is_active
      from hdbk.rate where date_from <=sysdate and sysdate < date_to and amnd_state = 'A';      
      
    return v_results;
  exception when others then
    hdbk.LOG_API.LOG_ADD(p_proc_name=>'rate_list', p_msg_type=>'UNHANDLED_ERROR',
      P_MSG => to_char(SQLCODE) || ' '|| SQLERRM|| ' '|| chr(13)||chr(10)|| ' '|| sys.DBMS_UTILITY.format_call_stack,p_info => 'p_process=select,p_table=rate_list,p_date='
      || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);
    RAISE_APPLICATION_ERROR(-20002,'select row into rate error. '||SQLERRM);
    return null;    
  end;



END fwdr;

/
