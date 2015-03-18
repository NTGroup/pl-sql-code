create or replace package ntg.fwdr as

/*
pkg: ntg.fwdr
*/

function utc_offset_mow return number;

type iata_record IS record (IATA GEO.IATA%type);
type iata_table is table of iata_record  index by pls_integer;
type iata_array is table of GEO.IATA%type index by pls_integer;

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
$obj_desc: list of airlines with flag commission(means: is airline have rules for calc commission).
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
  function markup_get(p_version in ntg.dtype.t_id default null)
  return SYS_REFCURSOR;

end;
/
create or replace package body ntg.fwdr as
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
      ntg.airline al,
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
      NTG.LOG_API.LOG_ADD(p_proc_name=>'get_full', p_msg_type=>'UNHANDLED_ERROR', 
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
      FROM GEO g , table(v_iata_tab) iata_list
      WHERE g.IS_ACTIVE IN ('W','Y')
      and g.iata is not null
      and g.iata not like '%@%'
      and g.iata = iata_list.IATA
      group by g.iata;
  else
    OPEN v_results FOR
      SELECT 
      g.iata, max(utc_offset) utc_offset
      FROM GEO g --, table(v_iata_tab) iata_list
      WHERE g.IS_ACTIVE IN ('W','Y')
      and g.iata is not null
      and g.iata not like '%@%'
--      and g.iata = iata_list.IATA
      group by g.iata;    
  end if;  
  NTG.LOG_API.LOG_ADD(p_proc_name=>'client_set_name', p_msg_type=>'Error');
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
      FROM GEO g --, table(v_iata_tab) iata_list
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
      FROM GEO g, geo parents --, table(v_iata_tab) iata_list
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
      from airline
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
      from airplane
      ;    

  return v_results;
end;



  function markup_get(p_version in ntg.dtype.t_id default null)
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
      (select max(id) from ntg.markup)  version,
      decode(mkp.amnd_state, 'A','Y','C','N','E') is_active,
      (select name from ntg.markup_type where id = markup_type_oid) markup_type
      from markup mkp, airline air
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
      NTG.LOG_API.LOG_ADD(p_proc_name=>'get_full', p_msg_type=>'UNHANDLED_ERROR', 
        P_MSG => to_char(SQLCODE) || ' '|| SQLERRM,p_info => 'p_process=select,p_table=markup,p_date=' 
        || to_char(sysdate,'dd.mm.yyyy HH24:mi:ss'),P_ALERT_LEVEL=>10);      
      RAISE_APPLICATION_ERROR(-20002,'select row into markup error. '||SQLERRM);
    return null;  
  end;


end;
/

grant execute on ntg.fwdr to ord ;
grant execute on ntg.fwdr to blng ;

/